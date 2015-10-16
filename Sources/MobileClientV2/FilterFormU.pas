unit FilterFormU;
// _______________________________________________________________ ZYMA __
// $HeadURL: svn://bitnami-redmine/_GL/trunk/Cimeti%C3%A8res/Sources/MobileClient/uFilter.pas $
// .......................................................................
// Last committed    : $Revision:: 62               $
// Last changed by   : $Author:: labelleg           $
// Last changed date : $Date:: 2015-06-15 12:53:26 #$
// .......................................................................
// Copyright (c) ZYMA 2014
// _______________________________________________________________________

interface

uses
  FMX.Forms, FMX.ListView.Types, Data.Bind.EngExt, FMX.Bind.DBEngExt, DataModuleU,
  System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope, FMX.ActnList, System.Classes, System.Actions,
  FMX.TabControl, FMX.ListView, FMX.StdCtrls, FMX.ListBox, FMX.Layouts,
  FMX.Controls, FMX.Types, FMX.Controls.Presentation, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Cim.Types;//, codeSiteLogging;

type

  TFiltreGeneralActif = record
    Types: TFiltreGeneralActifTypes;
    ID: integer;
    Caption: string;

    procedure Clear;
    // procedure SetType(Types: TFiltreGeneralActifTypes);
    // procedure SetId(id : integer);
    // procedure SetCaption(caption : string);
  end;

  TFormFilter = class(TForm)
    lbFiltres: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    lbiFiltreTypeCimArcheoHistoire: TListBoxItem;
    lbiFiltreTypeCimCimetieres: TListBoxItem;
    lbiFiltreTypeCimColumbariums: TListBoxItem;
    lbiFiltreTypeCimCryptes: TListBoxItem;
    lbiFiltreTypeCimDivers: TListBoxItem;
    tbFiltres: TToolBar;
    Label7: TLabel;
    btnShowMap: TButton;
    lbiFiltreRegions: TListBoxItem;
    lbiFiltreMRCs: TListBoxItem;
    lbiFiltreVilles: TListBoxItem;
    lbiFiltreAucun: TListBoxItem;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    SwitchFiltreTypeCimArcheoHistoire: TSwitch;
    SwitchFiltreTypeCimCimetieres: TSwitch;
    SwitchFiltreTypeCimColumbariums: TSwitch;
    SwitchFiltreTypeCimCryptes: TSwitch;
    SwitchFiltreTypeCimDivers: TSwitch;
    TabControl1: TTabControl;
    tabFilter: TTabItem;
    tabVilles: TTabItem;
    tabRegions: TTabItem;
    tabMrcs: TTabItem;
    ActionList1: TActionList;
    ToolBar1: TToolBar;
    Label1: TLabel;
    btnVillesBack: TButton;
    ToolBar2: TToolBar;
    Label2: TLabel;
    btnRegionsBack: TButton;
    ToolBar3: TToolBar;
    Label3: TLabel;
    btnMRCsBack: TButton;
    lvVilles: TListView;
    BindingsList1: TBindingsList;
    lvRegions: TListView;
    lvMRCs: TListView;
    BindSourceListRegions: TBindSourceDB;
    BindSourceQryListMRC: TBindSourceDB;
    actGotoTabVilles: TChangeTabAction;
    actGotoTabRegions: TChangeTabAction;
    actGotoTabMRCs: TChangeTabAction;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB1: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    SpeedButton1: TSpeedButton;
    actCloseForm: TAction;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    BindSourceDB3: TBindSourceDB;
    LinkListControlToField3: TLinkListControlToField;
    procedure FormCreate(Sender: TObject);
    procedure SwitchFiltreTypeCimArcheoHistoireSwitch(Sender: TObject);
    procedure btnShowMapClick(Sender: TObject);
    procedure lbiFiltreVillesClick(Sender: TObject);
    procedure lbiFiltreRegionsClick(Sender: TObject);
    procedure lbiFiltreMRCsClick(Sender: TObject);
    procedure btnVillesBackClick(Sender: TObject);
    procedure btnRegionsBackClick(Sender: TObject);
    procedure btnMRCsBackClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure lbiFiltreAucunClick(Sender: TObject);
    procedure lvVillesItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure actCloseFormExecute(Sender: TObject);
    procedure lvRegionsItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure lvMRCsItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    // procedure lbiFiltreAProximiteClick(Sender: TObject);
  strict private
    FFiltresCimTypeActif:    TFiltresCimTypeActif;
    FFiltreGeneralActif: TFiltreGeneralActif;

  private
    FInitComplete: Boolean;

    procedure SetFiltresCimActif(const Value: TFiltresCimTypeActif);
    procedure SetItemDataFiltreCim(switch: TSwitch; flt: TFiltreCimTypeActif);
    procedure ClearAllFilterDetails;
    procedure SetFiltreGeneralActif(const Value: TFiltreGeneralActif);
    procedure ShowListViewSearchOption(lv: TListView);
    { Private declarations }

  public

    procedure SetAllFilterON;
