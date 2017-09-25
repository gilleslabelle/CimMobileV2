unit Geodesy.Angle;
// Gavaghan.Geodesy by Mike Gavaghan
// 
// http://www.gavaghan.org/blog/free-source-code/geodesy-library-vincentys-formula/
// 
// This code may be freely used and modified on any personal or professional
// project.  It comes with no warranty.
// BitCoin tips graciously accepted at 1FB63FYQMy7hpC2ANVhZ5mSgAZEtY1aVLf
// */

interface

uses System.Generics.Defaults, System.Classes, System.SysUtils;

type

  TAngle = class(TinterfacedObject, IComparable<TAngle>)
  private const
    /// <summary>Degrees/Radians conversion constant.</summary>
    PiOver180 = PI / 180.0;
  private
    /// <summary>Angle value in degrees.</summary>
    var mDegrees: Double;
//    var FAbs: TAngle;
    class function GetZero: TAngle;  static;
    class function GetAngle180: TAngle; static;
    procedure SetDegrees(const Value: Double);
    procedure SetRadians(const Value: Double);
    function GetRadians: Double;
    function GetAbs: TAngle;
  public
    /// <summary>
    /// Construct a new Angle from a degree measurement.
    /// </summary>
    /// <param name="degrees">angle measurement</param>
    constructor Create(degrees: Double); overload;
    /// <summary>
    /// Construct a new Angle from degrees and minutes.
    /// </summary>
    /// <param name="degrees">degree portion of angle measurement</param>
    /// <param name="minutes">minutes portion of angle measurement (0 <= minutes < 60)</param>
    constructor Create(degrees: integer; minutes: Double); overload;
    /// <summary>
    /// Construct a new Angle from degrees, minutes, and seconds.
    /// </summary>
    /// <param name="degrees">degree portion of angle measurement</param>
    /// <param name="minutes">minutes portion of angle measurement (0 <= minutes < 60)</param>
    /// <param name="seconds">seconds portion of angle measurement (0 <= seconds < 60)</param>
    constructor Create(degrees: integer; minutes: integer; seconds: Double)overload;

     function CompareTo(Value: TObject): integer;  overload;

     function CompareTo(Value: TAngle): integer;  overload;
     class property Zero: TAngle read GetZero;
     class property Angle180: TAngle read GetAngle180;
    /// <summary>
    /// Get/set angle measured in degrees.
    /// </summary>
    property degrees: Double read mDegrees write SetDegrees;
    /// <summary>
    /// Get/set angle measured in radians.
    /// </summary>
     property Radians: Double read GetRadians write SetRadians;
    /// <summary>
    /// Get the absolute value of the angle.
    /// </summary>
     property Abs: TAngle read GetAbs;

    /// <summary>
    /// Imlplicity cast a double as an Angle measured in degrees.
    /// </summary>
    /// <param name="degrees">angle in degrees</param>
    /// <returns>double cast as an Angle</returns>
//     operator Implicit(degrees: Double): TAngle;
    /// <summary>
    /// Calculate a hash code for the angle.
    /// </summary>
    /// <returns>hash code</returns>
     function GetHashCode(): integer;

    /// <summary>
    /// Compare this Angle to another Angle for equality.  Angle comparisons
    /// are performed in absolute terms - no "wrapping" occurs.  In other
    /// words, 360 degress != 0 degrees.
    /// </summary>
    /// <param name="obj">object to compare to</param>
    /// <returns>'true' if angles are equal</returns>
    function Equals(obj: TAngle): boolean;

     /// <summary>
    /// Get coordinates as a string.
    /// </summary>
    /// <returns></returns>
    function ToString(): string ;

//     operator Add(lhs, rhs: TAngle): TAngle;
//    class operator Subtract(lhs, rhs: TAngle): TAngle;
//    class operator GreaterThan(lhs, rhs: TAngle): Boolean;
//    class operator GreaterThanOrEqual(lhs, rhs: TAngle): Boolean;
//    class operator LessThan(lhs, rhs: TAngle): Boolean;
//    class operator LessThanOrEqual(lhs, rhs: TAngle): Boolean;
//    class operator Equal(lhs, rhs: TAngle): Boolean;
//    class operator NotEqual(lhs, rhs: TAngle): Boolean;


  end;

