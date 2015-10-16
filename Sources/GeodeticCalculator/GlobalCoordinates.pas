unit GlobalCoordinates;

interface

uses Geodesy.Angle;
type

   /// <summary>
  /// Encapsulation of latitude and longitude coordinates on a globe.  Negative
  /// latitude is southern hemisphere.  Negative longitude is western hemisphere.
  ///
  /// Any angle may be specified for longtiude and latitude, but all angles will
  /// be canonicalized such that:
  ///
  ///      -90 <= latitude <= +90
  ///     -180 < longitude <= +180
  /// </summary>
 TGlobalCoordinates=class //(Tobject, IComparable<TGlobalCoordinates>)
     private
         /// <summary>Latitude.  Negative latitude is southern hemisphere.</summary>
      mLatitude:Geodesy.Angle.TAngle;

    /// <summary>Longitude.  Negative longitude is western hemisphere.</summary>
     mLongitude:TAngle;
     public
      procedure Canonicalize;
  end;


implementation

{ TGlobalCoordinates }

procedure TGlobalCoordinates.Canonicalize;
var
  latitude,longitude:double;
begin
//    latitude := mLatitude.Degrees;
//     longitude := mLongitude.Degrees;
//
//      latitude = (latitude + 180) % 360;
//      if (latitude < 0) latitude += 360;
//      latitude -= 180;
//
//      if (latitude > 90)
//      {
//        latitude = 180 - latitude;
//        longitude += 180;
//      }
//      else if (latitude < -90)
//      {
//        latitude = -180 - latitude;
//        longitude += 180;
//      }
//
//      longitude = ((longitude + 180) % 360);
//      if (longitude <= 0) longitude += 360;
//      longitude -= 180;
//
//      mLatitude = new Angle(latitude);
//      mLongitude = new Angle(longitude);
end;

end.
