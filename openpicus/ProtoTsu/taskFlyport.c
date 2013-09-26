#include "taskFlyport.h"
#include "WebSocket.h"

//BYTE g_d1[] = { p2, p5, p10, p12};
//BYTE g_d2[] = { p4, p6, p11, p14};
//BYTE g_an[] ={ 1, 2, 3 };

#define ARRAY_LEN(a) (sizeof(a)/sizeof(a[0]))
#define MATRIX_SIZE 8
#define ROW_SEL_DELAY 15 // 10us units
#define COL_SEL_DELAY 30

BYTE g_uartEnabled = 0;

// S0(LBS), S1, S2(MSB)
static const BYTE PIN_COL_DATA = p2;
static const BYTE PIN_COL_CLOCK = p4;
static const BYTE PIN_COL_RESET = p5;
static const BYTE PIN_OUT_ROWS[] = { p2, p4, p5 };
static const BYTE PIN_OUT_COLS[] = { p6, p10, p11};
static const BYTE PIN_IN_TOUCH = 1;

// table in grams / 10
#define WEIGHT_COUNT_STEP 16
static ROM const int WEIGHT[] =
{
  3, 7, 11, 14, 16, 19, 22, 24, // count = 0, 16, 32, 48, 64, 80, 96, 112
  27, 29, 32, 35, 37, 40, 43, 46,
  49, 52, 55, 58, 61, 64, 68, 71,
  75, 78, 82, 86, 91, 95, 100, 104,
  109, 115, 120, 126, 132, 139, 146, 154,
  162, 170, 180, 190, 201, 213, 226, 241,
  257, 275, 296, 320, 348, 380, 419, 467,
  526, 605, 712, 870, 1132, 1673, 3737, 0
};

static int Interpolate(int a, int b, int pos)
{
  return (b * pos + a * (WEIGHT_COUNT_STEP - pos)) / WEIGHT_COUNT_STEP;
}

static int Convert(int valAdc)
{
  int i = valAdc / WEIGHT_COUNT_STEP;
  int pos = valAdc % WEIGHT_COUNT_STEP;
  return Interpolate(WEIGHT[i], WEIGHT[i+1], pos);
}

static void ConvertCol(int *values)
{
	int row;
	for (row = 0; row < MATRIX_SIZE; ++row) {
		values[row] = Convert(values[row]);
	}
}

static void InitPorts()
{
  int i;
  for (i = 0; i < ARRAY_LEN(PIN_OUT_COLS); ++i)
  {
    IOInit(PIN_OUT_COLS[i], out);
    IOInit(PIN_OUT_ROWS[i], out);
  }
  // analog ping doesn't need initialization
}

static void OutAddr3Bits(int addr, const BYTE *pins)
{
  IOPut(pins[0], (addr & 0x01) != 0 ? ON : OFF);
  IOPut(pins[1], (addr & 0x02) != 0 ? ON : OFF);
  IOPut(pins[2], (addr & 0x04) != 0 ? ON : OFF);
}

static void OutColShift()
{
	IOPut(PIN_COL_CLOCK, ON);
	Delay10us(1);
	IOPut(PIN_COL_CLOCK, OFF);
	Delay10us(1);
}

static void OutAddrColShift(int addr)
{
	int i;
	IOPut(PIN_COL_RESET, OFF); // reset
	IOPut(PIN_COL_CLOCK, OFF);
	IOPut(PIN_COL_DATA, ON);
	IOPut(PIN_COL_RESET, ON);
	Delay10us(1);
	OutColShift();
	IOPut(PIN_COL_DATA, OFF);
	Delay10us(1);	
	for (i = 0; i < addr; ++i) {
		OutColShift();
	}
}

static void ReadCol(int col, int *values)
{
	int row;
	OutAddr3Bits(col, PIN_OUT_COLS);
	//OutAddrColShift(col);
	Delay10us(COL_SEL_DELAY); // wait for line charge
	for (row = 0; row < MATRIX_SIZE; ++row)
	{
		OutAddr3Bits(MATRIX_SIZE-1-row, PIN_OUT_ROWS);
		Delay10us(ROW_SEL_DELAY); // wait for a stable signal
		values[row] = ADCVal(PIN_IN_TOUCH);
	}
}

static void SendColWS(int col, int values[])
{
	char text[64];
	int row;
	sprintf(text, "{\"c\":%d,\"v\":[", col);
	for (row = 0; row < MATRIX_SIZE; ++row) {
		if (row != 0)
		{
			strcat(text, ",");
		}
		char s[10];
		sprintf(s, "%d", values[row]);
		strcat(text, s);
	}
	strcat(text, "]}");
	WsSendTextEvent(text);
	//int	cnt = WsSendTextEvent(text);
	//if (cnt>0) {
	//  sprintf(text, "EventSubscriber: %d\n", cnt);
	// UARTWrite(1, text);
	//}
}

static void SendFrameUart(const int *frame)
{
	int elem;
	UARTWrite(1, "R=");
	for (elem = 0; elem < MATRIX_SIZE*MATRIX_SIZE; ++elem) {
		if (elem != 0) {
			UARTWrite(1, ",");
		}
		char s[10];
		sprintf(s, "%d", frame[elem]);
		UARTWrite(1, s);
	}
	UARTWrite(1, "\n");
}

void FlyportTask()
{	
	vTaskDelay(100);
	UARTWrite(1,"Welcome to ProtoTsu test program!\r\n");

	InitPorts();
  
	// Connection to Network
	#if defined (FLYPORT_WF)
	WFConnect(WF_DEFAULT);
	while (WFStatus != CONNECTED);
	#endif
	#if defined (FLYPORTETH)
	while(!MACLinked);
	#endif
	UARTWrite(1,"Flyport connected... hello world!\r\n");
	vTaskDelay(200);
	
	while(1)
	{
		int frame[MATRIX_SIZE][MATRIX_SIZE];
		int col;
		for (col = 0; col < MATRIX_SIZE; ++col)
		{
			ReadCol(col, frame[col]);
			ConvertCol(frame[col]);
			SendColWS(col, frame[col]);
		}
		if (g_uartEnabled)
		{
			SendFrameUart(frame[0]);
		}
	}
}
