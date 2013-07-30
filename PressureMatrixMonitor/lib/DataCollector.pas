unit DataCollector;

interface

uses
  DataTransport,
  Classes,
  SysUtils,
  SuperObject;

const
  CONST_BS=1024;

type
  TDataCollector=class
  protected
    fData:TStringList;
    fTransport:TDataTransport;
    fDataBuffer:array[0..CONST_BS-1] of byte;
    fDataStr:AnsiString;
    fStart:AnsiString;
    fEnd:AnsiChar;
    fSave:boolean;
    fStream:TFileStream;
    procedure OnDataAvailable(aSender:TObject);
  public
    pOnData:TNotifyEvent;
  public
    constructor Create(aTransport:TDataTransport;
                       aSep:AnsiChar;
                       aStart:AnsiString;
                       aEnd:AnsiChar;
                       aSave:boolean);
    destructor Destroy;override;
    procedure Reset;
    property pData:TStringList read fData;
  end;

implementation

constructor TDataCollector.Create(aTransport:TDataTransport;
                                 aSep:AnsiChar;
                                 aStart:AnsiString;
                                 aEnd:AnsiChar;
                                 aSave:boolean);
begin
  inherited Create;
  fData:=TStringList.Create;
  fData.StrictDelimiter:=true;
  fData.Delimiter:=char(aSep);
  fStart:=aStart;
  fEnd:=aEnd;
  fTransport:=aTransport;
  if assigned(fTransport) then
    fTransport.pOnData:=OnDataAvailable;
  fStream:=nil;
  fSave:=aSave;
  if aSave then

end;

destructor TDataCollector.Destroy;
begin
  FreeAndNil(fData);
  if assigned(fStream) then
    FreeAndNil(fStream);
  inherited Destroy;
end;

procedure TDataCollector.Reset;
begin
  fDataStr:='';
  if assigned(fStream) then
    FreeAndNil(fStream);
end;

procedure TDataCollector.OnDataAvailable(aSender:TObject);
var
  lRead:integer;
  lStartPos:integer;
  lEndPos:integer;
begin
  if assigned(fTransport) then
  begin
    while fTransport.GetData(@fDataBuffer[0],CONST_BS-2,lRead) do
    begin
      fDataBuffer[lRead]:=0;
      fDataBuffer[lRead+1]:=0;
      fDataStr:=fDataStr+AnsiString(pAnsiChar(@fDataBuffer[0]));
      lStartPos:=pos(fStart,fDataStr);
      if lStartPos>1 then
        delete(fDataStr,1,lStartPos-1);
      lEndPos:=pos(fEnd,fDataStr);
      if (lStartPos>0)and
         (lEndPos>0)and
         (lStartPos<lEndPos)
      then
      begin
        fData.DelimitedText:=trim(string(copy(fDataStr,
                                              lStartPos+length(fStart),
                                              lEndPos-(lStartPos+length(fStart)))));
        if (fSave)and
           (not assigned(fStream))
        then
          fStream:=TFileStream.Create(IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'capture.dat',fmCreate);
        if assigned(fStream) then
          fStream.Write(fDataStr[lStartPos],lEndPos-lStartPos+1);
        delete(fDataStr,1,lEndPos);
        if assigned(pOnData) then
          pOnData(self);
      end;
    end;
  end;
end;



end.


