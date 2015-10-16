unit PagedListBox;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListBox, FMX.ListView, System.Generics.Collections, System.SyncObjs;

type
  TframeLoadingMoreResults = class(TFrame)
    MainMessage: TLabel;
    AniIndicator1: TAniIndicator;
  private
    FOnPaint: TNotifyEvent;
    procedure SetOnPaint(const Value: TNotifyEvent);
  protected
    procedure Paint; override;
  public
    property OnPaint: TNotifyEvent read FOnPaint write SetOnPaint;
  end;

  TListBoxBottomLoadingItem = class(TListBoxItem)
  private
    FStartTheLoad: TNotifyEvent;
    procedure SetStartTheLoad(const Value: TNotifyEvent);
    procedure CreateInnerFrame;
    procedure CascadeRepaint(AOwner: TObject);
    procedure PerformDataReload;
  protected
    FFrame: TframeLoadingMoreResults;
    FHasNotified: boolean;
    FOwner: TComponent;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ChangeText(AText: string);
    procedure ClearState;
    property StartTheLoad: TNotifyEvent read FStartTheLoad write SetStartTheLoad;
  end;

  TPagedListBoxLoadItemInfo = class
  public
    Items: TList<TListBoxItem>;
    HasLoaded: boolean;
    PageNumber: integer;
    PageSize: integer;
    HasMore: boolean;
  end;

  TPagedListBoxLoadItemsLoad = procedure(Sender: TObject; Info: TPagedListBoxLoadItemInfo) of object;
  TPagedListBoxLoadException = procedure(Sender: TObject; AException: Exception) of object;

  TPagedListBoxLoadLocation = (llUnknown, llFromSource, llFromBackup);

  TPagedListBox = class(TListBox)
  private
    FOnDataLoaded: TPagedListBoxLoadItemsLoad;
    FLoadedFrom: TPagedListBoxLoadLocation;
    FPageNumber: integer;
    FPageSize: integer;
    FDoNextLoadTimer: TTimer;
    FOnDataFailedLoaded: TPagedListBoxLoadItemsLoad;
    FOnExceptionDuringLoad: TPagedListBoxLoadException;
    FClearOnDataFail: boolean;

    FOnLoadComplete: TNotifyEvent;

    FLock: TCriticalSection;

    procedure LoadNextPage(Sender: TObject);
    procedure SetOnDataFailedLoaded(const Value: TPagedListBoxLoadItemsLoad);
    procedure SetOnDataLoaded(const Value: TPagedListBoxLoadItemsLoad);
    procedure SetPageNumber(const Value: integer);
    procedure SetPageSize(const Value: integer);
    procedure LoadPage(APageNumber: integer);
    procedure AddItems(AItems: TList<TListBoxItem>);
    procedure CreateLoadingListBoxItem;
    procedure LoadNextPageFromTimer(Sender: TObject);
    procedure SetOnExceptionDuringLoad(const Value: TPagedListBoxLoadException);
    procedure SetClearOnDataFail(const Value: boolean);
    procedure SetOnLoadComplete(const Value: TNotifyEvent);
  protected
    FBottomItem, FLastItem: TListBoxBottomLoadingItem;
    property  OnClick;
    property  OnItemClick;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;
    property LoadedFrom: TPagedListBoxLoadLocation read FLoadedFrom;
    procedure AddLoadMore;
    procedure Start;
  published
    property PageSize: integer read FPageSize write SetPageSize;
    property PageNumber: integer read FPageNumber write SetPageNumber;
    property OnLoadSinglePage: TPagedListBoxLoadItemsLoad read FOnDataLoaded write SetOnDataLoaded;
    property OnDataFailedLoaded: TPagedListBoxLoadItemsLoad read FOnDataFailedLoaded write SetOnDataFailedLoaded;
    property OnExceptionDuringLoad: TPagedListBoxLoadException read FOnExceptionDuringLoad write SetOnExceptionDuringLoad;
    property ClearOnDataFail: boolean read FClearOnDataFail write SetClearOnDataFail;
    property OnLoadComplete: TNotifyEvent read FOnLoadComplete write SetOnLoadComplete;
  end;

procedure Register;

implementation

{$R *.fmx}

uses
  AnonThread;

procedure Register;
begin
  RegisterComponents('ZYMA Mobile', [TPagedListBox]);
end;

{ TBottomLoadingItem }

procedure TListBoxBottomLoadingItem.ChangeText(AText: string);
begin
  FFrame.MainMessage.Text := AText;
end;

procedure TListBoxBottomLoadingItem.ClearState;
begin
  FHasNotified := false;

  RemoveObject(FFrame);
  CreateInnerFrame;
end;

procedure TListBoxBottomLoadingItem.PerformDataReload;
begin
  if FHasNotified = false then
  begin
    if Assigned(StartTheLoad) then
    begin

      StartTheLoad(Self);
    end;
    FHasNotified := true;
  end;
end;

procedure TListBoxBottomLoadingItem.CreateInnerFrame;
begin
  FFrame := TframeLoadingMoreResults.Create(FOwner);
  FFrame.Name := '';
  FFrame.Parent := Self;

  FFrame.AniIndicator1.Enabled := True;

  FFrame.OnPaint := CascadeRepaint;

  Self.Height := FFrame.Height;
  FFrame.Align := TAlignLayout.alClient;
end;

procedure TListBoxBottomLoadingItem.CascadeRepaint(AOwner: TObject);
begin
  PerformDataReload;
end;

constructor TListBoxBottomLoadingItem.Create(AOwner: TComponent);
begin
  inherited;


  FOwner := AOwner;
  CreateInnerFrame;
end;

procedure TListBoxBottomLoadingItem.Paint;
begin
  inherited;

  PerformDataReload;
end;

