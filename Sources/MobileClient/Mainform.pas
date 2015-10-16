unit Mainform;
// _______________________________________________________________ ZYMA __
// $HeadURL: svn://bitnami-redmine/_GL/trunk/Cimeti%C3%A8res/Sources/MobileClient/Mainform.pas $
// .......................................................................
// Last committed    : $Revision:: 62               $
// Last changed by   : $Author:: labelleg           $
// Last changed date : $Date:: 2015-06-15 12:53:26 #$
// .......................................................................
// Copyright (c) ZYMA 2014
// _______________________________________________________________________

interface

uses
  FMX.Forms, FMX.ListView.Types, FMX.ExtCtrls, FireDAC.UI.Intf, FireDAC.FMXUI.Wait, Data.Bind.EngExt, FMX.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.ObjectScope, FMX.Types, FMX.Gestures, Data.Bind.Components, Data.Bind.DBScope,
  FireDAC.Stan.Intf, FireDAC.Comp.UI, FMX.ActnList,
  System.Classes, System.Actions, FMX.TabControl, FMX.Controls, FMX.Objects, FMX.StdCtrls, FMX.Layouts, FMX.Effects,
  FMX.ListBox, FMX.ListView,
  FMX.Controls.Presentation, uFilter, uPictureCls, SortForm, ShowCimLocations,
  FMX.Maps, FMX.Ani, FMX.ListView.Appearances, FMX.ListView.Adapters.Base;

// uses
// FMX.Forms, FMX.ListView.Types, FireDAC.UI.Intf, FireDAC.FMXUI.Wait,
// Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
// Fmx.Bind.Editors, Data.Bind.ObjectScope, FMX.Types, FMX.Gestures,
// Data.Bind.Components, Data.Bind.DBScope, FireDAC.Stan.Intf, FireDAC.Comp.UI,
// FMX.ActnList, System.Classes, System.Actions, FMX.TabControl, FMX.Controls,
// FMX.Objects, FMX.StdCtrls, FMX.Layouts, FMX.Effects, FMX.ListBox, FMX.ListView,
// uFilter, uPictureCls,FMX.ExtCtrls, SortForm, ShowCimLocations,
// FMX.Controls.Presentation, FMX.Maps;

type
  TformMain = class(TForm)
    TabControl1: TTabControl;
    tabListCims: TTabItem;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    ChangeTabActionBackToSearch: TChangeTabAction;
    tabCimDetails: TTabItem;
    tbListCimHeader: TToolBar;
    lblTitleCim: TLabel;
    ToolBar7: TToolBar;
    Label7: TLabel;
    ChangeTabActionBackToCim: TChangeTabAction;
    btnShowMap: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    SpeedButton3: TSpeedButton;
    GestureManager1: TGestureManager;
    actStartList: TAction;
    cmdMapAllCims: TSpeedButton;
    AdapterBindSource1: TAdapterBindSource;
    LinkFillControlToField1: TLinkFillControlToField;
    lvCimetieres: TListView;
    LinkFillControlToField2: TLinkFillControlToField;
    lblSousTitleCim: TLabel;
    AdapterBindSource2: TAdapterBindSource;
    LinkFillControlToField3: TLinkFillControlToField;
    // lvCimDetails: TListView;
    LinkFillControlToField4: TLinkFillControlToField;
    lblCimCaption: TLabel;
    actOpenDrawer: TAction;
    ChangeTabActionBackToCimDetail: TChangeTabAction;
    ChangeTabActionToCimMap: TChangeTabAction;
    tabCimImage: TTabItem;
    tbCimImage: TToolBar;
    btnCloseCimImage: TSpeedButton;
    tbCimImageBottom: TToolBar;
    lblCimImageDetail: TText;
    btnCimImageNext: TSpeedButton;
    btnCimImagePrevious: TSpeedButton;
    lblCimImageCaption: TLabel;
    actShowFilterDialog: TAction;
    cmdShowOptions: TSpeedButton;
    lbOptions: TListBox;
    lbiOptionFiltre: TListBoxItem;
    lbiOptionSort: TListBoxItem;
    actShowSortDialog: TAction;
    pnlCimCaption: TPanel;
    lbiOptionRefresh: TListBoxItem;
    ShadowEffect1: TShadowEffect;
    vsbCimDetails: TVertScrollBox;
    StyleBook1: TStyleBook;
    mapCim: TMapView;
    MapFloatAnimation: TFloatAnimation;
    procedure FormCreate(Sender: TObject);
    procedure tabListCimsClick(Sender: TObject);
    procedure btnShowMapClick(Sender: TObject);
    procedure actStartListExecute(Sender: TObject);
    procedure cmdMapAllCimsClick(Sender: TObject);
    procedure lvCimetieresUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
    procedure lvCimetieresItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure FormResize(Sender: TObject);
    procedure cmdShowDirectionClick(Sender: TObject);
    procedure hsbCimDetailImagesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure btnCloseCimImageClick(Sender: TObject);
    procedure tabCimImageGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure btnCimImageNextClick(Sender: TObject);
    procedure btnCimImagePreviousClick(Sender: TObject);
    procedure actShowFilterDialogExecute(Sender: TObject);
    procedure actOpenDrawerExecute(Sender: TObject);
    procedure actOpenDrawerUpdate(Sender: TObject);
    procedure actShowSortDialogExecute(Sender: TObject);
    procedure lbiOptionFiltreClick(Sender: TObject);
    procedure lbiOptionSortClick(Sender: TObject);
    procedure lbiOptionRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mapCimMapDoubleClick(const Position: TMapCoordinate);

  private

    FiltresCimActif   : TFiltresCimActif;
    FiltreGeneralActif: TFiltreGeneralActif;

    FCurrentCimImages : TCimImageCollection;
    FCurrentImage     : TImageViewer;
    FcurrentImageIndex: integer;
    FFormeFiltre      : TFormFilter;
    FFormeSort        : TFormSort;
    FFormeLocationsMap: TShowCimLocationsForm;

    FSortActif: TCimSortBy;

    FUseDistance     : Boolean;
    FCurrentMapMarker: TMapMarker;
    FMapOriginalHeight: integer;
    FMapZoomed: Boolean;

    procedure AfficheDetailCim(cimId: integer);
    procedure LoadCimetieres;
    procedure ShowCimBigImage;
    procedure AfficheBigImage(Sender: TObject);

    { Private declarations }
    // function IsPad: Boolean;
    procedure SetUseDistance(const Value: Boolean);

    procedure ShowBigCimCarte(const Position: TMapCoordinate);

  public
    { Public declarations }
    property UseDistance: Boolean read FUseDistance write SetUseDistance;
  end;

