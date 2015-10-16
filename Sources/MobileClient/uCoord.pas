unit uCoord;
// _______________________________________________________________ ZYMA __
// $HeadURL: https://vmsubversion2.zymasoft.local/svn/_GL/trunk/Cimeti%C3%A8res/Sources/MobileClient/uCoord.pas $
// .......................................................................
// Last committed    : $Revision:: 45               $
// Last changed by   : $Author:: Builder            $
// Last changed date : $Date:: 2014-04-11 12:20:31 #$
// .......................................................................
// Copyright (c) ZYMA 2014
// _______________________________________________________________________



// ========================================================================
// Coord_Incl.asp
// ========================================================================
// Version date: 09/10/2013
// Author: Daniel Labelle
// Web: www.leslabelle.com
// ........................................................................
// Various routines for coordinates handling
// ........................................................................
// SUBROUTINES:
// Conv_Dec2DMS(): Coordinate conversion from Decimal to DMS formats (function)
// ValidateDecimalLatitude(): Validate decimal latitude value (function)
// ValidateDecimalLongitude(): Validate decimal longitude value (function)
// ........................................................................

interface

//uses
//  System.StrUtils, System.Character;

const
  Type1: string = 'gil';

  // Types of coordinates
Const
  Type_Latitude: integer = 1; // as byte

Const
  Type_Longitude: integer = 2; // as byte

const
  MinutesSymbol: char = #39;

const
  SecondsSymbol: char = #34; // = '&quot;'

const
  DegresSymbol: char = #176; // = '&quot;'

function ValidateDecimalLatitude(dblLatitude: double): Boolean;
function ValidateDecimalLongitude(dblLongitude: double): Boolean;
function Conv_Dec2DMS(Coordinate: double; CoordType: integer): string;
function DistanceInKm(plong1, plat1, plong2, plat2: double): double;
function DistanceInKm2(plong1, plat1, plong2, plat2: double): double;

implementation


uses
  System.SysUtils,  System.Math, Geodesy.GlobalCoordinates, Geodesy.Angle,System.StrUtils,
  Geodesy, Geodesy.GeodeticCurve;
//  Geodesy, Geodesy.GeodeticCurve;

// SecondsSymbol = Chr(34)
//
// --------------------------------------------------------------------
// Conv_Dec2DMS: Coordinate conversion from Decimal to DMS formats
// --------------------------------------------------------------------
// IN: CoordType = Latitude or Longitude [Byte]
// Coordinate = Decimal coordinate to convert [Double] (±DDD.dddddd)
// OUT: Conv_Dec2DMS = Converted DMS coordinate [String]
// (ZDD°MM//SS.sss'|ZDDD°MM//SS.sss')
// (Z= N|S for Latitude / E|W for Longitude)
// ErrorCode = 0-OK / >0-Error
// ....................................................................
function Conv_Dec2DMS(Coordinate: double; CoordType: integer): string;
var
  //
  i: integer; // as Integer
  strTemp: string; // As String
  strCoordinate: string; // As String
  dblZone: double; // As Double
//  dblCoord: double; // As Double
  strZone: string; // As String * 1
  PtPos: integer; // As Integer
  CoordValue: double; // As Double
  intNbMin: integer; // As Integer
  sglNbSec: single; // As Single
  strNbSec: string; // As String
  dblTmpVal: double; // As Double
  strDecodeCoord: string;
  ErrorCode: integer; // As String
  decSep: string;
