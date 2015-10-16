program GeodesyExample;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, Geodesy, Geodesy.GlobalCoordinates, Geodesy.Angle,Geodesy.GeodeticCurve;

  var
  geoCalc: TGeodeticCalculator;
   reference:TEllipsoid;
   lincolnMemorial : TGlobalCoordinates ;
    eiffelTower:    TGlobalCoordinates ;
geoCurve : TGeodeticCurve;
ellipseKilometers:double;
ellipseMiles:double;
   ang1,ang2 : Tangle;
begin
  try
    { TODO -oUser -cConsole Main : Insert code here }

    // instantiate the calculator
       geoCalc :=  TGeodeticCalculator.Create();

       // select a reference elllipsoid
      reference := TEllipsoid.WGS84;


      // set Lincoln Memorial coordinates
//      GlobalCoordinates lincolnMemorial;

      ang1 :=  TAngle.Create(38.88922);
      ang2 :=   TAngle.Create(-77.04978) ;
      lincolnMemorial :=  TGlobalCoordinates.Create(  ang1, ang2 );



      // set Eiffel Tower coordinates


      eiffelTower := TGlobalCoordinates.Create( TAngle.Create(48.85889), TAngle.Create(2.29583)     );

 // calculate the geodetic curve
       geoCurve := geoCalc.CalculateGeodeticCurve(reference, lincolnMemorial, eiffelTower);


       ellipseKilometers := geoCurve.EllipsoidalDistance / 1000.0;





  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
