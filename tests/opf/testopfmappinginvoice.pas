unit TestOPFMappingInvoice;

{$mode objfpc}{$H+}

interface

uses
  JCoreOPFMetadata,
  TestOPFMapping;

type

  { TClientSQLMapping }

  TClientSQLMapping = class(TTestAbstractSQLMapping)
  protected
    function CreateEntityFromDriver: TObject; override;
    function GenerateDeleteStatement(const AOIDCount: Integer): string; override;
    function GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string; override;
    function GenerateSelectStatement(const ABaseMap: TJCoreOPFMap; const AOwnerClass: TJCoreOPFClassMetadata; const AOwnerAttr: TJCoreOPFAttrMetadata; const AOIDCount: Integer): string; override;
    function GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string; override;
    procedure ReadFromDriver(const AMapping: TJCoreOPFADMMapping); override;
    procedure WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping); override;
  public
    class function Apply(const AMap: TJCoreOPFMap): Boolean; override;
  end;

  { TPersonSQLMapping }

  TPersonSQLMapping = class(TClientSQLMapping)
  protected
    function GenerateDeleteStatement(const AOIDCount: Integer): string; override;
    function GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string; override;
    function GenerateSelectStatement(const ABaseMap: TJCoreOPFMap; const AOwnerClass: TJCoreOPFClassMetadata; const AOwnerAttr: TJCoreOPFAttrMetadata; const AOIDCount: Integer): string; override;
    function GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string; override;
    procedure ReadFromDriver(const AMapping: TJCoreOPFADMMapping); override;
    procedure WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping); override;
  public
    class function Apply(const AMap: TJCoreOPFMap): Boolean; override;
  end;

  { TCompanySQLMapping }

  TCompanySQLMapping = class(TClientSQLMapping)
  protected
    function GenerateDeleteStatement(const AOIDCount: Integer): string; override;
    function GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string; override;
    function GenerateSelectStatement(const ABaseMap: TJCoreOPFMap; const AOwnerClass: TJCoreOPFClassMetadata; const AOwnerAttr: TJCoreOPFAttrMetadata; const AOIDCount: Integer): string; override;
    function GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string; override;
    procedure ReadFromDriver(const AMapping: TJCoreOPFADMMapping); override;
    procedure WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping); override;
  public
    class function Apply(const AMap: TJCoreOPFMap): Boolean; override;
  end;

  { TProductSQLMapping }

  TProductSQLMapping = class(TTestAbstractSQLMapping)
  protected
    function GenerateDeleteStatement(const AOIDCount: Integer): string; override;
    function GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string; override;
    function GenerateSelectStatement(const ABaseMap: TJCoreOPFMap; const AOwnerClass: TJCoreOPFClassMetadata; const AOwnerAttr: TJCoreOPFAttrMetadata; const AOIDCount: Integer): string; override;
    function GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string; override;
    procedure ReadFromDriver(const AMapping: TJCoreOPFADMMapping); override;
    procedure WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping); override;
  public
    class function Apply(const AMap: TJCoreOPFMap): Boolean; override;
  end;

  { TInvoiceSQLMapping }

  TInvoiceSQLMapping = class(TTestAbstractSQLMapping)
  protected
    function GenerateDeleteStatement(const AOIDCount: Integer): string; override;
    function GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string; override;
    function GenerateSelectStatement(const ABaseMap: TJCoreOPFMap; const AOwnerClass: TJCoreOPFClassMetadata; const AOwnerAttr: TJCoreOPFAttrMetadata; const AOIDCount: Integer): string; override;
    function GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string; override;
    procedure ReadFromDriver(const AMapping: TJCoreOPFADMMapping); override;
    procedure WriteExternalsToDriver(const AMapping: TJCoreOPFADMMapping); override;
    procedure WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping); override;
  public
    class function Apply(const AMap: TJCoreOPFMap): Boolean; override;
  end;

  { TInvoiceItemSQLMapping }

  TInvoiceItemSQLMapping = class(TTestAbstractSQLMapping)
  protected
    function CreateEntityFromDriver: TObject; override;
    function GenerateDeleteStatement(const AOIDCount: Integer): string; override;
    function GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string; override;
    function GenerateSelectStatement(const ABaseMap: TJCoreOPFMap; const AOwnerClass: TJCoreOPFClassMetadata; const AOwnerAttr: TJCoreOPFAttrMetadata; const AOIDCount: Integer): string; override;
    function GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string; override;
    procedure ReadFromDriver(const AMapping: TJCoreOPFADMMapping); override;
    procedure WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping); override;
  public
    class function Apply(const AMap: TJCoreOPFMap): Boolean; override;
  end;

  { TInvoiceItemProductSQLMapping }

  TInvoiceItemProductSQLMapping = class(TInvoiceItemSQLMapping)
  protected
    function GenerateDeleteStatement(const AOIDCount: Integer): string; override;
    function GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string; override;
    function GenerateSelectStatement(const ABaseMap: TJCoreOPFMap; const AOwnerClass: TJCoreOPFClassMetadata; const AOwnerAttr: TJCoreOPFAttrMetadata; const AOIDCount: Integer): string; override;
    function GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string; override;
    procedure ReadFromDriver(const AMapping: TJCoreOPFADMMapping); override;
    procedure WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping); override;
  public
    class function Apply(const AMap: TJCoreOPFMap): Boolean; override;
  end;

  { TInvoiceItemServiceSQLMapping }

  TInvoiceItemServiceSQLMapping = class(TInvoiceItemSQLMapping)
  protected
    function GenerateDeleteStatement(const AOIDCount: Integer): string; override;
    function GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string; override;
    function GenerateSelectStatement(const ABaseMap: TJCoreOPFMap; const AOwnerClass: TJCoreOPFClassMetadata; const AOwnerAttr: TJCoreOPFAttrMetadata; const AOIDCount: Integer): string; override;
    function GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string; override;
    procedure ReadFromDriver(const AMapping: TJCoreOPFADMMapping); override;
    procedure WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping); override;
  public
    class function Apply(const AMap: TJCoreOPFMap): Boolean; override;
  end;