begin

  Result := '';
  strCoordinate := UpperCase(Trim(floattostr(Coordinate)));
  dblZone := 1;
  strZone := '';
  ErrorCode := 0;
  //

  decSep := '' + FormatSettings.DecimalSeparator + '';
  // Select coordinate type
  Case CoordType of

    1:
      begin // Type_Latitude
        // -----------
        // Latitude
        // -----------
        // Check for valid latitude value
        if Not(ValidateDecimalLatitude(Coordinate)) then
        begin
          exit;
        end;
        // Extract zone information
        strTemp := LeftStr(strCoordinate, 1);
        if (strTemp = '+') then
        begin
          dblZone := 1;
          strZone := 'N';
          strCoordinate := MidStr(strCoordinate, 2, 999);
        end
        else if (strTemp = '-') then
        begin
          dblZone := -1;
          strZone := 'S';
          strCoordinate := MidStr(strCoordinate, 2, 999)
        end
        else
        begin
          dblZone := 1;
          strZone := 'N';
        end;
        //
        strCoordinate := '0' + strCoordinate;
        CoordValue := StrToFloat(strCoordinate);
        strCoordinate := FormatFloat('0.00000', CoordValue);

        // (  strCoordinate := FormatNumber(CoordValue,5,-1,0,0)
        // Pad
        PtPos := Pos(FormatSettings.DecimalSeparator, strCoordinate);
        If (PtPos = 0) Then
        begin
          strCoordinate := strCoordinate + '.0';
        end;
        PtPos := Pos(FormatSettings.DecimalSeparator, strCoordinate);
        // Pad left
        Case PtPos of
          1:
            strCoordinate := '00' + strCoordinate;
          2:
            strCoordinate := '0' + strCoordinate;
        End;
        // Pad right
        strCoordinate := LeftStr(strCoordinate + '00000000', 8);
        // Format output
        dblTmpVal := StrToFloat('0' + MidStr(strCoordinate, 3, 999));
        dblTmpVal := dblTmpVal * 60.00000;
        intNbMin := Trunc(dblTmpVal);
        dblTmpVal := (dblTmpVal - intNbMin) * 60.0000;
        sglNbSec := dblTmpVal;
        // strNbSec := FormatNumber(sglNbSec,3,-1,0,0);

        strNbSec := FormatFloat('0.000', sglNbSec);
        strNbSec := Trim(strNbSec);
        // Pad left 0 in seconds string
        i := Pos(FormatSettings.DecimalSeparator, strNbSec);
        Case i of
          1:
            strNbSec := '00' + strNbSec;
          2:
            strNbSec := '0' + strNbSec;
        end;
        //
        strDecodeCoord := strZone + LeftStr(strCoordinate, 2) + DegresSymbol;
        strDecodeCoord := strDecodeCoord + RightStr('00' + Trim(IntToStr(intNbMin)), 2) + MinutesSymbol;
        //
        strDecodeCoord := strDecodeCoord + Trim(strNbSec);
        If (RightStr(strDecodeCoord, 1) = '0') Then
        begin
          strDecodeCoord := LeftStr(strDecodeCoord, Length(strDecodeCoord) - 1);
        end;
        If (RightStr(strDecodeCoord, 1) = '0') Then
        begin
          strDecodeCoord := LeftStr(strDecodeCoord, Length(strDecodeCoord) - 1);
        end;
        If (RightStr(strDecodeCoord, 1) = '0') Then
        begin
          strDecodeCoord := LeftStr(strDecodeCoord, Length(strDecodeCoord) - 1);
        end;
        If (RightStr(strDecodeCoord, 1) = FormatSettings.DecimalSeparator) Then
        begin
          strDecodeCoord := LeftStr(strDecodeCoord, Length(strDecodeCoord) - 1);
        end;
        strDecodeCoord := strDecodeCoord + SecondsSymbol;
        //
        Conv_Dec2DMS := Trim(strDecodeCoord);
      end;
    2:
      begin // Type_Longitude
        // -----------
        // Longitude
        // -----------
        // Check if valid longitude value
        if Not(ValidateDecimalLongitude(Coordinate)) then
        begin
          exit;
        end;
        // Extract zone information
        strTemp := LeftStr(strCoordinate, 1);
        if (strTemp = '+') then
        begin
          dblZone := 1;
          strZone := 'E';
          strCoordinate := MidStr(strCoordinate, 2, 999);
        end
        else if (strTemp = '-') then
        begin
          dblZone := -1;
          strZone := 'W';
          strCoordinate := MidStr(strCoordinate, 2, 999);
        end
        else
        begin
          dblZone := 1;
          strZone := 'E';
        end;
        //
        strCoordinate := '0' + strCoordinate;
        CoordValue := StrToFloat(strCoordinate);
        // strCoordinate := FormatNumber(CoordValue,5,-1,0,0);
        strCoordinate := FormatFloat('0.00000', CoordValue);

        // Pad
        PtPos := Pos(FormatSettings.DecimalSeparator, strCoordinate);
        if (PtPos = 0) then
        begin
          strCoordinate := strCoordinate + '.0';
        end;
        PtPos := Pos(FormatSettings.DecimalSeparator, strCoordinate);
        // Pad left
        Case PtPos of
          1:
            begin
              strCoordinate := '000' + strCoordinate;
            end;
          2:
            begin
              strCoordinate := '00' + strCoordinate;
            end;
          3:
            begin
              strCoordinate := '0' + strCoordinate;
            end;
        End;
        // Pad right
        strCoordinate := LeftStr(strCoordinate + '000000000', 9);
        // Format output
        dblTmpVal := StrToFloat('0' + MidStr(strCoordinate, 4, 999));
        dblTmpVal := dblTmpVal * 60.00000;
        intNbMin := Trunc(dblTmpVal);
        dblTmpVal := (dblTmpVal - intNbMin) * 60.00000;
        sglNbSec := dblTmpVal;
        // strNbSec := FormatNumber(sglNbSec,3,-1,0,0);
        strNbSec := FormatFloat('0.000', sglNbSec);
        strNbSec := Trim(strNbSec);
        i := Pos(FormatSettings.DecimalSeparator, strNbSec);
        Case i of
          1:
            strNbSec := '00' + strNbSec;
          2:
            strNbSec := '0' + strNbSec;
        end;
        //
        strDecodeCoord := strZone + LeftStr(strCoordinate, 3) + DegresSymbol;
        strDecodeCoord := strDecodeCoord + RightStr('00' + Trim(IntToStr(intNbMin)), 2) + MinutesSymbol;
        strDecodeCoord := strDecodeCoord + Trim(strNbSec);
        //
        if (RightStr(strDecodeCoord, 1) = '0') then
        begin
          strDecodeCoord := LeftStr(strDecodeCoord, Length(strDecodeCoord) - 1);
        end;
        if (RightStr(strDecodeCoord, 1) = '0') then
        begin
          strDecodeCoord := LeftStr(strDecodeCoord, Length(strDecodeCoord) - 1);
        end;
        if (RightStr(strDecodeCoord, 1) = '0') then
        begin
          strDecodeCoord := LeftStr(strDecodeCoord, Length(strDecodeCoord) - 1);
        end;
        if (RightStr(strDecodeCoord, 1) = FormatSettings.DecimalSeparator) then
        begin
          strDecodeCoord := LeftStr(strDecodeCoord, Length(strDecodeCoord) - 1);
        end;
        strDecodeCoord := strDecodeCoord + SecondsSymbol;
        //
        Result := Trim(strDecodeCoord)
      end;
  Else
    begin
      ErrorCode := 12 // Invalid coordinate type
      // Exit;
    end;

  End;
  //
