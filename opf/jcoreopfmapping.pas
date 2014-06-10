(*
  JCore, OPF Mapping Classes
  Copyright (C) 2014 Joao Morais

  See the file LICENSE.txt, included in this distribution,
  for details about the copyright.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
*)

unit JCoreOPFMapping;

{$I jcore.inc}

interface

uses
  typinfo,
  fgl,
  JCoreClasses,
  JCoreOPFDriver,
  JCoreOPFOID,
  JCoreOPFMetadata;

type

  TJCoreOPFClassMapping = class;

  { IJCoreOPFMapper }

  IJCoreOPFMapper = interface
    function AcquireClassMapping(const AClass: TClass): TJCoreOPFClassMapping;
    function AcquirePID(const AEntity: TObject): TJCoreOPFPID;
    procedure AddInTransactionPID(const APID: TJCoreOPFPID);
    function Driver: TJCoreOPFDriver;
    function Model: TJCoreOPFModel;
  end;

  TJCoreOPFMappingClass = class of TJCoreOPFMapping;

  { TJCoreOPFMappingClassRef }

  TJCoreOPFMappingClassRef = class(TObject)
  private
    FClass: TJCoreOPFMappingClass;
    FMap: TJCoreOPFMap;
  public
    constructor Create(const AClass: TJCoreOPFMappingClass; AMap: TJCoreOPFMap);
    property Map: TJCoreOPFMap read FMap;
    property TheClass: TJCoreOPFMappingClass read FClass;
  end;

  TJCoreOPFMappingClassRefList = specialize TFPGObjectList<TJCoreOPFMappingClassRef>;
  TJCoreOPFMappingClassRefListMap = specialize TFPGMap<Pointer, TJCoreOPFMappingClassRefList>;

  TJCoreOPFMappingClassList = specialize TFPGList<TJCoreOPFMappingClass>;

  { TJCoreOPFMappingClassFactory }

  TJCoreOPFMappingClassFactory = class(specialize TJCoreFactory<TJCoreOPFMappingClass>)
  // Class mappings of a single class metadata, without parents.
  // Based on TJCoreOPFMaps and synchronized with TJCoreOPFADMMapping ADMs.
  private
    FMappingClassList: TJCoreOPFMappingClassList;
    FMappingClassRefListMap: TJCoreOPFMappingClassRefListMap;
    FModel: TJCoreOPFModel;
  protected
    function CreateMappingClassRef(const AMap: TJCoreOPFMap): TJCoreOPFMappingClassRef;
    function CreateMappingClassRefList(const AClass: TClass): TJCoreOPFMappingClassRefList;
    property MappingClassList: TJCoreOPFMappingClassList read FMappingClassList;
    property MappingClassRefListMap: TJCoreOPFMappingClassRefListMap read FMappingClassRefListMap;
  public
    constructor Create(const AModel: TJCoreOPFModel);
    destructor Destroy; override;
    function AcquireMappingClassRefList(const AClass: TClass): TJCoreOPFMappingClassRefList;
    procedure AddMappingClass(const AMappingClassArray: array of TJCoreOPFMappingClass);
    property Model: TJCoreOPFModel read FModel;
  end;

  TJCoreOPFMapping = class;
  TJCoreOPFMappingList = specialize TFPGObjectList<TJCoreOPFMapping>;
  TJCoreOPFMappingListMap = specialize TFPGMap<Pointer, TJCoreOPFMappingList>;

  { TJCoreOPFMappingFactory }

  TJCoreOPFMappingFactory = class(TObject)
  private
    FDriver: TJCoreOPFDriver;
    FMapper: IJCoreOPFMapper;
    FMappingClassFactory: TJCoreOPFMappingClassFactory;
    FMappingListMap: TJCoreOPFMappingListMap;
  protected
    function CreateMappingList(const AClass: TClass): TJCoreOPFMappingList;
    property MappingClassFactory: TJCoreOPFMappingClassFactory read FMappingClassFactory;
    property MappingListMap: TJCoreOPFMappingListMap read FMappingListMap;
  public
    constructor Create(const AMapper: IJCoreOPFMapper; const AMappingClassFactory: TJCoreOPFMappingClassFactory; const ADriver: TJCoreOPFDriver);
    destructor Destroy; override;
    function AcquireMappingList(const AClass: TClass): TJCoreOPFMappingList;
    property Driver: TJCoreOPFDriver read FDriver;
    property Mapper: IJCoreOPFMapper read FMapper;
  end;

  { TJCoreOPFClassMapping }

  TJCoreOPFClassMapping = class(TObject)
  private
    FDriver: TJCoreOPFDriver;
    FMapper: IJCoreOPFMapper;
    FMappingList: TJCoreOPFMappingList;
    FMetadata: TJCoreOPFClassMetadata;
    function CreateOIDFromDriver: TJCoreOPFOID;
    function CreateOIDFromString(const AOID: string): TJCoreOPFOID;
  protected
    procedure InternalDispose(const AOIDArray: array of TJCoreOPFOID);
    function InternalRetrieveOID(const AOID: TJCoreOPFOID): TObject;
    property Driver: TJCoreOPFDriver read FDriver;
    property Mapper: IJCoreOPFMapper read FMapper;
    property MappingList: TJCoreOPFMappingList read FMappingList;
  public
    // Internal mapping implementations, mapped from other classes
    procedure DisposeFromDriverInternal(const ACount: Integer);
    procedure DisposeFromOIDInternal(const AOIDArray: TJCoreOPFOIDArray);
    function RetrieveFromDriverInternal: TObject;
    procedure RetrieveCollectionInternal(const AOwnerPID: TJCoreOPFPID; const AOwnerADM: TJCoreOPFADMCollection);
    procedure RetrieveEntityInternal(const AOwnerPID: TJCoreOPFPID; const AOwnerADM: TJCoreOPFADMEntity);
    procedure RetrieveLazyEntityFromDriverInternal(const ALazyADM: TJCoreOPFADMEntity);
    procedure StoreCollectionInternal(const AOwnerMapping: TJCoreOPFADMMapping; const AOwnerADM: TJCoreOPFADMCollection);
  public
    // Public facades, mapped from session facades
    constructor Create(const AMapper: IJCoreOPFMapper; const AMetadata: TJCoreOPFClassMetadata; AMappingList: TJCoreOPFMappingList);
    procedure DisposeOID(const AStringOIDArray: array of string);
    procedure DisposePID(const APIDArray: array of TJCoreOPFPID);
    function RetrieveOID(const AStringOID: string): TObject;
    procedure StorePID(const APID: TJCoreOPFPID);
    property Metadata: TJCoreOPFClassMetadata read FMetadata;
  end;

  TJCoreOPFClassMappingMap = specialize TFPGMap<Pointer, TJCoreOPFClassMapping>;

  { TJCoreOPFMapping }

  TJCoreOPFMapping = class(TObject)
  private
    FDriver: TJCoreOPFDriver;
    FMap: TJCoreOPFMap;
    FMapper: IJCoreOPFMapper;
    FModel: TJCoreOPFModel;
  protected
    function CreateEntity: TObject; virtual;
    function InternalCreateOIDArray(const ACount: Integer): TJCoreOPFOIDArray; virtual; abstract;
    procedure InternalDispose(const AOIDArray: array of TJCoreOPFOID); virtual; abstract;
    procedure InternalRetrieveCollection(const AOwnerPID: TJCoreOPFPID; const AOwnerADM: TJCoreOPFADMCollection); virtual; abstract;
    function InternalRetrieveEntity(const AOID: TJCoreOPFOID): TObject; virtual; abstract;
    procedure InternalStore(const AMapping: TJCoreOPFADMMapping); virtual; abstract;
    property Driver: TJCoreOPFDriver read FDriver;
    property Map: TJCoreOPFMap read FMap;
    property Mapper: IJCoreOPFMapper read FMapper;
    property Model: TJCoreOPFModel read FModel;
  public
    constructor Create(const AMapper: IJCoreOPFMapper; const AMap: TJCoreOPFMap); virtual;
    class function Apply(const AMap: TJCoreOPFMap): Boolean; virtual; abstract;
    function CreateOID: TJCoreOPFOID;
    procedure Dispose(const AOIDArray: array of TJCoreOPFOID);
    procedure RetrieveCollection(const AOwnerPID: TJCoreOPFPID; const AOwnerADM: TJCoreOPFADMCollection);
    function RetrieveEntity(const AOID: TJCoreOPFOID): TObject;
    procedure Store(const AMapping: TJCoreOPFADMMapping);
  end;

  { TJCoreOPFSQLMapping }

  TJCoreOPFSQLMapping = class(TJCoreOPFMapping)
  private
    FSQLDriver: TJCoreOPFSQLDriver;
  protected
    function GenerateDeleteExternalLinkIDsStatement(const AAttrMetadata: TJCoreOPFAttrMetadata; const ASize: Integer): string; virtual;
    function GenerateDeleteExternalLinksStatement(const AAttrMetadata: TJCoreOPFAttrMetadata; const ASize: Integer): string; virtual;
    function GenerateDeleteStatement(const ASize: Integer): string; virtual; abstract;
    function GenerateInsertExternalLinksStatement(const AAttrMetadata: TJCoreOPFAttrMetadata): string; virtual;
    function GenerateInsertStatement(const AMapping: TJCoreOPFADMMapping): string; virtual; abstract;
    function GenerateSelectCompositionsForDeleteStatement(const ASize: Integer): string; virtual;
    function GenerateSelectCollectionStatement(const AOwnerClassMetadata: TJCoreOPFClassMetadata; const AOwnerAttrMetadata: TJCoreOPFAttrMetadata): string; virtual;
    function GenerateSelectForDeleteStatement(const AAttrMetadata: TJCoreOPFAttrMetadata; const ASize: Integer): string; virtual;
    function GenerateSelectStatement: string; virtual; abstract;
    function GenerateUpdateStatement(const AMapping: TJCoreOPFADMMapping): string; virtual; abstract;
    function ListEntityCompositionMetadatas: TJCoreOPFAttrMetadataArray; virtual;
    procedure ReadFromDriver(const APID: TJCoreOPFPID); virtual;
    procedure WriteDisposeCollectionToDriver(const AAttrMetadata: TJCoreOPFAttrMetadata; const AOIDArray: array of TJCoreOPFOID); virtual;
    procedure WriteDisposeEntityCompositionsToDriver(const AOIDArray: array of TJCoreOPFOID); virtual;
    procedure WriteDisposeExternalsToDriver(const AOIDArray: array of TJCoreOPFOID); virtual;
    procedure WriteDisposeToDriver(const AOIDArray: array of TJCoreOPFOID); virtual;
    procedure WriteExternalLinksToDriver(const AOwnerMapping: TJCoreOPFADMMapping; const AADM: TJCoreOPFADMCollection); virtual;
    procedure WriteExternalsToDriver(const AMapping: TJCoreOPFADMMapping); virtual;
    procedure WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping); virtual;
  protected
    function BuildParams(const ASize: Integer): string;
    procedure InternalDispose(const AOIDArray: array of TJCoreOPFOID); override;
    procedure InternalRetrieveCollection(const AOwnerPID: TJCoreOPFPID; const AOwnerADM: TJCoreOPFADMCollection); override;
    function InternalRetrieveEntity(const AOID: TJCoreOPFOID): TObject; override;
    procedure InternalStore(const AMapping: TJCoreOPFADMMapping); override;
  protected
    property Driver: TJCoreOPFSQLDriver read FSQLDriver;
  public
    constructor Create(const AMapper: IJCoreOPFMapper; const AMap: TJCoreOPFMap); override;
  end;

  { TJCoreOPFSQLManualMapping }

  TJCoreOPFSQLManualMapping = class(TJCoreOPFSQLMapping)
  protected
    function EnsureCollectionAttribute(const AMapping: TJCoreOPFADMMapping; const AAttributeName: string): TJCoreOPFADMCollection;
    function EnsureCollectionAttribute(const APID: TJCoreOPFPID; const AAttributeName: string): TJCoreOPFADMCollection;
    function EnsureEntityAttribute(const AMapping: TJCoreOPFADMMapping; const AAttributeName: string): TJCoreOPFADMEntity;
    function EnsureEntityAttribute(const APID: TJCoreOPFPID; const AAttributeName: string): TJCoreOPFADMEntity;
  protected
    function ReadEntity(const AClass: TClass): TObject;
    procedure ReadCollection(const APID: TJCoreOPFPID; const AAttributeName: string);
    procedure ReadLazyEntity(const APID: TJCoreOPFPID; const AAttributeName: string);
    procedure WriteCollection(const AMapping: TJCoreOPFADMMapping; const AAttributeName: string);
    procedure WriteEntity(const AClass: TClass; const AEntity: TObject);
    procedure WriteOwnerOIDToDriver(const AMapping: TJCoreOPFADMMapping);
  end;