procedure TListBoxBottomLoadingItem.SetStartTheLoad(const Value: TNotifyEvent);
begin
  FStartTheLoad := Value;
end;

{ TPagedListBox }

procedure TPagedListBox.AddItems(AItems: TList<TListBoxItem>);
var
  counter: integer;

begin

  Self.BeginUpdate;
  for counter := 0 to AItems.Count - 1 do begin
    AddObject(AItems[counter]);
  end;

  Self.EndUpdate;
end;

procedure TPagedListBox.AddLoadMore;
begin
  if FBottomItem <> nil then
  begin
    FBottomItem.ClearState;
    Self.BeginUpdate;
    Self.RemoveObject(FBottomItem);
    AddObject(FBottomItem);
    Self.EndUpdate;
  end;
end;

constructor TPagedListBox.Create(AOwner: TComponent);
begin
  inherited;

  FLock := TCriticalSection.Create();
  FDoNextLoadTimer := TTimer.Create(Self);
  FDoNextLoadTimer.Enabled := false;
  FDoNextLoadTimer.OnTimer := LoadNextPageFromTimer;
  FDoNextLoadTimer.Interval := 1;

  CreateLoadingListBoxItem;
end;

// We're loading it from a small timer. When the Paint Event fire's it is still
// within  the call to the object. If we were to free the loading TListBoxItem
// then we'll end up with a null reference. This works around it.
procedure TPagedListBox.LoadNextPageFromTimer(Sender: TObject);
begin
  LoadPage(PageNumber + 1);
end;

procedure TPagedListBox.LoadPage(APageNumber: integer);
var
  DidLoad: boolean;
begin
  FDoNextLoadTimer.Enabled := false;
  Self.PageNumber := APageNumber;

  TAnonymousThread<TPagedListBoxLoadItemInfo>.Create(
    function: TPagedListBoxLoadItemInfo
    var
      Info: TPagedListBoxLoadItemInfo;
    begin
      Info := TPagedListBoxLoadItemInfo.Create;
      Info.Items := TList<TListBoxItem>.Create;
      Info.HasLoaded := false;
      Info.PageSize := Self.PageSize;
      Info.PageNumber := Self.PageNumber;

      if Assigned(OnLoadSinglePage) then
      begin
        try

          OnLoadSinglePage(Self, Info);

          DidLoad := Info.HasLoaded;
          FLoadedFrom := llFromSource;
        except
          DidLoad := false;
        end;
      end;

      if not DidLoad then
      begin


        if Assigned(OnDataFailedLoaded) then
        begin
          try
            OnDataFailedLoaded(Self, Info);

            DidLoad := Info.HasLoaded;
            FLoadedFrom := llFromBackup;
          except
            DidLoad := false;
          end;
        end;
      end;

      Result := Info;
    end,

    procedure(AResult: TPagedListBoxLoadItemInfo)
    begin

      FLock.Acquire;
      Try

        if ClearOnDataFail and (FLoadedFrom = llFromBackup) then
        begin
          Items.Clear;
        end;

        AddItems(AResult.Items);

        if AResult.HasMore then
        begin
          RemoveObject(FBottomItem);
          CreateLoadingListBoxItem;

          AddLoadMore;

          FBottomItem.FHasNotified := false;
        end
        else
        begin
          FBottomItem.Free;
        end;

        if Assigned(OnLoadComplete) then
        begin
          OnLoadComplete(Self);
        end;
      Finally
        FLock.Release;

     end;
    end,
    procedure(AException: Exception)
    begin
      if Assigned(OnExceptionDuringLoad) then
      begin
        OnExceptionDuringLoad(Self, AException);
      end;
    end, false, true);

end;

procedure TPagedListBox.LoadNextPage(Sender: TObject);
begin
  FDoNextLoadTimer.Enabled := true;
end;

procedure TPagedListBox.SetClearOnDataFail(const Value: boolean);
begin
  FClearOnDataFail := Value;
end;

procedure TPagedListBox.SetOnDataFailedLoaded(const Value: TPagedListBoxLoadItemsLoad);
begin
  FOnDataFailedLoaded := Value;
end;

procedure TPagedListBox.SetOnDataLoaded(const Value: TPagedListBoxLoadItemsLoad);
begin
  FOnDataLoaded := Value;
end;

procedure TPagedListBox.SetOnExceptionDuringLoad(const Value: TPagedListBoxLoadException);
begin
  FOnExceptionDuringLoad := Value;
end;

procedure TPagedListBox.SetOnLoadComplete(const Value: TNotifyEvent);
begin
  FOnLoadComplete := Value;
end;

procedure TPagedListBox.SetPageNumber(const Value: integer);
begin
  FPageNumber := Value;
end;

procedure TPagedListBox.SetPageSize(const Value: integer);
begin
  FPageSize := Value;
end;

procedure TPagedListBox.Start;
begin

  Items.Clear;

  LoadPage(0);
end;

procedure TPagedListBox.CreateLoadingListBoxItem;
begin
  if FBottomItem <> nil then
  begin
    FLastItem := FBottomItem;
    FLastItem.Visible := false;
  end;

  FBottomItem := TListBoxBottomLoadingItem.Create(Self);
  FBottomItem.FFrame.Name := '';
  FBottomItem.StartTheLoad := LoadNextPage;
  FBottomItem.ClearState;
end;

destructor TPagedListBox.Destroy;
begin
  FLock.Free;

  inherited Destroy;
end;

{ TframeLoadingMoreResults }

procedure TframeLoadingMoreResults.Paint;
begin
  inherited;

  if Assigned(OnPaint) then
  begin
    OnPaint(Self);
  end;
end;

procedure TframeLoadingMoreResults.SetOnPaint(const Value: TNotifyEvent);
begin
  FOnPaint := Value;
end;

end.


