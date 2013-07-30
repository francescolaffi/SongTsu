unit DataTransport;

interface

uses
  SuperObject,
  Classes;

type
  TDataTransport=class
  public
    pOnData:TNotifyEvent;
    function Close:boolean;virtual;abstract;
    function Open(aConf:ISuperObject):boolean;virtual;abstract;
    function IsOpen:boolean;virtual;abstract;
    function GetData(aBuffer:pointer;
                     aBufferSize:integer;
                     var aRead:integer):boolean;virtual;abstract;
  end;

implementation

end.