implementation

uses
  sysutils,
  JCoreMetadata,
  JCoreOPFException;

{ TJCoreOPFMappingClassRef }

constructor TJCoreOPFMappingClassRef.Create(const AClass: TJCoreOPFMappingClass; AMap: TJCoreOPFMap);
begin
  inherited Create;
  FClass := AClass;
  FMap := AMap;
end;

{ TJCoreOPFMappingClassFactory }

function TJCoreOPFMappingClassFactory.CreateMappingClassRef(
  const AMap: TJCoreOPFMap): TJCoreOPFMappingClassRef;
var
  VActualMappingClass: TJCoreOPFMappingClass;
  VMappingClass: TJCoreOPFMappingClass;
begin
  VActualMappingClass := nil;
  for VMappingClass in MappingClassList do
    if VMappingClass.Apply(AMap) then
      VActualMappingClass := Choose(VActualMappingClass, VMappingClass);
  if not Assigned(VActualMappingClass) then
    raise EJCoreOPFMappingNotFound.Create(AMap.Metadata.TheClass.ClassName);
  Result := TJCoreOPFMappingClassRef.Create(VActualMappingClass, AMap);
end;

function TJCoreOPFMappingClassFactory.CreateMappingClassRefList(
  const AClass: TClass): TJCoreOPFMappingClassRefList;
