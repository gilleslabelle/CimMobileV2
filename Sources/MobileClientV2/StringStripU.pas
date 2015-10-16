unit StringStripU;

interface

const
  TCharsLikeAmaj = ['À' .. 'Å'];
  TCharsLikeCmaj = ['Ç' .. 'Ç'];
  TCharsLikeEmaj = ['È' .. 'Ë'];
  TCharsLikeImaj = ['Ì' .. 'Ï'];
  TCharsLikeOmaj = ['Ò' .. 'Ö'];
  TCharsLikeUmaj = ['Ù' .. 'Ü'];
  TCharsLikeYmaj = ['Ý' .. 'Ý'];
  TCharsLikeAmin = ['à' .. 'å'];
  TCharsLikeCmin = ['ç' .. 'ç'];
  TCharsLikeEmin = ['è' .. 'ë'];
  TCharsLikeImin = ['ì' .. 'ï'];
  TCharsLikeOmin = ['ò' .. 'ö'];
  TCharsLikeUmin = ['ù' .. 'ü'];
  TCharsLikeYmin = ['ý' .. 'ý'];

  // Allowed = ['A' .. 'Z', 'a' .. 'z', '0' .. '9', '_'];

function RemoveAccents(str: string): string;

implementation

uses System.Strutils, System.SysUtils;

function RemoveAccents(str: string): string;
var
  nbChar: integer;
  I:      integer;
  unChar: char;

begin

  nbChar := length(str);

  for I := 1 to nbChar do
  begin
    unChar := str[I];

    if CharInSet(unChar , TCharsLikeAmaj) then
      str[I] := 'A';
    if CharInSet(unChar , TCharsLikeCmaj) then
      str[I] := 'C';
    if CharInSet(unChar , TCharsLikeEmaj) then
      str[I] := 'E';
    if CharInSet(unChar , TCharsLikeImaj) then
      str[I] := 'I';
    if CharInSet(unChar , TCharsLikeOmaj) then
      str[I] := 'O';
    if CharInSet(unChar , TCharsLikeUmaj) then
      str[I] := 'U';
    if CharInSet(unChar , TCharsLikeYmaj) then
      str[I] := 'Y';
    if CharInSet(unChar , TCharsLikeAmin) then
      str[I] := 'a';
    if CharInSet(unChar , TCharsLikeCmin) then
      str[I] := 'c';
    if CharInSet(unChar , TCharsLikeEmin) then
      str[I] := 'e';
    if CharInSet(unChar , TCharsLikeImin) then
      str[I] := 'i';
    if CharInSet(unChar , TCharsLikeOmin) then
      str[I] := 'o';
    if CharInSet(unChar , TCharsLikeUmin) then
      str[I] := 'u';
    if CharInSet(unChar , TCharsLikeYmin) then
      str[I] := 'y';

  end;

  result := str;
end;

end.
