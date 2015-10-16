unit Geodesy;
/// * Gavaghan.Geodesy by Mike Gavaghan
// *
// * http://www.gavaghan.org/blog/free-source-code/geodesy-library-vincentys-formula/
// *
// * This code may be freely used and modified on any personal or professional
// * project.  It comes with no warranty.
// *
// * BitCoin tips graciously accepted at 1FB63FYQMy7hpC2ANVhZ5mSgAZEtY1aVLf
// */

interface

uses
  Geodesy.GlobalCoordinates, Geodesy.GeodeticCurve;

type

  /// <summary>
  /// Encapsulation of an ellipsoid, and declaration of common reference ellipsoids.
  /// </summary>
  TEllipsoid = record
  private
    /// <summary>Semi major axis (meters).</summary>
    mSemiMajorAxis: double;

    /// <summary>Semi minor axis (meters).</summary>
    mSemiMinorAxis: double;

    /// <summary>Flattening.</summary>
    mFlattening: double;

    /// <summary>Inverse flattening.</summary>
    mInverseFlattening: double;

//    FFlattening: double;
//    FInverseFlattening: double;
//    FSemiMajorAxis: double;
//    FSemiMinorAxis: double;
    class function GetANS: TEllipsoid; static;
    class function GetClarke1858: TEllipsoid; static;
    class function GetClarke1880: TEllipsoid; static;
    class function GetGRS67: TEllipsoid; static;
    class function GetGRS80: TEllipsoid; static;
    class function GetSphere: TEllipsoid; static;
    class function GetWGS72: TEllipsoid; static;
    class function GetWGS84: TEllipsoid; static;
  public

    /// <summary>The WGS84 ellipsoid.</summary>
    class property WGS84: TEllipsoid read GetWGS84;
    /// <summary>The GRS80 ellipsoid.</summary>
    class property GRS80: TEllipsoid read GetGRS80;
    /// <summary>The GRS67 ellipsoid.</summary>
    class property GRS67: TEllipsoid read GetGRS67;
    /// <summary>The ANS ellipsoid.</summary>
    class property ANS: TEllipsoid read GetANS;
    /// <summary>The WGS72 ellipsoid.</summary>
    class property WGS72: TEllipsoid read GetWGS72;
    /// <summary>The Clarke1858 ellipsoid.</summary>
    class property Clarke1858: TEllipsoid read GetClarke1858;
    /// <summary>The Clarke1880 ellipsoid.</summary>
    class property Clarke1880: TEllipsoid read GetClarke1880;
    /// <summary>A spherical "ellipsoid".</summary>
    class property Sphere: TEllipsoid read GetSphere;

    /// <summary>
    /// Construct a new Ellipsoid.  This is private to ensure the values are
    /// consistent (flattening = 1.0 / inverseFlattening).  Use the methods
    /// FromAAndInverseF() and FromAAndF() to create new instances.
    /// </summary>
    /// <param name="semiMajor"></param>
    /// <param name="semiMinor"></param>
    /// <param name="flattening"></param>
    /// <param name="inverseFlattening"></param>
    constructor Create(semiMajor: double; semiMinor: double; flattening: double; inverseFlattening: double);
    /// <summary>Get flattening.</summary>
    property flattening: double read mFlattening write mFlattening;
    /// <summary>Get inverse flattening.</summary>
    property inverseFlattening: double read mInverseFlattening write mInverseFlattening;
    /// <summary>Get semi major axis (meters).</summary>
    property SemiMajorAxis: double read mSemiMajorAxis write mSemiMajorAxis;
    /// <summary>Get semi minor axis (meters).</summary>
    property SemiMinorAxis: double read mSemiMinorAxis write mSemiMinorAxis;

    /// <summary>
    /// Build an Ellipsoid from the semi major axis measurement and the flattening.
    /// </summary>
    /// <param name="semiMajor">semi major axis (meters)</param>
    /// <param name="flattening"></param>
    /// <returns></returns>
    class function FromAAndF(semiMajor: double; flattening: double): TEllipsoid; static;
    /// <summary>
    /// Build an Ellipsoid from the semi major axis measurement and the inverse flattening.
    /// </summary>
    /// <param name="semiMajor">semi major axis (meters)</param>
    /// <param name="inverseFlattening"></param>
    /// <returns></returns>
    class function FromAAndInverseF(semiMajor: double; inverseFlattening: double): TEllipsoid; static;

  end;

  /// <summary>
  /// Implementation of Thaddeus Vincenty's algorithms to solve the direct and
  /// inverse geodetic problems.  For more information, see Vincent's original
  /// publication on the NOAA website:
  ///
  /// See http://www.ngs.noaa.gov/PUBS_LIB/inverse.pdf
  /// </summary>
  TGeodeticCalculator = class
  private

    const
    TwoPi: double = 2.0 * System.PI;

  public

    // function    CalculateEndingGlobalCoordinates(Ellipsoid ellipsoid, GlobalCoordinates start, Angle startBearing, double distance, out Angle endBearing ):GlobalCoordinates;
    // function    CalculateEndingGlobalCoordinates(Ellipsoid ellipsoid, GlobalCoordinates start, Angle startBearing, double distance):GlobalCoordinates;
    /// <summary>
    /// Calculate the geodetic curve between two points on a specified reference ellipsoid.
    /// This is the solution to the inverse geodetic problem.
    /// </summary>
    /// <param name="ellipsoid">reference ellipsoid to use</param>
    /// <param name="start">starting coordinates</param>
    /// <param name="end">ending coordinates </param>
    /// <returns></returns>
    function CalculateGeodeticCurve(ellipsoid: TEllipsoid; start: TGlobalCoordinates; leend: TGlobalCoordinates): TGeodeticCurve;
    // function   CalculateGeodeticMeasurement(Ellipsoid refEllipsoid, GlobalPosition start, GlobalPosition end):GeodeticMeasurement
  end;

