#include "taskFlyport.h"
#include "httplib.h"

const int OUT_PINS[] = {d1out, d2out, d3out, d4out};
const int IN_CH[] = {1, 2, 3, 4};
static void _selectRow(int row)
{
	int i;
	for (i = 0; i < 4; ++i) {
		IOPut(OUT_PINS[i], i == row ? ON : OFF);
	}
}

int val[4][4];

void Connect()
{
	if (WFStatus != CONNECTED) {
		WFConnect(WF_DEFAULT);
		while (WFStatus != CONNECTED)
			;
		UARTWrite(1,"Flyport connected... hello world!\r\n");
	}
}

void SendPost()
{
	Connect();
	
	char s[50 + 16*6] = "/bodyback/?c=";
	int row;
	for (row = 0; row < 4; ++row) {
		int col;
		for (col = 0; col < 4; ++col) {
			char num[6];
			if (row == 0 && col == 0) {
				sprintf(num, "%d", val[row][col]);
			} else {
				sprintf(num, "+%d", val[row][col]);
			}
			strcat(s, num);
		}
	}
	UARTWrite(1, s);
	UARTWrite(1, "\n");
	
	

	// changed lib to transmit on port 8000
	TCP_SOCKET* socket = create_http_socket("192.168.1.200");
 
	struct HTTP_HEADER_REQUEST pp;
	pp.method = "POST";
	pp.resource = s;
	pp.version = "HTTP/1.1";
	pp.host = "192.168.1.200";
	pp.parameters_size = 0;
	
	char* request = get_http_request(&pp);
        do_http_request(socket,request);
        free(request);
	char* response = http_get_response(socket);
        UARTWrite(1,response);
		UARTWrite(1, "\n");
        free(response);
	close_socket(socket);
}

void FlyportTask()
{
	vTaskDelay(10);
	UARTWrite(1,"* SongTsu *\r\n");
	int i;
	for (i = 0; i < 4; ++i) {
		IOInit(OUT_PINS[i], out);
	}

	Connect();
	while(1)
	{
		char buf[30];
		int row, col;
		for (row = 0; row < 4; ++row) {
			_selectRow(row);
			vTaskDelay(1);
			for (col = 0; col < 4; ++col) {
				int n;
				n = ADCVal(IN_CH[col]);
				val[row][col] = n;
				//sprintf(buf, " %05d", n);
				//UARTWrite(1, buf);
			}
			//UARTWrite(1, "\n");
		}
		//UARTWrite(1, "\n");
		SendPost();
		vTaskDelay(50);
	}
}
