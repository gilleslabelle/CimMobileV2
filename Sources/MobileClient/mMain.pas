unit mMain;
// _______________________________________________________________ ZYMA __
// $HeadURL: svn://bitnami-redmine/_GL/trunk/Cimeti%C3%A8res/Sources/MobileClient/mMain.pas $
// .......................................................................
// Last committed    : $Revision:: 62               $
// Last changed by   : $Author:: labelleg           $
// Last changed date : $Date:: 2015-06-15 12:53:26 #$
// .......................................................................
// Copyright (c) ZYMA 2014
// _______________________________________________________________________

interface

uses
 System.Classes,System.IOUtils,

{$IFDEF Win32}
FireDAC.VCLUI.Wait,

{$ENDIF}


 FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Phys.SQLiteWrapper,
  FireDAC.Comp.Client, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Data.DB, FireDAC.Comp.DataSet,
  System.Sensors, System.Generics.Collections,System.Sensors.Components,
  SortForm, uPictureCls, FMX.StdCtrls,  FireDAC.Comp.UI ;
 // FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
//  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
//  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param,
//  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Phys.SQLiteWrapper,
//  FireDAC.Comp.Client, IdBaseComponent, IdComponent, IdTCPConnection,
//  IdTCPClient, IdHTTP, Data.DB, FireDAC.Phys.SQLite, FireDAC.Comp.DataSet,
//  FMX.Objects,
//  System.Generics.Collections,System.Sensors, SortForm,FMX.StdCtrls,
//  uPictureCls, FireDAC.Phys.SQLiteDef, System.Sensors.Components, FireDAC.VCLUI.Wait  ;

//uses
//  System.SysUtils, System.Classes, Data.DbxSqlite, Data.FMTBcd,
//  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
//  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
//  FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
//  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.SqlExpr, Data.DB,
//  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteWrapper,
//
//  System.Sensors, System.Generics.Collections, FMX.StdCtrls, IdBaseComponent,
//  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, FMX.Sensors, SortForm,
//  FMX.Types, FMX.Layouts, uPictureCls;

