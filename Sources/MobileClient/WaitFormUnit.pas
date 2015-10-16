unit WaitFormUnit;
// _______________________________________________________________ ZYMA __
// $HeadURL: svn://bitnami-redmine/_GL/trunk/Cimeti%C3%A8res/Sources/MobileClient/WaitFormUnit.pas $
// .......................................................................
// Last committed    : $Revision:: 62               $
// Last changed by   : $Author:: labelleg           $
// Last changed date : $Date:: 2015-06-15 12:53:26 #$
// .......................................................................
// Copyright (c) ZYMA 2014
// _______________________________________________________________________

interface

uses
  FMX.Forms, FMX.StdCtrls, FMX.Controls, FMX.Objects, System.Classes, FMX.Types,
  System.SysUtils, FMX.Controls.Presentation;

//uses
//  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
//  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
//  FMX.Objects, FMX.Ani, FMX.Layouts;

type
  TWaitForm = class(TForm)
    // WorkingPanel: TRectangle;
    bgImage: TImage;
    // GrayBox: TRectangle;
    WorkingLBL: TLabel;
    AniIndicator: TAniIndicator;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FHadErrors: Boolean;
    procedure DoErrorHandling(E: Exception; AOnError: TProc<TWaitForm, Exception>);
    procedure DoOnCompleted(AOnComplete: TProc<TWaitForm>);
  protected
    function GetTitle: string; virtual;
    procedure SetTitle(const Value: string); virtual;
  public
    { Public declarations }

    procedure Run(ATask: TProc<TWaitForm>; AOnComplete: TProc<TWaitForm> = nil; AOnError: TProc<TWaitForm, Exception> = nil); virtual;

    { ATask: main task to be executed in a background thread
      AOnComplete: optional procedure to be executed after ATask completion
      and with main thread synchronization (i.e. to access GUI elements) }
    constructor CreateAndRun(ATitle: string; ATask: TProc<TWaitForm>; AOnComplete: TProc<TWaitForm> = nil;
      AOnError: TProc<TWaitForm, Exception> = nil); virtual;

    property HadErrors: Boolean read FHadErrors;
    property Title: string read GetTitle write SetTitle;
  end;

implementation

{$R *.fmx}

uses Mainform;

//uses Mainform;

procedure TWaitForm.DoErrorHandling(E: Exception; AOnError: TProc<TWaitForm, Exception>);
begin
  TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      FHadErrors := True;
      if Assigned(AOnError) then
        AOnError(Self, E);
    end);
end;

procedure TWaitForm.DoOnCompleted(AOnComplete: TProc<TWaitForm>);
begin
  TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      AniIndicator.Enabled := false;
      Close;
      if Assigned(AOnComplete) then
        AOnComplete(Self);
    end);
end;

procedure TWaitForm.FormCreate(Sender: TObject);
begin
{$IFDEF IOS}
  bgImage.Visible := false;
{$ENDIF}
end;

function TWaitForm.GetTitle: string;
var
  LTitle: string;
begin
  TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      LTitle := WorkingLBL.Text;
    end);

  Result := LTitle;
end;

procedure TWaitForm.Run(ATask, AOnComplete: TProc<TWaitForm>; AOnError: TProc<TWaitForm, Exception>);
begin

{$IFDEF IOS}
  Self.bgImage.Visible := false;
{$ENDIF}

  // TODO: Corriger pour Android !
{$IFDEF ANDROID}
  Self.bgImage.Bitmap.Assign(formMain.TabControl1.MakeScreenshot);
{$ENDIF}
  application.ProcessMessages;

  Show;

  AniIndicator.Enabled := True;



  // WaitAnimation.Start;

  TThread.CreateAnonymousThread(
    procedure
    begin
      try
        FHadErrors := false;
        ATask(Self);
      except
        on E: Exception do
          DoErrorHandling(E, AOnError);
      end;

      DoOnCompleted(AOnComplete);
{$IFDEF ANDROID}
      bgImage.Bitmap.Assign(nil);
{$ENDIF}
    end).Start;
end;

constructor TWaitForm.CreateAndRun(ATitle: string; ATask: TProc<TWaitForm>; AOnComplete: TProc<TWaitForm>; AOnError: TProc<TWaitForm, Exception>);
begin
  inherited Create(nil);

  application.ProcessMessages;

{$IFDEF IOS}
  Self.bgImage.Visible := false;
{$ENDIF}
  application.ProcessMessages;
  SetTitle(ATitle);

  Run(ATask, AOnComplete, AOnError);

end;

procedure TWaitForm.SetTitle(const Value: string);
begin
  TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      WorkingLBL.Text := Value;
    end);
end;

end.
