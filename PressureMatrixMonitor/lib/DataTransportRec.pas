unit DataTransportRec;

interface

uses
  DataTransport,
  SuperObject,
  Math,
  Classes,
  ExtCtrls,
  SysUtils;

type
  TDataTransportRec=class(TDataTransport)
  protected
    fHasData:boolean;
    fTimer:TTimer;
    fRow:integer;
    fColumn:integer;
    fList:TStringList;
    fLoop:boolean;
    procedure OnTimer(aSender:TObject);
  public
    constructor Create(aFileName:string;
                       aLoop:boolean);overload;
    constructor Create(aList:TStringList;
                       aLoop:boolean);overload;
    destructor Destroy;override;
    function Close:boolean;override;
    function Open(aConf:ISuperObject):boolean;override;
    function IsOpen:boolean;override;
    function GetData(aBuffer:pointer;
                     aBufferSize:integer;
                     var aRead:integer):boolean;override;
  end;

implementation


constructor TDataTransportRec.Create(aFileName:string;
                                     aLoop:boolean);
begin
  inherited Create;
  fTimer:=TTimer.Create(nil);
  fTimer.Enabled:=false;
  fTimer.OnTimer:=OnTimer;
  fTimer.Interval:=50;
  fList:=TStringList.Create;
  fHasData:=false;
  fLoop:=aLoop;
  if FileExists(aFileName) then
  begin
    fList.LoadFromFile(aFileName);
    fList.Text:=trim(fList.Text);
  end;
end;

constructor TDataTransportRec.Create(aList:TStringList;
                                     aLoop:boolean);
begin
  fTimer:=TTimer.Create(nil);
  fTimer.Enabled:=false;
  fTimer.OnTimer:=OnTimer;
  fTimer.Interval:=50;
  fList:=TStringList.Create;
  fHasData:=false;
  fLoop:=aLoop;
  fList:=aList;
  if assigned(fList) then
    fList.Text:=trim(fList.Text);
end;

destructor TDataTransportRec.Destroy;
begin
  FreeAndNil(fTimer);
  FreeAndNil(fList);
  inherited Destroy;
end;

function TDataTransportRec.Close:boolean;
begin
  fTimer.Enabled:=false;
  result:=not fTimer.Enabled;
end;

function TDataTransportRec.Open(aConf:ISuperObject):boolean;
begin
  fTimer.Enabled:=false;
  fRow:=0;
  fColumn:=1;
  fHasData:=false;
  result:=assigned(fList);
  if result then
    result:=fList.Count>0;
  if result then
    fTimer.Enabled:=true;
end;

function TDataTransportRec.IsOpen:boolean;
begin
  result:=fTimer.Enabled;
end;

procedure TDataTransportRec.OnTimer(aSender:TObject);
begin
  if assigned(fList) then
  begin
    fHasData:=fRow<fList.Count;
    if assigned(pOnData) then
      pOnData(self);
  end;
end;

function TDataTransportRec.GetData(aBuffer:pointer;
                                    aBufferSize:integer;
                                     var aRead:integer):boolean;
var
  lStr:AnsiString;
begin
  result:=(assigned(aBuffer))and
          (aBufferSize>0)and
          (fHasData)and
          (assigned(fList));
  if result then
  begin
    lStr:=fList.Strings[fRow]+#10;
    aRead:=min(length(lStr)-fColumn+1,aBufferSize);
    move(lStr[fColumn],aBuffer^,aRead);
    inc(fColumn,aRead);
    if fColumn>=length(lStr) then
    begin
      fColumn:=1;
      inc(fRow);
      if (fLoop)and
         (fRow>=fList.Count)
      then
        fRow:=0;
      fHasData:=false;
    end;
    result:=aRead>0;
  end;
end;

end.

