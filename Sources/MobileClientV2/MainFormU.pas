unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
{$IFDEF Win32}
//  codesitelogging,

{$ENDIF}
{$IFDEF Win64}
//  codesitelogging,

{$ENDIF}
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.Layouts, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.MultiView, FMX.ActnList, System.Actions, System.Generics.Collections,
  // codesitelogging,
  Cim.Types, FMX.Effects, FMX.ListBox, FilterFormU, FMX.Maps, Cims.ClassesU, Data.Bind.GenData, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt,
  Data.Bind.Components, Data.Bind.ObjectScope, Data.Bind.Controls, FMX.Bind.Navigator, System.Sensors, System.Sensors.Components, System.ImageList, FMX.ImgList;

type
  TMainForm = class(TForm)
    TabControl1: TTabControl;
    tabListCims: TTabItem;
    tabCimDetails: TTabItem;
    tabCimImage: TTabItem;
    MultiView1: TMultiView;
    tbListCimHeader: TToolBar;
    lblTitleCim: TLabel;
    lblSousTitleCim: TLabel;
    cmdShowOptions: TSpeedButton;
    Layout1: TLayout;
    lvCimetieres: TListView;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabActionBackToSearch: TChangeTabAction;
    ChangeTabActionBackToCim: TChangeTabAction;
    ChangeTabActionBackToCimDetail: TChangeTabAction;
    ChangeTabActionToCimMap: TChangeTabAction;
    actShowFilterDialog: TAction;
    actOpenDrawer: TAction;
    actShowSortDialog: TAction;
    lbOptions: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    lbFilter: TListBoxItem;
    lbRefresh: TListBoxItem;
    lbiAfficheList: TListBoxItem;
    lbiAfficheCarte: TListBoxItem;
    ListBoxGroupHeader3: TListBoxGroupHeader;
    lbiSortNom: TListBoxItem;
    lbiSortVille: TListBoxItem;
    lbiSortDistance: TListBoxItem;
    TabControl2: TTabControl;
    TabCimList: TTabItem;
    tabCimMap: TTabItem;
    LocationSensor1: TLocationSensor;
    MapView1: TMapView;
    ListView1: TListView;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure lvCimetieresItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure lvCimetieresUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbiSortNomClick(Sender: TObject);
    procedure lbiSortVilleClick(Sender: TObject);
    procedure lbiSortDistanceClick(Sender: TObject);
    procedure actShowFilterDialogExecute(Sender: TObject);
    procedure lbFilterClick(Sender: TObject);
    procedure lbRefreshClick(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const [Ref] OldLocation, NewLocation: TLocationCoord2D);
    procedure lbiAfficheCarteClick(Sender: TObject);
    procedure MapView1MarkerClick(Marker: TMapMarker);
    procedure lbiAfficheListClick(Sender: TObject);
  strict private
    FCurrentSort:        TCimSortBy;
    FCurrentLocaton:     TLocationCoord2D;
    FisGPPLocationValid: Boolean;
    FLesMarker:          TList<TMapMarker>;

    // FCimColl:TCims;
  private
    FiltresCimActif:    TFiltresCimTypeActif;
    FiltreGeneralActif: TFiltreGeneralActif;
    //
    // FCurrentCimImages : TCimImageCollection;
    // FCurrentImage     : TImageViewer;
    // FcurrentImageIndex: integer;
    // FFormeFiltre: TFormFilter;
    // FFormeLocationsMap: TShowCimLocationsForm;
    //
    //
    // FUseDistance: Boolean;
    // FCurrentMapMarker: TMapMarker;
    // FMapOriginalHeight: integer;
    // FMapZoomed:         Boolean;

    // procedure AfficheDetailCim(cimId: integer);
    // procedure ShowCimBigImage;
    // procedure AfficheBigImage(Sender: TObject);

    { Private declarations }
    // function IsPad: Boolean;

    procedure ShowCorrectSort;
    procedure ShowCorrectMapList;

    procedure DisplayAllCimsOnMap;

    // procedure ShowBigCimCarte(const Position: TMapCoordinate);

  public
    { Public declarations }
    // property UseDistance: Boolean read FUseDistance write SetUseDistance;
    { Private declarations }
    procedure LoadCimetieres2;

  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}
{$R *.iPad.fmx IOS}
{$R *.Windows.fmx MSWINDOWS}
{$R *.iPhone4in.fmx IOS}
{$R *.iPhone47in.fmx IOS}
{$R *.iPhone55in.fmx IOS}
{$R *.Macintosh.fmx MACOS}

