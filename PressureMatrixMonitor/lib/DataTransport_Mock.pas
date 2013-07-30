unit DataTransport_Mock;


interface

uses
  DataTransport,
  SuperObject,
  Math,
  ExtCtrls,
  SysUtils;

type
  TDataTransportMock=class(TDataTransport)
  protected
    fDataBuffer:array[0..1023] of AnsiChar;
    fStart:integer;
    fTimer:TTimer;
    procedure OnTimer(aSender:TObject);
  public
    constructor Create;
    destructor Destroy;override;
    function Close:boolean;override;
    function Open(aConf:ISuperObject):boolean;override;
    function IsOpen:boolean;override;
    function GetData(aBuffer:pointer;
                     aBufferSize:integer;
                     var aRead:integer):boolean;override;
  end;

implementation

const
  MAX_COUNT=64;
  MAX_VALUE=1024;
  CHAR_SEP=',';
  CHAR_END=#10;


constructor TDataTransportMock.Create;
begin
  inherited Create;
  randomize;
  fTimer:=TTimer.Create(nil);
  fTimer.Enabled:=false;
  fTimer.OnTimer:=OnTimer;
  fTimer.Interval:=1000;
end;

destructor TDataTransportMock.Destroy;
begin
  FreeAndNil(fTimer);
  inherited Destroy;
end;

function TDataTransportMock.Close:boolean;
begin
  fTimer.Enabled:=false;
  result:=not fTimer.Enabled;
end;

function TDataTransportMock.Open(aConf:ISuperObject):boolean;
begin
  fTimer.Enabled:=true;
  result:=fTimer.Enabled;
end;

function TDataTransportMock.IsOpen:boolean;
begin
  result:=fTimer.Enabled;
end;

procedure TDataTransportMock.OnTimer(aSender:TObject);
var
  i:integer;
  lVal:integer;
  lDigit:byte;
begin
  fStart:=length(fDataBuffer)-1;
  fDataBuffer[fStart]:=CHAR_END;
  dec(fStart);
  for i:=0 to MAX_COUNT-1 do
  begin
    lVal:=random(MAX_VALUE+1);
    while lVal>0 do
    begin
      lDigit:=lVal mod 10;
      lVal:=lVal div 10;
      fDataBuffer[fStart]:=AnsiChar(chr(lDigit+ord('0')));
      dec(fStart);
    end;
    if i<(MAX_COUNT-1) then
    begin
      fDataBuffer[fStart]:=CHAR_SEP;
      dec(fStart);
    end;
  end;
  fDataBuffer[fStart]:='=';
  dec(fStart);
  fDataBuffer[fStart]:='R';
  if assigned(pOnData) then
    pOnData(self);
end;



function TDataTransportMock.GetData(aBuffer:pointer;
                                   aBufferSize:integer;
                                   var aRead:integer):boolean;
begin
  result:=(assigned(aBuffer))and
          (aBufferSize>0)and
          (fStart<length(fDataBuffer)-1);
  if result then
  begin
    aRead:=min(length(fDataBuffer)-fStart,aBufferSize);
    move(fDataBuffer[fStart],aBuffer^,aRead);
    inc(fStart,aRead);
    result:=aRead>0;
  end;
end;



end.

