unit uFilter;
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
  FMX.Forms, FMX.ListView.Types, Data.Bind.EngExt, FMX.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope, FMX.ActnList, System.Classes, System.Actions,
  FMX.TabControl, FMX.ListView, FMX.StdCtrls, FMX.ListBox, FMX.Layouts,
  FMX.Controls, FMX.Types, FMX.Controls.Presentation, FMX.ListView.Appearances, FMX.ListView.Adapters.Base;

// uses
// System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
// FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
// FMX.ListBox, FMX.Layouts, FMX.Ani, FMX.TabControl, System.Actions,
// FMX.ActnList, mMain, FMX.ListView.Types, FMX.ListView, Data.Bind.EngExt,
// FMX.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors,
// Data.Bind.Components, Data.Bind.DBScope;

type

  TFiltreGeneralActifTypes = (Aucun, Ville, MRC, Region);
  TFiltreCimActif = (Archeo, Crypte, Cimetieres, Autre, Columbarium);
  TFiltresCimActif = set of TFiltreCimActif;

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
    procedure lvVillesItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure actCloseFormExecute(Sender: TObject);
    procedure lvRegionsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvMRCsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    // procedure lbiFiltreAProximiteClick(Sender: TObject);
  strict private
    FFiltresCimActif: TFiltresCimActif;
    FFiltreGeneralActif: TFiltreGeneralActif;

  private
    FInitComplete: Boolean;

    procedure SetFiltresCimActif(const Value: TFiltresCimActif);
    procedure SetItemDataFiltreCim(switch: TSwitch; flt: TFiltreCimActif);
    procedure ClearAllFilterDetails;
    procedure SetFiltreGeneralActif(const Value: TFiltreGeneralActif);
    procedure ShowListViewSearchOption(lv: TListView);
    { Private declarations }

  public

    procedure SetAllFilterON;
    function getActiveFilterString: string;

    class function GetFilterCaption(Filtre: TFiltreGeneralActif): string;

    property FiltresCimActif: TFiltresCimActif read FFiltresCimActif
      write SetFiltresCimActif;
    property FiltreGeneralActif: TFiltreGeneralActif read FFiltreGeneralActif
      write SetFiltreGeneralActif;

    property InitComplete: Boolean read FInitComplete;
  end;

var
  FormFilter: TFormFilter;

implementation

uses System.UITypes, mMain,// AnonThread,
System.SysUtils, FireDAC.Stan.Param;

{$R *.fmx}
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

  dmmain.cmdCimClearAllVisible.Execute;
  dmmain.cmdCimSetVisibleByMRC.Params[0].Value :=     dmmain.qryListMRCMRC_No.AsInteger;
  dmmain.cmdCimSetVisibleByMRC.Execute;

  flt := FiltreGeneralActif;

  flt.Types := TFiltreGeneralActifTypes.MRC;
  flt.ID := -1;
  flt.Caption := dmmain.qryListMRCMRC_Nom.AsString;

  FiltreGeneralActif := flt;

  TabControl1.ActiveTab := tabFilter;

  actCloseForm.Execute;
end;

procedure TFormFilter.btnRegionsBackClick(Sender: TObject);
var
  flt: TFiltreGeneralActif;
begin

  ClearAllFilterDetails;

  dmmain.cmdCimClearAllVisible.Execute;
  dmmain.cmdCimSetVisibleByRegion.Params[0].Value :=
    dmmain.qryListRegionsRegionNo.AsInteger;
  dmmain.cmdCimSetVisibleByRegion.Execute;

  flt := FiltreGeneralActif;

  flt.Types := TFiltreGeneralActifTypes.Region;
  flt.ID := -1;
  flt.Caption := dmmain.qryListRegionsRegionNom.AsString;

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

  dmmain.cmdCimClearAllVisible.Execute;
  dmmain.cmdCimSetVisibleByVille.Params[0].Value :=
    dmmain.qryListVillesVille.AsString;
  dmmain.cmdCimSetVisibleByVille.Execute;

  flt := FiltreGeneralActif;

  flt.Types := TFiltreGeneralActifTypes.Ville;
  flt.ID := -1;
  flt.Caption := dmmain.qryListVillesVille.AsString;

  FiltreGeneralActif := flt;

  TabControl1.ActiveTab := tabFilter;

  actCloseForm.Execute;
