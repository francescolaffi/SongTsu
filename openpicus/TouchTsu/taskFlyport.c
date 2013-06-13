#include "taskFlyport.h"
#include "rtcc.h"
//define to have a visual blink in case of changed parameters!
#define BlinkParams

// CONFIGURATION PAGE Variable:
extern BOOL ParamSet;
// RTCC VARIABLES:
extern BOOL alarmflag;
t_RTCC myrtcc;
t_RTCC myalarm;
// WiFi Scan Variables:
extern BOOL ScanCompleted;		// This var is declared in WiFi events
extern BOOL startScan;
BOOL scanningResultsReady = FALSE;
tWFNetwork NetData;
char scannedString [2500];

// USER CUSTOMIZABLE PARAMETERS:
const int setuptimeSec = 3;		// seconds of pause for setup time
const int setuptimeMin = 1;		// minutes of pause for setup time
const int setupPinNumber = 5;	// pin number to assign for setup mode select
const int scanPinNumber = 7;	// pin number to assign for the scanning function
const int waitbuttonSec = 3;	// seconds to wait for the reset to default factory button
int pos = 1;

void FlyportTask()
{
	// At the startup the module should enter in a
	// "setuptime" pause, where the Wi-Fi connection is always
	// in adhoc mode for setting up the custom parameters

	// Setup Hardware
	IOInit(setupPinNumber, inup);	// setupPinNumber input with pullup resistor
	IOInit(scanPinNumber, inup);	// scanPinNumber input with pullup resitor
	IOInit(21, out);				// to be sure that LED5 is output
	IOInit(19, out);				// to be sure that LED4 is output

	// Set RTCC
	myrtcc.year = 12; //last two year number
	myrtcc.month = 2;
	myrtcc.dweek = 4; //sunday is 0
	myrtcc.day = 2;
	myrtcc.hour = 00;
	myrtcc.min = 00;
	myrtcc.sec = 00;
	// Create alarm configuration
	myalarm = myrtcc;
	myalarm.sec = myalarm.sec + setuptimeSec;
	myalarm.min = myalarm.min + setuptimeMin;
	vTaskDelay(100);
	ScanCompleted = FALSE;
	scanningResultsReady = FALSE;
	WFScan();
	while(!ScanCompleted);
	UARTWrite(1,"\r\nNetworks found:\r\n");
	// Reads all discovered networks stored in the memory of Flyport and writes the results
	while (pos < (WFNetworkFound+1))
	{
		NetData = WFScanList(pos);
		char temp[500];
		char sec[300];
		if (NetData.security == WF_SECURITY_OPEN)
		{
			sprintf(sec, "OPEN");
		}
		if (NetData.security == WF_SECURITY_GENERIC_WPA)
		{
			sprintf(sec, "WPA");
		}
		if (NetData.security == WF_SECURITY_GENERIC_WPA2)
		{
			sprintf(sec, "WPA2");
		}
		if (NetData.security == WF_SECURITY_GENERIC_WEP)
		{
			sprintf(sec, "WEP");
		}
		sprintf(temp, "SSID:%s\r\nSecurity:%s\r\n", NetData.ssid, sec);
		vTaskDelay(20);
		pos++;
		scanningResultsReady = TRUE;
		// Append the results to the string
		strcat(scannedString, temp);
	}
	// Print on UART the networks found list
	UARTWrite(1, scannedString);
	UARTWrite(1,"\r\nSetup completed\r\nconnecting to setup (default) parameters...\r\n");
	WFConnect(WF_DEFAULT);
	while (WFStatus != CONNECTED);
	vTaskDelay(200); // wait for DHCP...
	
	// Write settings on internal registers
	RTCCWrite(&myrtcc);
	// Set Alarm configuration to internal registers
	RTCCSetAlarm(&myalarm, REPEAT_INFINITE, EVERY_TEN_MIN);
	// Active alarm
	RTCCRunAlarm(1); // 1 turn on, 0 turn off
	UARTWrite(1, "RTCC setup completed!\r\nentering inside the RTCC timed loop...\r\n");
	
	while(alarmflag == 0)
	{
		// wait for the alarm... setup only configuration!
		IOPut(21, toggle);
		vTaskDelay(50);
		// If the parameters are updated by webpage, exit!
		if(ParamSet)
		{
			UARTWrite(1, "quit from timed loop...\r\n");
			break;
		}
	}
	IOPut(21, on);
	RTCCRunAlarm(0); // turn off alarm now...
	WFDisconnect();
	while (WFStatus != NOT_CONNECTED);
	vTaskDelay(50);
	
	if (WFCustomExist())
	{
		WFCustomLoad();
		UARTWrite(1,"Connecting to custom...\r\n");
		WFConnect(WF_CUSTOM);
	}
	else
	{
		UARTWrite(1,"Connecting to default...\r\n");
		WFConnect(WF_DEFAULT);
	}
	while (WFStatus != CONNECTED);
	
	vTaskDelay(100);
	
	UARTWrite(1,"\r\nEntering in infinite loop...\r\n");
	
	while(1)
	{
		if (ParamSet)
		{
			#ifdef BlinkParams
			int k;
			for (k=0; k<8; k++)
			{
				IOPut(21, on);
				vTaskDelay(17);
				IOPut(21, toggle);
				vTaskDelay(8);
				IOPut(21, toggle);
			}
			#endif
			UARTWrite(1, "Params changed!\r\n");
			WFDisconnect();
			while (WFStatus != NOT_CONNECTED);
			vTaskDelay(50);
			IOPut(21, toggle);
			WFCustomSave();
			UARTWrite(1,"Custom config saved!\r\n");
			UARTWrite(1,"Connecting custom...\r\n");
			WFConnect(WF_CUSTOM);
			while (WFStatus != CONNECTED);
			ParamSet = FALSE;
			IOPut(21, on);
		}
		if ( IOButtonState(setupPinNumber) == pressed )
		{
			IOPut(19, on);
			vTaskDelay(waitbuttonSec*100);  // wait for about waitbuttonSec seconds 
											// and check if the button is pressed again...
			if( IOButtonState(setupPinNumber) == pressed)
			{
				IOPut(19, off);
				WFCustomDelete();
				UARTWrite(1, "\r\n****\r\nParams deleted!\r\n****\r\n");
				WFDisconnect();
				while (WFStatus != NOT_CONNECTED);
				vTaskDelay(50);
				UARTWrite(1,"Connecting defaults...\r\n");
				WFConnect(WF_DEFAULT);
			}
			else
				IOPut(19, off);
		}
		if ( (IOButtonState(scanPinNumber) == pressed) || (startScan == TRUE) )
		{
			startScan = FALSE;
			scanningResultsReady = FALSE;
			pos = 1;
			UARTWrite(1,"Starting scan...\r\n");
			ScanCompleted = FALSE;
			WFScan();
			while(!ScanCompleted);
			UARTWrite(1,"\r\nNetworks found:\r\n");
			scannedString[0] = '\0';
			// Reads all discovered networks stored in the memory of Flyport and writes the results
			while (pos < (WFNetworkFound+1))
			{
				NetData = WFScanList(pos);
				char temp[500];
				char sec[300];
				if (NetData.security == WF_SECURITY_OPEN)
				{
					sprintf(sec, "OPEN");
				}
				if (NetData.security == WF_SECURITY_GENERIC_WPA)
				{
					sprintf(sec, "WPA");
				}
				if (NetData.security == WF_SECURITY_GENERIC_WPA2)
				{
					sprintf(sec, "WPA2");
				}
				if (NetData.security == WF_SECURITY_GENERIC_WEP)
				{
					sprintf(sec, "WEP");
				}
				sprintf(temp, "SSID:%s\r\nSecurity:%s\r\n", NetData.ssid, sec);
				vTaskDelay(20);
				pos++;
				// Append the results to the string
				strcat(scannedString, temp);
				scanningResultsReady = TRUE;
			}
			// Print on UART the networks found list
			UARTWrite(1, scannedString);
		}
	}
}
