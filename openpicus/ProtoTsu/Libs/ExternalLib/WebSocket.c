// Include all headers for any enabled TCPIP Stack functions
#include "TCPIP Stack/TCPIP.h"
#include "WebSocket.h"

void WebSocketInit();

int  CreateHandShake(TCP_SOCKET MySocket,unsigned char* WebSocketKey, short KeyLength);
int  UnMaskFrame(WebSocketFrame *Frame);
WebSocketFrame CreateFrame(BYTE* Data, int Length, int Opcode);

BYTE ServerReply [] =
"HTTP/1.1 101 Switching Protocols\r\n"
"Upgrade: websocket\r\n"
"Connection: Upgrade\r\n"
"Sec-WebSocket-Accept: ";
BYTE WebSocketGuid [] = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11";

BYTE *wsFrameBuf[MAX_HTTP_CONNECTIONS];
int   wsFrameLen[MAX_HTTP_CONNECTIONS];
int   wsFrameOpC[MAX_HTTP_CONNECTIONS];

/**
*  Call in HTTPInit()
*/
void WsInit() {
  // ------------------------------------------------------------ JH --
  int conn;
  for(conn=0; conn<MAX_HTTP_CONNECTIONS; conn++) {
    wsFrameLen[conn] = 0;
  }
}

/*
*  Websocket-Listener methode interface implementation:
*/
void  WsOnOpen(int connID){
	//----------------------------------------------------------- JH --
    UARTWrite(1,"WsOnOpen()\r\n");
    // TODO	
}

/*
*  Websocket-Listener methode interface implementation:
*/
void  WsOnClose(int connID){
	//----------------------------------------------------------- JH --
    UARTWrite(1,"WsOnClose()\r\n");
    // TODO	
}

/*
*  Websocket-Listener methode interface implementation:
*/
void WsOnBinary(int connID, BYTE* data, int dataLen) {
	//----------------------------------------------------------- JH --
    UARTWrite(1,"WsOnBinary()\r\n");
    // TODO	
}

/*
*  Websocket-Listener methode interface implementation:
*/
void WsOnText(int connId, BYTE* text, int textLen) {
	//----------------------------------------------------------- JH --
    UARTWrite(1,"WsOnText()\r\n");
    // TODO	
	WsSendResponse(connId, text, textLen);
}

BOOL WsSendResponse(int connId, BYTE* response, int responseLen) {
	//----------------------------------------------------------- JH --
    UARTWrite(1,"WsSendResponse()\r\n");
	BOOL ret = FALSE;
		
	if (wsFrameLen[connId]!=0) {
      UARTWrite(1,"WsSendResponse() failed! (ToDo)\r\n");
	} else {
	  wsFrameBuf[connId] = malloc(responseLen);
	  int a;
      for (a = 0; a < responseLen; a++) {
        wsFrameBuf[connId][a] = response[a];
      }
	  wsFrameLen[connId] = responseLen;
	  ret = TRUE;
	}
	return ret;
}
int WsSendEvent(BYTE* text, int textLen) {
	//----------------------------------------------------------- JH --
    //UARTWrite(1,"WsSendEvent()\r\n");
    int a, conn, dest=0;
	for (conn=0; conn<MAX_HTTP_CONNECTIONS; conn++) {
	    if (httpStubs[conn].sm==SM_HTTP_PROC_WEBSOCKET){
			if (wsFrameLen[conn]!=0) {
              UARTWrite(1,"WsSendEvent() failed! (ToDo)\r\n");
			} else {
				wsFrameBuf[conn] = malloc(textLen);
				wsFrameLen[conn] = textLen;
				for (a = 0; a < textLen; a++) {
					wsFrameBuf[conn][a] = text[a];
				}
				dest++;
            }
		}
	}
	return dest;
}
int WsSendTextEvent(char* text) {
	//----------------------------------------------------------- JH --
	int len = strlen(text);
	//BYTE *strbuf = malloc(len);
	//memcpy(strbuf,text,len);
	return WsSendEvent((BYTE*)text, len);
	//free
 }