var
  VMappingClassRefList: TJCoreOPFMappingClassRefList;
  VMaps: TJCoreOPFMaps;
  VMap: TJCoreOPFMap;
begin
  VMappingClassRefList := TJCoreOPFMappingClassRefList.Create(True);
  try
    VMaps := Model.AcquireMetadata(AClass).Maps;
    for VMap in VMaps do
      VMappingClassRefList.Add(CreateMappingClassRef(VMap));
  except
    FreeAndNil(VMappingClassRefList);
    raise;
  end;
  Result := VMappingClassRefList;
end;

constructor TJCoreOPFMappingClassFactory.Create(const AModel: TJCoreOPFModel);
begin
  inherited Create;
  FModel := AModel;
  FMappingClassList := TJCoreOPFMappingClassList.Create;
  FMappingClassRefListMap := TJCoreOPFMappingClassRefListMap.Create;
end;

destructor TJCoreOPFMappingClassFactory.Destroy;
var
  I: Integer;
begin
  for I := 0 to Pred(FMappingClassRefListMap.Count) do
    FMappingClassRefListMap.Data[I].Free;
  FreeAndNil(FMappingClassRefListMap);
  FreeAndNil(FMappingClassList);
  inherited Destroy;
end;

function TJCoreOPFMappingClassFactory.AcquireMappingClassRefList(
  const AClass: TClass): TJCoreOPFMappingClassRefList;
var
  VIndex: Integer;
begin
  VIndex := MappingClassRefListMap.IndexOf(AClass);
  if VIndex = -1 then
    VIndex := MappingClassRefListMap.Add(AClass, CreateMappingClassRefList(AClass));
  Result := MappingClassRefListMap.Data[VIndex];
end;

procedure TJCoreOPFMappingClassFactory.AddMappingClass(
  const AMappingClassArray: array of TJCoreOPFMappingClass);
var
  I: Integer;