uses DataModuleU, Data.DB, System.Threading, System.SyncObjs, System.Math;

procedure TMainForm.actShowFilterDialogExecute(Sender: TObject);
var

//  NewCimTypeFilter: string;
  NewFiltreGeneral: TFiltreGeneralActif;
  doUpdate:         Boolean;
begin

  if Assigned(FormFilter) and FormFilter.InitComplete then
  begin

    if FiltresCimActif = [] then
    begin
      FormFilter.SetAllFilterON;
    end
    else
    begin
      FormFilter.FiltresCimTypeActif := Self.FiltresCimActif;
    end;

    FormFilter.FiltreGeneralActif := Self.FiltreGeneralActif;

    FormFilter.ShowModal(
      procedure(ModalResult: TModalResult)
      begin

        doUpdate := false;

//        NewCimTypeFilter := FormFilter.getActiveCimTypeFilterString;

        NewFiltreGeneral := FormFilter.FiltreGeneralActif;

        if (not SameText(NewFiltreGeneral.caption, Self.FiltreGeneralActif.caption)) or (NewFiltreGeneral.ID <> Self.FiltreGeneralActif.ID) then
        begin
          doUpdate := true;
        end;

        Self.FiltreGeneralActif := FormFilter.FiltreGeneralActif;

        if Self.FiltresCimActif<> FormFilter.FiltresCimTypeActif  then
//
//
//        if not SameText(Datamodule1.CurrentCimFilter, NewCimTypeFilter) then
        begin
          Self.FiltresCimActif := FormFilter.FiltresCimTypeActif;
//          Datamodule1.CurrentCimFilter := NewCimTypeFilter;
          doUpdate := true;
        end;

        if doUpdate then
        begin
          LoadCimetieres2;
        end;

      end);

  end;

end;

procedure TMainForm.DisplayAllCimsOnMap;
var
  nb:       Integer;
  MyMarker: TMapMarker;
  I:        Integer;
  unCim:    TCim;
begin

  for MyMarker in FLesMarker do
  begin
  end;

  FLesMarker.Clear;

  MapView1.MapType  := TMapType.Normal;
  MapView1.Location := TMapCoordinate.Create(FCurrentLocaton.Latitude, FCurrentLocaton.Longitude);

  MapView1.Bearing := 0;
  MapView1.Zoom    := 11;

  Datamodule1.CimColl.Value.SortByDistance;
  nb := min(100, lvCimetieres.ItemCount);

  for I := 1 to nb do
  begin
    unCim := Datamodule1.CimColl.Value.Coll[I];

    MyMarker := MapView1.AddMarker(TMapMarkerDescriptor.Create(TMapCoordinate.Create(unCim.Latitude, unCim.Longitude), unCim.caption));

    FLesMarker.Add(MyMarker);
  end;

end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  application.Terminate;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin


  // FFormeFiltre := nil;
  //
  // FFormeSort := nil;

  // FCimColl:=TCims.Create;

  // FCimColl.SortByName;

  TabControl1.ActiveTab   := tabListCims;
  TabControl1.TabPosition := TTabPosition.None;

  TabControl2.ActiveTab   := TabCimList;
  TabControl2.TabPosition := TTabPosition.None;

  // FCurrentCimImages := TCimImageCollection.Create(false);

  lblSousTitleCim.Text := '';

  FCurrentSort := TCimSortBy.byName;
  ShowCorrectSort;
  //
  FiltresCimActif := []; // TFiltresCimActif
  FiltreGeneralActif.Clear;
  //
  // Self.FFormeFiltre := TFormFilter.Create(Self);
  //

  FLesMarker := TList<TMapMarker>.Create;

  // if DebugHook <> 0 then
  // begin
  //
  // FCurrentLocaton.Latitude  := 45.6400; // Nan;
  // FCurrentLocaton.Longitude := -73.5046; // Nan;
  // FisGPPLocationValid       := true;
  // end
  // else
  // begin

  FCurrentLocaton.Latitude  := Nan;
  FCurrentLocaton.Longitude := Nan;

  FisGPPLocationValid := false;
  // end;

end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  // FCurrentCimImages.Free;
  // FFormeFiltre.Free;
  //
  // FFormeLocationsMap.Free;

  FLesMarker.free;