//    function getActiveCimTypeFilterString: string;

    class function GetFilterCaption(Filtre: TFiltreGeneralActif): string;

    property FiltresCimTypeActif: TFiltresCimTypeActif read FFiltresCimTypeActif write SetFiltresCimActif;
    property FiltreGeneralActif: TFiltreGeneralActif read FFiltreGeneralActif write SetFiltreGeneralActif;

    property InitComplete: Boolean read FInitComplete;
  end;

var
  FormFilter: TFormFilter;

implementation

uses System.UITypes, // AnonThread,
  System.SysUtils, FireDAC.Stan.Param;

{$R *.fmx}
{$R *.iPad.fmx IOS}

{ TFormFilter }

procedure TFormFilter.actCloseFormExecute(Sender: TObject);
begin
  Self.ModalResult := mrOk;
  Self.Close;
end;

procedure TFormFilter.btnMRCsBackClick(Sender: TObject);
var
  flt: TFiltreGeneralActif;
begin
  ClearAllFilterDetails;

//  dataModule1.cmdCimClearAllVisible.Execute;
//  dataModule1.cmdCimSetVisibleByMRC.Params[0].Value := dataModule1.qryListMRCMRC_No.AsInteger;
//  dataModule1.cmdCimSetVisibleByMRC.Execute;

  flt := FiltreGeneralActif;

  flt.Types   := TFiltreGeneralActifTypes.MRC;
  flt.ID      := -1;
  flt.Caption := dataModule1.qryListMRCMRC_Nom.AsString;

  FiltreGeneralActif := flt;

  TabControl1.ActiveTab := tabFilter;

  actCloseForm.Execute;
end;

procedure TFormFilter.btnRegionsBackClick(Sender: TObject);
var
  flt: TFiltreGeneralActif;
begin

  ClearAllFilterDetails;

//  dataModule1.cmdCimClearAllVisible.Execute;
//  dataModule1.cmdCimSetVisibleByRegion.Params[0].Value := dataModule1.qryListRegionsRegionNo.AsInteger;
//  dataModule1.cmdCimSetVisibleByRegion.Execute;

  flt := FiltreGeneralActif;

  flt.Types   := TFiltreGeneralActifTypes.Region;
  flt.ID      := -1;
  flt.Caption := dataModule1.qryListRegionsRegionNom.AsString;

  FiltreGeneralActif := flt;

  TabControl1.ActiveTab := tabFilter;

  actCloseForm.Execute;

end;

procedure TFormFilter.btnShowMapClick(Sender: TObject);
begin
  actCloseForm.Execute;
end;

procedure TFormFilter.btnVillesBackClick(Sender: TObject);
var
  flt: TFiltreGeneralActif;

begin

  ClearAllFilterDetails;

//  dataModule1.cmdCimClearAllVisible.Execute;
//  dataModule1.cmdCimSetVisibleByVille.Params[0].Value := dataModule1.qryListVillesVille.AsString;
//  dataModule1.cmdCimSetVisibleByVille.Execute;

  flt := FiltreGeneralActif;

  flt.Types   := TFiltreGeneralActifTypes.Ville;
  flt.ID      := -1;
  flt.Caption := dataModule1.qryListVillesVille.AsString;

  FiltreGeneralActif := flt;

  TabControl1.ActiveTab := tabFilter;

  actCloseForm.Execute;
end;

procedure TFormFilter.FormCreate(Sender: TObject);
begin

  FInitComplete := false;

  TabControl1.ActiveTab   := tabFilter;
  TabControl1.TabPosition := TTabPosition.None;

   FiltreGeneralActif.Clear;
   SwitchFiltreTypeCimArcheoHistoire.Tag := ord(TFiltreCimTypeActif.Archeo);
   SwitchFiltreTypeCimCimetieres.Tag := ord(TFiltreCimTypeActif.Cimetieres);
   SwitchFiltreTypeCimColumbariums.Tag := ord(TFiltreCimTypeActif.Columbarium);
   SwitchFiltreTypeCimCryptes.Tag := ord(TFiltreCimTypeActif.Crypte);
   SwitchFiltreTypeCimDivers.Tag := ord(TFiltreCimTypeActif.Autre);
  //
   SetAllFilterON;
 FInitComplete := true;

end;