type
  TAreaStats = record
    NbCim: integer;
    SumArea: integer;
    AvgArea: double;
    LowRange: integer;
    HighRange: integer;

    GroupeFr: string;
    GroupeEng: string;
    RangeFr: string;
    RangeEng: string;

  end;

  TdmMain = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDQuery1: TFDQuery;
    FDQuery1CimNo: TIntegerField;
    FDQuery1CimCaption: TWideStringField;
    FDQuery1Ville: TWideStringField;
    FDQuery1Quartier: TWideStringField;
    FDQuery1Adresse_1: TWideStringField;
    FDQuery1Adresse_2: TWideStringField;
    FDQuery1Latitude: TFloatField;
    FDQuery1Longitude: TFloatField;
    FDQuery1MRC_Nom: TWideStringField;
    FDMemTable1: TFDMemTable;
    FDSQLiteFunction1: TFDSQLiteFunction;
    FDQuery1Dist: TFloatField;
    qrySelectCims: TFDQuery;
    qryGetCimDetail: TFDQuery;
    qryGetCimDetailCimNo: TIntegerField;
    qryGetCimDetailCimCaption: TWideStringField;
    qryGetCimDetailCimLongName: TWideStringField;
    qryGetCimDetailComteNo: TSmallintField;
    qryGetCimDetailConfessionNo: TSmallintField;
    qryGetCimDetailProprioNo: TSmallintField;
    qryGetCimDetailEglise: TWideStringField;
    qryGetCimDetailEntryType: TSmallintField;
    qryGetCimDetailLatitude: TFloatField;
    qryGetCimDetailLongitude: TFloatField;
    qryGetCimDetailQuartier: TWideStringField;
    qryGetCimDetailVille: TWideStringField;
    qryGetCimDetailAdresseCivique: TWideStringField;
    qryGetCimDetailAdresse_1: TWideStringField;
    qryGetCimDetailAdresse_2: TWideStringField;
    qryGetCimDetailSituation: TWideStringField;
    qryGetCimDetailNotes: TWideStringField;
    qryGetCimDetailNomLieu: TWideStringField;
    qryGetCimDetailParoisse: TWideStringField;
    qryGetCimDetailEgliseNom: TWideStringField;
    qryGetCimDetailRecordActif: TBooleanField;
    qryGetCimDetailPosPrecision: TSmallintField;
    qryGetCimDetailCaptionEng: TWideStringField;
    qryGetCimDetailCimRegionNo: TSmallintField;
    qryGetCimDetailCimMRCNo: TSmallintField;
    qryGetCimDetailFirstDate: TWideStringField;
    qryGetCimDetailLastDate: TWideStringField;
    qryGetCimDetailWikimapia: TSmallintField;
    qryGetCimDetailWikimapiaID: TWideStringField;
    qryGetCimDetailCimQCLink: TWideStringField;
    qryGetCimDetailVisited: TWideStringField;
    qryGetCimDetailPhotosNET: TWideStringField;
    qryGetCimDetailNbNodes: TSmallintField;
    qryGetCimDetailPerimeter: TIntegerField;
    qryGetCimDetailArea: TIntegerField;
    qryGetCimDetailAltitude: TSmallintField;
    qryGetCimDetailGenHCN_Net: TSmallintField;
    qryGetCimDetailChapelle: TWideStringField;
    qryGetCimDetailNbMausolees: TSmallintField;
    qryGetCimDetailPosEglise: TSmallintField;
    qryGetCimDetailOrgSpatiale: TSmallintField;
    qryGetCimDetailInterLink: TSmallintField;
    qryGetCimDetailGarminFrCaption: TWideStringField;
    qryGetCimDetailRouteNo: TSmallintField;
    qryGetCimDetailViewOrder: TSmallintField;
    qryGetCimDetailNotesRecherches: TWideStringField;
    qryGetCimDetailConfirme: TWideStringField;
    qryGetCimDetailInactif: TWideStringField;
    qryGetCimDetailNbInhumations: TIntegerField;
    qryGetCimDetailNbMonuments: TIntegerField;
    qryGetCimDetailDatePremiereInhumation: TWideStringField;
    qryGetCimDetailDateDerniereInhumation: TWideStringField;
    qryGetCimDetailDateNbInhumations: TWideStringField;
    qryGetCimDetailCodeBorden: TWideStringField;
    qryGetCimDetailVisible: TBooleanField;
    qryGetCimDetailDist: TFloatField;
    qryGetCimDetailComteNom: TWideStringField;
    qryGetCimDetailCimComteNo: TSmallintField;
    qryGetCimDetailConfessionFr: TWideStringField;
    qryGetCimDetailConfessionEng: TWideStringField;
    qryGetCimDetailConfessionLongFr: TWideStringField;
    qryGetCimDetailConfessionLongEng: TWideStringField;
    qryGetCimDetailLevelNo: TSmallintField;
    qryGetCimDetailParentNo: TSmallintField;
    qryGetCimDetailRegionNom: TWideStringField;
    qryGetCimDetailMRC_Nom: TWideStringField;
    qryListRegions: TFDQuery;
    qryListMRC: TFDQuery;
    qryListVilles: TFDQuery;
    qryListVillesVille: TWideStringField;
    qryListVillesNb: TLargeintField;
    qryListMRCMRC_No: TSmallintField;
    qryListMRCMRC_Nom: TWideStringField;
    qryListMRCMRC_NbCim: TSmallintField;
    qryListMRCMRC_Pcnt: TFloatField;
    qryListRegionsRegionNo: TSmallintField;
    qryListRegionsRegionNom: TWideStringField;
    qryListRegionsRegion_NbCim: TSmallintField;
    qryListRegionsRegion_Pcnt: TFloatField;
    cmdCimClearAllVisible: TFDCommand;
    cmdCimSetVisibleByVille: TFDCommand;
    cmdCimSetAllVisible: TFDCommand;
    qrySelectCimsCount: TFDQuery;
    cmdCimSetVisibleByMRC: TFDCommand;
    cmdCimSetVisibleByRegion: TFDCommand;
    cmdGetNbImagebyCimID: TFDCommand;
    qrySelectImages: TFDQuery;
    IdHTTP1: TIdHTTP;
    FDCommand1: TFDCommand;
    tblAreaStatdesc: TFDTable;
    tblAreaStatdescGroupeNo: TSmallintField;
    tblAreaStatdescGroupeFr: TWideStringField;
    tblAreaStatdescGroupeEng: TWideStringField;
    tblAreaStatdescRangeFr: TWideStringField;
    tblAreaStatdescRangeEng: TWideStringField;
    tblAreaStatdescLowRange: TIntegerField;
    tblAreaStatdescHighRange: TIntegerField;
    tblAreaStatdescNbCim: TIntegerField;
    tblAreaStatdescSumArea: TIntegerField;
    qrySelectImagesPicNo: TSmallintField;
    qrySelectImagesPicCimNo: TIntegerField;
    qrySelectImagesPicAuteur: TWideStringField;
    qrySelectImagesPicCaption: TWideStringField;
    qrySelectImagesPicDate: TWideStringField;
    qrySelectImagesPicDescr: TWideStringField;
    qrySelectImagesPicFileName: TWideStringField;
    qrySelectImagesPicWidth: TSmallintField;
    qrySelectImagesPicHeight: TSmallintField;
    qrySelectImagesPicOrder: TSmallintField;
    qrySelectImagesPicSourceID: TSmallintField;
    qrySelectImagesPicActive: TBooleanField;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure FDConnection1BeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure FDSQLiteFunction1Calculate(AFunc: TSQLiteFunctionInstance; AInputs: TSQLiteInputs; AOutput: TSQLiteOutput; var AUserData: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FCurrentLocaton: TLocationCoord2D;
    FCurrentCimFilter: string;
    FPosEgliseMatx: TList<string>;
    FClassificationMatx: TList<string>;
    FOrgSpatialeMatx: TList<string>;
    FLocationSensor: TLocationSensor;
    FisGPSEnabled: Boolean;
    FisGPPLocationValid: Boolean;

    FAreaStatsDescrCollection: TDictionary<integer, TAreaStats>;
    { Private declarations }
    procedure activateList(qry: TFDQuery); overload;
//    procedure activateList(qry: TFDTable); overload;
    procedure deactivateList(qry: TFDQuery); overload;
//    procedure deactivateList(qry: TFDTable); overload;
    procedure SetCurrentCimFilter(const Value: string);

    procedure LocationSensorLocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
//    procedure SetCurrentLocaton(const Value: TLocationCoord2D);

  public
    { Public declarations }
    property CurrentLocaton: TLocationCoord2D read FCurrentLocaton;
    procedure activateListRegions(deactivate: Boolean = false);
    procedure deactivateAllList;

    // function ResultsByPage(APageNumber, APageSize: integer): TDataSet;
    function CimsResults(sortBy: TCimSortBy; DoUpdateDist: Boolean; maxDist: single): TDataSet;

    property CurrentCimFilter: string read FCurrentCimFilter write SetCurrentCimFilter;

    property PosEgliseMatx: TList<string> read FPosEgliseMatx;
    property OrgSpatialeMatx: TList<string> read FOrgSpatialeMatx;
    property ClassificationMatx: TList<string> read FClassificationMatx;
    function LoadAllListes: Boolean;
    function LoadAllImageForCimID(CimId: integer): TDataSet;   overload;
    function LoadAllImageForCimID(CimId: integer; imgColl : TCimImageCollection): boolean; overload;

    procedure LoadAreaStatsDescrColl;

    function GetNbImagebyCimID(CimId: integer): integer;
    procedure LoadImage(var img: TimageControl; nomfichier: string);
    procedure LoadMap(var img: TimageControl; url: string);

    property isGPSEnabled: Boolean read FisGPSEnabled;
    property isGPPLocationValid: Boolean read FisGPPLocationValid;
    property AreaStatsDescrCollection: TDictionary<integer, TAreaStats> read FAreaStatsDescrCollection;
  end;

var
  dmMain: TdmMain;

implementation

  uses System.Math, System.SysUtils,uCoord,FMX.Dialogs,
  uImageLoader, FMX.Objects;
//uses
//  System.IOUtils, FMX.Dialogs, uCoord, System.Math, FMX.WebBrowser,
//  cimDetailControl, AnonThread;


{$R *.dfm}

procedure TdmMain.activateList(qry: TFDQuery);
begin
  if not qry.Active then
    qry.Active := true;

end;

//procedure TdmMain.activateList(qry: TFDTable);
//begin
//  if not qry.Active then
//    qry.Active := true;
//
//end;

procedure TdmMain.activateListRegions(deactivate: Boolean = false);
begin
  if deactivate then
  begin
    deactivateList(qryListRegions);
  end
  else
  begin
    activateList(qryListRegions);
  end;

end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin

  FAreaStatsDescrCollection := TDictionary<integer, TAreaStats>.Create();

  FCurrentCimFilter := '';
  FDConnection1.Connected := false;
  FDQuery1.Active := false;


  // FCurrentLocaton.Latitude := 45.6400; // Nan;
  // FCurrentLocaton.Longitude := -73.5046; // Nan;

  FCurrentLocaton.Latitude := Nan;
  FCurrentLocaton.Longitude := Nan;

  FisGPPLocationValid := false;
  FLocationSensor := TLocationSensor.Create(Self);

{$IFDEF Android}
  FLocationSensor.Active := true;
  FisGPSEnabled := true;
  FLocationSensor.Distance := 5;
  FLocationSensor.OnLocationChanged := LocationSensorLocationChanged;

{$ENDIF}
{$IFDEF iOS}
  FLocationSensor.Active := true;
  FisGPSEnabled := true;
  FLocationSensor.Distance := 5;
  FLocationSensor.OnLocationChanged := LocationSensorLocationChanged;

{$ENDIF}
{$IFDEF Win32}
  FLocationSensor.Active := true;
  FisGPSEnabled := true;
  FLocationSensor.Distance := 5;
  FLocationSensor.OnLocationChanged := LocationSensorLocationChanged;
{$ENDIF}




  // 45.500076, -73.506886,
{$IFDEF Android}
  // lepath := TPath.Combine(TPath.GetDocumentsPath, 'Cimetieres.db');
{$ENDIF}
{$IFDEF iOS}
  // lepath := TPath.Combine(TPath.GetDocumentsPath, 'Cimetieres.db');
{$ENDIF}
  // {$IFDEF Win32}
  // exit;
  // {$ENDIF}

  FPosEgliseMatx := TList<string>.Create();

  FPosEgliseMatx.Add('Inconnue');
  FPosEgliseMatx.Add('Ad sanctos');
  FPosEgliseMatx.Add('Intégré');
  FPosEgliseMatx.Add('Attenant');
  FPosEgliseMatx.Add('Écarté');
  FPosEgliseMatx.Add('Orphelin');
  FPosEgliseMatx.Add('Isolé');

  FOrgSpatialeMatx := TList<string>.Create();

  // Organisation spatiale
  FOrgSpatialeMatx.Add('Inconnue/ne s''applique pas');
  FOrgSpatialeMatx.Add('Aléatoire (groupement par famille)');
  FOrgSpatialeMatx.Add('Orthogonal - monobloc');
  FOrgSpatialeMatx.Add('Orthogonal - multiblocs');
  FOrgSpatialeMatx.Add('Cimeti&egrave;re-parc (jardin)');
  FOrgSpatialeMatx.Add('Cercle, demi-cercle, hexagonal ou octogonal');
  FOrgSpatialeMatx.Add('Dénaturé/Déplacé');
  FOrgSpatialeMatx.Add('Columbarium, mausolée, caveau familial');
  FOrgSpatialeMatx.Add('Divers (ad sanctos, sous l''eau, etc)');
  FOrgSpatialeMatx.Add('Mixte');

  // Classification (EntryType field)'
  FClassificationMatx := TList<string>.Create();

  FClassificationMatx.Add('Inconnue/ne s''applique pas');
  FClassificationMatx.Add('Cimetière');
  FClassificationMatx.Add('Archéologie/Histoire');
  FClassificationMatx.Add('Crypte d''église');
  FClassificationMatx.Add('Columbarium');
  FClassificationMatx.Add('Divers');

  Self.FDConnection1.Connected := true;

  LoadAllListes;

  dmMain.cmdCimSetAllVisible.Execute;

end;

procedure TdmMain.DataModuleDestroy(Sender: TObject);
begin
  FPosEgliseMatx.Free;
  FOrgSpatialeMatx.Free;
  FClassificationMatx.Free;
end;

procedure TdmMain.deactivateAllList;
begin
  deactivateList(qryListRegions);
  deactivateList(qryListMRC);
  deactivateList(qryListVilles);

end;

procedure TdmMain.deactivateList(qry: TFDQuery);
begin
  if qry.Active then
  begin
    qry.Active := false;
  end;
end;

//procedure TdmMain.deactivateList(qry: TFDTable);
//begin
//  if qry.Active then
//  begin
//    qry.Active := false;
//  end;
//end;

procedure TdmMain.FDConnection1BeforeConnect(Sender: TObject);
var
  lepath: string;
begin

{$IFDEF Android}
  lepath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, 'Cimetieres.db');
{$ENDIF}
{$IFDEF iOS}
  lepath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, 'Cimetieres.db');
{$ENDIF}
{$IFDEF Win32}
  // lepath := TPath.Combine(TPath.GetDocumentsPath, 'Cimetieres.db');
  lepath := 'C:\DataGL\Projets\Cimetieres\Db\Cimetieres.db';
{$ENDIF}
  if FileExists(lepath) then
  begin

    FDConnection1.Params.Values['Database'] := lepath;

  end
  else
  begin
    ShowMessage('Le fichier existe PAS');

  end;
