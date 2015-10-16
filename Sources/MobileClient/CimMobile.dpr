program CimMobile;





uses
  System.StartUpCopy,
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
  uPictureCls in 'uPictureCls.pas' {/{$IFDEF IOS},
  WelcomeForm in 'WelcomeForm.pas' {FormWelcome},
  SortForm in 'SortForm.pas' {FormSort},
//  AnonThread in 'C:\Users\Public\Documents\RAD Studio\12.0\Samples\Object Pascal\RTL\CrossPlatform Utils\AnonThread.pas',
  cimDetailControl in 'cimDetailControl.pas',
  mainformLogic in 'mainformLogic.pas',
  ShowCimLocations in 'ShowCimLocations.pas' {ShowCimLocationsForm},
  AsyncTask.HTTP in 'AsyncTask.HTTP.pas',
  AsyncTask in 'AsyncTask.pas';

{$IFDEF IOS}

//    {$I DPF.iOS.Defs.inc}
{$ENDIF}
{$R *.res}

//{$IFDEF IOS}
//  {$R *.ios.res}
//{$ENDIF}
//{$IFDEF ANDROID}
//  {$R *.android.res}
//{$ENDIF}
//{$IFDEF WIN32}
//   {$R *.win.res}
//{$ENDIF}

//var
//  CurrentStyle: TFmxObject;
//  lepath: string;

begin
//
//{$IFDEF MSWINDOWS}
//  CurrentStyle := TStyleManager.LoadFromResource(HInstance, 'Jet', RT_RCDATA);
//
//   if CurrentStyle <> nil then
//   begin
//     TStyleManager.SetStyle(CurrentStyle);
//   end;
//
//{$ENDIF}
//{$IFDEF Android}
//  CurrentStyle := TStyleManager.LoadFromResource(HInstance, 'Jet', RT_RCDATA);
//  if CurrentStyle <> nil then
//  begin
//    TStyleManager.SetStyle(CurrentStyle);
//  end;
//
//{$ENDIF}
//{$IFDEF iOS}
//  CurrentStyle := TStyleManager.LoadFromResource(HInstance, 'Jet', RT_RCDATA);
//  if CurrentStyle <> nil then
//  begin
//    TStyleManager.SetStyle(CurrentStyle);
//  end;
//
//{$ENDIF}



//  Application.Initialize;
//  Application.CreateForm(TdmMain, dmMain);
//  Application.CreateForm(TFormWelcome, FormWelcome);
//  {$IFDEF iOS}
//  Application.CreateForm(TFormShowLocationsMap, FormShowLocationsMap);
//   {$ENDIF}
//  Application.CreateForm(TformMainTablet, formMainTablet);
//  Application.CreateForm(TformMain, formMain);
//  Application.RegisterFormFamily('laMainForm', [TformMain, TformMainTablet]);



//  Application.Run;

  ////////////////////////////////////
  Application.Initialize;
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TFormWelcome, FormWelcome);
  // Application.RegisterFormFamily('laWelcomeForm', [TFormWelcome]);
//  Application.CreateForm(TFormShowLocationsMap, FormShowLocationsMap);


  Application.CreateForm(TformMain, formMain);
//  Application.CreateForm(TformMainTablet, formMainTablet);
//  Application.RegisterFormFamily('LaWelcomeForm', [TFormWelcome]);
  Application.Run;



end.

