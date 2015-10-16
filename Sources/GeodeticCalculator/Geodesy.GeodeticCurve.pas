unit Geodesy.GeodeticCurve;

interface

uses
  Geodesy.Angle;

type
    TGeodeticCurve=record
  private
   /// <summary>Ellipsoidal distance (in meters).</summary>
    class var mEllipsoidalDistance: double;
    /// <summary>Azimuth (degrees from north).</summary>
    class var mAzimuth  :TAngle;
    /// <summary>Reverse azimuth (degrees from north).</summary>
    class var mReverseAzimuth   :TAngle;
    class function GetEllipsoidalDistance: double; static;
    class function GetAzimuth: TAngle; static;
    class function GetReverseAzimuth: TAngle; static;


    public

    /// <summary>
    /// Create a new GeodeticCurve.
    /// </summary>
    /// <param name="ellipsoidalDistance">ellipsoidal distance in meters</param>
    /// <param name="azimuth">azimuth in degrees</param>
    /// <param name="reverseAzimuth">reverse azimuth in degrees</param>
    constructor Create( ellipsoidalDistance:double;  azimuth:TAngle;  reverseAzimuth:TAngle);

     /// <summary>Ellipsoidal distance (in meters).</summary>
    class property EllipsoidalDistance:double read GetEllipsoidalDistance;

    class property    Azimuth  :TAngle  read  GetAzimuth;
    class property  ReverseAzimuth  :TAngle   read GetReverseAzimuth;


    class function ToString:string; static;

    end;

implementation

uses
  System.Classes, System.SysUtils;

{ TGeodeticCurve }

constructor TGeodeticCurve.Create(ellipsoidalDistance: double; azimuth,
  reverseAzimuth: TAngle);
begin
     mEllipsoidalDistance := ellipsoidalDistance;
      mAzimuth := azimuth;
      mReverseAzimuth := reverseAzimuth;
end;


class function TGeodeticCurve.GetAzimuth: TAngle;
begin
   Result :=  mAzimuth;
end;

class function TGeodeticCurve.GetEllipsoidalDistance: double;
begin
    Result := mEllipsoidalDistance;
end;

class function TGeodeticCurve.GetReverseAzimuth: TAngle;
begin
   Result :=  mReverseAzimuth   ;
end;

class function TGeodeticCurve.ToString: string;
var
  sb: TStringList;
begin
    sb:= TStringList.Create;
     sb.Append('s=');
      sb.Append(double.ToString(mEllipsoidalDistance));
      sb.Append(';a12=');
      sb.Append(mAzimuth.ToString());
      sb.Append(';a21=');
      sb.Append(mReverseAzimuth.ToString);
      sb.Append(';');

      result := sb.Text;

end;

end.