//function TFormFilter.getActiveCimTypeFilterString: string;
//
//var
//  flt:   string;
//  AllON: Boolean;
//begin
//
//  flt   := '';
//  AllON := true;
//
//  if TFiltreCimTypeActif.Archeo in FFiltresCimTypeActif then
//  // swFlArcheo.IsChecked then
//  begin
//    flt := ' (EntryType=2) ';
//
//  end
//  else
//  begin
//    AllON := false;
//  end;
//
//  if TFiltreCimTypeActif.Crypte in FFiltresCimTypeActif then
//  // swFltCryptes.IsChecked then
//  begin
//    if flt <> '' then
//      flt := flt + ' OR ';
//    flt   := flt + ' (EntryType=3) ';
//  end
//  else
//  begin
//    AllON := false;
//  end;
//
//  if TFiltreCimTypeActif.Cimetieres in FFiltresCimTypeActif then
//  // swFltCimetiere.IsChecked then
//  begin
//    if flt <> '' then
//      flt := flt + ' OR ';
//    flt   := flt + ' (EntryType=1) ';
//  end
//  else
//  begin
//    AllON := false;
//  end;
//
//  if TFiltreCimTypeActif.Autre in FFiltresCimTypeActif then
//  // swFltCimetiereAutre.IsChecked then
//  begin
//    if flt <> '' then
//      flt := flt + ' OR ';
//    flt   := flt + ' (EntryType=5) ';
//  end
//  else
//  begin
//    AllON := false;
//  end;
//
//  if TFiltreCimTypeActif.Columbarium in FFiltresCimTypeActif then
//  // swFltColumbarium.IsChecked then
//  begin
//    if flt <> '' then
//      flt := flt + ' OR ';
//    flt   := flt + ' (EntryType=4) ';
//  end
//  else
//  begin
//    AllON := false;
//  end;
//
//  if AllON then
//  begin
//    flt := '';
//
//  end;
//  Result := flt;
//  // end;
//
//end;

class function TFormFilter.GetFilterCaption(Filtre: TFiltreGeneralActif): string;
begin
  case Filtre.Types of
    Aucun:
      Result := 'Tous';
    Ville:
      Result := Format('Ville : %s', [Filtre.Caption]);
    MRC:
      Result := Format('MRC : %s', [Filtre.Caption]);
    Region:
      Result := Format('Région : %s', [Filtre.Caption]);
    // Proximite : Result :=    'A proximité';
  else
    begin
      raise Exception.Create('Type de filtre non supporté');
    end;
  end;
end;

procedure TFormFilter.ShowListViewSearchOption(lv: TListView);
begin
  lv.SearchVisible := not lv.SearchVisible;
  if lv.SearchVisible then
  begin
    lv.SetFocus;
  end;
end;

procedure TFormFilter.ClearAllFilterDetails;
begin
  lbiFiltreAucun.ItemData.Detail   := '';
  lbiFiltreMRCs.ItemData.Detail    := '';
  lbiFiltreVilles.ItemData.Detail  := '';
  lbiFiltreRegions.ItemData.Detail := '';

  lbiFiltreAucun.ItemData.Accessory   := TListBoxItemData.TAccessory.aNone;
  lbiFiltreMRCs.ItemData.Accessory    := TListBoxItemData.TAccessory.aNone;
  lbiFiltreVilles.ItemData.Accessory  := TListBoxItemData.TAccessory.aNone;
  lbiFiltreRegions.ItemData.Accessory := TListBoxItemData.TAccessory.aNone;

end;

// procedure TFormFilter.lbiFiltreAProximiteClick(Sender: TObject);
// var
// flt: TFiltreGeneralActif;
// begin
// ClearAllFilterDetails;
//
// dmmain.cmdCimSetAllVisible.Execute;
//
// FiltreGeneralActif.Clear;
//
// flt := FiltreGeneralActif;
//
// flt.Types := TFiltreGeneralActifTypes.Proximite;
//
// FiltreGeneralActif := flt;
//
// actCloseForm.Execute;
// end;

procedure TFormFilter.lbiFiltreAucunClick(Sender: TObject);
var
  flt: TFiltreGeneralActif;
begin
  ClearAllFilterDetails;

//  dataModule1.cmdCimSetAllVisible.Execute;

  FiltreGeneralActif.Clear;

  flt := FiltreGeneralActif;

  flt.Types := TFiltreGeneralActifTypes.Aucun;

  FiltreGeneralActif := flt;

  actCloseForm.Execute;

end;

procedure TFormFilter.lbiFiltreMRCsClick(Sender: TObject);
begin
  dataModule1.qryListMRC.Active := true;

  actGotoTabMRCs.ExecuteTarget(Self);

end;

procedure TFormFilter.lbiFiltreRegionsClick(Sender: TObject);
begin
  dataModule1.qryListRegions.Active := true;

  actGotoTabRegions.ExecuteTarget(Self);
end;

procedure TFormFilter.lbiFiltreVillesClick(Sender: TObject);
begin

  dataModule1.qryListVilles.Active := true;

  actGotoTabVilles.ExecuteTarget(Self);

end;

