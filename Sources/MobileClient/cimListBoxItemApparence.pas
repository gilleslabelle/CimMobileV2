unit cimListBoxItemApparence;

interface

uses FMX.ListView, FMX.ListView.Types;

type

  TCimListBoxItemAppearanceNames = class
  public const
    ListItem = 'CimListItem';
    ListItemCheck = ListItem + 'ShowCheck';
    ListItemDelete = ListItem + 'Delete';
    Text2Name = 'Text2';  // Use with TListViewItem.Objects.FindObject
    Text3Name = 'Text3';  // Use with TListViewItem.Objects.FindObject
    Text4Name = 'Text4';  // Use with TListViewItem.Objects.FindObject
    TextDistanceName = 'Distance';  // Use with TListViewItem.Objects.FindObject
  end;



implementation

uses System.Rtti, System.Types, FMX.Types, System.SysUtils;

type

  TCimListItemAppearance = class(TPresetItemObjects)
  public const
    cDefaultHeight = 90;
  private
    FText2: TTextObjectAppearance;
    FText3: TTextObjectAppearance;
    FText4: TTextObjectAppearance;
    FTextDistance: TTextObjectAppearance;
    procedure SetText2(const Value: TTextObjectAppearance);
    procedure SetText3(const Value: TTextObjectAppearance);
    procedure SetText4(const Value: TTextObjectAppearance);
    procedure SetTextDistance(const Value: TTextObjectAppearance);

  protected
    function DefaultHeight: Integer; override;
    procedure UpdateSizes; override;
    function GetGroupClass: TPresetItemObjects.TGroupClass; override;
//    procedure SetObjectData(const AListViewItem: TListViewItem; const AIndex: string; const AValue: TValue; var AHandled: Boolean); override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property Text;
//    property Image;
    property Text2: TTextObjectAppearance read FText2 write SetText2;
    property Text3: TTextObjectAppearance read FText3 write SetText3;
    property Text4: TTextObjectAppearance read FText4 write SetText4;
    property TextDistance: TTextObjectAppearance read FTextDistance write SetTextDistance;

    property Accessory;
  end;


 TCimListItemDeleteAppearance = class(TCimListItemAppearance)
  private const
    cDefaultGlyph = TGlyphButtonType.Delete;
  public
    constructor Create; override;
  published
    property GlyphButton;
  end;

  TCimListItemShowCheckAppearance = class(TCimListItemAppearance)
  private const
    cDefaultGlyph = TGlyphButtonType.Checkbox;
  public
    constructor Create; override;
  published
    property GlyphButton;
  end;


const
  cText2MemberName = 'Text2';
  cText3MemberName = 'Text3';
  cText4MemberName = 'Text4';
  cTextDistanceMemberName = 'Distance';



procedure TCimListItemAppearance.SetText2(  const Value: TTextObjectAppearance);
begin
  FText2.Assign(Value);
end;

procedure TCimListItemAppearance.SetText3(  const Value: TTextObjectAppearance);
begin
  FText3.Assign(Value);
end;

procedure TCimListItemAppearance.SetText4(  const Value: TTextObjectAppearance);
begin
  FText4.Assign(Value);
end;

procedure TCimListItemAppearance.SetTextDistance(  const Value: TTextObjectAppearance);
begin
  FTextDistance.Assign(Value);
end;

function TCimListItemAppearance.DefaultHeight: Integer;
begin
  Result := cDefaultHeight;
end;

procedure TCimListItemAppearance.UpdateSizes;
var
  LOuterWidth: Single;
  LOuterHeight: Single;
  LTextOffset: Single;
begin
  BeginUpdate;
  try
    inherited;
    Assert(Owner <> nil);
    if Owner <> nil then
    begin
      LOuterHeight := Height - Owner.ItemSpaces.Top - Owner.ItemSpaces.Bottom;
      LOuterWidth := Owner.Width - Owner.ItemSpaces.Left - Owner.ItemSpaces.Right;
//      Image.InternalPlaceOffset.X := GlyphButton.ActualWidth;
      LTextOffset := 0; //GlyphButton.ActualWidth + Image.ActualWidth;

      Text.Font.Size := 16;
      Text.InternalPlaceOffset.X := LTextOffset;
      Text.Height :=   LOuterHeight;
      Text.Width :=   LOuterWidth-60;
      TextDistance.InternalPlaceOffset.Y := Text.Font.Size ;


