program PressureMatrixMonitor;

uses
  FastMM4,
  Forms,
  main in 'lib\main.pas' {Form1},
  DataCollector in 'lib\DataCollector.pas',
  DataTransport in 'lib\DataTransport.pas',
  DataTransport_COM in 'lib\DataTransport_COM.pas',
  DataTransport_Mock in 'lib\DataTransport_Mock.pas',
  DataTransportRec in 'lib\DataTransportRec.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