implementation

uses System.Math;

// function TAngle.CompareTo(Value: TAngle): Integer;
// begin
//
// end;

// constructor TAngle.Create;
// begin
// inherited Create;
// end;
//
{ TAngle2 }

{ TAngle2 }




// class operator TAngle.Implicit(degrees: double): TAngle;
// begin
// Result := TAngle.Create(degrees);
// end;

//class operator TAngle.Add(lhs, rhs: TAngle): TAngle;
//begin
//    result :=  TAngle.Create( lhs.mDegrees + rhs.mDegrees);
//end;

function TAngle.CompareTo(Value: TAngle): integer;
var
  epsilon: Double;
begin

  epsilon := Max(Min(System.Abs(mDegrees), System.Abs(Value.mDegrees)) * 0.000001, 0.000001);

  Result := comparevalue(mDegrees, Value.mDegrees, epsilon);

end;

constructor TAngle.Create(degrees: Double);
begin
  mDegrees := degrees;
end;

constructor TAngle.Create(degrees: integer; minutes: Double);
begin
  mDegrees := minutes / 60.0;
  mDegrees := IfThen((degrees < 0), (degrees - mDegrees), (degrees + mDegrees));
end;

function TAngle.CompareTo(Value: TObject): integer;
begin
    raise Exception.Create('Erreur');
end;

constructor TAngle.Create(degrees, minutes: integer; seconds: Double);
begin
  mDegrees := (seconds / 3600.0) + (minutes / 60.0);
  mDegrees := IfThen((degrees < 0), (degrees - mDegrees), (degrees + mDegrees));
end;

//class operator TAngle.Equal(lhs, rhs: TAngle): Boolean;
//begin
//      Result := ( lhs.mDegrees = rhs.mDegrees);
//end;

function TAngle.Equals(obj: TAngle): boolean;
begin

  Result := (mDegrees = obj.mDegrees);

end;

function TAngle.GetAbs: TAngle;
begin
  Result := TAngle.Create(System.Abs(mDegrees));
end;

class function TAngle.GetAngle180: TAngle;
begin
  Result := TAngle.Create(180);
end;

function TAngle.GetHashCode: integer;
begin
  Result := Round(mDegrees * 1000033);
end;

 function TAngle.GetRadians: Double;
begin
  Result := mDegrees * PiOver180;
end;

class  function TAngle.GetZero: TAngle;
begin
  Result := TAngle.Create(0);
end;

//class operator TAngle.GreaterThan(lhs, rhs: TAngle): Boolean;
//begin
//     Result := ( lhs.mDegrees > rhs.mDegrees);
//end;
//
//class operator TAngle.GreaterThanOrEqual(lhs, rhs: TAngle): Boolean;
//begin
//     Result := ( lhs.mDegrees >= rhs.mDegrees);
//end;
//
//class operator TAngle.Implicit(degrees: Double): TAngle;
//begin
//  Result := TAngle.Create(degrees);
//end;
//
//class operator TAngle.LessThan(lhs, rhs: TAngle): Boolean;
//begin
//    Result := ( lhs.mDegrees < rhs.mDegrees);
//end;
//
//class operator TAngle.LessThanOrEqual(lhs, rhs: TAngle): Boolean;
//begin
//     Result := ( lhs.mDegrees<= rhs.mDegrees);
//end;
//
//class operator TAngle.NotEqual(lhs, rhs: TAngle): Boolean;
//begin
//      Result := ( lhs.mDegrees <> rhs.mDegrees);
//end;

procedure TAngle.SetDegrees(const Value: Double);
begin
  mDegrees := Value;
end;

procedure TAngle.SetRadians(const Value: Double);
begin
  mDegrees := Value / PiOver180;
end;
//class operator TAngle.Subtract(lhs, rhs: TAngle): TAngle;
//begin
//    result :=  TAngle.Create( lhs.mDegrees - rhs.mDegrees);
//end;

function TAngle.ToString: string;
begin
    Result := FloatToStr(mDegrees)   ;
end;

{ ttest }

end.

