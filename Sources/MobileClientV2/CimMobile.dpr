program CimMobile;

uses
  {$IFDEF Win32}
//  madExcept,
//  madLinkDisAsm,
//  madListHardware,
//  madListProcesses,
//  madListModules,
  {$ENDIF }
  {$IFDEF Win64}
  madExcept,
  {$ENDIF }
  System.StartUpCopy,
  FMX.Forms,
  DataModuleU in 'DataModuleU.pas' {DataModule1: TDataModule},
  Cim.Types in 'Cim.Types.pas',
  CoordU in 'CoordU.pas',
  Geodesy.Angle in '..\GeodeticCalculator\Geodesy.Angle.pas',
  Geodesy.GeodeticCurve in '..\GeodeticCalculator\Geodesy.GeodeticCurve.pas',
  Geodesy.GlobalCoordinates in '..\GeodeticCalculator\Geodesy.GlobalCoordinates.pas',
  Geodesy in '..\GeodeticCalculator\Geodesy.pas',
  WelcomeForm in 'WelcomeForm.pas' {FormWelcome},
  MainFormU in 'MainFormU.pas' {MainForm},
  FilterFormU in 'FilterFormU.pas' {FormFilter},
  Cims.ClassesU in 'Cims.ClassesU.pas',
  StringStripU in 'StringStripU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormWelcome, FormWelcome);
  Application.RegisterFormFamily('LaWelcomeForm', [TFormWelcome]);
  Application.Run;
end.