end;

procedure TFormFilter.FormCreate(Sender: TObject);
begin

  FInitComplete := false;

  TabControl1.ActiveTab := tabFilter;
  TabControl1.TabPosition := TTabPosition.None;

//  TAnonymousThread<Boolean>.Create(
//    function: Boolean
//    begin
//      try
//
//        FiltreGeneralActif.Clear;
//
//        SwitchFiltreTypeCimArcheoHistoire.Tag := ord(TFiltreCimActif.Archeo);
//        SwitchFiltreTypeCimCimetieres.Tag := ord(TFiltreCimActif.Cimetieres);
//        SwitchFiltreTypeCimColumbariums.Tag := ord(TFiltreCimActif.Columbarium);
//        SwitchFiltreTypeCimCryptes.Tag := ord(TFiltreCimActif.Crypte);
//        SwitchFiltreTypeCimDivers.Tag := ord(TFiltreCimActif.Autre);
//
//        SetAllFilterON;
//
//      except
//        raise Exception.Create('Erreur setting components');
//      end;
//
//
//      // Result := dmMain.LoadAllListes;;
//
//    end,
//    procedure(AResult: Boolean)
//    begin
//      FInitComplete := true;
//
//    end,
//
//    procedure(AException: Exception)
//    begin
//      raise Exception.Create('Error Create Filter dialog : ' +
//        AException.Message);
//    end);

end;

function TFormFilter.getActiveFilterString: string;

var
  flt: string;
  AllON: Boolean;
begin


  flt := '';
  AllON := true;

  if TFiltreCimActif.Archeo in FFiltresCimActif then
  // swFlArcheo.IsChecked then
  begin
    flt := ' (EntryType=2) ';

  end
  else
  begin
    AllON := false;
  end;

  if TFiltreCimActif.Crypte in FFiltresCimActif then
  // swFltCryptes.IsChecked then
  begin
    if flt <> '' then
      flt := flt + ' OR ';
    flt := flt + ' (EntryType=3) ';
  end
  else
  begin
    AllON := false;
  end;

  if TFiltreCimActif.Cimetieres in FFiltresCimActif then
  // swFltCimetiere.IsChecked then
  begin
    if flt <> '' then
      flt := flt + ' OR ';
    flt := flt + ' (EntryType=1) ';
  end
  else
  begin
    AllON := false;
  end;

  if TFiltreCimActif.Autre in FFiltresCimActif then
  // swFltCimetiereAutre.IsChecked then
  begin
    if flt <> '' then
      flt := flt + ' OR ';
    flt := flt + ' (EntryType=5) ';
  end
  else
  begin
    AllON := false;
  end;

  if TFiltreCimActif.Columbarium in FFiltresCimActif then
  // swFltColumbarium.IsChecked then
  begin
    if flt <> '' then
      flt := flt + ' OR ';
    flt := flt + ' (EntryType=4) ';
  end
  else
  begin
    AllON := false;
  end;

  if AllON then
  begin
    flt := '';

  end;
  Result := flt;
  // end;

end;

class function TFormFilter.GetFilterCaption
  (Filtre: TFiltreGeneralActif): string;
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
  lbiFiltreAucun.ItemData.Detail := '';
  lbiFiltreMRCs.ItemData.Detail := '';
  lbiFiltreVilles.ItemData.Detail := '';
  lbiFiltreRegions.ItemData.Detail := '';

  lbiFiltreAucun.ItemData.Accessory := TListBoxItemData.TAccessory.aNone;
  lbiFiltreMRCs.ItemData.Accessory := TListBoxItemData.TAccessory.aNone;
  lbiFiltreVilles.ItemData.Accessory := TListBoxItemData.TAccessory.aNone;
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

  dmmain.cmdCimSetAllVisible.Execute;

  FiltreGeneralActif.Clear;

  flt := FiltreGeneralActif;

  flt.Types := TFiltreGeneralActifTypes.Aucun;

  FiltreGeneralActif := flt;

  actCloseForm.Execute;

