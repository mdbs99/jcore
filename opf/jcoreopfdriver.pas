unit JCoreOPFDriver;

{$mode objfpc}{$H+}

interface

uses
  fgl;

type

  {
    Some lines about SQL Driver.

    * Write<Data> are added in the same order of the Query fields, eg:
    - WriteInteger 15
    - WriteString ThePersonName
    - ExecSQL INSERT INTO PERSON(ID, NAME) VALUES(?, ?)
    - WriteString TheCityName
    - WriteInteger 4
    - ExecSQL UPDATE CITY SET NAME=? WHERE ID=?

    * Create a stack with Write<Data>, ie, take the last entries if the number of
      <Data> is greater then the number of Query fields:
    - WriteInteger 15
    - WriteString ThePersonName
    - WriteInteger 4
    - WriteString TheCityName
    - ExecSQL INSERT INTO CITY(ID, NAME) VALUES(?, ?)
    - WriteInteger 4
    - ExecSQL INSERT INTO PERSON(ID, NAME, CITY) VALUES(?, ?, ?)

    * The same logic to deletes:
    - WriteInteger 15
    - ExecSQL DELETE FROM PERSON WHERE ID=?

    * Selects read params from the same stack and create a separate queue for
      future reading
    - WriteInteger 15
    - ExecSQL SELECT NAME,CITY FROM PERSON WHERE ID=?
    - ReadString
    - ReadInteger

    * The number of Query fields need to match the number of Write<Data>. On the
      commit event, if there are some Write<Data> in the stack, raise an exception

      * Always return de ExecSQL function with the number of the affected rows.

    * Drivers, as well as Mappings and Sessions are NOT thread safe. A threaded
      application need to create one Session per thread, which will create its
      own Mappings and Drivers. So relax =)
  }

  { TJCoreOPFDriver }

  TJCoreOPFDriver = class(TObject)
  public
    procedure WriteString(const AValue: string); virtual; abstract;
    procedure WriteInteger(const AValue: Integer); virtual; abstract;
    class function DriverName: string; virtual; abstract;
    function ReadString: string; virtual; abstract;
    function ReadInteger: Integer; virtual; abstract;
  end;

  TJCoreOPFDriverClass = class of TJCoreOPFDriver;

  TJCoreOPFDriverClassList = specialize TFPGMap<string, TJCoreOPFDriverClass>;

  { TJCoreOPFSQLDriver }

  TJCoreOPFSQLDriver = class(TJCoreOPFDriver)
  public
    procedure WriteNull; virtual; abstract;
    function ExecSQL(const ASQL: string): Integer; virtual; abstract;
    procedure ExecSQL(const ASQL: string; const AExpectedSize: Integer);
  end;

implementation

uses
  JCoreOPFException;

{ TJCoreOPFSQLDriver }

procedure TJCoreOPFSQLDriver.ExecSQL(const ASQL: string; const AExpectedSize: Integer);
var
  VSize: Integer;
begin
  VSize := ExecSQL(ASQL);
  if (VSize <> AExpectedSize) and (AExpectedSize <> -1) then
  begin
    if VSize = 0 then
      raise EJCoreOPFEmptyResultSet.Create(AExpectedSize);
    raise EJCoreOPFUnexpectedResultSetSize.Create(AExpectedSize, VSize);
  end;
end;

end.
