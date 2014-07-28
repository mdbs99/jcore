unit TestOPFMappingAutoTests;

{$mode objfpc}{$H+}

interface

uses
  TestOPFConfig;

type

  { TTestOPFInsertAutoMappingTests }

  TTestOPFInsertAutoMappingTests = class(TTestOPFProxyInvoiceAutoMappingTestCase)
  published
    procedure Single;
    procedure Inheritance;
    procedure CompositionNull;
    procedure CompositionSingle1;
    procedure CompositionSingle2;
    procedure CompositionCollection;
  end;

  { TTestOPFSelectAutoMappingTests }

  TTestOPFSelectAutoMappingTests = class(TTestOPFProxyInvoiceAutoMappingTestCase)
  published
    procedure Single;
    procedure Inheritance;
    procedure InheritanceFromParent;
  end;

  { TTestOPFUpdateAutoMappingTests }

  TTestOPFUpdateAutoMappingTests = class(TTestOPFProxyInvoiceAutoMappingTestCase)
  published
    procedure Single;
    procedure InheritanceUpdateParentClass;
    procedure InheritanceUpdateSubClass;
    procedure Inheritance;
  end;

  { TTestOPFDeleteAutoMappingTests }

  TTestOPFDeleteAutoMappingTests = class(TTestOPFProxyInvoiceAutoMappingTestCase)
  published
    procedure SingleFromEntity;
    procedure SingleFromClass;
    procedure InheritanceFromEntity;
    procedure InheritanceFromClass;
    procedure InheritanceFromParentClass;
    procedure InheritanceFromClassWithOIDArray;
  end;

implementation

uses
  testregistry,
  sysutils,
  TestOPFModelInvoice;

{ TTestOPFInsertAutoMappingTests }

procedure TTestOPFInsertAutoMappingTests.Single;
var
  VProduct: TProduct;
begin
  VProduct := TProduct.Create;
  try
    VProduct.Name := 'aprod';
    Session.Store(VProduct);
    AssertSQLDriverCommands([
     'WriteInt64 1',
     'WriteString aprod',
     'ExecSQL INSERT INTO PRODUCT (ID,NAME) VALUES (?,?)']);
  finally
    FreeAndNil(VProduct);
  end;
end;

procedure TTestOPFInsertAutoMappingTests.Inheritance;
var
  VCompany: TCompany;
begin
  VCompany := TCompany.Create;
  try
    VCompany.Name := 'corp';
    VCompany.ContactName := 'james';
    Session.Store(VCompany);
    AssertSQLDriverCommands([
     'WriteInt64 1',
     'WriteString corp',
     'ExecSQL INSERT INTO CLIENT (ID,NAME) VALUES (?,?)',
     'WriteInt64 1',
     'WriteString james',
     'ExecSQL INSERT INTO COMPANY (ID,CONTACTNAME) VALUES (?,?)']);
  finally
    FreeAndNil(VCompany);
  end;
end;

procedure TTestOPFInsertAutoMappingTests.CompositionNull;
var
  VInvoice: TInvoice;
begin
  VInvoice := TInvoice.Create;
  try
    VInvoice.Date := '02/01';
    Session.Store(VInvoice);
    AssertSQLDriverCommands([
     'WriteInt64 1',
     'WriteNull',
     'WriteString 02/01',
     'ExecSQL INSERT INTO INVOICE (ID,CLIENT,DATE) VALUES (?,?,?)']);
  finally
    FreeAndNil(VInvoice);
  end;
end;

procedure TTestOPFInsertAutoMappingTests.CompositionSingle1;
var
  VInvoice: TInvoice;
  VClient: TClient;
begin
  VInvoice := TInvoice.Create;
  try
    VClient := TClient.Create;
    VInvoice.Client := VClient;
    VClient.Name := 'bar sa';
    Session.Store(VClient);
    TTestSQLDriver.Commands.Clear;
    Session.Store(VInvoice);
    AssertSQLDriverCommands([
     'WriteInt64 2',
     'WriteInt64 1',
     'WriteString ',
     'ExecSQL INSERT INTO INVOICE (ID,CLIENT,DATE) VALUES (?,?,?)']);
  finally
    FreeAndNil(VInvoice);
  end;
end;

procedure TTestOPFInsertAutoMappingTests.CompositionSingle2;
var
  VInvoice: TInvoice;
