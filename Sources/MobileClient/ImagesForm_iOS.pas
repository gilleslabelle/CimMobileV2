unit ImagesForm_iOS;
 // _______________________________________________________________ ZYMA __
// $HeadURL: https://vmsubversion2.zymasoft.local/svn/_GL/trunk/Cimeti%C3%A8res/Sources/MobileClient/ImagesForm_iOS.pas $
// .......................................................................
// Last committed    : $Revision:: 45               $
// Last changed by   : $Author:: Builder            $
// Last changed date : $Date:: 2014-04-11 12:20:31 #$
// .......................................................................
// Copyright (c) ZYMA 2014
// _______________________________________________________________________

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Generics.Collections, FMX.Objects, FMX.StdCtrls, FMX.Gestures,



  DPF.iOS.UIImageView, DPF.iOS.BaseControl, DPF.iOS.UIView,
  DPF.iOS.UIViewController, DPF.iOS.UINavigationController, DPF.iOS.UILabel,
  uPictureCls;







type



  TFormImages = class(TForm)
    GestureManager1: TGestureManager;
    DPFUIView1: TDPFUIView;
    DPFImageView2: TDPFImageView;
    DPFNavigationController1: TDPFNavigationController;
    DPFNavigationControllerPage1: TDPFNavigationControllerPage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure DPFNavigationControllerPage1BarButtons0Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FLesImages: TCimImageCollection;
    FCoverIndex: integer;

    procedure SetLesImages(const Value: TCimImageCollection);

    { Private declarations }
  public
    { Public declarations }

   property  LesImages : TCimImageCollection read FLesImages write SetLesImages;
   procedure RefreshImage;
   procedure AfficheImage(index: integer);

protected
    procedure PaintRects( const UpdateRects: array of TRectF ); override;

  end;

var
  FormImages: TFormImages;

implementation

{$R *.fmx}

procedure TFormImages.AfficheImage(index: integer);
begin
     FCoverIndex := index;
     RefreshImage;
end;

procedure TFormImages.DPFNavigationControllerPage1BarButtons0Click(
  Sender: TObject);
begin
 Self.Close;
end;

procedure TFormImages.FormCreate(Sender: TObject);
begin
 FLesImages := TCimImageCollection.Create(false);

end;

procedure TFormImages.FormDestroy(Sender: TObject);
begin
FLesImages.Free;
end;

procedure TFormImages.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
  LObj: IControl;
  LImage: TImage;
  LImageCenter: TPointF;
begin
     case EventInfo.GestureID of
    sgiRight:
      begin
        if FCoverIndex > 0 then
        begin

          FCoverIndex := FCoverIndex - 1;
          RefreshImage;
        end;
      end;
    sgiLeft:
      begin

        if FCoverIndex < (FLesImages.count - 1) then
        begin

          FCoverIndex := FCoverIndex + 1;
          RefreshImage;
        end;

      end;

  end;
end;

procedure TFormImages.FormShow(Sender: TObject);
var
  i:integer;
begin
   DPFUIView1.Loaded;

   AfficheImage(0);


end;

procedure TFormImages.PaintRects(const UpdateRects: array of TRectF);
begin

   {}
end;

procedure TFormImages.SetLesImages(const Value: TCimImageCollection);
var
  I: Integer;
begin
  FLesImages := Value;


end;



procedure TFormImages.SpeedButton3Click(Sender: TObject);
begin
    Self.Close;
end;

procedure TFormImages.RefreshImage;
begin

    DPFImageView2.Bitmap.Assign(FLesImages[FCoverIndex].image.Bitmap);

    DPFNavigationControllerPage1.PageViewTitle := FLesImages[FCoverIndex].Detail;

     Application.ProcessMessages;


end;



end.