const
  CSQLINSERTINVOICECLIENT = 'INSERT INTO CLIENT (ID,NAME) VALUES (?,?)';
  CSQLINSERTINVOICEPERSON = 'INSERT INTO PERSON (ID,NICK) VALUES (?,?)';
  CSQLINSERTINVOICECOMPANY = 'INSERT INTO COMPANY (ID,CONTACTNAME) VALUES (?,?)';
  CSQLINSERTINVOICEPRODUCT = 'INSERT INTO PRODUCT (ID,NAME) VALUES (?,?)';
  CSQLINSERTINVOICEINVOICE = 'INSERT INTO INVOICE (ID,CLIENT,DATE) VALUES (?,?,?)';
  CSQLINSERTINVOICEINVOICEITEM = 'INSERT INTO INVOICEITEM (ID,TOTAL) VALUES (?,?)';
  CSQLINSERTINVOICEINVOICEITEMPRODUCT = 'INSERT INTO INVOICEITEMPRODUCT (ID,QTY,PRODUCT) VALUES (?,?,?)';
  CSQLINSERTINVOICEINVOICEITEMSERVICE = 'INSERT INTO INVOICEITEMSERVICE (ID,DESCRIPTION) VALUES (?,?)';
  CSQLSELECTINVOICECLIENT = 'SELECT T.ID,T_1.ID,T_2.ID,T.NAME FROM CLIENT T LEFT OUTER JOIN PERSON T_1 ON T.ID=T_1.ID LEFT OUTER JOIN COMPANY T_2 ON T.ID=T_2.ID WHERE T.ID';
  CSQLSELECTINVOICEPERSON = 'SELECT T.ID,T_1.NAME,T.NICK FROM PERSON T INNER JOIN CLIENT T_1 ON T.ID=T_1.ID WHERE T.ID';
  CSQLSELECTINVOICEPERSONCOMPLEMENTARY = 'SELECT ID,NICK FROM PERSON WHERE ID';
  CSQLSELECTINVOICECOMPANY = 'SELECT T.ID,T_1.NAME,T.CONTACTNAME FROM COMPANY T INNER JOIN CLIENT T_1 ON T.ID=T_1.ID WHERE T.ID';
  CSQLSELECTINVOICECOMPANYCOMPLEMENTARY = 'SELECT ID,CONTACTNAME FROM COMPANY WHERE ID';
  CSQLSELECTINVOICEINVOICE = 'SELECT ID,CLIENT,DATE FROM INVOICE WHERE ID';
  CSQLSELECTINVOICEINVOICEITEM = 'SELECT T.ID,T_1.ID,T_2.ID,T.TOTAL FROM INVOICEITEM T LEFT OUTER JOIN INVOICEITEMPRODUCT T_1 ON T.ID=T_1.ID LEFT OUTER JOIN INVOICEITEMSERVICE T_2 ON T.ID=T_2.ID WHERE T.ID';
  CSQLSELECTINVOICEINVOICEITEMPRODUCTCOMPLEMENTARY = 'SELECT ID,QTY,PRODUCT FROM INVOICEITEMPRODUCT WHERE ID';
  CSQLSELECTINVOICEINVOICEITEMSERVICECOMPLEMENTARY = 'SELECT ID,DESCRIPTION FROM INVOICEITEMSERVICE WHERE ID';
  CSQLSELECTINVOICEPRODUCT = 'SELECT ID,NAME FROM PRODUCT WHERE ID';
  CSQLUPDATEINVOICECLIENT = 'UPDATE CLIENT SET NAME=? WHERE ID=?';
  CSQLUPDATEINVOICEPERSON = 'UPDATE PERSON SET NICK=? WHERE ID=?';
  CSQLUPDATEINVOICECOMPANY = 'UPDATE COMPANY SET CONTACTNAME=? WHERE ID=?';
  CSQLUPDATEINVOICEPRODUCT = 'UPDATE PRODUCT SET NAME=? WHERE ID=?';
  CSQLUPDATEINVOICEINVOICE = 'UPDATE INVOICE SET CLIENT=?, DATE=? WHERE ID=?';
  CSQLUPDATEINVOICEINVOICEITEM = 'UPDATE INVOICEITEM SET TOTAL=? WHERE ID=?';
  CSQLUPDATEINVOICEINVOICEITEMPRODUCT = 'UPDATE INVOICEITEMPRODUCT SET QTY=?, PRODUCT=? WHERE ID=?';
  CSQLUPDATEINVOICEINVOICEITEMSERVICE = 'UPDATE INVOICEITEMSERVICE SET DESCRIPTION=? WHERE ID=?';
  CSQLDELETEINVOICECLIENT = 'DELETE FROM CLIENT WHERE ID';
  CSQLDELETEINVOICEPERSON = 'DELETE FROM PERSON WHERE ID';
  CSQLDELETEINVOICECOMPANY = 'DELETE FROM COMPANY WHERE ID';
  CSQLDELETEINVOICEPRODUCT = 'DELETE FROM PRODUCT WHERE ID';
  CSQLDELETEINVOICEINVOICE = 'DELETE FROM INVOICE WHERE ID';
  CSQLDELETEINVOICEINVOICEITEM = 'DELETE FROM INVOICEITEM WHERE ID';
  CSQLDELETEINVOICEINVOICEITEMPRODUCT = 'DELETE FROM INVOICEITEMPRODUCT WHERE ID';
  CSQLDELETEINVOICEINVOICEITEMSERVICE = 'DELETE FROM INVOICEITEMSERVICE WHERE ID';