begin
  VInvoice := TInvoice.Create;
  try
    VInvoice.Client := TClient.Create;
    VInvoice.Client.Name := 'bar sa';
    Session.Store(VInvoice);
    AssertSQLDriverCommands([
     'WriteInt64 1',
     'WriteInt64 2',
     'WriteString bar sa',
     'ExecSQL INSERT INTO CLIENT (ID,NAME) VALUES (?,?)',
     'WriteInt64 2',
     'WriteString ',
     'ExecSQL INSERT INTO INVOICE (ID,CLIENT,DATE) VALUES (?,?,?)']);
  finally
    FreeAndNil(VInvoice);
  end;
end;

procedure TTestOPFInsertAutoMappingTests.CompositionCollection;
var
  VInvoice: TInvoice;
  VItemProduct: TInvoiceItemProduct;
  VItemService: TInvoiceItemService;
  VProduct: TProduct;
begin
  VInvoice := TInvoice.Create;
  try
    VItemProduct := TInvoiceItemProduct.Create;
    VInvoice.Items.Add(VItemProduct);
    VItemService := TInvoiceItemService.Create;
    VInvoice.Items.Add(VItemService);
    VProduct := TProduct.Create;
    VItemProduct.Product := VProduct;
    VProduct.Name := 'orange';
    VItemProduct.Qty := 5;
    VItemProduct.Total := 50;
    VItemService.Description := 'transport';
    VItemService.Total := 20;
    Session.Store(VProduct);
    TTestSQLDriver.Commands.Clear;
    Session.Store(VInvoice);
    AssertSQLDriverCommands([
     'WriteInt64 2',
     'WriteNull',
     'WriteString ',
     'ExecSQL INSERT INTO INVOICE (ID,CLIENT,DATE) VALUES (?,?,?)',
     'WriteInt64 3',
     'WriteInt64 2',
     'WriteInt32 50',
     'ExecSQL INSERT INTO INVOICEITEM (ID,INVOICE,TOTAL) VALUES (?,?,?)',
     'WriteInt64 3',
     'WriteInt32 5',
     'WriteInt64 1',
     'ExecSQL INSERT INTO INVOICEITEMPRODUCT (ID,QTY,PRODUCT) VALUES (?,?,?)',
     'WriteInt64 4',
     'WriteInt64 2',
     'WriteInt32 20',
     'ExecSQL INSERT INTO INVOICEITEM (ID,INVOICE,TOTAL) VALUES (?,?,?)',
     'WriteInt64 4',
     'WriteString transport',
     'ExecSQL INSERT INTO INVOICEITEMSERVICE (ID,DESCRIPTION) VALUES (?,?)'
     ]);
  finally
    FreeAndNil(VInvoice);
  end;
end;

{ TTestOPFSelectAutoMappingTests }

procedure TTestOPFSelectAutoMappingTests.Single;
var
  VProduct: TProduct;
begin
  {1}TTestSQLDriver.ExpectedResultsets.Add(1);
  TTestSQLDriver.Data.Add('6');
  TTestSQLDriver.Data.Add('theprod');
  VProduct := Session.Retrieve(TProduct, '6') as TProduct;
  try
    AssertNotNull('prod nil', VProduct);
    AssertEquals('prod id', '6', VProduct._proxy.OID.AsString);
    AssertEquals('prod name', 'theprod', VProduct.Name);
    AssertSQLDriverCommands([
     'WriteInt64 6',
     {1}'ExecSQL SELECT ID,NAME FROM PRODUCT WHERE ID=?']);
    AssertEquals('expr cnt', 0, TTestSQLDriver.ExpectedResultsets.Count);
    AssertEquals('data cnt', 0, TTestSQLDriver.Data.Count);
  finally
    FreeAndNil(VProduct);
  end;
end;

procedure TTestOPFSelectAutoMappingTests.Inheritance;
var
  VCompany: TCompany;