end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  // FUseDistance := true; // DataModule1.LocationSensorStatus.Value;

  lbiSortDistance.Visible := FisGPPLocationValid;
  LoadCimetieres2;
end;

procedure TMainForm.lbFilterClick(Sender: TObject);
begin
  actShowFilterDialogExecute(nil);
end;

procedure TMainForm.lbiSortDistanceClick(Sender: TObject);
begin

  FCurrentSort := TCimSortBy.byDist;
  ShowCorrectSort;
  LoadCimetieres2;
  MultiView1.HideMaster;
end;

procedure TMainForm.lbiSortNomClick(Sender: TObject);
begin

  FCurrentSort := TCimSortBy.byName;
  ShowCorrectSort;
  LoadCimetieres2;

  MultiView1.HideMaster;

end;

procedure TMainForm.lbiSortVilleClick(Sender: TObject);
begin

  FCurrentSort := TCimSortBy.byVille;
  ShowCorrectSort;
  LoadCimetieres2;
  MultiView1.HideMaster;

end;

procedure TMainForm.lbRefreshClick(Sender: TObject);
begin

  if not FisGPPLocationValid then
  begin
    ShowMessage('pas de gps !');
  end
  else
  begin

    ShowMessage(Format('Long: %g, Lat:%g', [FCurrentLocaton.Longitude, FCurrentLocaton.Latitude]));
  end;
end;

procedure TMainForm.lbiAfficheCarteClick(Sender: TObject);
begin

  DisplayAllCimsOnMap;

  TabControl2.ActiveTab := tabCimMap;

end;

procedure TMainForm.lbiAfficheListClick(Sender: TObject);
begin
  TabControl2.ActiveTab := TabCimList;

end;

procedure TMainForm.LoadCimetieres2;
var
  // ds:          TDataSet;
  // DoLimit:     Boolean;
  // RecNo:       integer;
  // cimId:       integer;
  // sCimCaption: string;
  // sVille:      string;
  // sQuartier:   string;
  // Dist:        Double;
  // Item:        TListViewItem;
  // TextLabel:   TListItemText;
  // Item: TListViewItem;
  TextLabel: TListItemText;
//  unCim:     TCim;
  // Item:      TListViewItem;
  // I:                  integer;
  // ABindSourceAdapter: TBindSourceAdapter;
  Filltask: ITask;
  NbVisible: Integer;
  I: Integer;