implementation

uses
  TestOPFModelInvoice;

{ TClientSQLMapping }

function TClientSQLMapping.CreateEntityFromDriver: TObject;
begin
  if Map.Metadata.TheClass = TClient then
    Result := SelectClassFromDriver([TPerson, TCompany], TClient).Create
  else
    Result := inherited CreateEntityFromDriver;
end;

function TClientSQLMapping.GenerateDeleteStatement(const AOIDCount: Integer): string;
begin
  Result := CSQLDELETEINVOICECLIENT + BuildParams(AOIDCount);
end;

function TClientSQLMapping.GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string;
begin
  Result := CSQLINSERTINVOICECLIENT;
end;

function TClientSQLMapping.GenerateSelectStatement(const ABaseMap: TJCoreOPFMap;
  const AOwnerClass: TJCoreOPFClassMetadata; const AOwnerAttr: TJCoreOPFAttrMetadata;
  const AOIDCount: Integer): string;
begin
  Result := CSQLSELECTINVOICECLIENT + BuildParams(AOIDCount);
end;

function TClientSQLMapping.GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string;
begin
  Result := CSQLUPDATEINVOICECLIENT;
end;

procedure TClientSQLMapping.ReadFromDriver(const AMapping: TJCoreOPFADMMapping);
var
  VClient: TClient;
