program CimMobileTest;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  mMain in 'mMain.pas' {dmMain: TDataModule},
  uCoord in 'uCoord.pas',
  Geodesy in '..\GeodeticCalculator\Geodesy.pas',
  Geodesy.GlobalCoordinates in '..\GeodeticCalculator\Geodesy.GlobalCoordinates.pas',
  Geodesy.Angle in '..\GeodeticCalculator\Geodesy.Angle.pas',
  Geodesy.GeodeticCurve in '..\GeodeticCalculator\Geodesy.GeodeticCurve.pas',
  Mainform in 'Mainform.pas' {formMain},
  uFilter in 'uFilter.pas' {FormFilter},
  System.Types {WorkingForm},
  WaitFormUnit in 'WaitFormUnit.pas' {WaitForm},
  uImageLoader in 'uImageLoader.pas',
  uPictureCls in 'uPictureCls.pas',
  WelcomeForm in 'WelcomeForm.pas' {FormWelcome},
  SortForm in 'SortForm.pas' {FormSort},
  ShowLocationsMap_iOS in 'ShowLocationsMap_iOS.pas' {FormShowLocationsMap},
  AnonThread in 'C:\Users\Public\Documents\RAD Studio\12.0\Samples\Object Pascal\RTL\CrossPlatform Utils\AnonThread.pas',
  cimDetailControl in 'cimDetailControl.pas',
  MainformTablet in 'MainformTablet.pas' {formMainTablet},
  mainformLogic in 'mainformLogic.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Run;
end.