end;

procedure TdmMain.FDSQLiteFunction1Calculate(AFunc: TSQLiteFunctionInstance; AInputs: TSQLiteInputs; AOutput: TSQLiteOutput; var AUserData: TObject);
begin

  if (not isNan(FCurrentLocaton.Latitude)) and (not isNan(FCurrentLocaton.Longitude)) then
  begin
    AOutput.asFloat := DistanceInKm2(FCurrentLocaton.Longitude, FCurrentLocaton.Latitude, AInputs[1].asFloat, AInputs[0].asFloat);

  end
  else
  begin
    AOutput.asFloat := 999999;
  end;
end;

function TdmMain.GetNbImagebyCimID(CimId: integer): integer;
begin

  Result := FDConnection1.ExecSQLScalar('select count(PicNo) from tblPhotos where PicCimNo= :CimID', [CimId]);

end;

function TdmMain.CimsResults(sortBy: TCimSortBy; DoUpdateDist: Boolean; maxDist: single): TDataSet;
begin

  if DoUpdateDist then
  begin
    FDCommand1.Execute();
  end;

  qrySelectCims.Close; // .Active := false;

  if FCurrentCimFilter <> '' then
  begin
    qrySelectCims.Filtered := false;
    qrySelectCims.Filter := FCurrentCimFilter;
    qrySelectCims.Filtered := true;

  end;

  // qrySelectCims.Params.ParamByName('PAGENUMBER').AsInteger :=0;
  // qrySelectCims.Params.ParamByName('PAGESIZE').AsInteger := 99999;

  if not DoUpdateDist then
  begin
    maxDist := 999999;
  end;

  qrySelectCims.MacroByName('maxDist').Value := maxDist;

  case sortBy of
    byDist:
      begin
        qrySelectCims.MacroByName('Order1').Value := 'Dist';
        qrySelectCims.MacroByName('Order2').Value := 'Ville';
      end;
    byName:
      begin

        qrySelectCims.MacroByName('Order1').Value := 'CimCaption';
        qrySelectCims.MacroByName('Order2').Value := 'Ville';

      end;
    byVille:
      begin
        qrySelectCims.MacroByName('Order1').Value := 'Ville';
        qrySelectCims.MacroByName('Order2').Value := 'CimCaption';
      end;
  end;
  qrySelectCims.Open;

  Result := qrySelectCims;