begin
  VClient := AMapping.PID.Entity as TClient;
  VClient.Name := Driver.ReadString;
end;

procedure TClientSQLMapping.WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping);
var
  VClient: TClient;
begin
  VClient := AMapping.PID.Entity as TClient;
  Driver.WriteString(VClient.Name);
end;

class function TClientSQLMapping.Apply(const AMap: TJCoreOPFMap): Boolean;
begin
  Result := AMap.Metadata.TheClass = TClient;
end;

{ TPersonSQLMapping }

function TPersonSQLMapping.GenerateDeleteStatement(const AOIDCount: Integer): string;
begin
  Result := CSQLDELETEINVOICEPERSON + BuildParams(AOIDCount);
end;

function TPersonSQLMapping.GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string;
begin
  Result := CSQLINSERTINVOICEPERSON;
end;

function TPersonSQLMapping.GenerateSelectStatement(const ABaseMap: TJCoreOPFMap;
  const AOwnerClass: TJCoreOPFClassMetadata; const AOwnerAttr: TJCoreOPFAttrMetadata;
  const AOIDCount: Integer): string;
begin
  if not Assigned(ABaseMap) then
    Result := CSQLSELECTINVOICEPERSON + BuildParams(AOIDCount)
  else if ABaseMap.Metadata.TheClass = TClient then
    Result := CSQLSELECTINVOICEPERSONCOMPLEMENTARY + BuildParams(AOIDCount)
  else
    Result := inherited GenerateSelectStatement(ABaseMap, AOwnerClass, AOwnerAttr, AOIDCount);
end;

function TPersonSQLMapping.GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string;
begin
  Result := CSQLUPDATEINVOICEPERSON;
end;

procedure TPersonSQLMapping.ReadFromDriver(const AMapping: TJCoreOPFADMMapping);
var
  VPerson: TPerson;
begin
  VPerson := AMapping.PID.Entity as TPerson;
  VPerson.Nick := Driver.ReadString;
end;

procedure TPersonSQLMapping.WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping);
var
  VPerson: TPerson;
begin
  VPerson := AMapping.PID.Entity as TPerson;
  Driver.WriteString(VPerson.Nick);
end;

class function TPersonSQLMapping.Apply(const AMap: TJCoreOPFMap): Boolean;
begin
  Result := AMap.Metadata.TheClass = TPerson;
end;

{ TCompanySQLMapping }

function TCompanySQLMapping.GenerateDeleteStatement(const AOIDCount: Integer): string;
begin
  Result := CSQLDELETEINVOICECOMPANY + BuildParams(AOIDCount);
