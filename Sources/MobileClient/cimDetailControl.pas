unit cimDetailControl;

interface

uses
  FMX.Controls, FMX.Objects, FMX.Types, System.Types, System.Classes;

//uses
//  System.SysUtils, System.Classes, FMX.Controls, FMX.Objects, FMX.Types,
//  System.Types, FMX.Layouts;

type

  TCimDetailCtl = class(TStyledControl)
  private const
    defaultHeight: integer = 32;
    defaultCaptionWidth: integer = 85;
    defaultFontsize: integer = 12;
  private
    FLabelCaption: string;
    FLabelDetail: string;
    FLabelDetailWidth: integer;
    FLabelDetailFontHeight: integer;
    FLabelCaptionFontHeight: integer;
    procedure SetLabelCaption(const Value: string);
    procedure SetLabelDetail(const Value: string);
    procedure SetLabelDetailWidth(const Value: integer);
    procedure SetLabelCaptionFontHeight(const Value: integer);
    procedure SetLabelDetailFontHeight(const Value: integer);
    { Private declarations }
  protected
    { Protected declarations }
    FTextCaption: TText;
    FTextGroupe: TText;
//    FTextLayout: TLayout;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    function GetStyleObject(const Clone: Boolean): TFmxObject; override;
    function GetDefaultSize: TSizeF; override;

    procedure Resize; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;

  published
    { Published declarations }

    property Align;
    property Anchors;
    property Cursor;
    property Height;
    property Position;
    property RotationCenter;
    property RotationAngle;
    property StyleLookup;
    property Visible;
    property Width;

    property LabelCaption: string read FLabelCaption write SetLabelCaption;
    property LabelCaptionFontHeight: integer read FLabelCaptionFontHeight write SetLabelCaptionFontHeight;

    property LabelDetail: string read FLabelDetail write SetLabelDetail;
    property LabelDetailWidth: integer read FLabelDetailWidth write SetLabelDetailWidth;
    property LabelDetailFontHeight: integer read FLabelDetailFontHeight write SetLabelDetailFontHeight;

  end;

implementation

//uses
//  FMX.Styles;

// {$R CimDetailCtl.res}

// uses
// FMX.Styles, StrUtils;

function TCimDetailCtl.GetStyleObject(const Clone: Boolean): TFmxObject;
begin

  if (StyleLookup = '') then
  begin
//
//    Result := TFmxObject(TStyleManager.LoadFromResource(HInstance, 'CimDetailCtlStyle', RT_RCDATA));
//
  end
  else
  begin
    Result := inherited GetStyleObject(Clone);
  end;

end;

procedure TCimDetailCtl.Resize;
begin
  inherited;

end;

function TCimDetailCtl.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(480, defaultHeight);
end;

{ TX10CmdCtlCustom }

constructor TCimDetailCtl.Create(AOwner: TComponent);
//var
//  Style: TFmxObject;
begin
  inherited;

  FLabelDetailWidth := defaultCaptionWidth;

  FLabelCaption := 'Titre';
  FLabelDetail := 'Groupe1';

  FLabelCaptionFontHeight := defaultFontsize;
  FLabelDetailFontHeight := defaultFontsize;
end;

procedure TCimDetailCtl.FreeStyle;
begin
  inherited;
  FTextCaption := nil;
  FTextGroupe := nil;

//  FTextLayout := nil;

end;

procedure TCimDetailCtl.SetLabelDetail(const Value: string);
begin
  FLabelDetail := Value;
  ApplyStyle;
end;

procedure TCimDetailCtl.SetLabelDetailFontHeight(const Value: integer);
begin
  FLabelDetailFontHeight := Value;
  ApplyStyle;
end;

procedure TCimDetailCtl.SetLabelDetailWidth(const Value: integer);
begin
  FLabelDetailWidth := Value;
  ApplyStyle;
end;

procedure TCimDetailCtl.SetLabelCaption(const Value: string);
begin
  FLabelCaption := Value;
  ApplyStyle;
end;

procedure TCimDetailCtl.SetLabelCaptionFontHeight(const Value: integer);
begin
  FLabelCaptionFontHeight := Value;
  ApplyStyle;
end;

procedure TCimDetailCtl.ApplyStyle;
//var
//  T: TFmxObject;
begin

  inherited;

//  T := FindStyleResource('caption');
//  if (T <> nil) and (T is TImage) then
//  begin
//    FTextCaption.Text := FLabelCaption;
//  end;

//  if not Assigned(FTextLayout) then
//  begin
//    FTextLayout := FindStyleResource('cimdetailctlstyle') as TLayout;
//  end;
//
//  if Assigned(FTextLayout) then
//  begin
//      FTextLayout.Height := 100;
//  end;

  if not Assigned(FTextCaption) then
  begin
    FTextCaption := FindStyleResource('caption') as TText;
  end;

  if Assigned(FTextCaption) then
  begin
    FTextCaption.Text := FLabelCaption;
    FTextCaption.Width := FLabelDetailWidth;
    FTextCaption.Font.Size := FLabelCaptionFontHeight;

  end;

  if not Assigned(FTextGroupe) then
  begin
    FTextGroupe := FindStyleResource('ledetail') as TText;
  end;

  if Assigned(FTextGroupe) then
  begin
    FTextGroupe.Text := FLabelDetail;
    FTextGroupe.Font.Size := FLabelDetailFontHeight;


  end;

end;

end.
