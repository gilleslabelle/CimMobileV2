unit uImageLoader;
// _______________________________________________________________ ZYMA __
// $HeadURL: svn://bitnami-redmine/_GL/trunk/Cimeti%C3%A8res/Sources/MobileClient/uImageLoader.pas $
// .......................................................................
// Last committed    : $Revision:: 52               $
// Last changed by   : $Author:: labelleg           $
// Last changed date : $Date:: 2014-07-03 13:53:57 #$
// .......................................................................
// Copyright (c) ZYMA 2014
// _______________________________________________________________________



interface

uses SysUtils, Classes, System.Generics.Collections,
   FMX.Types, FMX.Objects, FMX.Controls, AsyncTask, AsyncTask.HTTP, FMX.Graphics,FMX.MultiResBitmap ;

type
  TLoadQueueItem = record
    ImageURL: String;
    Image: TImage;
  end;
  TLoadQueue = TList<TLoadQueueItem>;

  TImageLoader = class(TObject)
  private
    fQueue: TLoadQueue;
    fWorker: TTimer;
    fActiveItem: TLoadQueueItem;
    fIsWorking: Boolean;
    procedure QueueWorkerOnTimer(ASender: TObject);
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadImage(AImage: TImage; AImageURL: string);
    property ActiveItem: TLoadQueueItem read fActiveItem;
    property IsWorking: Boolean read fIsWorking;
  end;

var
  DefaultImageLoader: TImageLoader;

implementation

var
  FCachedImages: TObjectDictionary<String, TBitmap>;
{ TImageLoader }

constructor TImageLoader.Create;
begin
  inherited Create;
  fQueue := TLoadQueue.Create;
  fIsWorking := False;
  fWorker := TTimer.Create(nil);
  fWorker.Enabled := False;
  fWorker.Interval := 100;
  fWorker.OnTimer := QueueWorkerOnTimer;
  fWorker.Enabled := True;
end;

destructor TImageLoader.Destroy;
begin
  fWorker.Free;
  fQueue.Free;
  inherited;
end;

procedure TImageLoader.LoadImage(AImage: TImage; AImageURL: string);
var
  item: TLoadQueueItem;
begin
  item.ImageURL := AImageURL;
  item.Image := AImage;
  fQueue.Add(item);
end;

procedure TImageLoader.QueueWorkerOnTimer(ASender: TObject);
var
  lBitmap: TBitmap;
begin
  fWorker.Enabled := False;
  if (fQueue.Count > 0) and (not fIsWorking) then
  begin
    fIsWorking := True;
    fActiveItem := fQueue[0];
    fQueue.Delete(0);
    lBitmap := nil;
    if FCachedImages.TryGetValue(fActiveItem.ImageURL, lBitmap) and (lBitmap <> nil) then
    begin
      fActiveItem.Image.Bitmap.Assign(lBitmap);
      fIsWorking := False;
    end else
    begin
      AsyncTask.Run(
        THttpAsyncTaskBitmap.Create(fActiveItem.ImageURL),
        // Finished
        procedure (ATask: IAsyncTask)
        var
          fBitmap: TBitmap;
        begin
          lBitmap := TBitmap.Create(0, 0);
          fBitmap := (ATask as IHttpBitmapResponse).Bitmap;
          if fBitmap <> nil then
          begin
            lBitmap.Assign(fBitmap);
            FCachedImages.AddOrSetValue(fActiveItem.ImageURL, lBitmap);
            fActiveItem.Image.Bitmap.Assign(lBitmap);

          end;

          fIsWorking := False;
        end
      );
    end;

  end;
  fWorker.Enabled := True;
end;

initialization
  FCachedImages := TObjectDictionary<String, TBitmap>.Create([], 10);
  DefaultImageLoader := TImageLoader.Create;

finalization
  FCachedImages.Free;
  DefaultImageLoader.Free;


end.

