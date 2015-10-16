unit ShowLocationsMap_iOS;
//_______________________________________________________________ ZYMA __
// $HeadURL: https://vmsubversion2.zymasoft.local/svn/_GL/trunk/Cimeti%C3%A8res/Sources/MobileClient/ShowLocationsMap_iOS.pas $
//.......................................................................
// Last committed    : $Revision:: 44               $
// Last changed by   : $Author:: Builder            $
// Last changed date : $Date:: 2014-04-01 16:47:23 #$
//.......................................................................
// Copyright (c) ZYMA 2014
//_______________________________________________________________________

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

   {$IFDEF iOS}

    iOSapi.CoreLocation,

{$ENDIF}

  DPF.iOS.ApplicationManager, DPF.iOS.MKMapView, DPF.iOS.UIViewController,
  DPF.iOS.UINavigationController, DPF.iOS.BaseControl, DPF.iOS.UIView,


  DPF.iOS.MapKit,

  DPF.iOS.UILabel, DPF.iOS.UIButton, DPF.iOS.UIToolbar,


  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs;


type
  TFormShowLocationsMap = class(TForm)
   {$IFDEF iOS}
    DPFMapView1: TDPFMapView;
    DPFApplicationManager1: TDPFApplicationManager;
    DPFNavigationController1: TDPFNavigationController;
    DPFNavigationControllerPage1: TDPFNavigationControllerPage;
    DPFUIView1: TDPFUIView;
 {$ENDIF}
    procedure FormShow(Sender: TObject);
    procedure DPFNavigationControllerPage1BarButtons0Click(Sender: TObject);
    procedure DPFApplicationManager1MemoryWarning(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    {$IFDEF iOS}

    procedure AddMarker (Title: string; SubTitle: string; Latitude: Double; longitude: Double);
    procedure SetMapCenter(Latitude: Double; longitude: Double) ;
    procedure AddCircle(Latitude: Double; longitude: Double; radius:Double);

    {$ENDIF}

 protected
    procedure PaintRects( const UpdateRects: array of TRectF ); override;

  end;

var
  FormShowLocationsMap: TFormShowLocationsMap;

implementation

{$R *.fmx}

{$IFDEF iOS}

procedure TFormShowLocationsMap.SetMapCenter(Latitude: Double; longitude: Double) ;
begin
//   DPFMapView1.setCenter(Latitude, longitude,true) ;
end;

procedure TFormShowLocationsMap.AddCircle(Latitude: Double; longitude: Double; radius:Double);
begin
  DPFMapView1.AddCircle( Latitude, longitude, radius, TAlphaColors.Blue, TAlphaColors.Darkblue, 5, 0.2, '', '' );
end;


procedure TFormShowLocationsMap.AddMarker( Title: string; SubTitle: string; Latitude: Double; longitude: Double);
var
  Marker  : MKPointAnnotation;
begin
//   DPFMapView1.add d.AddAnnotation( 'Iran', 'Tehran', 35.737229, 51.405630, -1, true, 0.7 );
//  DPFMapView1.ShowUserLocation := false;

//  DPFMapView1.setCenter(35.737229, 51.405630,true) ;

//  Marker   := DPFMapView1.AddAnnotation( 'Iran', 'Tehran', 35.737229, 51.405630, 14, true, 0.7 );
  Marker   := DPFMapView1.AddAnnotation( Title, SubTitle, Latitude, longitude, 10, false, 0.7,pcGreen,'cemeteryvert.png','cemeteryvert.png',true,true );


//  Marker1 := DPFMapView1.AddAnnotation( 'Iran', 'Tehran - Asad Abadi SQ.', 35.737177, 51.405807, 15, true, 1.0, pcRed, '', 'flag_iran.png', true, true );
//  Marker2 := DPFMapView1.AddAnnotation( 'Iran', 'Tehran - Traffic Zone!', 35.736202, 51.403280, 15, false, 1.0, pcGreen, 'trafficlight_on.png', 'flag_iran.png', true, true );


end;
{$ENDIF}


procedure TFormShowLocationsMap.DPFApplicationManager1MemoryWarning(
  Sender: TObject);
begin
 ShowMessage( 'Low Memory!' );
end;

procedure TFormShowLocationsMap.DPFNavigationControllerPage1BarButtons0Click(
  Sender: TObject);
begin
      Self.ModalResult := mrOk;
end;

procedure TFormShowLocationsMap.FormCreate(Sender: TObject);
var
    DPFUIView: TDPFUIView  ;
    DPFNavigationController: TDPFNavigationController;
    DPFNavigationControllerPage: TDPFNavigationControllerPage;
    DPFMapView     : TDPFMapView;
begin







end;

procedure TFormShowLocationsMap.FormShow(Sender: TObject);
begin
{$IFDEF iOS}
  DPFUIView1.Loaded;
{$ENDIF}
//C:\DataGL\DelphiLib\DPF.iOS.Native.Components.v8.1.6\Demos\NavigationController

end;

procedure TFormShowLocationsMap.PaintRects(const UpdateRects: array of TRectF);
begin
  { }

end;

end.