end;

procedure TdmMain.SetCurrentCimFilter(const Value: string);
begin
  FCurrentCimFilter := Value;
end;

//procedure TdmMain.SetCurrentLocaton(const Value: TLocationCoord2D);
//begin
//  FCurrentLocaton := Value;
//end;

function TdmMain.LoadAllImageForCimID(CimId: integer): TDataSet;
begin

  qrySelectImages.Close;

  qrySelectImages.Params[0].Value := CimId;
  qrySelectImages.Open;

  Result := qrySelectImages;

end;

function TdmMain.LoadAllImageForCimID(CimId: integer; imgColl : TCimImageCollection): boolean;
var
i :integer;
  url: string;
  img : TImage;
begin

  qrySelectImages.Close;

  qrySelectImages.Params[0].Value := CimId;
  qrySelectImages.Open;


   I := 0;
      while not qrySelectImages.Eof do
      begin

          img := TImage.Create(nil);
          img.Tag := i;


       url := 'http://www.leslabelle.com/Cimetieres/Photos/' + qrySelectImagesPicFileName.AsString;

        DefaultImageLoader.LoadImage(img, url);

        imgColl.Add(TCimImage.Create(img,
              qrySelectImagesPicCaption.AsString,
              qrySelectImagesPicDescr.AsString,
              qrySelectImagesPicWidth.AsInteger,
              qrySelectImagesPicHeight.AsInteger,url));

        qrySelectImages.Next;
        inc(I);
      end;




