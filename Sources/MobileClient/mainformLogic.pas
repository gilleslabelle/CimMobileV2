unit mainformLogic;

interface

uses
  System.Classes, FMX.Layouts, uPictureCls, FMX.Types, FMX.WebBrowser;

// uses
// System.Classes, FMX.Layouts, uPictureCls, FMX.Types, FMX.WebBrowser;

type
  TAfficheBigImage = TNotifyEvent;

  /// <summary>
  /// Affiche l'application de map selon le type de tablette
  /// </summary>
  /// <param name="Lat">
  /// Latitude
  /// </param>
  /// <param name="Long">
  /// Longtitude
  /// </param>
  /// <param name="NomCim">
  /// Nom du cimetière
  /// </param>
procedure AfficheCarteDirection(Lat, Long: double; NomCim: string);
procedure loadCimImages(cimId: integer; hsbCimDetailImages: TVertScrollBox;
  CimImagesColl: TCimImageCollection; clickEvent: TAfficheBigImage);
procedure ClearScrollBox(fmxParent: TFmxObject);
procedure AfficheCarteGoogle(var wb: TWebBrowser; Lat, Long: double;
  NomCim: string);
procedure ShowImage_iOS(index: integer; CimImagesColl: TCimImageCollection);

Const
  ApproxPositionLevel: integer = 3; // ' Trigger for approximate position level
  PrecisionLevel_1_Fr: string = 'Position précise: ±2.0 Mètres (±6.8 Pieds)';
  PrecisionLevel_2_Fr: string = 'Position approchée: ±100 Mètres (±328 Pieds)';
  PrecisionLevel_3_Fr: string = 'Position mentionnée: ±1 Km (±0.6 Mille)';
  PrecisionLevel_4_Fr: string = 'Position imprécise: >1 Km (0.6 Mille)';
  CF_MeterToFeet = 3.28083;
  CF_SQMeterToSQFeet = 10.76391;
  Col_HighRange = 5;

  sDist = 'DistObj';
  GoogleAPIKey = 'AIzaSyAMUNKeqoy6KE-ZAdGZkAs9udaeG2S-Inw';

  // MapboxKey = 'examples.map-zr0njcqy';
  MapboxKey = 'gilleslabelle.ho54gpgo';

implementation

uses
  // {$IFDEF iOS}
  // iOSapi.UIKit,
  // iOSapi.Foundation,
  // ImagesForm_iOS,
  // {$ENDIF}
  System.SysUtils, Data.DB, FMX.StdCtrls, //AnonThread,
  mMain, cimDetailControl, FMX.Objects, System.IOUtils,
{$IFDEF Win32}
  ShellApi,
  Winapi.Windows,
{$ENDIF}
{$IFDEF ANDROID}
  FMX.Platform.Android, FMX.Helpers.Android, idURi, Androidapi.Jni.Net,
  Androidapi.Jni.JavaTypes, Androidapi.Jni.GraphicsContentViewText,
  // FMX.Helpers.Android, Androidapi.Jni.GraphicsContentViewText,
  // Androidapi.Jni.Net, Androidapi.Jni.JavaTypes,
  // idURi,
{$ENDIF}
  System.UITypes, FMX.Dialogs, FMX.Maps;

procedure AfficheCarteDirection(Lat, Long: double; NomCim: string);
var
  // lepath : string;
  // bit: TBitmap;
{$IFDEF iOS}
  // UIApp: UIApplication;
{$ENDIF}
{$IFDEF ANDROID}
  // Intent: JIntent;
{$ENDIF}
  s, sLat, sLong: string;
  // URLString: string;
begin

  // Show Map using Google Maps
  // URLString := Format(
  // 'https://maps.google.com/maps?q=%s,%s&output=embed',
  // [Format('%2.6f', [Lat]), Format('%2.6f', [Long])]);
  // WebBrowser1.Navigate(URLString);
  //
  sLat := Format('%8.6f', [Lat]);
  sLat := StringReplace(sLat, ',', '.', [rfReplaceAll, rfIgnoreCase]);
  sLong := Format('%8.6f', [Long]);
  sLong := StringReplace(sLong, ',', '.', [rfReplaceAll, rfIgnoreCase]);
  // s:= Format('http://maps.google.com/maps?q=%s,%s',[sLat,sLong]);
  s := Format('http://maps.apple.com/?q=%s,%s', [sLat, sLong]);
{$IFDEF Win32}
  shellexecute(0, 'open', pchar(s), nil, nil, SW_SHOWNORMAL)
{$ENDIF}
{$IFDEF iOS}
  // UIApp := TUIApplication.Wrap(TUIApplication.OCClass.sharedApplication);
  // UIApp.openURL(TNSURL.Wrap(TNSURL.OCClass.URLWithString
  // (NSSTR(pchar(String(s))))));
{$ENDIF}
{$IFDEF Android}
    s := Format('geo://0,0?q=%s,%s(%s)', [sLat, sLong, NomCim]);
  try
    // Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW, TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(s))));
    // SharedActivity.startActivity(Intent);

    SharedActivity.startActivity
      (TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
      TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(s)))));

  except
    on E: Exception do
      ShowMessage(E.Message);
  end;

{$ENDIF}
end;

procedure loadCimImages(cimId: integer; hsbCimDetailImages: TVertScrollBox;
  CimImagesColl: TCimImageCollection; clickEvent: TAfficheBigImage);
var
  // ds: TDataSet;
  img: TImage;
  // I: integer;
  cImage: TCimImage;
