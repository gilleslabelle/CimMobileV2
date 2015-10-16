unit Geodesy.GlobalCoordinates;

interface

uses
  Geodesy.Angle;

type

  /// <summary>
  /// Encapsulation of latitude and longitude coordinates on a globe.  Negative
  /// latitude is southern hemisphere.  Negative longitude is western hemisphere.
  ///
  /// Any angle may be specified for longtiude and latitude, but all angles will
  /// be canonicalized such that:
  ///
  /// -90 <= latitude <= +90
  /// -180 < longitude <= +180
  /// </summary>
  ///
  TGlobalCoordinates = class(TinterfacedObject, IComparable<TGlobalCoordinates>)
  private
    /// <summary>Latitude.  Negative latitude is southern hemisphere.</summary>
    mLatitude: TAngle;

    /// <summary>Longitude.  Negative longitude is western hemisphere.</summary>
    mLongitude: TAngle;
//    function GetLatitude: TAngle;
    procedure SetLatitude(const Value: TAngle);
    procedure SetLongitude(const Value: TAngle);
  public
    /// <summary>
    /// Canonicalize the current latitude and longitude values such that:
    ///
    ///      -90 <= latitude <= +90
    ///     -180 < longitude <= +180
    /// </summary>
    procedure Canonicalize;

    function CompareTo(Value: TGlobalCoordinates): Integer; overload;
    function CompareTo(Value: TObject): Integer; overload;

    constructor Create( latitude:TAngle; longitude:TAngle);

     /// <summary>
    /// Get/set latitude.  The latitude value will be canonicalized (which might
    /// result in a change to the longitude). Negative latitude is southern hemisphere.
    /// </summary>
    property Latitude :TAngle read mLatitude write SetLatitude;

     /// <summary>
    /// Get/set longitude.  The longitude value will be canonicalized. Negative
    /// longitude is western hemisphere.
    /// </summary>
    property Longitude :TAngle read mLongitude write SetLongitude;


  end;

implementation

uses
  System.SysUtils;

{ TGlobalCoordinates }

function modFloat( x,y : double) : double;
begin
     Result := x - y * Trunc(x/y);
end;

 procedure TGlobalCoordinates.Canonicalize;
var
  latitude, longitude: double;
begin
   latitude := mLatitude.Degrees;
   longitude := mLongitude.Degrees;

   latitude := modFloat (latitude + 180 , 360);
   if (latitude < 0) then  latitude:= latitude + 360;
   latitude := latitude - 180;

   if (latitude > 90) then begin

   latitude := 180 - latitude;
   longitude := longitude+ 180;
   end
   else if (latitude < -90) then begin

   latitude := -180 - latitude;
   longitude := longitude+ 180;
   end;

   longitude := modFloat((longitude + 180) , 360);
   if (longitude <= 0) then longitude := longitude+ 360;
   longitude := longitude - 180;

   mLatitude :=  TAngle.Create(latitude);
   mLongitude := TAngle.Create(longitude);
end;

function TGlobalCoordinates.CompareTo(Value: TGlobalCoordinates): Integer;
begin
  raise Exception.Create('Error Message');
end;


function TGlobalCoordinates.CompareTo(Value: TObject): Integer;
begin
  raise Exception.Create('Error Message');
end;

constructor TGlobalCoordinates.Create( latitude:TAngle; longitude:TAngle);
begin
      mLatitude := TAngle.Create(latitude.degrees);
      mLongitude := TAngle.Create( longitude.degrees);

//     mLatitude.degrees := latitude.degrees;
//      mLongitude.degrees := longitude.degrees;
      Canonicalize();
end;

//function TGlobalCoordinates.GetLatitude: TAngle;
//begin
//
//end;

procedure TGlobalCoordinates.SetLatitude(const Value: TAngle);
begin
     mLatitude := value;
        Canonicalize();
end;

procedure TGlobalCoordinates.SetLongitude(const Value: TAngle);
begin
     mLongitude := value;
        Canonicalize();
end;

end.