begin
  for I := Low(AMappingClassArray) to High(AMappingClassArray) do
    MappingClassList.Add(AMappingClassArray[I]);
end;

{ TJCoreOPFMappingFactory }

function TJCoreOPFMappingFactory.CreateMappingList(
  const AClass: TClass): TJCoreOPFMappingList;
var
  VMappingClassRefList: TJCoreOPFMappingClassRefList;
  VMappingList: TJCoreOPFMappingList;
  VMappingClassRef: TJCoreOPFMappingClassRef;
begin
  VMappingClassRefList := MappingClassFactory.AcquireMappingClassRefList(AClass);
  VMappingList := TJCoreOPFMappingList.Create(True);
  try
    for VMappingClassRef in VMappingClassRefList do
      VMappingList.Add(VMappingClassRef.TheClass.Create(Mapper, VMappingClassRef.Map));
  except
    FreeAndNil(VMappingList);
    raise;
  end;
  Result := VMappingList;
end;

constructor TJCoreOPFMappingFactory.Create(const AMapper: IJCoreOPFMapper;
  const AMappingClassFactory: TJCoreOPFMappingClassFactory; const ADriver: TJCoreOPFDriver);
begin
  inherited Create;
  FMapper := AMapper;
  FMappingClassFactory := AMappingClassFactory;
  FDriver := ADriver;
  FMappingListMap := TJCoreOPFMappingListMap.Create;
end;

destructor TJCoreOPFMappingFactory.Destroy;
var
  I: Integer;
begin
  for I := 0 to Pred(FMappingListMap.Count) do
    FMappingListMap.Data[I].Free;
  FreeAndNil(FMappingListMap);
  inherited Destroy;
end;

function TJCoreOPFMappingFactory.AcquireMappingList(const AClass: TClass): TJCoreOPFMappingList;
var
  VIndex: Integer;
begin
  VIndex := MappingListMap.IndexOf(AClass);
  if VIndex = -1 then
    VIndex := MappingListMap.Add(AClass, CreateMappingList(AClass));
  Result := MappingListMap.Data[VIndex];
end;

{ TJCoreOPFClassMapping }

function TJCoreOPFClassMapping.CreateOIDFromDriver: TJCoreOPFOID;
begin
  if not Driver.ReadNull then
    Result := Metadata.OIDClass.CreateFromDriver(Driver)
  else
    Result := nil;
end;

function TJCoreOPFClassMapping.CreateOIDFromString(const AOID: string): TJCoreOPFOID;
begin
  Result := Metadata.OIDClass.CreateFromString(AOID);
end;

procedure TJCoreOPFClassMapping.InternalDispose(const AOIDArray: array of TJCoreOPFOID);
var
  I: Integer;
begin
  if Length(AOIDArray) > 0 then
    for I := 0 to Pred(MappingList.Count) do
      MappingList[I].Dispose(AOIDArray);
end;

function TJCoreOPFClassMapping.InternalRetrieveOID(const AOID: TJCoreOPFOID): TObject;
begin
  Result := MappingList.Last.RetrieveEntity(AOID);
end;

procedure TJCoreOPFClassMapping.DisposeFromDriverInternal(const ACount: Integer);
var
  VOIDArray: TJCoreOPFOIDArray;
  I, VCount: Integer;
begin
  SetLength(VOIDArray, ACount);
  try
    VCount := 0;
    for I := 0 to Pred(ACount) do
    begin
      VOIDArray[VCount] := CreateOIDFromDriver;
      if Assigned(VOIDArray[VCount]) then
        Inc(VCount);
    end;
    SetLength(VOIDArray, VCount);
    InternalDispose(VOIDArray);
  finally
    for I := 0 to Pred(VCount) do
      FreeAndNil(VOIDArray[I]);
  end;
end;

procedure TJCoreOPFClassMapping.DisposeFromOIDInternal(const AOIDArray: TJCoreOPFOIDArray);
begin
  InternalDispose(AOIDArray);
end;

function TJCoreOPFClassMapping.RetrieveFromDriverInternal: TObject;
var
  VOID: TJCoreOPFOID;
begin
  VOID := CreateOIDFromDriver;
  if Assigned(VOID) then
  begin
    try
      Result := InternalRetrieveOID(VOID);
    except
      FreeAndNil(VOID);
      raise;
    end;
  end else
    Result := nil;
end;

procedure TJCoreOPFClassMapping.RetrieveCollectionInternal(const AOwnerPID: TJCoreOPFPID;
  const AOwnerADM: TJCoreOPFADMCollection);
begin
  MappingList.Last.RetrieveCollection(AOwnerPID, AOwnerADM);
end;

procedure TJCoreOPFClassMapping.RetrieveEntityInternal(const AOwnerPID: TJCoreOPFPID;
  const AOwnerADM: TJCoreOPFADMEntity);
var
  VOID: TJCoreOPFOID;
  VComposite: TObject;
begin
  VOID := AOwnerADM.CompositionOID;
  if not Assigned(VOID) then
    raise EJCoreOPFEmptyOID.Create;
  VOID.AddRef;
  try
    VComposite := InternalRetrieveOID(VOID);
    AOwnerADM.AssignComposition(VComposite);
  except
    FreeAndNil(VOID);
    raise;
  end;
end;

procedure TJCoreOPFClassMapping.RetrieveLazyEntityFromDriverInternal(const ALazyADM: TJCoreOPFADMEntity);
begin
  ALazyADM.CompositionOID := CreateOIDFromDriver;