//      Text.Width :=   Owner.Width-100;

      TextDistance.Font.Size := 9;

      TextDistance.Height :=   LOuterHeight;
      TextDistance.Width :=   LOuterWidth;
      TextDistance.TextVertAlign := TTextAlign.taLeading;
      TextDistance.TextAlign :=    TTextAlign.taTrailing;

      TextDistance.InternalPlaceOffset.X :=LTextOffset;
      TextDistance.InternalPlaceOffset.Y := TextDistance.Font.Size-2 ;

      Text2.Font.Size := 12;
      Text2.InternalPlaceOffset.X := LTextOffset;
      Text2.Height :=   LOuterHeight;
      Text2.Width :=   LOuterWidth;
      Text2.TextVertAlign := TTextAlign.taLeading;
      Text2.TextAlign :=    TTextAlign.taLeading;
      Text2.InternalPlaceOffset.Y := Text2.Font.Size +12 ;


      Text3.Font.Size := 12;
      Text3.InternalPlaceOffset.X := LTextOffset;
      Text3.Height :=   LOuterHeight;
      Text3.Width :=   LOuterWidth;
      Text3.TextVertAlign := TTextAlign.taLeading;
      Text3.TextAlign :=    TTextAlign.taLeading;
      Text3.InternalPlaceOffset.Y :=  Text3.Font.Size+Text2.InternalPlaceOffset.Y+5;


       Text4.Font.Size := 12;
      Text4.InternalPlaceOffset.X := LTextOffset;
      Text4.Height :=   LOuterHeight;
      Text4.Width :=   LOuterWidth;
      Text4.TextVertAlign := TTextAlign.taLeading;
      Text4.TextAlign :=    TTextAlign.taLeading;
      Text4.InternalPlaceOffset.Y := Text4.Font.Size + Text3.InternalPlaceOffset.Y+5 ;


//      Text4.Font.Size := 13;
//      Text4.InternalPlaceOffset.X := LTextOffset;
//      Text4.Height :=   LOuterHeight;
//      Text4.Width :=   LOuterWidth;
//      Text4.TextVertAlign := TTextAlign.taLeading;
//      Text4.TextAlign :=    TTextAlign.taLeading;
//      Text4.InternalPlaceOffset.Y := Text4.Font.Size +10 +Text2.Font.Size +Text3.Font.Size+10 ;


//      RatingsImage.InternalPlaceOffset.X := LTextOffset;
//      RatingsImage.InternalWidth := LOuterWidth;
    end;
  finally
    EndUpdate;
  end;

end;


function TCimListItemAppearance.GetGroupClass: TPresetItemObjects.TGroupClass;
begin
  Result := TCimListItemAppearance;
end;


//procedure TCimListItemAppearance.SetObjectData(
//  const AListViewItem: TListViewItem; const AIndex: string;
//  const AValue: TValue; var AHandled: Boolean);
//begin
////  if AIndex = TRatingsListItemAppearanceNames.RatingsImageName then
////  begin
////    AHandled := True;
////    UpdateImageSrcRect(AListViewItem);
////  end;
//end;






constructor TCimListItemAppearance.Create;
begin
  inherited;
  Accessory.DefaultValues.AccessoryType := TAccessoryType.More;
  Accessory.DefaultValues.Visible := True;
  Accessory.RestoreDefaults;

  Text.DefaultValues.Visible := True;
  Text.DefaultValues.VertAlign := TListItemAlign.Trailing;
  Text.DefaultValues.TextVertAlign := TTextAlign.taLeading;
  Text.DefaultValues.Height := 74;
  Text.RestoreDefaults;






  FText2 := TTextObjectAppearance.Create;
  FText2.Name := TCimListBoxItemAppearanceNames.Text2Name;
  FText2.DefaultValues.Assign(Text.DefaultValues);
  FText2.DefaultValues.IsDetailText := True;
  FText2.DefaultValues.Height := 56;
  FText2.RestoreDefaults;
  FText2.OnChange := Self.ItemPropertyChange;
  FText2.Owner := Self;

  Text2.DataMembers :=
    TObjectAppearance.TDataMembers.Create(
      TObjectAppearance.TDataMember.Create(
        cText2MemberName, // Displayed by LiveBindings
        Format('Data["%s"]', [TCimListBoxItemAppearanceNames.Text2Name])));   // Expression to access value from TListViewItem


  FTextDistance := TTextObjectAppearance.Create;
  FTextDistance.Name := TCimListBoxItemAppearanceNames.TextDistanceName;
  FTextDistance.DefaultValues.Assign(Text2.DefaultValues);