begin

  Datamodule1.CimColl.Value.FiltreByCimType(FiltresCimActif);

  case FCurrentSort of
    byDist:
      Datamodule1.CimColl.Value.SortByDistance;
    byName:
      Datamodule1.CimColl.Value.SortByName;
    byVille:
      Datamodule1.CimColl.Value.SortByVille;
  end;

  if FisGPPLocationValid then
  begin
    Datamodule1.CimColl.Value.UpdateDistances(FCurrentLocaton.Longitude, FCurrentLocaton.Latitude);
  end;




  // with TListBindSourceAdapter<TCim>(AdapterBindSource1.InternalAdapter) do
  // begin
  // SetList(DataModule1.CimColl.Coll,true);
  // active := true;
  // end;


  // lvCimetieres.BeginUpdate;
  NbVisible:= Datamodule1.CimColl.Value.GetNbVisibleCount;

  if (lvCimetieres.Items.Count = 0) or (lvCimetieres.Items.Count <> NbVisible) then
  begin

    lvCimetieres.Items.Clear;
    Application.ProcessMessages;

    for I := 0 to NbVisible - 1 do
    begin
      lvCimetieres.Items.Add;

    end;
  end;

  Filltask := TTask.Create(
    procedure()
    var
      I: Integer;
      Item: TListViewItem;
      unCim: TCim;
      idxItem: Integer;
    begin
      idxItem := 0;
      for I := 0 to Datamodule1.CimColl.Value.Coll.Count - 1 do
      begin

        unCim := Datamodule1.CimColl.Value.Coll[I];

        if unCim.Visible then
        begin
          Item := lvCimetieres.Items[idxItem];

          Item.Text := unCim.caption;

          if unCim.Quartier.IsEmpty then
          begin
            Item.Detail := unCim.Ville;
          end
          else
          begin
            Item.Detail := Format('%s (%s)', [unCim.Ville, unCim.Quartier]);
          end;

          TextLabel := Item.Objects.FindDrawable(sDist) as TListItemText;
          if Assigned(TextLabel) then
          begin
            // TextLabel := Item.Objects.FindObject(sDist) as TListItemText;

            if FisGPPLocationValid then
            begin
              TextLabel.Visible := true;

              if (unCim.Dist > 10) then
              begin
                TextLabel.Text := FormatFloat('0', unCim.Dist) + ' Km';
              end
              else
              begin
                TextLabel.Text := FormatFloat('0.0', unCim.Dist) + ' Km';
              end;
            end
            else
            begin
              TextLabel.Text := '';
              TextLabel.Visible := false
            end;
          end;

          Item.Tag := unCim.ID;

          inc(idxItem);
        end;
      end;

    end);

  Filltask.Start;

  // for unCim in DataModule1.CimColl.Coll do
  // begin
  //
  // Item := lvCimetieres.Items.Add;
  // Item.Text := unCim.Caption;
  //
  // if unCim.Quartier.IsEmpty  then
  // begin
  // Item.Detail := unCim.Ville;
  // end
  // else
  // begin
  // Item.Detail := Format('%s (%s)', [unCim.Ville, unCim.Quartier]);
  // end;
  //
  // TextLabel := Item.Objects.FindDrawable(sDist) as TListItemText;
  // if assigned(TextLabel) then
  // begin
  /// /      TextLabel := Item.Objects.FindObject(sDist) as TListItemText;
  //
  // if (Datamodule1.isGPSEnabled and Datamodule1.isGPPLocationValid) then
  // begin
  //
  // if (unCim.Dist > 100) then
  // begin
  // TextLabel.Text := FormatFloat('0', unCim.Dist) + ' Km';
  // end
  // else
  // begin
  // TextLabel.Text := FormatFloat('0.0', unCim.Dist) + ' Km';
  // end;
  // end
  // else
  // begin
  // TextLabel.Text := '';
  // end;
  // end;
  //
  // Item.Tag := unCim.Id;
  // end;
  //
  //
  // lvCimetieres.EndUpdate;
  //
  lblSousTitleCim.Text := Format('%s - %s ', [TFormFilter.GetFilterCaption(FiltreGeneralActif), FCurrentSort.toString]);


  // MapView1.MapType := TMapType.Normal;
  // MapView1.Location :=  TMapCoordinate.Create ( DataModule1.CurrentLocaton.Latitude,DataModule1.CurrentLocaton.Longitude) ;
  // MapView1.Bearing :=10;

end;

procedure TMainForm.LocationSensor1LocationChanged(Sender: TObject; const [Ref] OldLocation, NewLocation: TLocationCoord2D);
begin
  //

  FCurrentLocaton := NewLocation;

  FisGPPLocationValid     := true;
  lbiSortDistance.Visible := true;

end;

procedure TMainForm.lvCimetieresItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  //
end;

procedure TMainForm.lvCimetieresUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
var
  TextLabel: TListItemText;
  // idx: Integer;
begin

  TextLabel := AItem.Objects.FindDrawable(sDist) as TListItemText;
  if not Assigned(TextLabel) then // = nil then
  begin

    // idx:=  aitem.Index;
    // CodeSite.SendFmtMsg('index : %d',[aitem.Index]);
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

procedure TMainForm.MapView1MarkerClick(Marker: TMapMarker);
begin
  // Marker.Descriptor.
end;

// procedure TMainForm.SetUseDistance(const Value: Boolean);
// begin
/// /  FUseDistance            := Value;
// lbiSortDistance.Visible := Value;
// end;

procedure TMainForm.ShowCorrectMapList;
begin

  lbiAfficheList.ItemData.Accessory  := TListBoxItemData.TAccessory.aNone;
  lbiAfficheCarte.ItemData.Accessory := TListBoxItemData.TAccessory.aNone;
end;

procedure TMainForm.ShowCorrectSort;
begin

  lbiSortNom.ItemData.Accessory      := TListBoxItemData.TAccessory.aNone;
  lbiSortVille.ItemData.Accessory    := TListBoxItemData.TAccessory.aNone;
  lbiSortDistance.ItemData.Accessory := TListBoxItemData.TAccessory.aNone;

  case FCurrentSort of
    byDist:
      lbiSortDistance.ItemData.Accessory := TListBoxItemData.TAccessory.aCheckmark;
    byVille:
      lbiSortVille.ItemData.Accessory := TListBoxItemData.TAccessory.aCheckmark;
    byName:
      lbiSortNom.ItemData.Accessory := TListBoxItemData.TAccessory.aCheckmark;
  end;
end;

end.