end;


function TdmMain.LoadAllListes: Boolean;
begin

  Self.qryListVilles.Active := true;
  Self.qryListMRC.Active := true;
  Self.qryListRegions.Active := true;
  LoadAreaStatsDescrColl;
  Result := true;

end;

procedure TdmMain.LoadAreaStatsDescrColl;
var
  j: integer;
  stat: TAreaStats;
begin

  tblAreaStatdesc.Active := true;
  tblAreaStatdesc.First;
  j := 0;
  while not tblAreaStatdesc.Eof do
  begin

    stat.GroupeFr := tblAreaStatdescGroupeFr.AsString;
    stat.GroupeEng := tblAreaStatdescGroupeEng.AsString;
    stat.RangeFr := tblAreaStatdescRangeFr.AsString;
    stat.RangeEng := tblAreaStatdescRangeEng.AsString;

    stat.NbCim := tblAreaStatdescNbCim.AsInteger;
    stat.SumArea := tblAreaStatdescSumArea.AsInteger;
    stat.LowRange := tblAreaStatdescLowRange.AsInteger;
    stat.HighRange := tblAreaStatdescHighRange.AsInteger;

    // Compute average area per cemetery
    if (stat.NbCim < 1) then
    begin
      stat.AvgArea := 0.000;
    end
    else
    begin
      stat.AvgArea := stat.SumArea / stat.NbCim;
    end;

    FAreaStatsDescrCollection.Add(j, stat);

    tblAreaStatdesc.Next;

    inc(j);
  end;