implementation

uses System.Math,Geodesy.Angle;

constructor TEllipsoid.Create(semiMajor: double; semiMinor: double; flattening: double; inverseFlattening: double);
begin

  mSemiMajorAxis := semiMajor;
  mSemiMinorAxis := semiMinor;
  mFlattening := flattening;
  mInverseFlattening := inverseFlattening;
end;

class function TEllipsoid.FromAAndF(semiMajor: double; flattening: double): TEllipsoid;
var
  inverseF, b: double;
begin
  inverseF := 1.0 / flattening;
  b := (1.0 - flattening) * semiMajor;

  Result := TEllipsoid.Create(semiMajor, b, flattening, inverseF);

end;

class function TEllipsoid.FromAAndInverseF(semiMajor, inverseFlattening: double): TEllipsoid;

var
  f, b: double;
begin
  f := 1.0 / inverseFlattening;
  b := (1.0 - f) * semiMajor;

  Result := TEllipsoid.Create(semiMajor, b, f, inverseFlattening);
end;

class function TEllipsoid.GetANS: TEllipsoid;
begin
  Result := FromAAndInverseF(6378160.0, 298.25);
end;

class function TEllipsoid.GetClarke1858: TEllipsoid;
begin
  Result := FromAAndInverseF(6378293.645, 294.26);
end;

class function TEllipsoid.GetClarke1880: TEllipsoid;
begin
  Result := FromAAndInverseF(6378249.145, 293.465);
end;

class function TEllipsoid.GetGRS67: TEllipsoid;
begin
  Result := FromAAndInverseF(6378160.0, 298.25);
end;

class function TEllipsoid.GetGRS80: TEllipsoid;
begin
  Result := FromAAndInverseF(6378137.0, 298.257222101);
end;

class function TEllipsoid.GetSphere: TEllipsoid;
begin
  Result := FromAAndF(6371000, 0.0);
end;

class function TEllipsoid.GetWGS72: TEllipsoid;
begin
  Result := FromAAndInverseF(6378135.0, 298.26);
end;

class function TEllipsoid.GetWGS84: TEllipsoid;
begin
  Result := FromAAndInverseF(6378137.0, 298.257223563);
end;

{ TGeodeticCalculator }

function TGeodeticCalculator.CalculateGeodeticCurve(ellipsoid: TEllipsoid; start, leend: TGlobalCoordinates): TGeodeticCurve;
var

     alo,
     blo,
     f,
     phi1,
     lambda1,
     phi2,
     lambda2,
     a2,
     b2,
     a2b2b2,
     omega,
     tanphi1,
     tanU1,
     U1,
     sinU1,
     cosU1,
     tanphi2,
     tanU2,
     U2,
     sinU2,
     cosU2,
     sinU1sinU2,
     cosU1sinU2,
     sinU1cosU2,
     cosU1cosU2,
     lambda,
     Aup,
     Bup,
     Cup,
     sigma,
     deltasigma,
     lambda0,
     sinlambda,
     coslambda,sin2sigma,
     sinsigma,
     cossigma,sinalpha,alpha ,cosalpha ,cos2alpha ,cos2sigmam  ,cos2sigmam2,change ,s
     :double;


       converged :boolean;
    alpha1,alpha2:TAngle;
  I: Integer;
  radians: double;