end;

procedure TJCoreOPFClassMapping.StoreCollectionInternal(const AOwnerMapping: TJCoreOPFADMMapping;
  const AOwnerADM: TJCoreOPFADMCollection);
var
  VOIDs: TJCoreOPFOIDArray;
  VPIDs: TJCoreOPFPIDArray;
  VPID: TJCoreOPFPID;
begin
  if AOwnerADM.Metadata.CompositionType = jctComposition then
  begin
    VOIDs := AOwnerADM.OIDRemoved;
    if Length(VOIDs) > 0 then
      Mapper.AcquireClassMapping(AOwnerADM.Metadata.CompositionClass).DisposeFromOIDInternal(VOIDs);
  end;

  VPIDs := AOwnerADM.PIDArray;
  for VPID in VPIDs do
  begin
    VPID.AssignOwner(AOwnerMapping.PID, AOwnerADM);
    if (AOwnerADM.Metadata.CompositionType = jctComposition) or
     not VPID.IsPersistent then
      { TODO : Document approach - non composition attributes are stored if they are not persistent }
      { TODO : Implement apply(classtype) in order to avoid a trip }
      Mapper.AcquireClassMapping(VPID.Entity.ClassType).StorePID(VPID);
  end;
end;

constructor TJCoreOPFClassMapping.Create(const AMapper: IJCoreOPFMapper;
  const AMetadata: TJCoreOPFClassMetadata; AMappingList: TJCoreOPFMappingList);
begin
  inherited Create;
  FMapper := AMapper;
  FDriver := FMapper.Driver;
  FMetadata := AMetadata;
  FMappingList := AMappingList;
end;

procedure TJCoreOPFClassMapping.DisposeOID(const AStringOIDArray: array of string);
var
  VOIDArray: TJCoreOPFOIDArray;
  I, J: Integer;
begin
  for I := 0 to Pred(MappingList.Count) do
  begin
    SetLength(VOIDArray, Length(AStringOIDArray));
    try
      for J := Low(AStringOIDArray) to High(AStringOIDArray) do
        VOIDArray[J] := CreateOIDFromString(AStringOIDArray[J]);
      InternalDispose(VOIDArray);
    finally
      for J := Low(VOIDArray) to High(VOIDArray) do
        FreeAndNil(VOIDArray[J]);
    end;
  end;
end;

procedure TJCoreOPFClassMapping.DisposePID(const APIDArray: array of TJCoreOPFPID);
var
  VOIDArray: TJCoreOPFOIDArray;
  I: Integer;
begin
  SetLength(VOIDArray, Length(APIDArray));
  for I := 0 to Pred(Length(VOIDArray)) do
    VOIDArray[I] := APIDArray[I].OID;
  InternalDispose(VOIDArray);
  for I := 0 to Pred(Length(APIDArray)) do
  begin
    APIDArray[I].AssignOID(nil);
    Mapper.AddInTransactionPID(APIDArray[I]);
  end;
end;

function TJCoreOPFClassMapping.RetrieveOID(const AStringOID: string): TObject;
var
  VOID: TJCoreOPFOID;
begin
  if AStringOID <> '' then
  begin
    VOID := CreateOIDFromString(AStringOID);
    try
      Result := InternalRetrieveOID(VOID);
    except
      FreeAndNil(VOID);
      raise;
    end;
  end else
    Result := nil;
end;

procedure TJCoreOPFClassMapping.StorePID(const APID: TJCoreOPFPID);
var
  I: Integer;
begin
  if not APID.IsPersistent then
    APID.AssignOID(MappingList.Last.CreateOID);
  for I := 0 to Pred(MappingList.Count) do
    MappingList[I].Store(APID[I]);
  Mapper.AddInTransactionPID(APID);
end;

{ TJCoreOPFMapping }

function TJCoreOPFMapping.CreateEntity: TObject;
begin
  Result := Map.Metadata.TheClass.Create;
end;

constructor TJCoreOPFMapping.Create(const AMapper: IJCoreOPFMapper; const AMap: TJCoreOPFMap);
begin
  inherited Create;
  FMapper := AMapper;
  FMap := AMap;
  FModel := Mapper.Model;
  FDriver := Mapper.Driver;
end;

function TJCoreOPFMapping.CreateOID: TJCoreOPFOID;
begin
  Result := InternalCreateOIDArray(1)[0];
end;

procedure TJCoreOPFMapping.Dispose(const AOIDArray: array of TJCoreOPFOID);
begin
  InternalDispose(AOIDArray);
end;

procedure TJCoreOPFMapping.RetrieveCollection(const AOwnerPID: TJCoreOPFPID;
  const AOwnerADM: TJCoreOPFADMCollection);
begin
  InternalRetrieveCollection(AOwnerPID, AOwnerADM);
end;

function TJCoreOPFMapping.RetrieveEntity(const AOID: TJCoreOPFOID): TObject;
begin
  Result := InternalRetrieveEntity(AOID);
end;

procedure TJCoreOPFMapping.Store(const AMapping: TJCoreOPFADMMapping);
begin
  if AMapping.IsDirty then
    InternalStore(AMapping);
end;

{ TJCoreOPFSQLMapping }

function TJCoreOPFSQLMapping.GenerateDeleteExternalLinkIDsStatement(
  const AAttrMetadata: TJCoreOPFAttrMetadata; const ASize: Integer): string;
