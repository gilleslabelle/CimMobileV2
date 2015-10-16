unit SortForm;
// _______________________________________________________________ ZYMA __
// $HeadURL: svn://bitnami-redmine/_GL/trunk/Cimeti%C3%A8res/Sources/MobileClient/SortForm.pas $
// .......................................................................
// Last committed    : $Revision:: 62               $
// Last changed by   : $Author:: labelleg           $
// Last changed date : $Date:: 2015-06-15 12:53:26 #$
// .......................................................................
// Copyright (c) ZYMA 2014
// _______________________________________________________________________

interface

uses
  FMX.Forms, FMX.ListBox, FMX.Layouts, FMX.StdCtrls, FMX.Controls,
  System.Classes, FMX.Types, FMX.Controls.Presentation;

//uses
//  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
//  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
//  FMX.Layouts, FMX.ListBox;

type

  TCimSortBy = (byDist, byName, byVille);



  TFormSort = class(TForm)
    tbSort: TToolBar;
    ListBox1: TListBox;
    cmdQuit: TSpeedButton;
    lblTitle: TLabel;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    lbiSortVille: TListBoxItem;
    lbiSortNom: TListBoxItem;
    lbiSortDistance: TListBoxItem;
    procedure lbiSortNomClick(Sender: TObject);
    procedure lbiSortVilleClick(Sender: TObject);
    procedure lbiSortDistanceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdQuitClick(Sender: TObject);

  private
    FCurrentSort: TCimSortBy;

    procedure SetCurrentSort(const Value: TCimSortBy);
    procedure ShowCorrectSort;
    procedure SetIsSortDistanceVisible(const Value: Boolean);
    function GetIsSortDistanceVisible: Boolean;
    { Private declarations }
  public
    { Public declarations }

    property CurrentSort : TCimSortBy read FCurrentSort write SetCurrentSort;
    property IsSortDistanceVisible : Boolean read GetIsSortDistanceVisible write SetIsSortDistanceVisible;
    class function GetSortCaption(sort :TCimSortBy ): string;
  end;

var
  FormSort: TFormSort;

implementation

uses System.UITypes ;
{$R *.fmx}

procedure TFormSort.cmdQuitClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
    Self.Close
end;

procedure TFormSort.FormCreate(Sender: TObject);
begin
      Self.IsSortDistanceVisible := true;
end;

function TFormSort.GetIsSortDistanceVisible: Boolean;
begin
   Result  :=  lbiSortDistance.Visible;
end;

class function TFormSort.GetSortCaption(sort :TCimSortBy ) : string;
begin
   case sort of
     byDist:  Result := 'Trié par distance';
     byName:  Result := 'Trié par nom de cimetière';
     byVille:  Result := 'Trié par ville';
   end;
end;

procedure TFormSort.lbiSortDistanceClick(Sender: TObject);
begin
SetCurrentSort( TCimSortBy.byDist);
  Self.cmdQuitClick(nil);
end;

procedure TFormSort.lbiSortNomClick(Sender: TObject);
begin
  SetCurrentSort( TCimSortBy.byName);

  Self.cmdQuitClick(nil);
end;

procedure TFormSort.lbiSortVilleClick(Sender: TObject);
begin
SetCurrentSort( TCimSortBy.byVille);
  Self.cmdQuitClick(nil);
end;

procedure TFormSort.SetCurrentSort(const Value: TCimSortBy);
begin
  FCurrentSort := Value;
  ShowCorrectSort;
end;




procedure TFormSort.SetIsSortDistanceVisible(const Value: Boolean);
begin

  lbiSortDistance.Visible := value;
end;

procedure TFormSort.ShowCorrectSort;
begin

   lbiSortNom.ItemData.Accessory := TListBoxItemData.TAccessory.aNone;
   lbiSortVille.ItemData.Accessory := TListBoxItemData.TAccessory.aNone;
   lbiSortDistance.ItemData.Accessory := TListBoxItemData.TAccessory.aNone;

      case FCurrentSort of
        byDist:lbiSortDistance.ItemData.Accessory := TListBoxItemData.TAccessory.aCheckmark;
        byVille: lbiSortVille.ItemData.Accessory := TListBoxItemData.TAccessory.aCheckmark;
        byName:lbiSortNom.ItemData.Accessory := TListBoxItemData.TAccessory.aCheckmark;
      end;
end;

end.

