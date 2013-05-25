#include "taskFlyport.h"

const int OUT_PINS[] = {d1out, d2out, d3out, d4out};
const int IN_CH[] = {1, 2, 3, 4};
static void _selectRow(int row)
{
	int i;
	for (i = 0; i < 4; ++i) {
		IOPut(OUT_PINS[i], i == row ? ON : OFF);
	}
}

void FlyportTask()
{
	vTaskDelay(200);
	UARTWrite(1,"* SongTsu *\r\n");
	int i;
	for (i = 0; i < 4; ++i) {
		IOInit(OUT_PINS[i], out);
	}
		
	WFConnect(WF_DEFAULT);
	while (WFStatus != CONNECTED);
	UARTWrite(1,"Flyport connected... hello world!\r\n");
	while(1)
	{
		char buf[30];
		int val[4][4];
		int row, col;
		for (row = 0; row < 4; ++row) {
			_selectRow(row);
			vTaskDelay(1);
			for (col = 0; col < 4; ++col) {
				int n;
				n = ADCVal(IN_CH[col]);
				val[row][col] = n;
				sprintf(buf, " %05d", n);
				UARTWrite(1, buf);
			}
			UARTWrite(1, "\n");
		}
		UARTWrite(1, "\n");
		vTaskDelay(200);
	}
}
