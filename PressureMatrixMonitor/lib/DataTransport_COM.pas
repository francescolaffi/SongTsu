unit DataTransport_COM;

interface

uses
  DataTransport,
  CPort,
  CPortCtl,
  Math,
  SuperObject,
  SysUtils;

type
  TDataTransportCom=class(TDataTransport)
  protected
    fPort:TComPort;
    fCount:integer;
    procedure OnDataAvailable(aSender:TObject;aCount:integer);
    function GetPort:string;
  public
    constructor Create(aRate:TBaudRate);
    destructor Destroy;override;
    function Close:boolean;override;
    function Open(aConf:ISuperObject):boolean;override;
    function IsOpen:boolean;override;
    function GetData(aBuffer:pointer;
                     aBufferSize:integer;
                     var aRead:integer):boolean;override;
  end;

implementation

constructor TDataTransportCom.Create(aRate:TBaudRate);
begin
  inherited Create;
  fPort:=TComPort.Create(nil);
  fPort.BaudRate:=aRate;
  fPort.StopBits:=sbOneStopBit;
  fPort.DataBits:=dbEight;
  fPort.OnRxChar:=OnDataAvailable;
end;

destructor TDataTransportCom.Destroy;
begin
  FreeAndNil(fPort);
  inherited Destroy;
end;

function TDataTransportCom.GetPort:string;
begin
  result:='';
  if fPort.Connected then
    result:=fPort.Port;
end;

function TDataTransportCom.Close:boolean;
begin
  try
    if fPort.Connected then
      fPort.Close;
  finally
    result:=not fPort.Connected;
  end;
end;

function TDataTransportCom.Open(aConf:ISuperObject):boolean;
var
  lPort:string;
begin
  try
    if assigned(aConf) then
      lPort:=trim(aConf.S['port']);
    if fPort.Connected then
    begin
      if fPort.Port<>lPort then
        Close;
    end;
    if not fPort.Connected then
    begin
      fPort.Port:=lPort;
      if fPort.Port<>'' then
      begin
        fCount:=0;
        fPort.Open;
      end;
    end;
  finally
    result:=fPort.Connected;
  end;
end;

function TDataTransportCom.IsOpen:boolean;
begin
  result:=fPort.Connected;
end;

procedure TDataTransportCom.OnDataAvailable(aSender:TObject;aCount:integer);
begin
  fCount:=aCount;
  if assigned(pOnData) then
    pOnData(self);

end;

function TDataTransportCom.GetData(aBuffer:pointer;
                                   aBufferSize:integer;
                                   var aRead:integer):boolean;
begin
  result:=(assigned(aBuffer))and
          (aBufferSize>0)and
          (fCount>0);
  if result then
  begin
    aRead:=fPort.Read(aBuffer^,min(fCount,aBUfferSize));
    dec(fCount,aRead);
    result:=aRead>0;
  end;
end;

end.