end;

procedure TFormFilter.lbiFiltreMRCsClick(Sender: TObject);
begin
  dmmain.qryListMRC.Active := true;

  actGotoTabMRCs.ExecuteTarget(Self);

end;

procedure TFormFilter.lbiFiltreRegionsClick(Sender: TObject);
begin
  dmmain.qryListRegions.Active := true;

  actGotoTabRegions.ExecuteTarget(Self);
end;

procedure TFormFilter.lbiFiltreVillesClick(Sender: TObject);
begin

  dmmain.qryListVilles.Active := true;

  actGotoTabVilles.ExecuteTarget(Self);

end;

procedure TFormFilter.lvMRCsItemClick(const Sender: TObject;
const AItem: TListViewItem);
begin
  if AItem <> nil then
  begin

    btnMRCsBackClick(nil);
  end;

end;

procedure TFormFilter.lvRegionsItemClick(const Sender: TObject;
const AItem: TListViewItem);
begin
  if AItem <> nil then
  begin

    btnRegionsBackClick(nil);
  end;

end;

procedure TFormFilter.lvVillesItemClick(const Sender: TObject;
const AItem: TListViewItem);
begin
  if AItem <> nil then
  begin

    btnVillesBackClick(nil);
  end;

end;

procedure TFormFilter.SetItemDataFiltreCim(switch: TSwitch;
flt: TFiltreCimActif);
begin

  if switch.IsChecked then
  begin

    FFiltresCimActif := FFiltresCimActif + [flt];

  end
  else
  begin
    FFiltresCimActif := FFiltresCimActif - [flt];
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
  sw: TSwitch;
  flt: TFiltreCimActif;
begin

  sw := (Sender as TSwitch);

  if Assigned(sw) then
  begin
    try
      flt := TFiltreCimActif(sw.Tag);
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
  unFiltre: TFiltreCimActif;
begin

  for unFiltre := low(TFiltreCimActif) to high(TFiltreCimActif) do
  begin
    FFiltresCimActif := FFiltresCimActif + [unFiltre];
  end;

  SetFiltresCimActif(FFiltresCimActif);

end;

procedure TFormFilter.SetFiltreGeneralActif(const Value: TFiltreGeneralActif);
begin
  FFiltreGeneralActif := Value;

  ClearAllFilterDetails;

  case FFiltreGeneralActif.Types of
    Aucun:
      lbiFiltreAucun.ItemData.Accessory :=
        TListBoxItemData.TAccessory.aCheckmark;

    Ville:
      begin
        lbiFiltreVilles.ItemData.Detail := FFiltreGeneralActif.Caption;
        lbiFiltreVilles.ItemData.Accessory :=
          TListBoxItemData.TAccessory.aCheckmark;
      end;
    MRC:
      begin
        lbiFiltreMRCs.ItemData.Detail := FFiltreGeneralActif.Caption;
        lbiFiltreMRCs.ItemData.Accessory :=
          TListBoxItemData.TAccessory.aCheckmark;
      end;

    Region:
      begin
        lbiFiltreRegions.ItemData.Detail := FFiltreGeneralActif.Caption;
        lbiFiltreRegions.ItemData.Accessory :=
          TListBoxItemData.TAccessory.aCheckmark;
      end;

  end;

end;

procedure TFormFilter.SetFiltresCimActif(const Value: TFiltresCimActif);

var

  // TFiltreCimActif = (Archeo, Crypte, Cimetieres,Autre, Columbarium);
  unFiltre: TFiltreCimActif;

begin

  FFiltresCimActif := Value;

  SwitchFiltreTypeCimArcheoHistoire.IsChecked := false;
  SwitchFiltreTypeCimCryptes.IsChecked := false;
  SwitchFiltreTypeCimCimetieres.IsChecked := false;
  SwitchFiltreTypeCimDivers.IsChecked := false;
  SwitchFiltreTypeCimColumbariums.IsChecked := false;

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
  Types := TFiltreGeneralActifTypes.Aucun;
  ID := -1;
  Caption := '';
end;

end.