begin
  raise EJCoreOPFUnsupportedListOperations.Create;
end;

function TJCoreOPFSQLMapping.GenerateDeleteExternalLinksStatement(
  const AAttrMetadata: TJCoreOPFAttrMetadata; const ASize: Integer): string;
begin
  raise EJCoreOPFUnsupportedListOperations.Create;
end;

function TJCoreOPFSQLMapping.GenerateInsertExternalLinksStatement(
  const AAttrMetadata: TJCoreOPFAttrMetadata): string;
begin
  raise EJCoreOPFUnsupportedListOperations.Create;
end;

function TJCoreOPFSQLMapping.GenerateSelectCompositionsForDeleteStatement(const ASize: Integer): string;
begin
  raise EJCoreOPFUnsupportedSelectForDeleteOperation.Create(Map.Metadata.TheClass);
end;

function TJCoreOPFSQLMapping.GenerateSelectCollectionStatement(
  const AOwnerClassMetadata: TJCoreOPFClassMetadata;
  const AOwnerAttrMetadata: TJCoreOPFAttrMetadata): string;
begin
  raise EJCoreOPFUnsupportedListOperations.Create;
end;

function TJCoreOPFSQLMapping.GenerateSelectForDeleteStatement(
  const AAttrMetadata: TJCoreOPFAttrMetadata; const ASize: Integer): string;
begin
  raise EJCoreOPFUnsupportedSelectForDeleteOperation.Create(AAttrMetadata.CompositionClass);
end;

function TJCoreOPFSQLMapping.ListEntityCompositionMetadatas: TJCoreOPFAttrMetadataArray;
var
  VClassMetadata: TJCoreOPFClassMetadata;
  VAttrMetadata: TJCoreOPFAttrMetadata;
  VCount, I: Integer;
begin
  VClassMetadata := Map.Metadata;
  SetLength(Result, VClassMetadata.AttributeCount);
  VCount := 0;
  for I := 0 to Pred(VClassMetadata.AttributeCount) do
  begin
    VAttrMetadata := VClassMetadata.Attributes[I];
    if (VAttrMetadata.CompositionType = jctComposition) and (VAttrMetadata.AttributeType = jatEntity) then
    begin
      Result[VCount] := VAttrMetadata;
      Inc(VCount);
    end;
  end;
  SetLength(Result, VCount);
end;

procedure TJCoreOPFSQLMapping.ReadFromDriver(const APID: TJCoreOPFPID);
begin
end;

procedure TJCoreOPFSQLMapping.WriteDisposeCollectionToDriver(
  const AAttrMetadata: TJCoreOPFAttrMetadata; const AOIDArray: array of TJCoreOPFOID);
var
  VOID: TJCoreOPFOID;
  VSelectStmt: string;
  VDeleteStmt: string;
  VCount: Integer;
begin
  {
    Collections might be:
    * compositions (owned) with embedded link
      -- select external IDs
      -- delete objects
    * compositions (owned) with external link
      -- select external IDs
      -- delete links
      -- delete objects
    * aggregations (shared) with external link
      -- delete links
  }
  VCount := 0;
  if AAttrMetadata.CompositionType = jctComposition then
  begin
    // Select external IDs
    VSelectStmt := GenerateSelectForDeleteStatement(AAttrMetadata, Length(AOIDArray));
    for VOID in AOIDArray do
      VOID.WriteToDriver(Driver);
    VCount := Driver.ExecSQL(VSelectStmt);
  end;
  if (AAttrMetadata.CompositionLinkType = jcltExternal) and
   ((VCount > 0) or (AAttrMetadata.CompositionType = jctAggregation)) then
  begin
    // Delete external links
    VDeleteStmt := GenerateDeleteExternalLinksStatement(AAttrMetadata, Length(AOIDArray));
    for VOID in AOIDArray do
      VOID.WriteToDriver(Driver);
    Driver.ExecSQL(VDeleteStmt);
  end;
  if (VCount > 0) and (AAttrMetadata.CompositionType = jctComposition) then
  begin
    // Delete external objects
    Mapper.AcquireClassMapping(AAttrMetadata.CompositionClass).DisposeFromDriverInternal(VCount);
  end;
end;

procedure TJCoreOPFSQLMapping.WriteDisposeEntityCompositionsToDriver(
  const AOIDArray: array of TJCoreOPFOID);
var
  VCompositionMetadatas: TJCoreOPFAttrMetadataArray;
  VCompositionMetadata: TJCoreOPFClassMetadata;
  VOID: TJCoreOPFOID;
  VSelectStmt: string;
begin
  VCompositionMetadatas := ListEntityCompositionMetadatas;
  { TODO : Implement reading of more than one entity composition }
  if Length(VCompositionMetadatas) = 1 then
  begin
    VSelectStmt := GenerateSelectCompositionsForDeleteStatement(Length(AOIDArray));
    for VOID in AOIDArray do
      VOID.WriteToDriver(Driver);
    Driver.ExecSQL(VSelectStmt, Length(AOIDArray));
    VCompositionMetadata := VCompositionMetadatas[0].CompositionMetadata;
    Mapper.AcquireClassMapping(VCompositionMetadata.TheClass).DisposeFromDriverInternal(Length(AOIDArray));
  end;
end;

procedure TJCoreOPFSQLMapping.WriteDisposeExternalsToDriver(const AOIDArray: array of TJCoreOPFOID);
var
  VClassMetadata: TJCoreOPFClassMetadata;
  VAttrMetadata: TJCoreOPFAttrMetadata;
  VHasEntityComposition: Boolean;
  I: Integer;