end;

procedure TdmMain.LoadImage(var img: TimageControl; nomfichier: string);

var
  memStream: TMemoryStream;
  url: string;
begin

  memStream := TMemoryStream.Create();
  url := 'http://www.leslabelle.com/Cimetieres/Photos/' + nomfichier;

  try
    img.Bitmap := nil;

    IdHTTP1.Get(url, memStream);
  except
    memStream.Free;
    exit;
  end;

  try
    memStream.Position := 0;
    img.Bitmap.LoadFromStream(memStream);
  finally
    memStream.Free;
  end;

end;
procedure TdmMain.LoadMap(var img: TimageControl; url: string);

var
  memStream: TMemoryStream;
 // url: string;
begin

  memStream := TMemoryStream.Create();
//  url := 'http://www.leslabelle.com/Cimetieres/Photos/' + nomfichier;

  try
    img.Bitmap := nil;
    // idhttp1.Get ('http://www.leslabelle.com/Cimetieres/Photos/Cim_0869_2.jpg',memStream);
    IdHTTP1.Get(url, memStream);
  except
    memStream.Free;
    exit;
  end;

  try
    memStream.Position := 0;
    img.Bitmap.LoadFromStream(memStream);
  finally
    memStream.Free;
  end;

end;





procedure TdmMain.LocationSensorLocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
begin
  FCurrentLocaton := NewLocation;

  FisGPPLocationValid := true;
end;

end.