begin
  {1}TTestSQLDriver.ExpectedResultsets.Add(1);
  TTestSQLDriver.Data.Add('6');
  TTestSQLDriver.Data.Add('acorp');
  TTestSQLDriver.Data.Add('jack');
  VCompany := Session.Retrieve(TCompany, '6') as TCompany;
  try
    AssertNotNull('comp nil', VCompany);
    AssertEquals('comp id', '6', VCompany._proxy.OID.AsString);
    AssertEquals('comp name', 'acorp', VCompany.Name);
    AssertEquals('comp contact', 'jack', VCompany.ContactName);
    AssertSQLDriverCommands([
     'WriteInt64 6',
     {1}'ExecSQL SELECT T_0.ID,T_0.NAME,T_1.CONTACTNAME FROM CLIENT T_0 INNER JOIN COMPANY T_1 ON T_0.ID=T_1.ID WHERE T_0.ID=?']);
  finally
    FreeAndNil(VCompany);
  end;
end;

procedure TTestOPFSelectAutoMappingTests.InheritanceFromParent;
var
  VClient: TClient;
  VCompany: TCompany;
begin
  {1}TTestSQLDriver.ExpectedResultsets.Add(1);
  TTestSQLDriver.Data.Add('12');
  TTestSQLDriver.Data.Add('null');
  TTestSQLDriver.Data.Add('12');
  TTestSQLDriver.Data.Add('thecorp');
  {2}TTestSQLDriver.ExpectedResultsets.Add(1);
  TTestSQLDriver.Data.Add('12');
  TTestSQLDriver.Data.Add('joe');
  VClient := Session.Retrieve(TClient, '12') as TClient;
  try
    AssertNotNull('client nil', VClient);
    AssertTrue('is client TCompany', VClient is TCompany);
    VCompany := VClient as TCompany;
    AssertEquals('comp id', '12', VCompany._proxy.OID.AsString);
    AssertEquals('comp name', 'thecorp', VCompany.Name);
    AssertEquals('comp contact', 'joe', VCompany.ContactName);
    AssertSQLDriverCommands([
     'WriteInt64 12',
     {1}'ExecSQL SELECT T_0.ID,TS_0.ID,TS_1.ID,T_0.NAME FROM CLIENT T_0 LEFT OUTER JOIN PERSON TS_0 ON T_0.ID=TS_0.ID LEFT OUTER JOIN COMPANY TS_1 ON T_0.ID=TS_1.ID WHERE T_0.ID=?',
     'WriteInt64 12',
     {2}'ExecSQL SELECT ID,CONTACTNAME FROM COMPANY WHERE ID=?']);
  finally
    FreeAndNil(VClient);
  end;
end;

{ TTestOPFUpdateAutoMappingTests }

procedure TTestOPFUpdateAutoMappingTests.Single;
var
  VProduct: TProduct;
begin
  VProduct := TProduct.Create;
  try
    VProduct.Name := 'aprod';
    Session.Store(VProduct);
    TTestSQLDriver.Commands.Clear;
    VProduct.Name := 'newprod';
    Session.Store(VProduct);
    AssertSQLDriverCommands([
     'WriteString newprod',
     'WriteInt64 1',
     'ExecSQL UPDATE PRODUCT SET NAME=? WHERE ID=?']);
  finally
    FreeAndNil(VProduct);
  end;
end;

procedure TTestOPFUpdateAutoMappingTests.InheritanceUpdateParentClass;
var
  VPerson: TPerson;
begin
  VPerson := TPerson.Create;
  try
    VPerson.Name := 'james';
    VPerson.Nick := 'j';
    Session.Store(VPerson);
    TTestSQLDriver.Commands.Clear;
    VPerson.Name := 'j.james';
    Session.Store(VPerson);
    AssertSQLDriverCommands([
     'WriteString j.james',
     'WriteInt64 1',
     'ExecSQL UPDATE CLIENT SET NAME=? WHERE ID=?']);
  finally
    FreeAndNil(VPerson);
  end;
end;

procedure TTestOPFUpdateAutoMappingTests.InheritanceUpdateSubClass;
var
  VPerson: TPerson;
begin
  VPerson := TPerson.Create;
  try
    VPerson.Name := 'j.james';
    VPerson.Nick := 'j';
    Session.Store(VPerson);
    TTestSQLDriver.Commands.Clear;
    VPerson.Nick := 'jj';
    Session.Store(VPerson);
    AssertSQLDriverCommands([
     'WriteString jj',
     'WriteInt64 1',
     'ExecSQL UPDATE PERSON SET NICK=? WHERE ID=?']);
  finally
    FreeAndNil(VPerson);
  end;
end;

