unit ShowCimLocations;
// _______________________________________________________________ ZYMA __
// $HeadURL: https://vmsubversion2.zymasoft.local/svn/_GL/trunk/Cimeti%C3%A8res/Sources/MobileClient/MainformTablet.pas $
// .......................................................................
// Last committed    : $Revision:: 45               $
// Last changed by   : $Author:: Builder            $
// Last changed date : $Date:: 2014-04-11 12:20:31 #$
// .......................................................................
// Copyright (c) ZYMA 2014
// _______________________________________________________________________

interface

uses
  FMX.Forms, FMX.Objects, FMX.StdCtrls, System.Classes, FMX.Types, FMX.Controls, FMX.Controls.Presentation,
  System.Sensors, System.Generics.Collections;

//uses
//  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
//  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
//  System.Generics.Collections, System.Sensors, FMX.Objects,
//  FMX.Controls.Presentation;

type

  TMarkerItem = record
    Nom: string;
    LocationCoord: TLocationCoord2D;

    constructor Create(Nom: string; long, lat: double);
  end;

  TMarkerCollection = TList<TMarkerItem>;

  TShowCimLocationsForm = class(TForm)
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    FLatLongCollection: TMarkerCollection;
  public
    { Public declarations }

    procedure ShowMap(markers: TMarkerCollection; long, lat: double);
  end;

var
  ShowCimLocationsForm: TShowCimLocationsForm;

implementation

{$R *.fmx}

uses mMain, uImageLoader, mainformLogic, System.SysUtils,System.UITypes;

{ TForm1 }

procedure TShowCimLocationsForm.FormCreate(Sender: TObject);
begin
  FLatLongCollection := TMarkerCollection.Create();
end;

procedure TShowCimLocationsForm.ShowMap(markers: TMarkerCollection; long, lat: double);

var
  // Img: TImage  ;
  url: string;
  w, h: integer;
  sLong, sLat: string;
  sMarkers, sTmp: string;
  mi: TMarkerItem;
  sf: TFormatSettings;
  I: integer;

begin


  w := Self.ClientWidth;
  h := Self.ClientHeight;

  sf := TFormatSettings.Create('en-US');


  markers.Insert(0,TMarkerItem.Create('Position', long,lat));

  sMarkers := '';
  for I := 0 to 50 do
  begin // markers.Coutd-1  do begin



    mi := markers[I];

    sLat:=  mi.LocationCoord.Latitude.ToString(sf);
    sLong:=  mi.LocationCoord.Longitude.ToString(sf);

    if (I = 0) then begin
    sTmp := Format('pin-s+cc4422(%s,%s)', [sLong, sLat]);
    end else begin

    sTmp := Format('pin-s-cemetery(%s,%s)', [sLong, sLat]);

    end;


    if sMarkers = '' then
    begin
      sMarkers := sTmp;
    end
    else
    begin
      sMarkers := sMarkers + ', ' + sTmp;
    end;

  end;

  sLong := FloatToStrF(long, ffFixed, 6, 4, sf);
  sLat := FloatToStrF(lat, ffFixed, 6, 4, sf);

  url := Format('http://api.tiles.mapbox.com/v3/%s/' + sMarkers + '/%s,%s,11/%dx%d.png', [mainformLogic.MapboxKey, sLong, sLat, w, h]);

  DefaultImageLoader.LoadImage(Image1, url);


end;

procedure TShowCimLocationsForm.SpeedButton1Click(Sender: TObject);
begin
  Self.ModalResult := mrOk;
  Self.Close;
end;

{ TMarkerItem }

constructor TMarkerItem.Create(Nom: string; long, lat: double);
begin
  Self.Nom := Nom;
  Self.LocationCoord.Latitude := lat;
  Self.LocationCoord.Longitude := long;
end;

end.
