unit DataModuleU;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Stan.Def, FireDAC.Phys.SQLiteWrapper, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.UI.Intf, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet,  FireDAC.Comp.UI, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  System.Generics.Collections, System.Sensors.Components,
  Cim.Types, FMX.StdCtrls, Cims.ClassesU, System.Threading;

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


  TDataModule1 = class(TDataModule)
    FDSQLiteFunction1: TFDSQLiteFunction;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDConnection1: TFDConnection;
    qryListRegions: TFDQuery;
    qryListRegionsRegionNo: TSmallintField;
    qryListRegionsRegionNom: TWideStringField;
    qryListRegionsRegion_NbCim: TSmallintField;
    qryListRegionsRegion_Pcnt: TFloatField;
    qryListMRC: TFDQuery;
    qryListMRCMRC_No: TSmallintField;
    qryListMRCMRC_Nom: TWideStringField;
    qryListMRCMRC_NbCim: TSmallintField;
    qryListMRCMRC_Pcnt: TFloatField;
    qryListVilles: TFDQuery;
    qryListVillesVille: TWideStringField;
    qryListVillesNb: TLargeintField;
    cmdGetNbImagebyCimID: TFDCommand;
    qrySelectCims: TFDQuery;
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
    qrySelectImages: TFDQuery;
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
    qryAllCims: TFDQuery;
    qryAllCimsCimNo: TIntegerField;
    qryAllCimsCimCaption: TWideStringField;
    qryAllCimsCimLongName: TWideStringField;
    qryAllCimsComteNo: TSmallintField;
    qryAllCimsConfessionNo: TSmallintField;
    qryAllCimsProprioNo: TSmallintField;
    qryAllCimsEglise: TWideStringField;
    qryAllCimsEntryType: TSmallintField;
    qryAllCimsLatitude: TFloatField;
    qryAllCimsLongitude: TFloatField;
    qryAllCimsQuartier: TWideStringField;
    qryAllCimsVille: TWideStringField;
    qryAllCimsAdresseCivique: TWideStringField;
    qryAllCimsAdresse_1: TWideStringField;
    qryAllCimsAdresse_2: TWideStringField;
    qryAllCimsSituation: TWideStringField;
    qryAllCimsNotes: TWideStringField;
    qryAllCimsNomLieu: TWideStringField;
    qryAllCimsParoisse: TWideStringField;
    qryAllCimsEgliseNom: TWideStringField;
    qryAllCimsRecordActif: TBooleanField;
    qryAllCimsPosPrecision: TSmallintField;
    qryAllCimsCaptionEng: TWideStringField;
    qryAllCimsCimRegionNo: TSmallintField;
    qryAllCimsCimMRCNo: TSmallintField;
    qryAllCimsFirstDate: TWideStringField;
    qryAllCimsLastDate: TWideStringField;
    qryAllCimsWikimapia: TSmallintField;
    qryAllCimsWikimapiaID: TWideStringField;
    qryAllCimsCimQCLink: TWideStringField;
    qryAllCimsVisited: TWideStringField;
    qryAllCimsPhotosNET: TWideStringField;
    qryAllCimsNbNodes: TSmallintField;
    qryAllCimsPerimeter: TIntegerField;
    qryAllCimsArea: TIntegerField;
    qryAllCimsAltitude: TSmallintField;
    qryAllCimsGenHCN_Net: TSmallintField;
    qryAllCimsChapelle: TWideStringField;
    qryAllCimsNbMausolees: TSmallintField;
    qryAllCimsPosEglise: TSmallintField;
    qryAllCimsOrgSpatiale: TSmallintField;
    qryAllCimsInterLink: TSmallintField;
    qryAllCimsGarminFrCaption: TWideStringField;
    qryAllCimsRouteNo: TSmallintField;
    qryAllCimsViewOrder: TSmallintField;
    qryAllCimsNotesRecherches: TWideStringField;
    qryAllCimsConfirme: TWideStringField;
    qryAllCimsInactif: TWideStringField;
    qryAllCimsNbInhumations: TIntegerField;
    qryAllCimsNbMonuments: TIntegerField;
    qryAllCimsDatePremiereInhumation: TWideStringField;
    qryAllCimsDateDerniereInhumation: TWideStringField;
    qryAllCimsDateNbInhumations: TWideStringField;
    qryAllCimsCodeBorden: TWideStringField;
    qryAllCimsVisible: TBooleanField;
    qryAllCimsDist: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure FDConnection1BeforeConnect(Sender: TObject);
  private
    FPosEgliseMatx: TList<string>;
    FClassificationMatx: TList<string>;
    FOrgSpatialeMatx: TList<string>;