procedure TTestOPFUpdateAutoMappingTests.Inheritance;
var
  VPerson: TPerson;
begin
  VPerson := TPerson.Create;
  try
    VPerson.Name := 'james';
    VPerson.Nick := 'j';
    Session.Store(VPerson);
    TTestSQLDriver.Commands.Clear;
    VPerson.Name := 'j.james';
    VPerson.Nick := 'jj';
    Session.Store(VPerson);
    AssertSQLDriverCommands([
     'WriteString j.james',
     'WriteInt64 1',
     'ExecSQL UPDATE CLIENT SET NAME=? WHERE ID=?',
     'WriteString jj',
     'WriteInt64 1',
     'ExecSQL UPDATE PERSON SET NICK=? WHERE ID=?']);
  finally
    FreeAndNil(VPerson);
  end;
end;

{ TTestOPFDeleteAutoMappingTests }

procedure TTestOPFDeleteAutoMappingTests.SingleFromEntity;
var
  VProduct: TProduct;
begin
  VProduct := TProduct.Create;
  try
    VProduct.Name := 'aprod';
    Session.Store(VProduct);
    TTestSQLDriver.Commands.Clear;
    Session.Dispose(VProduct);
    AssertSQLDriverCommands([
     'WriteInt64 1',
     'ExecSQL DELETE FROM PRODUCT WHERE ID=?']);
  finally
    FreeAndNil(VProduct);
  end;
end;

procedure TTestOPFDeleteAutoMappingTests.SingleFromClass;
begin
  Session.Dispose(TProduct, ['7']);
  AssertSQLDriverCommands([
   'WriteInt64 7',
   'ExecSQL DELETE FROM PRODUCT WHERE ID=?']);
end;

procedure TTestOPFDeleteAutoMappingTests.InheritanceFromEntity;
var
  VPerson: TPerson;
begin
  VPerson := TPerson.Create;
  try
    VPerson.Name := 'joe';
    Session.Store(VPerson);
    TTestSQLDriver.Commands.Clear;
    Session.Dispose(VPerson);
    AssertSQLDriverCommands([
     'WriteInt64 1',
     'ExecSQL DELETE FROM CLIENT WHERE ID=?',
     'WriteInt64 1',
     'ExecSQL DELETE FROM PERSON WHERE ID=?']);
  finally
    FreeAndNil(VPerson);
  end;
end;

procedure TTestOPFDeleteAutoMappingTests.InheritanceFromClass;
begin
  Session.Dispose(TPerson, ['5']);
  AssertSQLDriverCommands([
   'WriteInt64 5',
   'ExecSQL DELETE FROM CLIENT WHERE ID=?',
   'WriteInt64 5',
   'ExecSQL DELETE FROM PERSON WHERE ID=?']);
end;

procedure TTestOPFDeleteAutoMappingTests.InheritanceFromParentClass;
begin
  Session.Dispose(TClient, ['2']);
  AssertSQLDriverCommands([
   'WriteInt64 2',
   'ExecSQL DELETE FROM CLIENT WHERE ID=?',
   'WriteInt64 2',
   'ExecSQL DELETE FROM PERSON WHERE ID=?',
   'WriteInt64 2',
   'ExecSQL DELETE FROM COMPANY WHERE ID=?']);
end;

procedure TTestOPFDeleteAutoMappingTests.InheritanceFromClassWithOIDArray;
begin
  Session.Dispose(TPerson, ['7', '9', '11']);
  AssertSQLDriverCommands([
   'WriteInt64 7',
   'WriteInt64 9',
   'WriteInt64 11',
   'ExecSQL DELETE FROM CLIENT WHERE ID IN (?,?,?)',
   'WriteInt64 7',
   'WriteInt64 9',
   'WriteInt64 11',
   'ExecSQL DELETE FROM PERSON WHERE ID IN (?,?,?)']);
end;

initialization
  RegisterTest('jcore.opf.mapping.automapping', TTestOPFInsertAutoMappingTests);
  RegisterTest('jcore.opf.mapping.automapping', TTestOPFSelectAutoMappingTests);
  RegisterTest('jcore.opf.mapping.automapping', TTestOPFUpdateAutoMappingTests);
  RegisterTest('jcore.opf.mapping.automapping', TTestOPFDeleteAutoMappingTests);

end.