var
  formMain: TformMain;

implementation

{$R *.fmx}

uses
  // {$IFDEF iOS}
  // IOSApi.Foundation,
  // IOSApi.UIKit,
  // ShowLocationsMap_iOS,
  // ImagesForm_IOS,
  // {$ENDIF}
{$IFDEF Win32}
  ShellApi,
  Winapi.Windows,
{$ENDIF}
{$IFDEF ANDROID}
  // FMX.Platform.Android, FMX.Helpers.Android, Androidapi.Jni.GraphicsContentViewText,
  // Androidapi.Jni.Net, Androidapi.Jni.JavaTypes,

{$ENDIF}
  uCoord, mMain, mainformLogic, cimDetailControl, System.SysUtils,
  System.UITypes, System.Types, Data.DB, FMX.Dialogs, System.Math;

// , cimDetailControl, System.SysUtils,System.UITypes,
// System.Types, Data.DB, WaitFormUnit,FMX.Dialogs,
// System.Math, uImageLoader;
//



// idURi, uCoord, FMX.Styles, System.IOUtils, System.DateUtils,
// AnonThread, WaitFormUnit,
//
// FMX.Platform, cimDetailControl, mainformLogic;

procedure TformMain.AfficheDetailCim(cimId: integer);

  procedure AddItem(var sb: TVertScrollBox; caption, texte: string);
  var
    CimDetailCtl: TCimDetailCtl;
  begin
    CimDetailCtl              := TCimDetailCtl.Create(sb);
    CimDetailCtl.StyleLookup  := 'CimDetailCtlStyle';
    CimDetailCtl.LabelCaption := caption;
    CimDetailCtl.LabelDetail  := texte;
    CimDetailCtl.Align        := TAlignLayout.Top;
    CimDetailCtl.Parent       := sb;

  end;

var
  strTemp  : string;
  mapView  : TMapView;
  mapCenter: TMapCoordinate;
  MyMarker : TMapMarkerDescriptor;