begin

  // ClearScrollBox(hsbCimDetailImages);

  // dmMain.LoadAllImageForCimID(cimId, CimImagesColl);


  // for cImage in CimImagesColl do
  // begin
  //
  // img := cImage.image;
  //
  // img.Parent := hsbCimDetailImages;
  //
  // img.Height := hsbCimDetailImages.Height/2;
  // img.Width := img.Height ;
  // img.WrapMode := TImageWrapMode.iwFit;
  // img.Align := TAlignLayout.alLeft;
  //
  //
  // hsbCimDetailImages.AddObject(img);
  //
  // img.OnClick := clickEvent;
  //
  //
  // end;

  dmMain.LoadAllImageForCimID(cimId, CimImagesColl);

  for cImage in CimImagesColl do
  begin

    img := cImage.image;

    img.Parent := hsbCimDetailImages;

    // img.Height := hsbCimDetailImages.Height;
    img.Width := hsbCimDetailImages.Width;
    img.Height := cImage.OriHeight;
    img.WrapMode := TImageWrapMode.Fit;
    img.Align := TAlignLayout.Top;

    img.Margins.Top := 5;

    hsbCimDetailImages.AddObject(img);

    img.OnClick := clickEvent;

  end;

  // TAnonymousThread<TDataSet>.Create(
  // function: TDataSet
  // begin
  //
  // dmMain.LoadAllImageForCimID(cimId, CimImagesColl);
  //
  // end,
  // procedure(AResult: TDataSet)
  //
  // var
  // picCaption: string;
  // cImage: TCimImage;
  // begin
  //
  // for cImage in CimImagesColl do
  // begin
  //
  // img := cImage.image;
  //
  // img.Parent := hsbCimDetailImages;
  //
  /// /        img.Height := hsbCimDetailImages.Height*2;
  /// /        img.Width := img.Height ;
  // img.WrapMode := TImageWrapMode.iwFit;
  // img.Align := TAlignLayout.alLeft;
  //
  //
  // hsbCimDetailImages.AddObject(img);
  //
  // img.OnClick := clickEvent;
  //
  //
  // end;
  //
  // end,
  // procedure(AException: Exception)
  // begin
  // raise Exception.Create('Error Message' + AException.Message);
  // end, false, true);
  //
end;

procedure ClearScrollBox(fmxParent: TFmxObject);
var
  I: integer;
  FMX: TFmxObject;
begin

  for I := fmxParent.ChildrenCount - 1 downto 0 do
  begin

    FMX := fmxParent.Children[I];

    if (FMX is TImageControl) or (FMX is TWebBrowser) or (FMX is TCimDetailCtl)
      or (FMX is TImage) then
    begin

      fmxParent.RemoveObject(FMX);
      FMX.Free;
    end
    else
    begin
      ClearScrollBox(FMX);
    end;

    if FMX is TWebBrowser then
    begin

    end;

    if FMX is TMapView then
    begin
      fmxParent.RemoveObject(FMX);
      FMX.Free;

    end;


  end;

end;

procedure AfficheCarteGoogle(var wb: TWebBrowser; Lat, Long: double;
  NomCim: string);
var
  URLString: string;
  sLat, sLong: string;
  sl: TStringList;
  fullFichier: string;

  // frW, frH: integer;
const
  NomFichier = 'GoogleMap.html';
begin

  sLat := Format('%8.6f', [Lat]);
  sLat := StringReplace(sLat, ',', '.', [rfReplaceAll, rfIgnoreCase]);

  sLong := Format('%8.6f', [Long]);
  sLong := StringReplace(sLong, ',', '.', [rfReplaceAll, rfIgnoreCase]);

  sl := TStringList.Create;

  // GoogleAPIKey

  // frH := Round(wb.ChildrenRect.Height);
  // frW := Round(wb.ChildrenRect.Width);

  // sl.Add(Format
  // ('<html> <iframe width="%d" height="%d" frameborder="0" style="border:0" src="https://www.google.com/maps/embed/v1/search?key=%s&q=%s,%s"> </iframe> </html>',
  // [frW, frH, GoogleAPIKey, sLat, sLong]));

  sl.Add(Format
    ('<html> <iframe width="100%%" height="100%%" frameborder="0" style="border:0" src="https://www.google.com/maps/embed/v1/search?key=%s&q=%s,%s"> </iframe> </html>',
    [GoogleAPIKey, sLat, sLong]));

  fullFichier := TPath.Combine(TPath.GetDocumentsPath, NomFichier);
  sl.SaveToFile(fullFichier);

  // Show Map using Google Maps
  // URLString := Format('https://maps.google.com/maps?q=%s,%s', [sLat, sLong]);
  URLString := 'file:///' + fullFichier;
  wb.Navigate(URLString);

  // Application.ProcessMessages;

  // {$IFDEF Windows}
  // shellexecute(0, 'open', pchar(URLString), nil, nil, SW_SHOWNORMAL);
  // {$ENDIF}
  // ChangeTabActionToCimMap.ExecuteTarget(Self);

end;

procedure ShowImage_iOS(index: integer; CimImagesColl: TCimImageCollection);
{$IFDEF iOS}
// var
// qq: TFormImages;
{$ENDIF}
begin
{$IFDEF iOS}
  // qq := TFormImages.Create(nil);
  // qq.LesImages := CimImagesColl;
  // qq.AfficheImage(index);
  // qq.ShowModal(
  // procedure(ModalResult: TModalResult)
  // begin
  // // if ModalResult = mrOK then
  // // if OK was pressed and an item is selected, pick it
  // // if dlg.ListBox1.ItemIndex >= 0 then      edit1.Text := dlg.ListBox1.Items [dlg.ListBox1.ItemIndex];
  // qq.DisposeOf;
  // end);

{$ENDIF}
end;

end.