// private
void WsReturnSendFrame(int connId, BYTE* frame, int* frameLen, int* opCode) {
	//----------------------------------------------------------- JH --
    //UARTWrite(1,"WsReturnSendFrame()\r\n");
	
	int a;
    for (a = 0; a < wsFrameLen[connId]; a++) {
        frame[a] = wsFrameBuf[connId][a];
    }
    *frameLen = wsFrameLen[connId];
    *opCode   = TextFrame; //ToDo!
	
    free(wsFrameBuf[connId]);
	wsFrameLen[connId] = 0;
}

BOOL WsDoSend(int connId) {
//----------------------------------------------------------------- JH --
  return (wsFrameLen[connId]>0) ? TRUE : FALSE;
}

/*
 * Requires that TCPIsPutReady() is called first
 */
int CreateHandShake(TCP_SOCKET MySocket,unsigned char* WebSocketKey, short KeyLength){

    BYTE MyDebug[30];
    int b;
    for(b=0;b<KeyLength;b++){
        MyDebug[b] = WebSocketKey[b];
    }

    TCPPutArray(MySocket,ServerReply,sizeof ServerReply - 1);
    HASH_SUM ReplyHash;
    BYTE Sha1Result[20];
    BYTE ResultBase64[40];
    int ResultStringLength;
    SHA1Initialize(&ReplyHash);
    HashAddData(&ReplyHash,(BYTE*)WebSocketKey,(WORD)KeyLength);
    HashAddData(&ReplyHash,(BYTE*)WebSocketGuid,(WORD)sizeof WebSocketGuid - 1);
    SHA1Calculate(&ReplyHash,Sha1Result);
    ResultStringLength = Base64Encode(Sha1Result,20,ResultBase64,40);
    TCPPutArray(MySocket,ResultBase64,ResultStringLength);
    TCPPut(MySocket,0xD);//\r
    TCPPut(MySocket,0xA);//\n
    TCPPut(MySocket,0xD);//\r
    TCPPut(MySocket,0xA);//\n
    return 0;
}

int UnMaskFrame(WebSocketFrame *Frame) {
    int i;
    int DataOffset = 4;
    int DataLength = 0;
    int MaskOffset = 0;
    if (!Frame->Mask || !Frame->FIN) {
        return 0;//already opened, or incorrect, should be masked, plus we don't accept fragmented frames at this point
    }
    if (Frame->PayloadLen == 126){
        DataOffset += 2;
        MaskOffset += 2;
        DataLength = (Frame->data[0] << 8) + Frame->data[1];
    } else if(Frame->PayloadLen == 127 ){
        return 0;//not supported
    } else    {
        DataLength = Frame->PayloadLen;
    }
    if(DataLength > MaxFrameLength)
        return 0; //too long
    unsigned char Mask[4];
    memcpy(Mask, &Frame->data[MaskOffset], 4);
    for (i = 0; i < DataLength; i++)
        Frame->data[i] = Frame->data[i + DataOffset] ^ Mask[i % 4];
    return DataLength;
}

WebSocketFrame CreateFrame(BYTE* Data, int Length, int Opcode) {
    WebSocketFrame RF;
    int a;
    RF.FIN = 1;
    RF.Mask = 0;
    RF.Opcode = Opcode;
    RF.RSV = 0;
    int DataOffset = 0;
    if (Length < 126)
        RF.PayloadLen = Length;
    else {
        DataOffset = 2;
        RF.PayloadLen = 126; //Flag that we use the 16 bit extended length
        RF.data[0] = (Length >> 8)&0xFF;
        RF.data[1] = Length & 0xFF;
    }
    if (Length > MaxFrameLength)
        Length = MaxFrameLength;
    for (a = 0; a < Length; a++) {
        RF.data[a + DataOffset] = Data[a];
    }
    return RF;
}