begin
  VClassMetadata := Map.Metadata;
  VHasEntityComposition := False;
  for I := 0 to Pred(VClassMetadata.AttributeCount) do
  begin
    VAttrMetadata := VClassMetadata.Attributes[I];
    if VAttrMetadata.AttributeType = jatCollection then
      WriteDisposeCollectionToDriver(VAttrMetadata, AOIDArray)
    else if (VAttrMetadata.AttributeType = jatEntity) and (VAttrMetadata.CompositionType = jctComposition) then
      VHasEntityComposition := True;
  end;
  if VHasEntityComposition then
    WriteDisposeEntityCompositionsToDriver(AOIDArray);
end;

procedure TJCoreOPFSQLMapping.WriteDisposeToDriver(const AOIDArray: array of TJCoreOPFOID);
var
  VOID: TJCoreOPFOID;
begin
  for VOID in AOIDArray do
    VOID.WriteToDriver(Driver);
  Driver.ExecSQL(GenerateDeleteStatement(Length(AOIDArray)));
end;

procedure TJCoreOPFSQLMapping.WriteExternalLinksToDriver(
  const AOwnerMapping: TJCoreOPFADMMapping; const AADM: TJCoreOPFADMCollection);
var
  VInsertStmt: string;
  VPIDs: TJCoreOPFPIDArray;
  VPID: TJCoreOPFPID;
begin
  VInsertStmt := GenerateInsertExternalLinksStatement(AADM.Metadata);
  VPIDs := AADM.PIDAdded;
  for VPID in VPIDs do
  begin
    AOwnerMapping.PID.OID.WriteToDriver(Driver);
    VPID.OID.WriteToDriver(Driver);
    Driver.ExecSQL(VInsertStmt);
  end;
end;

procedure TJCoreOPFSQLMapping.WriteExternalsToDriver(const AMapping: TJCoreOPFADMMapping);
begin
end;

procedure TJCoreOPFSQLMapping.WriteInternalsToDriver(const AMapping: TJCoreOPFADMMapping);
begin
end;

function TJCoreOPFSQLMapping.BuildParams(const ASize: Integer): string;
var
  I: Integer;
begin
  if ASize > 1 then
  begin
    { TODO : allocate once, at the start }
    Result := ' IN (?';
    for I := 2 to ASize do
      Result := Result + ',?';
    Result := Result + ')';
  end else if ASize = 1 then
    Result := '=?'
  else
    Result := '';
end;

procedure TJCoreOPFSQLMapping.InternalDispose(const AOIDArray: array of TJCoreOPFOID);
begin
  WriteDisposeExternalsToDriver(AOIDArray);
  WriteDisposeToDriver(AOIDArray);
end;

procedure TJCoreOPFSQLMapping.InternalRetrieveCollection(const AOwnerPID: TJCoreOPFPID;
  const AOwnerADM: TJCoreOPFADMCollection);
var
  VElementsArray: TJCoreObjectArray;
  VOID: TJCoreOPFOID;
  VPID: TJCoreOPFPID;
  VCount: Integer;
  I: Integer;
begin
  AOwnerPID.OID.WriteToDriver(Driver);
  VCount := Driver.ExecSQL(GenerateSelectCollectionStatement(AOwnerPID.Metadata, AOwnerADM.Metadata));
  SetLength(VElementsArray, VCount);
  try
    for I := Low(VElementsArray) to High(VElementsArray) do
    begin
      VElementsArray[I] := CreateEntity;
      VOID := Map.OIDClass.CreateFromDriver(Driver);
      try
        VPID := Mapper.AcquirePID(VElementsArray[I]);
        try
          VPID.AssignOID(VOID);
          ReadFromDriver(VPID);
        except
          VPID.ReleaseOID(VOID);
          raise;
        end;
      except
        FreeAndNil(VOID);
        raise;
      end;
    end;
    AOwnerADM.AssignArray(VElementsArray);
  except
    for I := Low(VElementsArray) to High(VElementsArray) do
      FreeAndNil(VElementsArray[I]);
    raise;
  end;
end;

function TJCoreOPFSQLMapping.InternalRetrieveEntity(const AOID: TJCoreOPFOID): TObject;
var
  VPID: TJCoreOPFPID;
begin
  AOID.WriteToDriver(Driver);
  Driver.ExecSQL(GenerateSelectStatement, 1);
  Result := CreateEntity;
  try
    VPID := Mapper.AcquirePID(Result);
    try
      VPID.AssignOID(AOID);
      ReadFromDriver(VPID);
    except
      VPID.ReleaseOID(AOID);
      raise;
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure TJCoreOPFSQLMapping.InternalStore(const AMapping: TJCoreOPFADMMapping);
var
  VPID: TJCoreOPFPID;
begin
  VPID := AMapping.PID;
  if not VPID.IsPersistent then
  begin
    VPID.OID.WriteToDriver(Driver);
    WriteInternalsToDriver(AMapping);
    Driver.ExecSQL(GenerateInsertStatement(AMapping));
  end else if AMapping.IsInternalsDirty then
  begin
    WriteInternalsToDriver(AMapping);
    VPID.OID.WriteToDriver(Driver);
    Driver.ExecSQL(GenerateUpdateStatement(AMapping));
  end;
  WriteExternalsToDriver(AMapping);