End;

//
// --------------------------------------------------------------------
// ValidateDecimalLatitude: Validate decimal latitude value
// --------------------------------------------------------------------
// IN: Latitude = Decimal latitude [Double]
// OUT: ValidateDecimalLatitude = True|False [Boolean]
// ....................................................................
function ValidateDecimalLatitude(dblLatitude: double): Boolean;
begin
  //
  Result := False;
  // Check if valid numeric value
  // if Not (IsNumber(  dblLatitude)) then begin
  // // Invalid decimal latitude
  // exit;
  // end;
  // Check if valid range
  if ((dblLatitude < -90.0) Or (dblLatitude > 90.0)) then
  begin
    // Invalid decimal latitude
    exit;
  end;
  Result := True;
  //
end;

//
// --------------------------------------------------------------------
// ValidateDecimalLongitude: Validate decimal longitude value
// --------------------------------------------------------------------
// IN: Latitude = Longitude = Decimal longitude [Double]
// OUT: ValidateDecimalLongitude = True|False [Boolean]
// ....................................................................
function ValidateDecimalLongitude(dblLongitude: double): Boolean;
begin
  //
  Result := False;
  // Check if valid numeric value
  // if Not (IsNumeric(dblLongitude)) then begin
  // // Invalid decimal longitude
  // exit;
  // end;
  // Check if valid range
  if ((dblLongitude < -180.0) Or (dblLongitude > 180.0)) then
  begin
    // Invalid decimal longitude
    exit;
  end;
  Result := True;
  //
end;

function DistanceInKm(plong1, plat1, plong2, plat2: double): double;
const
  R = 6367.5;
var

  dLat, dLon,

    a, c: double;

begin

  dLat := DegToRad(plat2 - plat1);
  dLon := DegToRad(plong2 - plong1);
  plat1 := DegToRad(plat1);
  plat2 := DegToRad(plat2);

  a := sin(dLat / 2) * sin(dLat / 2) + sin(dLon / 2) * sin(dLon / 2) * cos(plat1) * cos(plat2);
  c := 2 * ArcTan2(sqrt(a), sqrt(1 - a));
  Result := R * c;

end;

function DistanceInKm2(plong1, plat1, plong2, plat2: double): double;
var
  Positition1, Positition2: TGlobalCoordinates;

  geoCalc: TGeodeticCalculator;
  reference: TEllipsoid;
  geoCurve: TGeodeticCurve;
//  ellipseKilometers: double;
//  ellipseMiles: double;
//  ang1, ang2: Tangle;
begin

  geoCalc := TGeodeticCalculator.Create();

  // select a reference elllipsoid
  reference := TEllipsoid.WGS84;

  Positition1 := TGlobalCoordinates.Create(Tangle.Create(plat1), Tangle.Create(plong1));
  Positition2 := TGlobalCoordinates.Create(Tangle.Create(plat2), Tangle.Create(plong2));

  geoCurve := geoCalc.CalculateGeodeticCurve(reference, Positition1, Positition2);

  Result := geoCurve.EllipsoidalDistance / 1000.0;
end;

end.

