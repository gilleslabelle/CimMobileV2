unit Cim.Types;

interface

type

  TCimSortBy = (byDist, byName, byVille);


  TCimSortByHelper = record helper for TCimSortBy
    function toString:string;
  end;


  TFiltreGeneralActifTypes = (Aucun, Ville, MRC, Region);








  TFiltreCimTypeActif = (Archeo, Crypte, Cimetieres, Autre, Columbarium);
  TFiltresCimTypeActif = set of TFiltreCimTypeActif;

   TFiltreCimTypeActifHelper = record helper for TFiltreCimTypeActif
    function ToEntryType:integer;
    class function  EntryTypeToTFiltreCimTypeActif(value :integer):TFiltreCimTypeActif; static;
   end;


const
  NBRECMAX: integer   = 200;
  MaxDistance: single = 20;

  ApproxPositionLevel: integer = 3; // ' Trigger for approximate position level
  PrecisionLevel_1_Fr: string  = 'Position précise: ±2.0 Mètres (±6.8 Pieds)';
  PrecisionLevel_2_Fr: string  = 'Position approchée: ±100 Mètres (±328 Pieds)';
  PrecisionLevel_3_Fr: string  = 'Position mentionnée: ±1 Km (±0.6 Mille)';
  PrecisionLevel_4_Fr: string  = 'Position imprécise: >1 Km (0.6 Mille)';
  CF_MeterToFeet               = 3.28083;
  CF_SQMeterToSQFeet           = 10.76391;
  Col_HighRange                = 5;

  sDist        = 'DistObj';
  GoogleAPIKey = 'AIzaSyAMUNKeqoy6KE-ZAdGZkAs9udaeG2S-Inw';

  // MapboxKey = 'examples.map-zr0njcqy';
  MapboxKey = 'gilleslabelle.ho54gpgo';

implementation

uses
  System.SysUtils;

{ TCimSortByHelper }

function TCimSortByHelper.toString: string;
begin
  case self of
     byDist:  Result := 'Trié par distance';
     byName:  Result := 'Trié par nom de cimetière';
     byVille:  Result := 'Trié par ville';
  end;
end;

{ TFiltreGeneralActifTypesHelper }


{ TFiltreCimTypeActifHelper }

class function TFiltreCimTypeActifHelper.EntryTypeToTFiltreCimTypeActif(value: integer): TFiltreCimTypeActif;
begin
    case value of
    1: Result := Cimetieres;
    2:Result := Archeo;
    3:Result := Crypte;
    4:Result := Columbarium;
    5:Result := Autre;
    else
    begin
        raise Exception.Create('valeur non supporté');
    end;

    end;
end;

function TFiltreCimTypeActifHelper.ToEntryType: integer;
begin
    case Self of
      Archeo: Result := 2;
      Crypte: Result := 3;
      Cimetieres: Result :=1;
      Autre: Result:=5;
      Columbarium:Result:=4 ;
    else
    begin
        raise Exception.Create('Type non supporté');
    end;
    end;
end;








end.
