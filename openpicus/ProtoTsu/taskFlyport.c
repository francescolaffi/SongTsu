#include "taskFlyport.h"

//BYTE g_d1[] = { p2, p5, p10, p12};
//BYTE g_d2[] = { p4, p6, p11, p14};
//BYTE g_an[] ={ 1, 2, 3 };

#define ARRAY_LEN(a) (sizeof(a)/sizeof(a[0]))
#define MATRIX_SIZE 8
#define ROW_SEL_DELAY 1 // 10us units
#define COL_SEL_DELAY 2
#define LOOP_DELAY 20 // ms

// S0(LBS), S1, S2(MSB)
static const BYTE PIN_OUT_COLS[] = { p2, p4, p5 };
static const BYTE PIN_OUT_ROWS[] = { p6, p10, p11};
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
	UARTWrite(1, "R=");
    int col;
    for (col = 0; col < MATRIX_SIZE; ++col)
    {
      int row;
      OutAddr3Bits(col, PIN_OUT_COLS);
      Delay10us(COL_SEL_DELAY); // wait for line charge
      for (row = 0; row < MATRIX_SIZE; ++row)
      {
        char s[8];
        OutAddr3Bits(row, PIN_OUT_ROWS);
        Delay10us(ROW_SEL_DELAY); // wait for a stable signal
        int val = ADCVal(PIN_IN_TOUCH);
        if (row != 0 || col != 0)
        {
          UARTWrite(1, ",");
        }
        sprintf(s, "%d", Convert(val));
        UARTWrite(1, s);
      }
    }
      UARTWrite(1, "\n");

	  //vTaskDelay(LOOP_DELAY);
	}
}