end;

function TCompanySQLMapping.GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string;
begin
  Result := CSQLINSERTINVOICECOMPANY;
end;

function TCompanySQLMapping.GenerateSelectStatement(const ABaseMap: TJCoreOPFMap;
  const AOwnerClass: TJCoreOPFClassMetadata; const AOwnerAttr: TJCoreOPFAttrMetadata;
  const AOIDCount: Integer): string;
begin
  if not Assigned(ABaseMap) then
    Result := CSQLSELECTINVOICECOMPANY + BuildParams(AOIDCount)
  else if ABaseMap.Metadata.TheClass = TClient then
    Result := CSQLSELECTINVOICECOMPANYCOMPLEMENTARY + BuildParams(AOIDCount)
  else
    Result := inherited GenerateSelectStatement(ABaseMap, AOwnerClass, AOwnerAttr, AOIDCount);
end;

function TCompanySQLMapping.GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string;
begin
  Result := CSQLUPDATEINVOICECOMPANY;
end;

procedure TCompanySQLMapping.ReadFromDriver(const AMapping: TJCoreOPFADMMapping);
var
  VCompany: TCompany;
begin
  VCompany := AMapping.PID.Entity as TCompany;
  VCompany.ContactName := Driver.ReadString;
end;

procedure TCompanySQLMapping.WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping);
var
  VCompany: TCompany;
begin
  VCompany := AMapping.PID.Entity as TCompany;
  Driver.WriteString(VCompany.ContactName);
end;

class function TCompanySQLMapping.Apply(const AMap: TJCoreOPFMap): Boolean;
begin
  Result := AMap.Metadata.TheClass = TCompany;
end;

{ TProductSQLMapping }

function TProductSQLMapping.GenerateDeleteStatement(const AOIDCount: Integer): string;
begin
  Result := CSQLDELETEINVOICEPRODUCT + BuildParams(AOIDCount);
end;

function TProductSQLMapping.GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string;
begin
  Result := CSQLINSERTINVOICEPRODUCT;
end;

function TProductSQLMapping.GenerateSelectStatement(const ABaseMap: TJCoreOPFMap;
  const AOwnerClass: TJCoreOPFClassMetadata; const AOwnerAttr: TJCoreOPFAttrMetadata;
  const AOIDCount: Integer): string;
begin
  Result := CSQLSELECTINVOICEPRODUCT + BuildParams(AOIDCount);
end;

function TProductSQLMapping.GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string;
begin
  Result := CSQLUPDATEINVOICEPRODUCT;
end;

procedure TProductSQLMapping.ReadFromDriver(const AMapping: TJCoreOPFADMMapping);
var
  VProduct: TProduct;
begin
  VProduct := AMapping.PID.Entity as TProduct;
  VProduct.Name := Driver.ReadString;
end;

procedure TProductSQLMapping.WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping);
var
  VProduct: TProduct;
begin
  VProduct := AMapping.PID.Entity as TProduct;
  Driver.WriteString(VProduct.Name);
end;

class function TProductSQLMapping.Apply(const AMap: TJCoreOPFMap): Boolean;
begin
  Result := AMap.Metadata.TheClass = TProduct;
end;

{ TInvoiceSQLMapping }

function TInvoiceSQLMapping.GenerateDeleteStatement(const AOIDCount: Integer): string;
begin
  Result := CSQLDELETEINVOICEINVOICE + BuildParams(AOIDCount);
end;

function TInvoiceSQLMapping.GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string;
begin
  Result := CSQLINSERTINVOICEINVOICE;
end;

function TInvoiceSQLMapping.GenerateSelectStatement(const ABaseMap: TJCoreOPFMap;
  const AOwnerClass: TJCoreOPFClassMetadata; const AOwnerAttr: TJCoreOPFAttrMetadata;
  const AOIDCount: Integer): string;
