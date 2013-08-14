#include "GenericTypeDefs.h"
#define MaxFrameLength 265
#define ShortExtendLength 2
#define LongExtendLength 4
#define MaskLength 4
#define ShortReplyAddition 2

typedef struct {
    unsigned char Opcode : 4;
    unsigned char RSV : 3;
    unsigned char FIN : 1;
    unsigned char PayloadLen : 7;
    unsigned char Mask : 1;
    BYTE data[MaxFrameLength + 6];//allow room for additional
} WebSocketFrame;

typedef enum {
    ContinuationFrame, TextFrame, BinaryFrame, ConnectionClose = 0x08, WSPing, WSPong
} OPCODES;


// public:
extern void WsInit();
// Service methods
extern int  WsSendTextEvent  (char* event);
extern int  WsSendEvent      (BYTE* event, int eventLen);
extern BOOL WsSendResponse   (int connID, BYTE* response, int responseLen);
// Event declarations
extern void WsOnOpen         (int connID);
extern void WsOnClose        (int connID);
extern void WsOnText         (int connID, BYTE* text,  int textLen);
extern void WsOnBinary       (int connID, BYTE* data,  int dataLen);

// private: http server fetch methode
extern void WsReturnSendFrame(int connID, BYTE* frame, int *frameLen, int *opCode);
extern BOOL WsDoSend(int connId);
extern int CreateHandShake(TCP_SOCKET MySocket,unsigned char* WebSocketKey, short KeyLength);
extern int UnMaskFrame(WebSocketFrame *Frame);
extern WebSocketFrame CreateFrame(BYTE* Data, int Length, int Opcode);

//extern int WebSocketEventRequest[MAX_HTTP_CONNECTIONS];//for requesting an data out event
//extern void WebSocketNewFrame(BYTE* DATA, int Len, int SocketID, int Opcode);
//extern void WebSocketGetFrame(BYTE* Stream, int* Length, int* Opcode, int SocketID);