begin
   //
      // All equation numbers refer back to Vincenty's publication:
      // See http://www.ngs.noaa.gov/PUBS_LIB/inverse.pdf
      //

      // get constants
      alo := ellipsoid.SemiMajorAxis;
      blo := ellipsoid.SemiMinorAxis;
      f := ellipsoid.Flattening;

      // get parameters as radians
       phi1 := start.Latitude.Radians;
       lambda1 := start.Longitude.Radians;
       phi2 := leend.Latitude.Radians;
       lambda2 := leend.Longitude.Radians;

      // calculations
       a2 := alo * alo;
       b2 := blo * blo;
       a2b2b2 := (a2 - b2) / b2;

       omega := lambda2 - lambda1;

       tanphi1 := Tan(phi1);
       tanU1 := (1.0 - f) * tanphi1;
       U1 := ArcTan(tanU1);
       sinU1 := Sin(U1);
       cosU1 := Cos(U1);

       tanphi2 := Tan(phi2);
       tanU2 := (1.0 - f) * tanphi2;
       U2 := ArcTan(tanU2);
       sinU2 := Sin(U2);
       cosU2 := Cos(U2);

       sinU1sinU2 := sinU1 * sinU2;
       cosU1sinU2 := cosU1 * sinU2;
       sinU1cosU2 := sinU1 * cosU2;
       cosU1cosU2 := cosU1 * cosU2;

      // eq. 13
       lambda := omega;

      // intermediates we'll need to compute 's'
//       Aup := 0.0;
//       Bup := 0.0;
//       sigma := 0.0;
//       deltasigma := 0.0;

       converged := false;

       for I := 0 to 19 do begin



        lambda0 := lambda;

         sinlambda := Sin(lambda);
         coslambda := Cos(lambda);

        // eq. 14
         sin2sigma := (cosU2 * sinlambda * cosU2 * sinlambda) + Power(cosU1sinU2 - sinU1cosU2 * coslambda, 2.0);
         sinsigma := Sqrt(sin2sigma);

        // eq. 15
         cossigma := sinU1sinU2 + (cosU1cosU2 * coslambda);

        // eq. 16
        sigma := ArcTan2(sinsigma, cossigma);

        // eq. 17    Careful!  sin2sigma might be almost 0!
         sinalpha := ifthen((sin2sigma = 0) , 0.0 , cosU1cosU2 * sinlambda / sinsigma);
         alpha := Arcsin(sinalpha);
         cosalpha := Cos(alpha);
         cos2alpha := cosalpha * cosalpha;

        // eq. 18    Careful!  cos2alpha might be almost 0!
         cos2sigmam := ifthen(cos2alpha = 0.0 , 0.0 , cossigma - 2 * sinU1sinU2 / cos2alpha);
         u2 := cos2alpha * a2b2b2;

         cos2sigmam2 := cos2sigmam * cos2sigmam;

        // eq. 3
        Aup := 1.0 + u2 / 16384 * (4096 + u2 * (-768 + u2 * (320 - 175 * u2)));

        // eq. 4
        Bup := u2 / 1024 * (256 + u2 * (-128 + u2 * (74 - 47 * u2)));

        // eq. 6
        deltasigma := Bup * sinsigma * (cos2sigmam + Bup / 4 * (cossigma * (-1 + 2 * cos2sigmam2) - Bup / 6 * cos2sigmam * (-3 + 4 * sin2sigma) * (-3 + 4 * cos2sigmam2)));

        // eq. 10
         Cup := f / 16 * cos2alpha * (4 + f * (4 - 3 * cos2alpha));

        // eq. 11 (modified)
        lambda := omega + (1 - Cup) * f * sinalpha * (sigma + Cup * sinsigma * (cos2sigmam + Cup * cossigma * (-1 + 2 * cos2sigmam2)));

        // see how much improvement we got
        change := Abs((lambda - lambda0) / lambda);

        if ((i > 1) and (change < 0.0000000000001)) then begin

          converged := true;
          break;
        end;
       end;

      // eq. 19
      s := blo * Aup * (sigma - deltasigma);

      // didn't converge?  must be N/S
      if (not converged) then begin

        if (phi1 > phi2) then
        begin
          alpha1 := TAngle.Angle180;
          alpha2 := TAngle.Zero;
        end
        else if (phi1 < phi2) then
        begin
          alpha1 := TAngle.Zero;
          alpha2 := TAngle.Angle180;
        end
        else
        begin
          alpha1 :=  TAngle.Create(NaN);
          alpha2 := TAngle.Create(NaN);
        end
      end

      // else, it converged, so do the math
      else
      begin
//        double radians;

        alpha1 := TAngle.Create();
        alpha2 := TAngle.Create();

        // eq. 20
        radians := ArcTan2(cosU2 * Sin(lambda), (cosU1sinU2 - sinU1cosU2 * Cos(lambda)));
        if (radians < 0.0) then  radians :=radians + TwoPi;
        alpha1.Radians := radians;

        // eq. 21
        radians := Arctan2(cosU1 * Sin(lambda), (-sinU1cosU2 + cosU1sinU2 * Cos(lambda))) + PI;
        if (radians < 0.0) then radians := radians+ TwoPi;
        alpha2.Radians := radians;
      end;

      if (alpha1.degrees >= 360.0) then alpha1.degrees := alpha1.degrees- 360.0;
      if (alpha2.degrees >= 360.0) then alpha2.degrees := alpha2.degrees- 360.0;

      Result :=  TGeodeticCurve.Create(s, alpha1, alpha2);
end;

end.