begin

  FCurrentCimImages.Clear;

  ClearScrollBox(vsbCimDetails);

  vsbCimDetails.BeginUpdate;

  dmMain.qryGetCimDetail.Active := false;

  dmMain.qryGetCimDetail.ParamByName('CIMID').AsInteger := cimId;
  dmMain.qryGetCimDetail.Active                         := true;





  // ImgCarte := TImage.Create(vsbCimDetails);
  //
  // ImgCarte.Align := TAlignLayout.MostTop;
  // ImgCarte.Height := 100;
  //
  // ImgCarte.Parent := vsbCimDetails;
  // ImgCarte.WrapMode := TImageWrapMode.Fit;
  //
  // sf := TFormatSettings.Create('en-US');
  // sLat:=  dmMain.qryGetCimDetailLatitude.AsSingle.ToString(sf);
  // sLong:=  dmMain.qryGetCimDetailLongitude.AsSingle.ToString(sf);
  //
  // sMarker := Format('pin-s-cemetery(%s,%s)', [sLong, sLat]);
  //
  //
  // url := Format('http://api.tiles.mapbox.com/v3/%s/' + sMarker + '/%s,%s,12/%dx%d.png', [mainformLogic.MapboxKey, sLong, sLat, 640, 200]);
  //
  //
  // DefaultImageLoader.LoadImage(ImgCarte,url);

  // mapView := TMapview.Create(vsbCimDetails);
  // MapView.MapType := TMapType.Normal;
  mapCenter := TMapCoordinate.Create(dmMain.qryGetCimDetailLatitude.AsSingle, dmMain.qryGetCimDetailLongitude.AsSingle);

  // MapView.Location := mapCenter;
  // mapView.Align := TAlignLayout.MostTop;
  // mapView.Height := 100;
  //
  // mapView.Parent := vsbCimDetails;

  MyMarker := TMapMarkerDescriptor.Create(mapCenter, dmMain.qryGetCimDetailCimLongName.AsString);

  MyMarker.Draggable := false;
  // Make a marker visible
  MyMarker.Visible := true;
  // MapView.AddMarker(MyMarker);

  // mapView.Zoom :=10;

  // mapView.OnMapClick := ShowBigCimCarte;

  mapCim.Location := mapCenter;
  // if Assigned(FCurrentMapMarker) then
  // begin
  // FCurrentMapMarker.Remove;
  // end;

  FCurrentMapMarker := mapCim.AddMarker(MyMarker);

  // TMapClickEvent = procedure(const Position: TMapCoordinate) of object;
  // mainformLogic.AfficheCarteDirection(dmMain.qryGetCimDetailLatitude.AsFloat, dmMain.qryGetCimDetailLongitude.AsFloat, dmMain.qryGetCimDetailCimCaption.AsString);



  // *****  Nom du cimetière (Long name)  *****

  lblCimCaption.Text := dmMain.qryGetCimDetailCimLongName.AsString;

  { -- *****  Cim.No.  ***** }
  // AddItem(vsbCimDetails, 'Cimetière #', dmMain.qryGetCimDetailCimNo.AsString);

  { -- *****  Cartouche (Caption)  ***** }
  // AddItem(vsbCimDetails, 'Cartouche', dmMain.qryGetCimDetailCimCaption.AsString);

  // *****  Nom du cimetière (Long name)  *****
  // AddItem('Nom complet', dmMain.qryGetCimDetailCimLongName.AsString);
  // *****  Quartier  *****
  if (trim(dmMain.qryGetCimDetailQuartier.AsString.trim) <> '') then
  begin
    AddItem(vsbCimDetails, 'Quartier', dmMain.qryGetCimDetailQuartier.AsString);
  end;
  //
  // *****  Ville  *****
  if (trim(dmMain.qryGetCimDetailVille.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Ville', dmMain.qryGetCimDetailVille.AsString);
  end;
  // *****  Comté  *****
  if (trim(dmMain.qryGetCimDetailComteNom.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Comté', dmMain.qryGetCimDetailComteNom.AsString);
  end;

  //
  // *****  MRC  *****
  if (trim(dmMain.qryGetCimDetailMRC_Nom.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'MRC', dmMain.qryGetCimDetailMRC_Nom.AsString);
  end;
  //
  // *****  Region  *****
  if (trim(dmMain.qryGetCimDetailRegionNom.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Région', dmMain.qryGetCimDetailRegionNom.AsString);
  end;
  //
  // *****  NomLieu  *****
  if (trim(dmMain.qryGetCimDetailNomLieu.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Nom du lieu', dmMain.qryGetCimDetailNomLieu.AsString);
  end;

  // *****  Paroisse  *****
  if (trim(dmMain.qryGetCimDetailParoisse.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Paroisse', dmMain.qryGetCimDetailParoisse.AsString);
  end;
  //
  // *****  EgliseNom  *****
  if (trim(dmMain.qryGetCimDetailEgliseNom.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Église', dmMain.qryGetCimDetailEgliseNom.AsString);
  end;
  //
  // *****  Adresse civique  *****
  if (trim(dmMain.qryGetCimDetailAdresseCivique.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Adresse civique', dmMain.qryGetCimDetailAdresseCivique.AsString);
  end;
  //
  // *****  Adresse_1  *****
  if (trim(dmMain.qryGetCimDetailAdresse_1.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Adresse_1', dmMain.qryGetCimDetailAdresse_1.AsString);
  end;
  //
  // *****  Adresse_2  *****
  if (trim(dmMain.qryGetCimDetailAdresse_2.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Adresse_2', dmMain.qryGetCimDetailAdresse_2.AsString);
  end;
  // *****  Situation  *****
  if (trim(dmMain.qryGetCimDetailSituation.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Situation', dmMain.qryGetCimDetailSituation.AsString);
  end;
  // *****  Confession  *****
  if (trim(dmMain.qryGetCimDetailConfessionLongFr.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Type / Confession', dmMain.qryGetCimDetailConfessionLongFr.AsString);
  end;
  // *****  Eglise  *****
  if (dmMain.qryGetCimDetailPosEglise.AsInteger = 0) then
  begin
    if dmMain.qryGetCimDetailEglise.AsBoolean then
    begin
      AddItem(vsbCimDetails, 'Église à proximité', dmMain.qryGetCimDetailEglise.AsString);
    end
  end;
  // *****  First date  *****
  if (trim(dmMain.qryGetCimDetailFirstDate.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Date de fondation', dmMain.qryGetCimDetailFirstDate.AsString);
  end;
  //
  // *****  Last date  *****
  if (trim(dmMain.qryGetCimDetailLastDate.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Date de fermeture', dmMain.qryGetCimDetailLastDate.AsString);
  end;
  //
  // *****  Date premiere inhumation  *****
  if (trim(dmMain.qryGetCimDetailDatePremiereInhumation.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Première Inhumation', dmMain.qryGetCimDetailDatePremiereInhumation.AsString);
  end;
  //
  // *****  Date derniere inhumation  *****
  if (trim(dmMain.qryGetCimDetailDateDerniereInhumation.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Dernière Inhumation', dmMain.qryGetCimDetailDateDerniereInhumation.AsString);
  end;
  //
  // *****  Notes  *****
  if (trim(dmMain.qryGetCimDetailNotes.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Note', dmMain.qryGetCimDetailNotes.AsString);
  end;
  //
  // *****  Latitude  *****
  if (dmMain.qryGetCimDetailLatitude.AsFloat <> 0) then
  begin
    strTemp := dmMain.qryGetCimDetailLatitude.AsString + #176;

    strTemp := strTemp + ' (' + Conv_Dec2DMS(dmMain.qryGetCimDetailLatitude.AsFloat, 1) + ') ';
    // dmMain.qryGetCimDetailNotes.AsString;

    if (dmMain.qryGetCimDetailPosPrecision.AsInteger >= ApproxPositionLevel) then
    begin
      strTemp := strTemp + ' *** Position approximative ***';
    end;

    if strTemp <> '' then
    begin

      AddItem(vsbCimDetails, 'Latitude', strTemp);

    end;

  end;

  // *****  Longitude  *****
  if (dmMain.qryGetCimDetailLongitude.AsFloat <> 0) then
  begin
    strTemp := dmMain.qryGetCimDetailLongitude.AsString + #176;

    strTemp := strTemp + ' (' + Conv_Dec2DMS(dmMain.qryGetCimDetailLongitude.AsFloat, 2) + ') ';
    // dmMain.qryGetCimDetailNotes.AsString;

    if (dmMain.qryGetCimDetailPosPrecision.AsInteger >= ApproxPositionLevel) then
    begin
      strTemp := strTemp + ' *** Position approximative ***';
    end;

    if strTemp <> '' then
    begin

      AddItem(vsbCimDetails, 'Longitude', strTemp);

    end;

  end;

  //
  // *****  Position precision  *****
  if (dmMain.qryGetCimDetailPosPrecision.AsInteger > 0) then
  begin
    strTemp := '';
    case dmMain.qryGetCimDetailPosPrecision.AsInteger of
      1:
        strTemp := PrecisionLevel_1_Fr;
      2:
        strTemp := PrecisionLevel_2_Fr;
      3:
        strTemp := PrecisionLevel_3_Fr;
      4:
        strTemp := PrecisionLevel_4_Fr;
    end;
    AddItem(vsbCimDetails, 'Présision', strTemp);
  end;
  //
  // *****  Altitude  *****
  if (dmMain.qryGetCimDetailAltitude.AsInteger > 0) then
  begin
    strTemp := Format('%d Mètres (%.0f Pieds)', [dmMain.qryGetCimDetailAltitude.AsInteger,
      dmMain.qryGetCimDetailAltitude.AsInteger * CF_MeterToFeet]);
    AddItem(vsbCimDetails, 'Altitude', strTemp);
  end;
  //
  // *****  Area  *****

  if (dmMain.qryGetCimDetailArea.AsInteger > 0) then
  begin
    strTemp := Format('%d Mètres² (%.0f Pieds²)', [dmMain.qryGetCimDetailArea.AsInteger,
      dmMain.qryGetCimDetailArea.AsInteger * CF_SQMeterToSQFeet]);
    strTemp := strTemp + '/ TYPE: ';
    if (dmMain.qryGetCimDetailArea.AsInteger <= dmMain.AreaStatsDescrCollection[1].HighRange) then
    begin
      strTemp := strTemp + dmMain.AreaStatsDescrCollection[1].GroupeFr + ' (' + dmMain.AreaStatsDescrCollection[1]
        .RangeFr + ')';
    end
    else if (dmMain.qryGetCimDetailArea.AsInteger <= dmMain.AreaStatsDescrCollection[2].HighRange) then
    begin
      strTemp := strTemp + dmMain.AreaStatsDescrCollection[2].GroupeFr + ' (' + dmMain.AreaStatsDescrCollection[2]
        .RangeFr + ')';
    end
    else if (dmMain.qryGetCimDetailArea.AsInteger <= dmMain.AreaStatsDescrCollection[3].HighRange) then
    begin
      strTemp := strTemp + dmMain.AreaStatsDescrCollection[3].GroupeFr + ' (' + dmMain.AreaStatsDescrCollection[3]
        .RangeFr + ')';
    end
    else if (dmMain.qryGetCimDetailArea.AsInteger <= dmMain.AreaStatsDescrCollection[4].HighRange) then
    begin
      strTemp := strTemp + dmMain.AreaStatsDescrCollection[4].GroupeFr + ' (' + dmMain.AreaStatsDescrCollection[4]
        .RangeFr + ')';
    end
    else
    begin
      strTemp := strTemp + dmMain.AreaStatsDescrCollection[5].GroupeFr + ' (' + dmMain.AreaStatsDescrCollection[5]
        .RangeFr + ')';
    end;

    AddItem(vsbCimDetails, 'Surface', strTemp);

  end;

  //
  // *****  Perimeter  *****
  if (dmMain.qryGetCimDetailPerimeter.AsInteger > 0) then
  begin
    strTemp := Format('%d Mètres (%.0f Pieds)', [dmMain.qryGetCimDetailPerimeter.AsInteger,
      dmMain.qryGetCimDetailPerimeter.AsInteger * CF_MeterToFeet]);

    AddItem(vsbCimDetails, 'Périmètre', strTemp);

  end;
  //
  // *****  Chapelle  *****
  if SameText(dmMain.qryGetCimDetailChapelle.AsString, 'Y') then
  begin
    AddItem(vsbCimDetails, 'Chapelle', 'Oui');
  end;
  //
  // *****  Nb. Mausolees  *****
  if dmMain.qryGetCimDetailNbMausolees.AsInteger > 0 then
  begin
    AddItem(vsbCimDetails, 'Nb. mausolées', FormatFloat('0.', dmMain.qryGetCimDetailNbMausolees.AsInteger));
  end;
  //
  // NbInhumations
  if dmMain.qryGetCimDetailNbInhumations.AsInteger > 0 then
  begin
    AddItem(vsbCimDetails, 'Nb. inhumations', FormatFloat('0.', dmMain.qryGetCimDetailNbInhumations.AsInteger));
  end;
  //
  // NbMonuments
  if dmMain.qryGetCimDetailNbMonuments.AsInteger > 0 then
  begin
    AddItem(vsbCimDetails, 'Nb. de monuments', FormatFloat('0.', dmMain.qryGetCimDetailNbMonuments.AsInteger));
  end;

  //
  // *****  CountDate - Date du decompte du nb. inhumations  *****
  if dmMain.qryGetCimDetailDateNbInhumations.AsString <> '' then
  begin
    AddItem(vsbCimDetails, 'Date du décompte', dmMain.qryGetCimDetailDateNbInhumations.AsString);
  end;

  // *****  Position par rapport a eglise  *****

  if dmMain.qryGetCimDetailPosEglise.AsInteger > 0 then
  begin
    AddItem(vsbCimDetails, 'Position vs église', dmMain.PosEgliseMatx[dmMain.qryGetCimDetailPosEglise.AsInteger]);
  end;

  // *****  Organisation spaciale  *****
  if dmMain.qryGetCimDetailOrgSpatiale.AsInteger > 0 then
  begin
    AddItem(vsbCimDetails, 'Organisation spatiale',
      dmMain.OrgSpatialeMatx[dmMain.qryGetCimDetailOrgSpatiale.AsInteger]);
  end;

  // **** Classification (EntryType) ****
  if dmMain.qryGetCimDetailEntryType.AsInteger > 0 then
  begin
    AddItem(vsbCimDetails, 'Classification', dmMain.ClassificationMatx[dmMain.qryGetCimDetailEntryType.AsInteger]);
  end;


  // **** Status ****

  if SameText(dmMain.qryGetCimDetailInactif.AsString, 'Y') or SameText(dmMain.qryGetCimDetailInactif.AsString, 'N') then
  begin
    strTemp := '';
    if SameText(dmMain.qryGetCimDetailInactif.AsString, 'Y') then
    begin
      strTemp := 'Actif';
    end;
    if SameText(dmMain.qryGetCimDetailInactif.AsString, 'N') then
    begin
      strTemp := 'Inactif';
    end;

    AddItem(vsbCimDetails, 'Status', strTemp);
  end;

  // // *** Notes de recherches ***

  if (trim(dmMain.qryGetCimDetailNotesRecherches.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Notes de recherches', dmMain.qryGetCimDetailNotesRecherches.AsString);
  end;

  // // *** Code Borden ***
  if (trim(dmMain.qryGetCimDetailCodeBorden.AsString) <> '') then
  begin
    AddItem(vsbCimDetails, 'Code Borden', dmMain.qryGetCimDetailCodeBorden.AsString);
  end;
  // // Confirmé

  // if (trim(dmMain.qryGetCimDetailConfirme.AsString) <> '?') then
  // begin
  // strTemp := '';
  // if SameText(trim(dmMain.qryGetCimDetailConfirme.AsString), 'Y') then
  // begin
  // strTemp := 'Oui';
  // end
  // else
  // begin
  // strTemp := 'Non';
  // end;
  // AddItem(vsbCimDetails, 'Confirmé', strTemp);
  //
  // end;



  // // Show Proprio
  // call ShowProprio(objCim.ProprioNo)
  // //
  // // Show Web links
  // call ShowWebLink
  // //
  // // Show Necrologies
  // call ShowNecros
  // //
  // // Show Sources
  // call ShowSources
  // //
  // // -----------------
  // // *****  END  *****
  // // -----------------
  //
  //
  //
  // hsbCimDetailImages.Align := TAlignLayout.alTop;
  // vsbCimDetails.AddObject(hsbCimDetailImages);

  if dmMain.GetNbImagebyCimID(cimId) > 0 then
  begin
    // hsbCimDetailImages.Visible := true;
    loadCimImages(cimId, vsbCimDetails, FCurrentCimImages, AfficheBigImage);
  end
  else
  begin
    // hsbCimDetailImages.Visible := false;
  end;

  vsbCimDetails.EndUpdate;

end;

procedure TformMain.btnCimImageNextClick(Sender: TObject);
begin
  if FcurrentImageIndex < (FCurrentCimImages.Count - 1) then
  begin

    inc(FcurrentImageIndex);
    ShowCimBigImage;
  end;

end;

procedure TformMain.btnCimImagePreviousClick(Sender: TObject);
begin
  if (FcurrentImageIndex > 0) then
  begin

    dec(FcurrentImageIndex);
    ShowCimBigImage;
  end;

end;

procedure TformMain.btnCloseCimImageClick(Sender: TObject);
begin
  TabControl1.ActiveTab := tabCimDetails;
end;

procedure TformMain.btnShowMapClick(Sender: TObject);
begin

  // Show Map using Google Maps
  // URLString := Format('https://maps.google.com/maps?q=%s,%s&output=embed', [Format('%2.6f', [NewLocation.Latitude]), Format('%2.6f', [NewLocation.Longitude])]);
  // WebBrowser1.Navigate(URLString);


  // AfficheCarteGoogle(dmMain.qryGetCimDetailLatitude.AsFloat, dmMain.qryGetCimDetailLongitude.AsFloat, dmMain.qryGetCimDetailCimCaption.AsString);

  mainformLogic.AfficheCarteDirection(dmMain.qryGetCimDetailLatitude.AsFloat, dmMain.qryGetCimDetailLongitude.AsFloat,
    dmMain.qryGetCimDetailCimCaption.AsString);

end;

procedure TformMain.actShowFilterDialogExecute(Sender: TObject);
var

  NewFilter       : string;
  NewFiltreGeneral: TFiltreGeneralActif;
  doUpdate        : Boolean;
begin

  if Assigned(FFormeFiltre) and FFormeFiltre.InitComplete then
  begin

    if Self.FiltresCimActif = [] then
    begin
      FFormeFiltre.SetAllFilterON;
    end
    else
    begin
      FFormeFiltre.FiltresCimActif := Self.FiltresCimActif;
    end;

    FFormeFiltre.FiltreGeneralActif := Self.FiltreGeneralActif;

    FFormeFiltre.ShowModal(
      procedure(ModalResult: TModalResult)
      begin
        // if ModalResult = mrOK then

        doUpdate := false;
        NewFilter := FFormeFiltre.getActiveFilterString;

        NewFiltreGeneral := FFormeFiltre.FiltreGeneralActif;

        if (not SameText(NewFiltreGeneral.caption, Self.FiltreGeneralActif.caption)) or
          (NewFiltreGeneral.ID <> Self.FiltreGeneralActif.ID) then
        begin
          doUpdate := true;
        end;

        Self.FiltreGeneralActif := FFormeFiltre.FiltreGeneralActif;

        if not SameText(dmMain.CurrentCimFilter, NewFilter) then
        begin
          Self.FiltresCimActif := FFormeFiltre.FiltresCimActif;
          dmMain.CurrentCimFilter := NewFilter;
          doUpdate := true;
        end;

        if doUpdate then
        begin
          actStartList.Execute;
        end;

      end);

  end;

end;

procedure TformMain.actShowSortDialogExecute(Sender: TObject);
var
  NewSort: TCimSortBy;
begin

  if Assigned(FFormeSort) then
  begin

    FFormeSort.IsSortDistanceVisible := (dmMain.isGPSEnabled and dmMain.isGPPLocationValid); // Self.UseDistance;

    FFormeSort.CurrentSort := Self.FSortActif;

    FFormeSort.ShowModal(
      procedure(ModalResult: TModalResult)
      begin
        // if ModalResult = mrOK then

        NewSort := FFormeSort.CurrentSort;
        if NewSort <> Self.FSortActif then
        begin
          Self.FSortActif := FFormeSort.CurrentSort;
          actStartList.Execute;
        end;

      end);

  end;

end;

procedure TformMain.actStartListExecute(Sender: TObject);
begin

  LoadCimetieres;
end;

procedure TformMain.lvCimetieresItemClick(const Sender: TObject; const AItem: TListViewItem);
var

  idx: integer;
begin
  // Item := TListBoxItem(FindItemParent(Sender as TFmxObject, TListBoxItem));

  if Assigned(AItem) then
  begin

    // ShowMessage(Item.Text);
    idx := AItem.Tag;
    AfficheDetailCim(idx);

    ChangeTabAction1.Tab := tabCimDetails;
    ChangeTabAction1.ExecuteTarget(Self);

    // InfoLabel.Text := 'Info Button click on ' + IntToStr(Item.Index) + ' listbox item';
  end;
  //
end;

procedure TformMain.lvCimetieresUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
var
  TextLabel: TListItemText;

begin

  TextLabel := AItem.Objects.FindObject(sDist) as TListItemText;
  if TextLabel = nil then
  begin

    TextLabel           := TListItemText.Create(AItem);
    TextLabel.Name      := sDist;
    TextLabel.Align     := TListItemAlign.Trailing;
    TextLabel.TextAlign := TTextAlign.Center;
    TextLabel.VertAlign := TListItemAlign.Trailing;
    // TextLabel.PlaceOffset.X := -120;
    // TextLabel.PlaceOffset.y := 0;
    TextLabel.Font.Size     := 9;
    TextLabel.Font.Style    := [];
    TextLabel.Width         := 50;
    TextLabel.Height        := 18;
    TextLabel.PlaceOffset.X := -5;

  end;

end;

procedure TformMain.mapCimMapDoubleClick(const Position: TMapCoordinate);
begin


//   FMapOriginalHeight:= 100;
//   FMapZoomed:= False;

   if   FMapZoomed then
   begin
       MapFloatAnimation.StopValue :=FMapOriginalHeight;
   end
   else
   begin
       MapFloatAnimation.StopValue := vsbCimDetails.Height +FMapOriginalHeight;
   end;

   MapFloatAnimation.Start;
   FMapZoomed:= not FMapZoomed;

end;

procedure TformMain.FormCreate(Sender: TObject);
begin

  FFormeFiltre := nil;

  FFormeSort := nil;

  cmdMapAllCims.Visible   := false;
  TabControl1.ActiveTab   := tabListCims;
  TabControl1.TabPosition := TTabPosition.None;

  FCurrentCimImages := TCimImageCollection.Create(false);

  lblSousTitleCim.Text := '';

  FSortActif := TCimSortBy.byName;

  FiltresCimActif := []; // TFiltresCimActif
  FiltreGeneralActif.Clear;

  Self.FFormeFiltre := TFormFilter.Create(Self);

  Self.FFormeSort := TFormSort.Create(Self);

  Self.FFormeLocationsMap := TShowCimLocationsForm.Create(Self);

  FMapOriginalHeight := 105;
  FMapZoomed:=False;
end;

procedure TformMain.FormDestroy(Sender: TObject);
begin
  FCurrentCimImages.Free;
  FFormeFiltre.Free;

  FFormeLocationsMap.Free;
end;

procedure TformMain.FormResize(Sender: TObject);
begin

  lvCimetieres.ItemAppearanceObjects.ItemObjects.Text.Width := Self.Width - 50;

  if (TabControl1.ActiveTab = tabCimImage) and Assigned(FCurrentImage) and (FcurrentImageIndex >= 0) then
  begin
    ShowCimBigImage;
  end;

end;

// hsbCimDetailImages             «zzaa                                    end
procedure TformMain.FormShow(Sender: TObject);
begin
  actStartList.Execute;
end;

procedure TformMain.ShowCimBigImage;
var
  rOriginal : TRectF;
  rAffichage: TRectF;
  z         : single;
  // InStream: TResourceStream;
  cimImage: TCimImage;
begin

  if Assigned(FCurrentImage) then
  begin
    FCurrentImage.Free;
  end;

  cimImage := FCurrentCimImages[FcurrentImageIndex];

  FCurrentImage := TImageViewer.Create(Self);

  FCurrentImage.Align  := TAlignLayout.Client;
  FCurrentImage.Parent := tabCimImage;

  // fCurrentImage.OnGesture :=  TabControl1Gesture;
  FCurrentImage.Touch.GestureManager := GestureManager1;

  FCurrentImage.Margins.Left   := 5;
  FCurrentImage.Margins.Right  := 5;
  FCurrentImage.Margins.Top    := 5;
  FCurrentImage.Margins.Bottom := 5;

  Application.ProcessMessages;

  rAffichage := TRectF.Empty;
  rOriginal  := TRectF.Empty;

  rAffichage := FCurrentImage.ChildrenRect;

  rOriginal.Width  := cimImage.OriWidth;  // 300;
  rOriginal.Height := cimImage.OriHeight; // 400;

  z := 1 / rOriginal.Fit(rAffichage);

  FCurrentImage.Bitmap.Assign(cimImage.image.Bitmap);
  FCurrentImage.BitmapScale := z;

  Application.ProcessMessages;

  FCurrentImage.RealignContent;

  lblCimImageDetail.Text := cimImage.Detail;

  lblCimImageCaption.Text := cimImage.caption;

  btnCimImageNext.Enabled     := (FcurrentImageIndex < (FCurrentCimImages.Count - 1));
  btnCimImagePrevious.Enabled := (FcurrentImageIndex > 0);

end;

procedure TformMain.hsbCimDetailImagesClick(Sender: TObject);
begin

  FcurrentImageIndex := 0;
  Self.ShowCimBigImage;
  TabControl1.ActiveTab := tabCimImage;


  // {$IFDEF Android}
  // FcurrentImageIndex := 0;
  // Self.ShowCimBigImage;
  // TabControl1.ActiveTab := tabCimImage;
  //
  // {$ENDIF}
  // {$IFDEF Windows}
  // FcurrentImageIndex := 0;
  // Self.ShowCimBigImage;
  // TabControl1.ActiveTab := tabCimImage;
  // {$ENDIF}
  // {$IFDEF iOS}
  // ShowImage_iOS(0, FCurrentCimImages);
  // {$ENDIF}

end;

procedure TformMain.AfficheBigImage(Sender: TObject);
begin
{$IFDEF iOS}
  ShowImage_iOS(TImageControl(Sender).Tag, FCurrentCimImages);

{$ENDIF}
end;

procedure TformMain.lbiOptionRefreshClick(Sender: TObject);
begin

  lbOptions.Visible := false;
  actStartList.Execute;

end;

procedure TformMain.LoadCimetieres;
var
  ds: TDataSet;
  // itemsAdded: Integer;
  Item       : TListViewItem;
  cimId      : integer;
  sCimCaption: string;
  sVille     : string;
  sQuartier  : string;
  Dist       : single;

  TextLabel: TListItemText;
  // FWaitForm: TWaitForm;
  RecNo  : integer;
  DoLimit: Boolean;
const
  NBRECMAX: integer   = 200;
  MaxDistance: single = 20;
begin

  // FWaitForm := TWaitForm.CreateAndRun('Chargement...',
  //
  // procedure(AWaitForm: TWaitForm)
  // begin
  //

  if dmMain.isGPSEnabled and dmMain.isGPPLocationValid and (Self.FSortActif = TCimSortBy.byDist) then
  begin
    ds := dmMain.CimsResults(TCimSortBy.byDist, true, MaxDistance);
  end
  else
  begin
    case FSortActif of
      byName:
        ds := dmMain.CimsResults(TCimSortBy.byName, false, 0);
      byVille:
        ds := dmMain.CimsResults(TCimSortBy.byVille, false, 0);

    else
      begin
        raise Exception.Create('Pas supposé ');
        // ds := dmMain.CimsResults(TCimSortBy.byName, true, MaxDistance);
      end;
    end;

  end;

  // end,
  // procedure(AWaitForm: TWaitForm)
  // // Runs in main thread
  // begin
  lblSousTitleCim.Text := '';
  lvCimetieres.Items.Clear;

  lvCimetieres.BeginUpdate;
  DoLimit := false;

  if (ds.RecordCount > NBRECMAX) then
  begin

    if MessageDlg(Format('Cette requête retourne plus de %d cimetières, désirez-vous limiter ce résultat?', [NBRECMAX]),
      TMsgDlgType.mtWarning, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = IDYES then
    begin
      DoLimit := true;
    end;
  end;
  RecNo := 0;

  if ds <> nil then
  begin

{$IFDEF iOS}
    cmdMapAllCims.Visible := true;
{$ENDIF}
    // cimId := ds.RecordCount;
    ds.First;
    while not ds.Eof do
    begin
      inc(RecNo);
      cimId       := ds.FieldByName('CimNo').AsInteger;
      sCimCaption := ds.FieldByName('CimCaption').AsString;
      sVille      := ds.FieldByName('Ville').AsString;
      sQuartier   := ds.FieldByName('Quartier').AsString;
      Dist        := ds.FieldByName('dist').AsFloat;

      Item := lvCimetieres.Items.Add;

      // Item.Height := 60;
      Item.Text := sCimCaption;

      if sQuartier <> '' then
      begin
        Item.Detail := Format('%s (%s)', [sVille, sQuartier]);
      end
      else
      begin
        Item.Detail := sVille;
      end;

      TextLabel := Item.Objects.FindObject(sDist) as TListItemText;

      if (dmMain.isGPSEnabled and dmMain.isGPPLocationValid) then
      begin

        if (Dist > 100) then
        begin
          TextLabel.Text := FormatFloat('0', Dist) + ' Km';
        end
        else
        begin
          TextLabel.Text := FormatFloat('0.0', Dist) + ' Km';
        end;
      end
      else
      begin
        TextLabel.Text := '';
      end;

      Item.Tag := cimId;

      ds.Next;

      if DoLimit and (RecNo >= NBRECMAX) then
      begin
        break;
      end;

    end
  end
  else
  begin
    ShowMessage('ds est nil!');
  end;

  lvCimetieres.EndUpdate;

  lblSousTitleCim.Text := Format('%s - %s ', [TFormFilter.GetFilterCaption(FiltreGeneralActif),
    TFormSort.GetSortCaption(FSortActif)]);


  // end ,
  //
  // procedure(AWaitForm: TWaitForm; e:Exception)
  // begin
  // ShowMessage('erreur ' + e.Message);
  // end
  //
  //
  // );

end;

procedure TformMain.cmdMapAllCimsClick(Sender: TObject);
{$IFDEF iOS}
// var
// qq: TFormShowLocationsMap;

{$ENDIF}
var
  nb        : integer;
  markercoll: TMarkerCollection;
  I         : integer;
begin

  nb := min(100, lvCimetieres.ItemCount);

  markercoll := TMarkerCollection.Create;

  for I := 0 to nb - 1 do
  begin
    dmMain.qryGetCimDetail.Active := false;

    dmMain.qryGetCimDetail.ParamByName('CIMID').AsInteger := lvCimetieres.Items[I].Tag;
    dmMain.qryGetCimDetail.Active                         := true;
    markercoll.Add(TMarkerItem.Create(dmMain.qryGetCimDetailCimCaption.AsString,
      dmMain.qryGetCimDetailLongitude.AsFloat, dmMain.qryGetCimDetailLatitude.AsFloat));
    // locmap.AddMarker(dmMain.qryGetCimDetailCimCaption.AsString, dmMain.qryGetCimDetailLatitude.AsFloat, dmMain.qryGetCimDetailLongitude.AsFloat);

  end;

  FFormeLocationsMap.ShowMap(markercoll, dmMain.CurrentLocaton.Longitude, dmMain.CurrentLocaton.Latitude);

  FFormeLocationsMap.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      // if ModalResult = mrOK then
      // if OK was pressed and an item is selected, pick it
      // if dlg.ListBox1.ItemIndex >= 0 then      edit1.Text := dlg.ListBox1.Items [dlg.ListBox1.ItemIndex];
      // locmap.DisposeOf;
    end);

  markercoll.Free;
  exit;

{$IFDEF iOS}
  // Application.ProcessMessages;
  //
  // qq := TFormShowLocationsMap.Create(nil);
  //
  // for I := 0 to lvCimetieres.ItemCount - 1 do
  // begin
  // dmMain.qryGetCimDetail.Active := false;
  //
  // dmMain.qryGetCimDetail.ParamByName('CIMID').AsInteger := lvCimetieres.Items[I].Tag;
  // dmMain.qryGetCimDetail.Active := true;
  //
  // qq.AddMarker(dmMain.qryGetCimDetailCimCaption.AsString, '', dmMain.qryGetCimDetailLatitude.AsFloat, dmMain.qryGetCimDetailLongitude.AsFloat);
  //
  // end;
  //
  // qq.ShowModal(
  // procedure(ModalResult: TModalResult)
  // begin
  // // if ModalResult = mrOK then
  // // if OK was pressed and an item is selected, pick it
  // // if dlg.ListBox1.ItemIndex >= 0 then      edit1.Text := dlg.ListBox1.Items [dlg.ListBox1.ItemIndex];
  // qq.DisposeOf;
  // end);
{$ENDIF}
end;

procedure TformMain.SpeedButton3Click(Sender: TObject);
begin
  TabControl1.ActiveTab := tabListCims;
end;

procedure TformMain.tabCimImageGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  case EventInfo.GestureID of

    sgiLeft:
      begin
        if FcurrentImageIndex < (FCurrentCimImages.Count - 1) then
        begin
          FcurrentImageIndex := FcurrentImageIndex + 1;
          Handled            := true;
          ShowCimBigImage;
        end;
      end;

    sgiRight:
      begin
        if FcurrentImageIndex > 0 then
        begin

          FcurrentImageIndex := FcurrentImageIndex - 1;
          Handled            := true;

          ShowCimBigImage;
        end;
      end;

  end;

end;

procedure TformMain.cmdShowDirectionClick(Sender: TObject);
begin
  AfficheCarteDirection(dmMain.qryGetCimDetailLatitude.AsFloat, dmMain.qryGetCimDetailLongitude.AsFloat,
    dmMain.qryGetCimDetailCimCaption.AsString);

end;

procedure TformMain.tabListCimsClick(Sender: TObject);
begin
  dmMain.deactivateAllList;

end;

procedure TformMain.actOpenDrawerExecute(Sender: TObject);
begin
  lbOptions.Visible := not lbOptions.Visible;
  Application.ProcessMessages;
  if lbOptions.Visible then
  begin
    lbOptions.ApplyStyleLookup;
    lbOptions.RealignContent;
  end;

end;

procedure TformMain.actOpenDrawerUpdate(Sender: TObject);
begin
  // actOpenDrawer.Visible := not(IsPad and IsLandscape);
  actOpenDrawer.Visible := true; // := not(IsPad and IsLandscape);
end;

// function TformMain.IsLandscape: Boolean;
// begin
// Result := Self.Width > Self.Height;
// end;

// function TformMain.IsPad: Boolean;
// begin
// {$IFDEF IOS}
// Result := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice).userInterfaceIdiom = UIUserInterfaceIdiomPad;
// {$ENDIF}
// {$IFDEF ANDROID}
// Result := (MainActivity.getResources.getConfiguration.screenLayout and TJConfiguration.JavaClass.SCREENLAYOUT_SIZE_MASK) >=
// TJConfiguration.JavaClass.SCREENLAYOUT_SIZE_LARGE;
// {$ENDIF}
// end;

procedure TformMain.lbiOptionFiltreClick(Sender: TObject);
begin

  lbOptions.Visible := false;

  actShowFilterDialog.Execute;

end;

procedure TformMain.lbiOptionSortClick(Sender: TObject);
begin

  lbOptions.Visible := false;

  actShowSortDialog.Execute;

end;

procedure TformMain.SetUseDistance(const Value: Boolean);
begin
  FUseDistance := Value;
  if Value then
  begin

    FSortActif := TCimSortBy.byDist;
  end;
end;

procedure TformMain.ShowBigCimCarte(const Position: TMapCoordinate);
begin
  mainformLogic.AfficheCarteDirection(dmMain.qryGetCimDetailLatitude.AsFloat, dmMain.qryGetCimDetailLongitude.AsFloat,
    dmMain.qryGetCimDetailCimCaption.AsString);
end;

end.
