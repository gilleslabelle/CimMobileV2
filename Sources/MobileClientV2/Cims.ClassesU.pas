unit Cims.ClassesU;

interface

uses
  System.Generics.Collections, System.Generics.Defaults, Cim.Types;

type

  TCim = class
  strict private
    FDist:      double;
    FID:        cardinal;
    FCaption:   string;
    FVille:     string;
    FQuartier:  string;
    FEntryType: TFiltreCimTypeActif;
    FLongitude: double;
    FLatitude:  double;
    FVisible: Boolean;
  published
  public
    constructor Create;
    destructor Destroy; override;
    property ID: cardinal read FID write FID;
    property Caption: string read FCaption write FCaption;
    property Ville: string read FVille write FVille;
    property Quartier: string read FQuartier write FQuartier;
    property Dist: double read FDist write FDist;
    property EntryType: TFiltreCimTypeActif read FEntryType write FEntryType;
    property Longitude: double read FLongitude write FLongitude;
    property Latitude: double read FLatitude write FLatitude;
    property Visible : Boolean read FVisible write FVisible;
  end;

  TCims = class
  private
    FCims: TObjectList<TCim>;
//    class function CompareNames(Item1, Item2: TCim): integer; static;
  public
    constructor Create;
    destructor Destroy; override;
    property Coll: TObjectList<TCim> read FCims;
    procedure SortByName;
    procedure SortByDistance;
    procedure SortByVille;

    procedure UpdateDistances(long, lat: double);

    procedure SetAllVisible;

    procedure FiltreByCimType(values: TFiltresCimTypeActif);

    function GetNbVisibleCount : integer;

  end;

  // TCimColl = class(TObjectList< TCim>)
  // private
  // public
  // constructor Create;
  // destructor Destroy; override;
  //
  /// /    class function CompareNames(Item1, Item2: Tcim): Integer; static;
  // end;

implementation

uses
  System.SysUtils, System.Math, CoordU, System.Threading,System.SyncObjs,
  StringStripU;

{ TCim }

constructor TCim.Create;
begin
  inherited Create;

  FVisible := true;
end;

destructor TCim.Destroy;
begin

  inherited Destroy;
end;


{ TCimColl }


// constructor TCimColl.Create;
// begin
// inherited Create(true);
//
//
// end;
//
// destructor TCimColl.Destroy;
// begin
//
// inherited;
// end;

{ TCimNamComparer }

{ TCims }


constructor TCims.Create;
begin
  inherited Create;
  FCims := TObjectList<TCim>.Create(true);
end;

destructor TCims.Destroy;
begin

  inherited Destroy;
end;

procedure TCims.FiltreByCimType(values: TFiltresCimTypeActif);
var
  unCim: Tcim;
//  qq:TFiltreCimTypeActif;
begin

    for unCim in Self.FCims do
     begin

//
       uncim.Visible :=   (uncim.EntryType in values) or (values=[]) ;


     end;

end;

function TCims.GetNbVisibleCount: integer;
var
  Tot: Integer;
begin
  Tot:=0;
  TParallel.For(0, Self.FCims.Count - 1,
    procedure(i: integer)
    begin
      if Self.FCims[i].Visible then begin
       TInterlocked.Increment (Tot);
      end;
    end);

    Result :=tot;

end;

procedure TCims.SetAllVisible;
begin
  TParallel.For(0, Self.FCims.Count - 1,
    procedure(i: integer)
    begin
      Self.FCims[i].Visible := true;
    end);

end;

procedure TCims.SortByDistance;
begin
  FCims.Sort(TComparer<TCim>.Construct(
    function(const Left, Right: TCim): integer
    begin
      if Left.Dist < Right.Dist then
        Result := -1
      else if Left.Dist > Right.Dist then
        Result := 1
      else
        Result := 0;
    end));

end;




procedure TCims.SortByName;
begin
  FCims.Sort(TComparer<TCim>.Construct(
    function(const Left, Right: TCim): integer
    begin
      Result := CompareText( ( Left.Caption), (Right.Caption));
//      Result := CompareText( RemoveAccents( Left.Caption), RemoveAccents(Right.Caption));
    end));
end;

procedure TCims.SortByVille;
begin
  FCims.Sort(TComparer<TCim>.Construct(
    function(const Left, Right: TCim): integer
    begin
      Result := CompareText((Left.Ville),( Right.Ville));
//      Result := CompareText(RemoveAccents(Left.Ville),RemoveAccents( Right.Ville));
    end));

end;

procedure TCims.UpdateDistances(long, lat: double);
begin

  TParallel.For(0, Self.FCims.Count - 1,
    procedure(i: integer)
    var
      unCim: TCim;
    begin
      unCim := Self.FCims[i];
      if isnan(long) or isnan(lat) then
      begin
        unCim.Dist := 999999;
      end
      else
      begin
        unCim.Dist := CoordU.DistanceInKm2(long, lat, unCim.Longitude, unCim.Latitude);
      end;

    end);

  // for unCim in Self.FCims do
  // begin
  //
  // if isnan(long) or isnan(lat) then
  // begin
  // unCim.Dist := 999999;
  // end
  // else
  // begin
  // uncim.Dist:= CoordU.DistanceInKm2(long, lat, unCim.Longitude,uncim.Latitude);
  // end;
  //
  //
  // end;

end;

end.