//   FTextDistance.DefaultValues.Width := 50;
//  FTextDistance.DefaultValues.VertAlign := TListItemAlign.Trailing ;
//  FTextDistance.DefaultValues.TextVertAlign := TTextAlign.taTrailing;

  FTextDistance.RestoreDefaults;
  FTextDistance.OnChange := Self.ItemPropertyChange;
  FTextDistance.Owner := Self;

  TextDistance.DataMembers :=
    TObjectAppearance.TDataMembers.Create(
      TObjectAppearance.TDataMember.Create(
        cTextDistanceMemberName, // Displayed by LiveBindings
        Format('Data["%s"]', [TCimListBoxItemAppearanceNames.TextDistanceName])));   // Expression to access value from TListViewItem







  FText3 := TTextObjectAppearance.Create;
  FText3.Name := TCimListBoxItemAppearanceNames.Text3Name;
  FText3.DefaultValues.Assign(Text2.DefaultValues);
  FText3.DefaultValues.Height := 56;
  FText3.RestoreDefaults;
  FText3.OnChange := Self.ItemPropertyChange;
  FText3.Owner := Self;

  Text3.DataMembers :=
    TObjectAppearance.TDataMembers.Create(
      TObjectAppearance.TDataMember.Create(
        cText3MemberName, // Displayed by LiveBindings
        Format('Data["%s"]', [TCimListBoxItemAppearanceNames.Text3Name])));   // Expression to access value from TListViewItem


  FText4 := TTextObjectAppearance.Create;
  FText4.Name := TCimListBoxItemAppearanceNames.Text4Name;
  FText4.DefaultValues.Assign(Text2.DefaultValues);
  FText4.DefaultValues.Height := 56;
  FText4.RestoreDefaults;
  FText4.OnChange := Self.ItemPropertyChange;
  FText4.Owner := Self;

  Text4.DataMembers :=
    TObjectAppearance.TDataMembers.Create(
      TObjectAppearance.TDataMember.Create(
        cText4MemberName, // Displayed by LiveBindings
        Format('Data["%s"]', [TCimListBoxItemAppearanceNames.Text4Name])));   // Expression to access value from TListViewItem










//  Image.DefaultValues.VertAlign := TListItemAlign.Center;
//  Image.DefaultValues.Height := 70;
//  Image.DefaultValues.Width := 70;
//  Image.DefaultValues.Visible := True;
//  Image.RestoreDefaults;


  AddObject(Text, True);
  AddObject(TextDistance, True);
  AddObject(Text2, True);
  AddObject(Text3, True);
  AddObject(Text4, True);
  AddObject(Image, True);
  AddObject(Accessory, True);
  AddObject(GlyphButton, IsItemEdit);
end;

destructor TCimListItemAppearance.Destroy;
begin
  FText2.Free;
  FText3.Free;
  FText4.Free;
  FTextDistance.Free;
  inherited;
end;



constructor TCimListItemDeleteAppearance.Create;
begin
  inherited;
  GlyphButton.DefaultValues.ButtonType := cDefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

constructor TCimListItemShowCheckAppearance.Create;
begin
  inherited;
  GlyphButton.DefaultValues.ButtonType := cDefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;


type
  TOption = TCustomListView.TRegisterAppearanceOption;
const
  sThisUnit = 'cimListBoxItemApparence';     // Will be added to the uses list when appearance is used


initialization
  // RatingsListItem group
  TCustomListView.RegisterAppearance(
    TCimListItemAppearance, TCimListBoxItemAppearanceNames.ListItem,    [TOption.Item], sThisUnit);
  TCustomListView.RegisterAppearance(
    TCimListItemDeleteAppearance, TCimListBoxItemAppearanceNames.ListItemDelete,    [TOption.ItemEdit], sThisUnit);
  TCustomListView.RegisterAppearance(
    TCimListItemShowCheckAppearance, TCimListBoxItemAppearanceNames.ListItemCheck,    [TOption.ItemEdit], sThisUnit);
finalization
  TCustomListView.UnregisterAppearances(  TArray<TCustomListView.TItemAppearanceObjectsClass>.Create(
     TCimListItemAppearance, TCimListItemDeleteAppearance,
      TCimListItemShowCheckAppearance));


end.