begin
  Result := CSQLSELECTINVOICEINVOICE + BuildParams(AOIDCount);
end;

function TInvoiceSQLMapping.GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string;
begin
  Result := CSQLUPDATEINVOICEINVOICE;
end;

procedure TInvoiceSQLMapping.ReadFromDriver(const AMapping: TJCoreOPFADMMapping);
var
  VInvoice: TInvoice;
begin
  VInvoice := AMapping.PID.Entity as TInvoice;
  VInvoice.Client := ReadEntity(TClient) as TClient;
  VInvoice.Date := Driver.ReadString;
end;

procedure TInvoiceSQLMapping.WriteExternalsToDriver(const AMapping: TJCoreOPFADMMapping);
begin
  WriteCollection(AMapping, 'Items');
end;

procedure TInvoiceSQLMapping.WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping);
var
  VInvoice: TInvoice;
begin
  VInvoice := AMapping.PID.Entity as TInvoice;
  WriteEntity(TClient, VInvoice.Client);
  Driver.WriteString(VInvoice.Date);
end;

class function TInvoiceSQLMapping.Apply(const AMap: TJCoreOPFMap): Boolean;
begin
  Result := AMap.Metadata.TheClass = TInvoice;
end;

{ TInvoiceItemSQLMapping }

function TInvoiceItemSQLMapping.CreateEntityFromDriver: TObject;
begin
  if Map.Metadata.TheClass = TInvoiceItem then
    Result := SelectClassFromDriver([TInvoiceItemProduct, TInvoiceItemService], TInvoiceItem).Create
  else
    Result := inherited CreateEntityFromDriver;
end;

function TInvoiceItemSQLMapping.GenerateDeleteStatement(const AOIDCount: Integer): string;
begin
  Result := CSQLDELETEINVOICEINVOICEITEM + BuildParams(AOIDCount);
end;

function TInvoiceItemSQLMapping.GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string;
begin
  Result := CSQLINSERTINVOICEINVOICEITEM;
end;

function TInvoiceItemSQLMapping.GenerateSelectStatement(const ABaseMap: TJCoreOPFMap;
  const AOwnerClass: TJCoreOPFClassMetadata; const AOwnerAttr: TJCoreOPFAttrMetadata;
  const AOIDCount: Integer): string;
begin
  if AOwnerClass.TheClass = TInvoice then
    Result := CSQLSELECTINVOICEINVOICEITEM + BuildParams(AOIDCount)
  else
    Result := inherited GenerateSelectStatement(ABaseMap, AOwnerClass, AOwnerAttr, AOIDCount);
end;

function TInvoiceItemSQLMapping.GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string;
begin
  Result := CSQLUPDATEINVOICEINVOICEITEM;
end;

procedure TInvoiceItemSQLMapping.ReadFromDriver(const AMapping: TJCoreOPFADMMapping);
var
  VInvoiceItem: TInvoiceItem;
begin
  VInvoiceItem := AMapping.PID.Entity as TInvoiceItem;
  VInvoiceItem.Total := Driver.ReadInteger;
end;

procedure TInvoiceItemSQLMapping.WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping);
var
  VInvoiceItem: TInvoiceItem;
begin
  VInvoiceItem := AMapping.PID.Entity as TInvoiceItem;
  Driver.WriteInteger(VInvoiceItem.Total);
end;

class function TInvoiceItemSQLMapping.Apply(const AMap: TJCoreOPFMap): Boolean;
begin
  Result := AMap.Metadata.TheClass = TInvoiceItem;
end;

{ TInvoiceItemProductSQLMapping }

function TInvoiceItemProductSQLMapping.GenerateDeleteStatement(const AOIDCount: Integer): string;
begin
  Result := CSQLDELETEINVOICEINVOICEITEMPRODUCT + BuildParams(AOIDCount);
end;

function TInvoiceItemProductSQLMapping.GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string;
begin
  Result := CSQLINSERTINVOICEINVOICEITEMPRODUCT;