procedure TFormFilter.lvMRCsItemClick(const Sender: TObject; const AItem: TListViewItem);
begin


  if AItem <> nil then
  begin
    btnMRCsBackClick(nil);
  end;

end;

procedure TFormFilter.lvRegionsItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  if AItem <> nil then
  begin
    btnRegionsBackClick(nil);
  end;

end;

procedure TFormFilter.lvVillesItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  if AItem <> nil then
  begin
    btnVillesBackClick(nil);
  end;

end;

procedure TFormFilter.SetItemDataFiltreCim(switch: TSwitch; flt: TFiltreCimTypeActif);
begin

  if switch.IsChecked then
  begin

    FFiltresCimTypeActif := FFiltresCimTypeActif + [flt];

  end
  else
  begin
    FFiltresCimTypeActif := FFiltresCimTypeActif - [flt];
  end;

end;

procedure TFormFilter.SpeedButton1Click(Sender: TObject);
begin

  ShowListViewSearchOption(lvVilles);

end;

procedure TFormFilter.SpeedButton2Click(Sender: TObject);
begin
  ShowListViewSearchOption(lvRegions);
end;

procedure TFormFilter.SpeedButton3Click(Sender: TObject);
begin
  ShowListViewSearchOption(lvMRCs);
end;

procedure TFormFilter.SwitchFiltreTypeCimArcheoHistoireSwitch(Sender: TObject);
var
  sw:  TSwitch;
  flt: TFiltreCimTypeActif;
begin

  sw := (Sender as TSwitch);

  if Assigned(sw) then
  begin
    try
      flt := TFiltreCimTypeActif(sw.Tag);
      SetItemDataFiltreCim(sw, flt);

    except
      raise Exception.Create('Tag non dénini dans controle');
    end;

  end
  else
  begin
    raise Exception.Create('Controle non défini');
  end;

end;

procedure TFormFilter.SetAllFilterON;

var
  unFiltre: TFiltreCimTypeActif;
begin

  for unFiltre := low(TFiltreCimTypeActif) to high(TFiltreCimTypeActif) do
  begin
    FFiltresCimTypeActif := FFiltresCimTypeActif + [unFiltre];
  end;

  SetFiltresCimActif(FFiltresCimTypeActif);

end;

procedure TFormFilter.SetFiltreGeneralActif(const Value: TFiltreGeneralActif);
begin
  FFiltreGeneralActif := Value;

  ClearAllFilterDetails;

  case FFiltreGeneralActif.Types of
    Aucun:
      lbiFiltreAucun.ItemData.Accessory := TListBoxItemData.TAccessory.aCheckmark;

    Ville:
      begin
        lbiFiltreVilles.ItemData.Detail    := FFiltreGeneralActif.Caption;
        lbiFiltreVilles.ItemData.Accessory := TListBoxItemData.TAccessory.aCheckmark;
      end;
    MRC:
      begin
        lbiFiltreMRCs.ItemData.Detail    := FFiltreGeneralActif.Caption;
        lbiFiltreMRCs.ItemData.Accessory := TListBoxItemData.TAccessory.aCheckmark;
      end;

    Region:
      begin
        lbiFiltreRegions.ItemData.Detail    := FFiltreGeneralActif.Caption;
        lbiFiltreRegions.ItemData.Accessory := TListBoxItemData.TAccessory.aCheckmark;
      end;

  end;

end;

procedure TFormFilter.SetFiltresCimActif(const Value: TFiltresCimTypeActif);

var

  // TFiltreCimActif = (Archeo, Crypte, Cimetieres,Autre, Columbarium);
  unFiltre: TFiltreCimTypeActif;

begin

  FFiltresCimTypeActif := Value;

  SwitchFiltreTypeCimArcheoHistoire.IsChecked := false;
  SwitchFiltreTypeCimCryptes.IsChecked        := false;
  SwitchFiltreTypeCimCimetieres.IsChecked     := false;
  SwitchFiltreTypeCimDivers.IsChecked         := false;
  SwitchFiltreTypeCimColumbariums.IsChecked   := false;

  for unFiltre in Value do
  begin
    case unFiltre of
      Archeo:
        begin
          SwitchFiltreTypeCimArcheoHistoire.IsChecked := true;

        end;
      Crypte:
        begin
          SwitchFiltreTypeCimCryptes.IsChecked := true;
        end;
      Cimetieres:
        begin
          SwitchFiltreTypeCimCimetieres.IsChecked := true;
        end;
      Autre:
        begin
          SwitchFiltreTypeCimDivers.IsChecked := true;
        end;
      Columbarium:
        begin
          SwitchFiltreTypeCimColumbariums.IsChecked := true;
        end;
    end;
  end;

end;

{ TFiltreGeneralActif }

procedure TFiltreGeneralActif.Clear;
begin
  Types   := TFiltreGeneralActifTypes.Aucun;
  ID      := -1;
  Caption := '';
end;





end.