//    FLocationSensor: TLocationSensor;
//    FisGPSEnabled: Boolean;
//    FisGPPLocationValid: Boolean;

    FAreaStatsDescrCollection: TDictionary<integer, TAreaStats>;
//    FCimColl: TCims;
    FcimCollFuture : IFuture<TCims>;

    { Private declarations }
    procedure activateList(qry: TFDQuery); overload;

    procedure deactivateList(qry: TFDQuery); overload;

//    procedure SetCurrentCimFilter(const Value: string);

    //procedure LocationSensorLocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);


  public
    { Public declarations }
//    LocationSensorStatus: IFuture<Boolean>;
     //
    procedure activateListRegions(deactivate: Boolean = false);
    procedure deactivateAllList;



    function CimsResults(sortBy: TCimSortBy; DoUpdateDist: Boolean; maxDist: single): TDataSet;


    property PosEgliseMatx: TList<string> read FPosEgliseMatx;
    property OrgSpatialeMatx: TList<string> read FOrgSpatialeMatx;
    property ClassificationMatx: TList<string> read FClassificationMatx;
//    function LoadAllListes: Boolean;
    function LoadAllImageForCimID(CimId: integer): TDataSet;   overload;
//    function LoadAllImageForCimID(CimId: integer; imgColl : TCimImageCollection): boolean; overload;

    procedure LoadAreaStatsDescrColl;

    procedure OpenDatabase;

    function GetNbImagebyCimID(CimId: integer): integer;

    procedure LoadImage(var img: TimageControl; nomfichier: string);
    procedure LoadMap(var img: TimageControl; url: string);

//    property isGPSEnabled: Boolean read FisGPSEnabled;
//    property isGPPLocationValid: Boolean read FisGPPLocationValid;
    property AreaStatsDescrCollection: TDictionary<integer, TAreaStats> read FAreaStatsDescrCollection;

//    property   CimColl:TCims read FCimColl;
    property   CimColl:IFuture<TCims> read FcimCollFuture;

    procedure PopulateCimsColl;

//   function GetCims:TObjectList<TCim>;



  end;

var
  DataModule1: TDataModule1;


implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  FMX.Dialogs, System.Math, CoordU,System.IOUtils;


{$R *.dfm}

{ TDataModule1 }


procedure TDataModule1.activateList(qry: TFDQuery);
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

procedure TDataModule1.activateListRegions(deactivate: Boolean = false);
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


procedure TDataModule1.deactivateAllList;
begin
  deactivateList(qryListRegions);
  deactivateList(qryListMRC);
  deactivateList(qryListVilles);

end;

procedure TDataModule1.deactivateList(qry: TFDQuery);
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

procedure TDataModule1.FDConnection1BeforeConnect(Sender: TObject);
var
  lepath: string;
begin

  lepath := 'C:\DataGL\Projets\Cimetieres\Db\Cimetieres.db';

{$IFDEF Android}
  lepath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, 'Cimetieres.db');
{$ENDIF}
{$IFDEF iOS}
  lepath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, 'Cimetieres.db');
{$ENDIF}

{$IFDEF OSX}
  lepath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, 'Cimetieres.db');
{$ENDIF}


{$IFDEF Win32}
  // lepath := TPath.Combine(TPath.GetDocumentsPath, 'Cimetieres.db');
{$ENDIF}
  if FileExists(lepath) then
  begin

    FDConnection1.Params.Values['Database'] := lepath;

  end
  else
  begin
    ShowMessage(Format('Le fichier existe PAS «%s»',[lepath]));

  end;
end;





function TDataModule1.GetNbImagebyCimID(CimId: integer): integer;
begin

  Result := FDConnection1.ExecSQLScalar('select count(PicNo) from tblPhotos where PicCimNo= :CimID', [CimId]);

end;

function TDataModule1.CimsResults(sortBy: TCimSortBy; DoUpdateDist: Boolean; maxDist: single): TDataSet;
begin

  if DoUpdateDist then
  begin
    FDCommand1.Execute();
  end;

  qrySelectCims.Close; // .Active := false;

//  if FCurrentCimFilter <> '' then
//  begin
//    qrySelectCims.Filtered := false;
//    qrySelectCims.Filter := FCurrentCimFilter;
//    qrySelectCims.Filtered := true;
//
//  end;

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

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin

 FDConnection1.Connected :=false;

 //FCimColl := TCims.Create;

  FAreaStatsDescrCollection := TDictionary<integer, TAreaStats>.Create();

  //FCurrentCimFilter := '';



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


end;

procedure TDataModule1.DataModuleDestroy(Sender: TObject);
begin
  FPosEgliseMatx.Free;
  FOrgSpatialeMatx.Free;
  FClassificationMatx.Free;


  FcimCollFuture.Value.Free;
  FcimCollFuture := nil;
