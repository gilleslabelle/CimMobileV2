unit uPictureCls;
// _______________________________________________________________ ZYMA __
// $HeadURL: svn://bitnami-redmine/_GL/trunk/Cimeti%C3%A8res/Sources/MobileClient/uPictureCls.pas $
// .......................................................................
// Last committed    : $Revision:: 51               $
// Last changed by   : $Author:: labelleg           $
// Last changed date : $Date:: 2014-07-02 16:01:41 #$
// .......................................................................
// Copyright (c) ZYMA 2014
// _______________________________________________________________________


interface

uses
  FMX.Graphics,System.Generics.Collections, FMX.Objects;

//uses
//  FMX.Graphics, System.Generics.Collections;

type
  TCimImage = class
  strict private
//    FBitmap: TBitmap;
    FCaption: string;
    FDetail: string;
    FOriWidth: integer;
    FOriHeight: integer;
    FUrl : string;
    FImage: TImage;
  public

    constructor Create; overload;
    constructor Create(image: Timage; caption: string; detail: string; width: integer; height: integer; url :string); overload;

  //  property bitmap: TBitmap read FBitmap;
    property image : TImage read FImage;
    property caption: string read FCaption;
    property detail: string read FDetail;
    property OriWidth: integer read FOriWidth;
    property OriHeight: integer read FOriHeight;
    property URL : string  read FUrl;

  end;

  TCimImageCollection = class(TObjectList<TCimImage>)

  public
     property OnNotify;
  end;



implementation

{ TCimImage }

constructor TCimImage.Create;
begin
  inherited Create;
end;

constructor TCimImage.Create(image: TImage; caption: string; detail: string; width: integer; height: integer; url :string);
begin
  Self.Create();

  Self.FImage := image;

  Self.FCaption := caption;
  Self.FDetail := detail;
  Self.FOriWidth := width;
  Self.FOriHeight := height;
  self.FUrl := url;
end;

end.
