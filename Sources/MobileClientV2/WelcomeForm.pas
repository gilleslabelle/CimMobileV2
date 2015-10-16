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

{$IFDEF Win32}
//  codesitelogging,

{$ENDIF}
{$IFDEF Win64}
//  codesitelogging,

{$ENDIF}
  FMX.Controls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, System.Actions, FMX.ActnList;

type
  TFormWelcome = class(TForm)
    lblTitle: TLabel;
    Text1: TLabel;
    cmdStartModeBrowse: TButton;
    Layout1: TLayout;
    GridLayout1: TGridLayout;
    ActionList1: TActionList;
    procedure FormCreate(Sender: TObject);
    procedure cmdStartModeBrowseClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  strict private
    FIsFormActivated: Boolean;
  private
    procedure DoInitialization;
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FormWelcome: TFormWelcome;

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}
{$R *.iPad.fmx IOS}
{$R *.iPhone4in.fmx IOS}

uses DataModuleU, System.SysUtils, MainFormU, FilterFormU;

procedure TFormWelcome.cmdStartModeBrowseClick(Sender: TObject);
begin
  Self.Visible := false;

  // MainForm.UseDistance := false;
  MainForm.Show;

end;

procedure TFormWelcome.DoInitialization;
begin

  DataModule1 := TDataModule1.Create(Self);


  DataModule1.OpenDatabase;

  Application.ProcessMessages;

  FormFilter:= TFormFilter.Create(Self);

  MainForm := TMainForm.Create(Self);

  cmdStartModeBrowse.Visible := true;
  cmdStartModeBrowse.Enabled := true;

end;

procedure TFormWelcome.FormActivate(Sender: TObject);
begin

  if not FIsFormActivated then
  begin
    FIsFormActivated := true;
    DoInitialization;
  end;

end;

procedure TFormWelcome.FormCreate(Sender: TObject);
begin

  FIsFormActivated := false;

  cmdStartModeBrowse.Visible := false;

{$IFDEF Win32}
  Self.Caption := lblTitle.Text;

{$ENDIF}
{$IFDEF Win64}
  Self.Caption := lblTitle.Text;
{$ENDIF}
end;

initialization

end.