//  FCimColl.Free;

end;

//procedure TDataModule1.SetCurrentCimFilter(const Value: string);
//begin
//  FCurrentCimFilter := Value;
//end;

//procedure TdmMain.SetCurrentLocaton(const Value: TLocationCoord2D);
//begin
//  FCurrentLocaton := Value;
//end;

function TDataModule1.LoadAllImageForCimID(CimId: integer): TDataSet;
begin

  qrySelectImages.Close;

  qrySelectImages.Params[0].Value := CimId;
  qrySelectImages.Open;

  Result := qrySelectImages;

end;

//function TDataModule1.LoadAllImageForCimID(CimId: integer; imgColl : TCimImageCollection): boolean;
//var
//i :integer;
//  url: string;
//  img : TImage;
//begin
//
//  qrySelectImages.Close;
//
//  qrySelectImages.Params[0].Value := CimId;
//  qrySelectImages.Open;
//
//
//   I := 0;
//      while not qrySelectImages.Eof do
//      begin
//
//          img := TImage.Create(nil);
//          img.Tag := i;
//
//
//       url := 'http://www.leslabelle.com/Cimetieres/Photos/' + qrySelectImagesPicFileName.AsString;
//
//        DefaultImageLoader.LoadImage(img, url);
//
//        imgColl.Add(TCimImage.Create(img,
//              qrySelectImagesPicCaption.AsString,
//              qrySelectImagesPicDescr.AsString,
//              qrySelectImagesPicWidth.AsInteger,
//              qrySelectImagesPicHeight.AsInteger,url));
//
//        qrySelectImages.Next;
//        inc(I);
//      end;
//
//
//
//
//end;


//function TDataModule1.LoadAllListes: Boolean;
//begin
//
//  AllListStatus := TTask.Future<boolean>(
//  function : boolean
//   begin
//    qryListVilles.Active := true;
//    qryListMRC.Active := true;
//    qryListRegions.Active := true;
//    LoadAreaStatsDescrColl;
//    Result := true;
//   end  );
//
//end;

procedure TDataModule1.LoadAreaStatsDescrColl;
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

procedure TDataModule1.LoadImage(var img: TimageControl; nomfichier: string);

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
procedure TDataModule1.LoadMap(var img: TimageControl; url: string);

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






//procedure TDataModule1.LocationSensorLocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
//begin
//  FCurrentLocaton := NewLocation;
//
//  FisGPPLocationValid := true;
//end;
//


procedure TDataModule1.OpenDatabase;
begin
  Self.FDConnection1.Connected := true;

//  LoadAllListes;


  PopulateCimsColl;

//  Self.cmdCimSetAllVisible.Execute;


end;


procedure TDataModule1.PopulateCimsColl;
var
  unCim : TCim;
begin


  FcimCollFuture := TTask.Future<TCims>(
  function : Tcims
  var
    coll : TCims;
  begin

     coll := TCims.Create;


    qryAllCims.Active :=true;

    while not qryAllCims.Eof do
    begin
      unCim := TCim.Create;

      unCim.ID :=qryAllCimsCimNo.AsLargeInt;
      unCim.Caption := qryAllCimsCimCaption.AsString;
      unCim.Ville :=qryAllCimsVille.AsString;
      unCim.Quartier := qryAllCimsQuartier.AsString;
      unCim.Dist := 9999;
      unCim.EntryType :=  TFiltreCimTypeActif.EntryTypeToTFiltreCimTypeActif( qryAllCimsEntryType.AsInteger);

      unCim.Longitude := qryAllCimsLongitude.AsFloat;
      unCim.Latitude := qryAllCimsLatitude.AsFloat;

      coll.Coll.Add(unCim);

      qryAllCims.Next;
    end;

    Result := Coll;


    Datamodule1.qryAllCims.Active :=false;

    // Load all other liste
    qryListVilles.Active := true;
    qryListMRC.Active := true;
    qryListRegions.Active := true;
    LoadAreaStatsDescrColl;

  end);

//  qryAllCims.Active :=true;
//
//    while not qryAllCims.Eof do
//    begin
//      unCim := TCim.Create;
//
//      unCim.ID :=qryAllCimsCimNo.AsLargeInt;
//      unCim.Caption := qryAllCimsCimCaption.AsString;
//      unCim.Ville :=qryAllCimsVille.AsString;
//      unCim.Quartier := qryAllCimsQuartier.AsString;
//      unCim.Dist := 9999;
//      unCim.EntryType := qryAllCimsEntryType.AsInteger;
//
//      FCimColl.Coll.Add(unCim);
//
//      qryAllCims.Next;
//    end;
//
//    Datamodule1.qryAllCims.Active :=false;


end;

end.