end;

constructor TJCoreOPFSQLMapping.Create(const AMapper: IJCoreOPFMapper; const AMap: TJCoreOPFMap);
var
  VDriver: TJCoreOPFDriver;
begin
  VDriver := AMapper.Driver;
  if not (VDriver is TJCoreOPFSQLDriver) then
    raise EJCoreOPFUnsupportedDriver.Create(VDriver.ClassName);
  inherited Create(AMapper, AMap);
  FSQLDriver := TJCoreOPFSQLDriver(VDriver);
end;

{ TJCoreOPFSQLManualMapping }

function TJCoreOPFSQLManualMapping.EnsureCollectionAttribute(const AMapping: TJCoreOPFADMMapping;
  const AAttributeName: string): TJCoreOPFADMCollection;
begin
  Result := EnsureCollectionAttribute(AMapping.PID, AAttributeName);
end;

function TJCoreOPFSQLManualMapping.EnsureCollectionAttribute(const APID: TJCoreOPFPID;
  const AAttributeName: string): TJCoreOPFADMCollection;
var
  VADM: TJCoreOPFADM;
begin
  VADM := APID.AcquireADM(AAttributeName);
  if not (VADM is TJCoreOPFADMCollection) then
    raise EJCoreOPFCollectionADMExpected.Create(
     APID.Entity.ClassName, AAttributeName);
  Result := TJCoreOPFADMCollection(VADM);
end;

function TJCoreOPFSQLManualMapping.EnsureEntityAttribute(const AMapping: TJCoreOPFADMMapping;
  const AAttributeName: string): TJCoreOPFADMEntity;
begin
  Result := EnsureEntityAttribute(AMapping.PID, AAttributeName);
end;

function TJCoreOPFSQLManualMapping.EnsureEntityAttribute(const APID: TJCoreOPFPID;
  const AAttributeName: string): TJCoreOPFADMEntity;
var
  VADM: TJCoreOPFADM;
begin
  VADM := APID.AcquireADM(AAttributeName);
  if not (VADM is TJCoreOPFADMEntity) then
    raise EJCoreOPFEntityADMExpected.Create(APID.Entity.ClassName, AAttributeName);
  Result := TJCoreOPFADMEntity(VADM);
end;

function TJCoreOPFSQLManualMapping.ReadEntity(const AClass: TClass): TObject;
begin
  Result := Mapper.AcquireClassMapping(AClass).RetrieveFromDriverInternal;
end;

procedure TJCoreOPFSQLManualMapping.ReadCollection(const APID: TJCoreOPFPID; const AAttributeName: string);
var
  VADM: TJCoreOPFADMCollection;
begin
  VADM := EnsureCollectionAttribute(APID, AAttributeName);
  Mapper.AcquireClassMapping(VADM.Metadata.CompositionClass).RetrieveCollectionInternal(APID, VADM);
end;

procedure TJCoreOPFSQLManualMapping.ReadLazyEntity(const APID: TJCoreOPFPID; const AAttributeName: string);
var
  VADM: TJCoreOPFADMEntity;
begin
  VADM := EnsureEntityAttribute(APID, AAttributeName);
  Mapper.AcquireClassMapping(VADM.Metadata.CompositionClass).RetrieveLazyEntityFromDriverInternal(VADM);
end;

procedure TJCoreOPFSQLManualMapping.WriteCollection(const AMapping: TJCoreOPFADMMapping;
  const AAttributeName: string);
var
  VADM: TJCoreOPFADMCollection;
  VMetadata: TJCoreOPFAttrMetadata;
  VOIDs: TJCoreOPFOIDArray;
  VOID: TJCoreOPFOID;
begin
  { TODO : Improve the change analyzer }
  VADM := EnsureCollectionAttribute(AMapping, AAttributeName);
  if VADM.IsDirty then
  begin
    VMetadata := VADM.Metadata;

    // remove old links
    if (VMetadata.CompositionLinkType = jcltExternal) and AMapping.PID.IsPersistent then
    begin
      VOIDs := VADM.OIDRemoved;
      if Length(VOIDs) > 0 then
      begin
        AMapping.PID.OID.WriteToDriver(Driver);
        for VOID in VOIDs do
          VOID.WriteToDriver(Driver);
        Driver.ExecSQL(GenerateDeleteExternalLinkIDsStatement(VMetadata, Length(VOIDs)));
      end;
    end;

    // update items
    Mapper.AcquireClassMapping(VADM.Metadata.CompositionClass).StoreCollectionInternal(AMapping, VADM);

    // add new links
    if VMetadata.CompositionLinkType = jcltExternal then
      WriteExternalLinksToDriver(AMapping, VADM);
  end;
end;

procedure TJCoreOPFSQLManualMapping.WriteEntity(const AClass: TClass; const AEntity: TObject);
var
  VPID: TJCoreOPFPID;
begin
  if Assigned(AEntity) then
  begin
    VPID := Mapper.AcquirePID(AEntity);
    Mapper.AcquireClassMapping(AEntity.ClassType).StorePID(VPID);
    VPID.OID.WriteToDriver(Driver);
  end else
    Model.AcquireMetadata(AClass).OIDClass.WriteNull(Driver);
end;

procedure TJCoreOPFSQLManualMapping.WriteOwnerOIDToDriver(const AMapping: TJCoreOPFADMMapping);
begin
  AMapping.PID.Owner.OID.WriteToDriver(Driver);
end;

end.

