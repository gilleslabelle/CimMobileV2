unit WelcomeForm;
// _______________________________________________________________ ZYMA __
// $HeadURL: svn://bitnami-redmine/_GL/trunk/Cimeti%C3%A8res/Sources/MobileClient/WelcomeForm.pas $
// .......................................................................
// Last committed    : $Revision:: 62               $
// Last changed by   : $Author:: labelleg           $
// Last changed date : $Date:: 2015-06-15 12:53:26 #$
// .......................................................................
// Copyright (c) ZYMA 2014
// _______________________________________________________________________

interface

uses
  FMX.Forms, FMX.Types, FMX.Layouts, FMX.StdCtrls, FMX.Objects, System.Classes,
  FMX.Controls, FMX.Controls.Presentation;

// uses
// System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
// FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
// FMX.StdCtrls, FMX.Objects;

type
  TFormWelcome = class(TForm)
    Label1: TLabel;
    Text1: TText;
    cmdStartModeBrowse: TButton;
    cmdStartModeGPS: TButton;
    Text2: TText;
    Layout1: TLayout;
    Timer1: TTimer;
    GridLayout1: TGridLayout;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure cmdStartModeBrowseClick(Sender: TObject);
    procedure cmdStartModeGPSClick(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }

//    function isModeTablet: Boolean;
  end;

var
  FormWelcome: TFormWelcome;

implementation

{$R *.fmx}

uses Mainform,  mMain;

// uses mMain, Mainform, MainformTablet;

procedure TFormWelcome.cmdStartModeBrowseClick(Sender: TObject);
begin
  Self.Visible := false;



//    if isModeTablet then begin
//      formMainTablet.UseDistance := false;
//      formMainTablet.Show;
//
//    end else begin
      formMain.UseDistance := false;
      formMain.Show;

//    end;


end;

procedure TFormWelcome.cmdStartModeGPSClick(Sender: TObject);
begin
  Self.Visible := false;

//  frm := Application.GetDeviceForm('laMainForm');

//  if isModeTablet then begin
//    formMainTablet.UseDistance := true;
//    formMainTablet.Show;
//
//  end else begin
    formMain.UseDistance := true;
    formMain.Show;

//  end;


//  if (frm = formMain) then
//  begin
//
//    formMain.UseDistance := true;
//    formMain.Show;
//
//  end
//  else if (frm = formMainTablet) then
//  begin
//
//    formMainTablet.UseDistance := true;
//    formMainTablet.Show;
//
//  end;

end;


//function TFormWelcome.isModeTablet : Boolean;
//var
////  ff: TFormFactor;
//  frm: TCommonCustomForm;
//begin
//
//  frm := Application.GetDeviceForm('laMainForm');
//
//  Result := False;
//
//  if (frm = formMain) then
//  begin
//
//  Result := False;
//
//  end
//  else if (frm = formMainTablet) then
//  begin
//
//  Result := True;
//
//  end;
//
//end;



//procedure TFormWelcome.GetMainFormFormFactor(ff: TFormFactor);
//begin
//  Application.GetDeviceForm('laMainForm', ff);
//end;

procedure TFormWelcome.FormCreate(Sender: TObject);
begin

  cmdStartModeGPS.Visible := false;
  if dmMain.isGPSEnabled then
  begin

    Timer1.Enabled := true;

  end;

end;

procedure TFormWelcome.Timer1Timer(Sender: TObject);
//var
//  ff: TFormFactor;
begin
  if dmMain.isGPPLocationValid then
  begin

    cmdStartModeGPS.Visible := true;

    Timer1.Enabled := false;

    Application.ProcessMessages;
  end;
end;


initialization





end.
