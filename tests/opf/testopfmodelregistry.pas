unit TestOPFModelRegistry;

{$mode objfpc}{$H+}

interface

uses
  JCoreMetadata,
  JCoreOPFMetadata;

type

  { TTestOPFModelIPID }

  TTestOPFModelIPID = class(TJCoreOPFModel)
  protected
    function BuildMetadata(const AClass: TClass): TJCoreClassMetadata; override;
    procedure InitRegistry; override;
  end;

  { TTestOPFModelProxy }

  TTestOPFModelProxy = class(TJCoreOPFModel)
  protected
    function BuildMetadata(const AClass: TClass): TJCoreClassMetadata; override;
    procedure InitRegistry; override;
  end;

implementation

uses
  sysutils,
  TestOPFModelContact;

{ TTestOPFModelIPID }

function TTestOPFModelIPID.BuildMetadata(const AClass: TClass): TJCoreClassMetadata;
var
  VMetadata: TJCoreOPFClassMetadata;
begin
  VMetadata := inherited BuildMetadata(AClass) as TJCoreOPFClassMetadata;
  try
    if AClass = TTestIPIDPerson then
    begin
      VMetadata.AttributeByName('Languages').CompositionType := jctAggregation;
      VMetadata.AttributeByName('Languages').CompositionLinkType := jcltExternal;
      VMetadata.AttributeByName('City').CompositionType := jctAggregation;
    end;
  except
    FreeAndNil(VMetadata);
    raise;
  end;
  Result := VMetadata;
end;

procedure TTestOPFModelIPID.InitRegistry;
begin
  inherited InitRegistry;
  AddClass(TTestIPIDPerson);
  AddClass(TTestIPIDPhone);
  AddClass(TTestIPIDLanguage);
  AddClass(TTestIPIDAddress);
  AddClass(TTestIPIDCity);
end;

{ TTestOPFModelProxy }

function TTestOPFModelProxy.BuildMetadata(const AClass: TClass): TJCoreClassMetadata;
begin
  Result := inherited BuildMetadata(AClass);
end;

procedure TTestOPFModelProxy.InitRegistry;
begin
  inherited InitRegistry;
  AddClass(TTestProxyPhone);
  AddClass(TTestProxyCity);
  AddClass(TTestProxyPerson);
end;

end.
