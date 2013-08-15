unit main;

interface

uses
  DataCollector,
  DataTransport,
  DataTransport_COM,
  DataTransport_Mock,
  DataTransportRec,
  CPort,
  SuperObject,
  Math,
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls;

type
  TForm1 = class(TForm)
    GridPanel: TGridPanel;
    Panel1: TPanel;
    Button1: TButton;
    ComboPorts: TComboBox;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    fDataTransport:TDataTransport;
    fDataCollector:TDataCollector;
    fCaption:string;
    procedure TestColors;
    procedure SetCollectorStatus;
    procedure OnDataCollector(aSender:TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  MATRIX_ROWS=8;
  MATRIX_COLS=8;
  MIN_VALUE=0;
  MAX_VALUE=1024;

procedure TForm1.FormCreate(Sender: TObject);
var
  lRow,lCol:integer;
  lPanel:TPanel;
begin
  fCaption:=self.Caption;
  GridPanel.ColumnCollection.Clear;
  GridPanel.RowCollection.Clear;
  for lCol:=0 to  MATRIX_COLS-1 do
    GridPanel.ColumnCollection.Add;
  for lRow:=0 to MATRIX_ROWS-1 do
    GridPanel.RowCollection.Add;
  for lRow:=0 to MATRIX_ROWS-1 do
  begin
    for lCol:=0 to MATRIX_COLS-1 do
    begin
      lPanel:=TPanel.Create(self);
      lPanel.Parent:=GridPanel;
      lPanel.Align:=alClient;
      lPanel.Visible:=true;
      lPanel.BevelOuter:=bvNone;
      lPanel.ParentColor:=false;
      lPanel.ControlStyle:=lPanel.ControlStyle+[csOpaque]-[csParentBackground];
      lPanel.Color:=clBlack;
    end;
  end;
  fDataTransport:=TDataTransportCom.Create(br19200);
  //fDataTransport:=TDataTransportMock.Create;
  (*
  fDataTransport:=TDataTransportRec.Create(
     IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'capture.orig',
     false);
     *)
  fDataCollector:=TDataCollector.Create(fDataTransport,
                                        ',',
                                        'R=',
                                        #10,
                                        true);
  fDataCollector.pOnData:=OnDataCollector;
  EnumComPorts(ComboPorts.Items);
  if ComboPorts.Items.Count>0 then
    ComboPorts.ItemIndex:=0;
  SetCollectorStatus;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDataCollector);
  fDataTransport.Close;
  FreeAndNil(fDataTransport);
end;

procedure TForm1.TestColors;
var
  i:integer;
  lPanel:TPanel;
  R,G,B:byte;
  lColor:integer;
begin
  G:=0;
  B:=0;
  for i:=0 to GridPanel.ControlCollection.Count-1 do
  begin
    R:=round((255/GridPanel.ControlCollection.Count)*i);

    lColor:=(B shl 16)+(G shl 8)+R;
    lPanel:=TPanel(GridPanel.ControlCollection.Items[i].Control);
    lPanel.Color:=lColor;
    lPanel.Caption:=inttoHex(R,2)+
                    inttoHex(G,2)+
                    inttoHex(B,2);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  TestColors;
end;

procedure TForm1.SetCollectorStatus;
begin
  self.Caption:=fCaption;
  if fDataTransport.IsOpen then
    self.Caption:=fCaption+': collecting data...'
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  fDataCollector.Reset;
  fDataTransport.Open(SO(['port',ComboPorts.Text]));
  SetCollectorStatus;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  fDataTransport.Close;
  fDataCollector.Reset;
  SetCollectorStatus;
end;

procedure TForm1.OnDataCollector(aSender:TObject);
var
  i:integer;
  lCount:integer;
  lPanel:TPanel;
  R,G,B:byte;
  lColor:integer;
  lValue:integer;
begin
  lCount:=min(GridPanel.ControlCollection.Count,
              fDataCollector.pData.Count);
  G:=$0;
  B:=$0;
  for i:=0 to lCount-1 do
  begin
    lValue:=strtointdef(fDataCollector.pData[i],0);
    if lValue>MAX_VALUE then
      lValue:=MAX_VALUE;
    R:=round((255/MAX_VALUE)*lValue);
    lColor:=(B shl 16)+(G shl 8)+R;
    lPanel:=TPanel(GridPanel.ControlCollection.Items[i].Control);
    lPanel.Color:=lColor;
    lPanel.Caption:=fDataCollector.pData[i];
  end;
end;


end.