end;

function TInvoiceItemProductSQLMapping.GenerateSelectStatement(const ABaseMap: TJCoreOPFMap;
  const AOwnerClass: TJCoreOPFClassMetadata; const AOwnerAttr: TJCoreOPFAttrMetadata;
  const AOIDCount: Integer): string;
begin
  if ABaseMap.Metadata.TheClass = TInvoiceItem then
    Result := CSQLSELECTINVOICEINVOICEITEMPRODUCTCOMPLEMENTARY + BuildParams(AOIDCount)
  else
    Result := inherited GenerateSelectStatement(ABaseMap, AOwnerClass, AOwnerAttr, AOIDCount);
end;

function TInvoiceItemProductSQLMapping.GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string;
begin
  Result := CSQLUPDATEINVOICEINVOICEITEMPRODUCT;
end;

procedure TInvoiceItemProductSQLMapping.ReadFromDriver(const AMapping: TJCoreOPFADMMapping);
var
  VItemProduct: TInvoiceItemProduct;
begin
  VItemProduct := AMapping.PID.Entity as TInvoiceItemProduct;
  VItemProduct.Qty := Driver.ReadInteger;
  VItemProduct.Product := ReadEntity(TProduct) as TProduct;
end;

procedure TInvoiceItemProductSQLMapping.WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping);
var
  VItemProduct: TInvoiceItemProduct;
begin
  VItemProduct := AMapping.PID.Entity as TInvoiceItemProduct;
  Driver.WriteInteger(VItemProduct.Qty);
  WriteEntity(TProduct, VItemProduct.Product);
end;

class function TInvoiceItemProductSQLMapping.Apply(const AMap: TJCoreOPFMap): Boolean;
begin
  Result := AMap.Metadata.TheClass = TInvoiceItemProduct;
end;

{ TInvoiceItemServiceSQLMapping }

function TInvoiceItemServiceSQLMapping.GenerateDeleteStatement(const AOIDCount: Integer): string;
begin
  Result := CSQLDELETEINVOICEINVOICEITEMSERVICE + BuildParams(AOIDCount);
end;

function TInvoiceItemServiceSQLMapping.GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string;
begin
  Result := CSQLINSERTINVOICEINVOICEITEMSERVICE;
end;

function TInvoiceItemServiceSQLMapping.GenerateSelectStatement(const ABaseMap: TJCoreOPFMap;
  const AOwnerClass: TJCoreOPFClassMetadata; const AOwnerAttr: TJCoreOPFAttrMetadata;
  const AOIDCount: Integer): string;
begin
  if ABaseMap.Metadata.TheClass = TInvoiceItem then
    Result := CSQLSELECTINVOICEINVOICEITEMSERVICECOMPLEMENTARY + BuildParams(AOIDCount)
  else
    Result := inherited GenerateSelectStatement(ABaseMap, AOwnerClass, AOwnerAttr, AOIDCount);
end;

function TInvoiceItemServiceSQLMapping.GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string;
begin
  Result := CSQLUPDATEINVOICEINVOICEITEMSERVICE;
end;

procedure TInvoiceItemServiceSQLMapping.ReadFromDriver(const AMapping: TJCoreOPFADMMapping);
var
  VItemService: TInvoiceItemService;
begin
  VItemService := AMapping.PID.Entity as TInvoiceItemService;
  VItemService.Description := Driver.ReadString;
end;

procedure TInvoiceItemServiceSQLMapping.WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping);
var
  VItemService: TInvoiceItemService;
begin
  VItemService := AMapping.PID.Entity as TInvoiceItemService;
  Driver.WriteString(VItemService.Description);
end;

class function TInvoiceItemServiceSQLMapping.Apply(const AMap: TJCoreOPFMap): Boolean;
begin
  Result := AMap.Metadata.TheClass = TInvoiceItemService;
end;

end.

