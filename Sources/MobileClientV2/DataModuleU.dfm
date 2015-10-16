object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 525
  Width = 786
  object FDSQLiteFunction1: TFDSQLiteFunction
    FunctionName = 'CalcDist'
    ArgumentsCount = 2
    Left = 88
    Top = 240
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 80
    Top = 324
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\DataGL\Projets\Cimetieres\Db\Cimetieres.db'
      'DriverID=SQLite')
    LoginPrompt = False
    BeforeConnect = FDConnection1BeforeConnect
    Left = 56
    Top = 80
  end
  object qryListRegions: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from tblRegions order by RegionNom')
    Left = 240
    Top = 16
    object qryListRegionsRegionNo: TSmallintField
      FieldName = 'RegionNo'
      Origin = 'RegionNo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryListRegionsRegionNom: TWideStringField
      FieldName = 'RegionNom'
      Origin = 'RegionNom'
      Size = 30
    end
    object qryListRegionsRegion_NbCim: TSmallintField
      FieldName = 'Region_NbCim'
      Origin = 'Region_NbCim'
    end
    object qryListRegionsRegion_Pcnt: TFloatField
      FieldName = 'Region_Pcnt'
      Origin = 'Region_Pcnt'
    end
  end
  object qryListMRC: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from tblMRCs order by MRC_Nom')
    Left = 376
    Top = 16
    object qryListMRCMRC_No: TSmallintField
      FieldName = 'MRC_No'
      Origin = 'MRC_No'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryListMRCMRC_Nom: TWideStringField
      FieldName = 'MRC_Nom'
      Origin = 'MRC_Nom'
      Size = 30
    end
    object qryListMRCMRC_NbCim: TSmallintField
      FieldName = 'MRC_NbCim'
      Origin = 'MRC_NbCim'
    end
    object qryListMRCMRC_Pcnt: TFloatField
      FieldName = 'MRC_Pcnt'
      Origin = 'MRC_Pcnt'
    end
  end
  object qryListVilles: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evMode, evRecordCountMode]
    FetchOptions.Mode = fmAll
    FetchOptions.RecordCountMode = cmTotal
    SQL.Strings = (
      
        'SELECT  distinct   cim1.Ville,  (  select  Count(cim2.Ville)    ' +
        '  FROM tblCimetieres as cim2   Where Cim1.Ville=Cim2.Ville  ) as' +
        ' Nb  from tblCimetieres as cim1'
      'order by cim1.Ville')
    Left = 456
    Top = 24
    object qryListVillesVille: TWideStringField
      FieldName = 'Ville'
      Origin = 'Ville'
      Size = 50
    end
    object qryListVillesNb: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'Nb'
      Origin = 'Nb'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object cmdGetNbImagebyCimID: TFDCommand
    Connection = FDConnection1
    CommandText.Strings = (
      'select count(PicNo) from tblPhotos where PicCimNo= :CimID')
    ParamData = <
      item
        Name = 'CIMID'
        DataType = ftSmallint
        ParamType = ptInput
        Value = 1111
      end>
    Left = 492
    Top = 176
  end
  object qrySelectCims: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 5000
    SQL.Strings = (
      ''
      
        'SELECT CimNo,   CimCaption,Adresse_1, Adresse_2,Ville , Quartier' +
        ',  Longitude, Latitude,  dist, EntryType'
      #9'FROM tblCimetieres '
      ''
      
        'WHERE ( (RecordActif <> 0)  AND (Visible= 1) and ( dist<=&maxDis' +
        't)  )'
      'order by &Order1, &Order2 '
      ''
      ''
      ''
      '')
    Left = 424
    Top = 352
    MacroData = <
      item
        Value = 999999.000000000000000000
        Name = 'MAXDIST'
        DataType = mdFloat
      end
      item
        Value = 'Dist'
        Name = 'ORDER1'
      end
      item
        Value = 'Ville '
        Name = 'ORDER2'
      end>
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 304
    Top = 328
  end
  object FDCommand1: TFDCommand
    Connection = FDConnection1
    CommandKind = skExecute
    CommandText.Strings = (
      
        'update tblCimetieres SET Dist=CalcDist( Latitude,Longitude) wher' +
        'e ((RecordActif <> 0)  AND (Visible= 1)) '
      ''
      ''
      ''
      '')
    Left = 224
    Top = 256
  end
  object tblAreaStatdesc: TFDTable
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'spAreaStats_All'
    TableName = 'spAreaStats_All'
    Left = 296
    Top = 152
    object tblAreaStatdescGroupeNo: TSmallintField
      FieldName = 'GroupeNo'
      Origin = 'GroupeNo'
    end
    object tblAreaStatdescGroupeFr: TWideStringField
      FieldName = 'GroupeFr'
      Origin = 'GroupeFr'
      Size = 100
    end
    object tblAreaStatdescGroupeEng: TWideStringField
      FieldName = 'GroupeEng'
      Origin = 'GroupeEng'
      Size = 100
    end
    object tblAreaStatdescRangeFr: TWideStringField
      FieldName = 'RangeFr'
      Origin = 'RangeFr'
      Size = 100
    end
    object tblAreaStatdescRangeEng: TWideStringField
      FieldName = 'RangeEng'
      Origin = 'RangeEng'
      Size = 100
    end
    object tblAreaStatdescLowRange: TIntegerField
      FieldName = 'LowRange'
      Origin = 'LowRange'
    end
    object tblAreaStatdescHighRange: TIntegerField
      FieldName = 'HighRange'
      Origin = 'HighRange'
    end
    object tblAreaStatdescNbCim: TIntegerField
      FieldName = 'NbCim'
      Origin = 'NbCim'
    end
    object tblAreaStatdescSumArea: TIntegerField
      FieldName = 'SumArea'
      Origin = 'SumArea'
    end
  end
  object qrySelectImages: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 100
    SQL.Strings = (
      ''
      'SELECT * from tblPhotos '
      ''
      'WHERE ( PicCimNo = :CimID)'
      ''
      ''
      ''
      ''
      '')
    Left = 248
    Top = 448
    ParamData = <
      item
        Name = 'CIMID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 869
      end>
    object qrySelectImagesPicNo: TSmallintField
      FieldName = 'PicNo'
      Origin = 'PicNo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrySelectImagesPicCimNo: TIntegerField
      FieldName = 'PicCimNo'
      Origin = 'PicCimNo'
    end
    object qrySelectImagesPicAuteur: TWideStringField
      FieldName = 'PicAuteur'
      Origin = 'PicAuteur'
      Size = 50
    end
    object qrySelectImagesPicCaption: TWideStringField
      FieldName = 'PicCaption'
      Origin = 'PicCaption'
      Size = 100
    end
    object qrySelectImagesPicDate: TWideStringField
      FieldName = 'PicDate'
      Origin = 'PicDate'
      Size = 30
    end
    object qrySelectImagesPicDescr: TWideStringField
      FieldName = 'PicDescr'
      Origin = 'PicDescr'
      Size = 250
    end
    object qrySelectImagesPicFileName: TWideStringField
      FieldName = 'PicFileName'
      Origin = 'PicFileName'
      Size = 100
    end
    object qrySelectImagesPicWidth: TSmallintField
      FieldName = 'PicWidth'
      Origin = 'PicWidth'
    end
    object qrySelectImagesPicHeight: TSmallintField
      FieldName = 'PicHeight'
      Origin = 'PicHeight'
    end
    object qrySelectImagesPicOrder: TSmallintField
      FieldName = 'PicOrder'
      Origin = 'PicOrder'
    end
    object qrySelectImagesPicSourceID: TSmallintField
      FieldName = 'PicSourceID'
      Origin = 'PicSourceID'
    end
    object qrySelectImagesPicActive: TBooleanField
      FieldName = 'PicActive'
      Origin = 'PicActive'
    end
  end
  object qryAllCims: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evMode, evCursorKind]
    FetchOptions.Mode = fmAll
    FetchOptions.CursorKind = ckForwardOnly
    SQL.Strings = (
      'select * from tblCimetieres ;')
    Left = 80
    Top = 440
    object qryAllCimsCimNo: TIntegerField
      FieldName = 'CimNo'
      Origin = 'CimNo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryAllCimsCimCaption: TWideStringField
      FieldName = 'CimCaption'
      Origin = 'CimCaption'
      Size = 75
    end
    object qryAllCimsCimLongName: TWideStringField
      FieldName = 'CimLongName'
      Origin = 'CimLongName'
      Size = 150
    end
    object qryAllCimsComteNo: TSmallintField
      FieldName = 'ComteNo'
      Origin = 'ComteNo'
    end
    object qryAllCimsConfessionNo: TSmallintField
      FieldName = 'ConfessionNo'
      Origin = 'ConfessionNo'
    end
    object qryAllCimsProprioNo: TSmallintField
      FieldName = 'ProprioNo'
      Origin = 'ProprioNo'
    end
    object qryAllCimsEglise: TWideStringField
      FieldName = 'Eglise'
      Origin = 'Eglise'
      Size = 1
    end
    object qryAllCimsEntryType: TSmallintField
      FieldName = 'EntryType'
      Origin = 'EntryType'
    end
    object qryAllCimsLatitude: TFloatField
      FieldName = 'Latitude'
      Origin = 'Latitude'
    end
    object qryAllCimsLongitude: TFloatField
      FieldName = 'Longitude'
      Origin = 'Longitude'
    end
    object qryAllCimsQuartier: TWideStringField
      FieldName = 'Quartier'
      Origin = 'Quartier'
      Size = 50
    end
    object qryAllCimsVille: TWideStringField
      FieldName = 'Ville'
      Origin = 'Ville'
      Size = 50
    end
    object qryAllCimsAdresseCivique: TWideStringField
      FieldName = 'AdresseCivique'
      Origin = 'AdresseCivique'
      Size = 100
    end
    object qryAllCimsAdresse_1: TWideStringField
      FieldName = 'Adresse_1'
      Origin = 'Adresse_1'
      Size = 100
    end
    object qryAllCimsAdresse_2: TWideStringField
      FieldName = 'Adresse_2'
      Origin = 'Adresse_2'
      Size = 100
    end
    object qryAllCimsSituation: TWideStringField
      FieldName = 'Situation'
      Origin = 'Situation'
      Size = 100
    end
    object qryAllCimsNotes: TWideStringField
      FieldName = 'Notes'
      Origin = 'Notes'
      Size = 250
    end
    object qryAllCimsNomLieu: TWideStringField
      FieldName = 'NomLieu'
      Origin = 'NomLieu'
      Size = 50
    end
    object qryAllCimsParoisse: TWideStringField
      FieldName = 'Paroisse'
      Origin = 'Paroisse'
      Size = 50
    end
    object qryAllCimsEgliseNom: TWideStringField
      FieldName = 'EgliseNom'
      Origin = 'EgliseNom'
      Size = 50
    end
    object qryAllCimsRecordActif: TBooleanField
      FieldName = 'RecordActif'
      Origin = 'RecordActif'
    end
    object qryAllCimsPosPrecision: TSmallintField
      FieldName = 'PosPrecision'
      Origin = 'PosPrecision'
    end
    object qryAllCimsCaptionEng: TWideStringField
      FieldName = 'CaptionEng'
      Origin = 'CaptionEng'
      Size = 75
    end
    object qryAllCimsCimRegionNo: TSmallintField
      FieldName = 'CimRegionNo'
      Origin = 'CimRegionNo'
    end
    object qryAllCimsCimMRCNo: TSmallintField
      FieldName = 'CimMRCNo'
      Origin = 'CimMRCNo'
    end
    object qryAllCimsFirstDate: TWideStringField
      FieldName = 'FirstDate'
      Origin = 'FirstDate'
      Size = 10
    end
    object qryAllCimsLastDate: TWideStringField
      FieldName = 'LastDate'
      Origin = 'LastDate'
      Size = 10
    end
    object qryAllCimsWikimapia: TSmallintField
      FieldName = 'Wikimapia'
      Origin = 'Wikimapia'
    end
    object qryAllCimsWikimapiaID: TWideStringField
      FieldName = 'WikimapiaID'
      Origin = 'WikimapiaID'
      Size = 10
    end
    object qryAllCimsCimQCLink: TWideStringField
      FieldName = 'CimQCLink'
      Origin = 'CimQCLink'
      Size = 80
    end
    object qryAllCimsVisited: TWideStringField
      FieldName = 'Visited'
      Origin = 'Visited'
      Size = 1
    end
    object qryAllCimsPhotosNET: TWideStringField
      FieldName = 'PhotosNET'
      Origin = 'PhotosNET'
      Size = 1
    end
    object qryAllCimsNbNodes: TSmallintField
      FieldName = 'NbNodes'
      Origin = 'NbNodes'
    end
    object qryAllCimsPerimeter: TIntegerField
      FieldName = 'Perimeter'
      Origin = 'Perimeter'
    end
    object qryAllCimsArea: TIntegerField
      FieldName = 'Area'
      Origin = 'Area'
    end
    object qryAllCimsAltitude: TSmallintField
      FieldName = 'Altitude'
      Origin = 'Altitude'
    end
    object qryAllCimsGenHCN_Net: TSmallintField
      FieldName = 'GenHCN_Net'
      Origin = 'GenHCN_Net'
    end
    object qryAllCimsChapelle: TWideStringField
      FieldName = 'Chapelle'
      Origin = 'Chapelle'
      Size = 1
    end
    object qryAllCimsNbMausolees: TSmallintField
      FieldName = 'NbMausolees'
      Origin = 'NbMausolees'
    end
    object qryAllCimsPosEglise: TSmallintField
      FieldName = 'PosEglise'
      Origin = 'PosEglise'
    end
    object qryAllCimsOrgSpatiale: TSmallintField
      FieldName = 'OrgSpatiale'
      Origin = 'OrgSpatiale'
    end
    object qryAllCimsInterLink: TSmallintField
      FieldName = 'InterLink'
      Origin = 'InterLink'
    end
    object qryAllCimsGarminFrCaption: TWideStringField
      FieldName = 'GarminFrCaption'
      Origin = 'GarminFrCaption'
      Size = 30
    end
    object qryAllCimsRouteNo: TSmallintField
      FieldName = 'RouteNo'
      Origin = 'RouteNo'
    end
    object qryAllCimsViewOrder: TSmallintField
      FieldName = 'ViewOrder'
      Origin = 'ViewOrder'
    end
    object qryAllCimsNotesRecherches: TWideStringField
      FieldName = 'NotesRecherches'
      Origin = 'NotesRecherches'
      Size = 250
    end
    object qryAllCimsConfirme: TWideStringField
      FieldName = 'Confirme'
      Origin = 'Confirme'
      Size = 1
    end
    object qryAllCimsInactif: TWideStringField
      FieldName = 'Inactif'
      Origin = 'Inactif'
      Size = 1
    end
    object qryAllCimsNbInhumations: TIntegerField
      FieldName = 'NbInhumations'
      Origin = 'NbInhumations'
    end
    object qryAllCimsNbMonuments: TIntegerField
      FieldName = 'NbMonuments'
      Origin = 'NbMonuments'
    end
    object qryAllCimsDatePremiereInhumation: TWideStringField
      FieldName = 'DatePremiereInhumation'
      Origin = 'DatePremiereInhumation'
      Size = 10
    end
    object qryAllCimsDateDerniereInhumation: TWideStringField
      FieldName = 'DateDerniereInhumation'
      Origin = 'DateDerniereInhumation'
      Size = 10
    end
    object qryAllCimsDateNbInhumations: TWideStringField
      FieldName = 'DateNbInhumations'
      Origin = 'DateNbInhumations'
      Size = 10
    end
    object qryAllCimsCodeBorden: TWideStringField
      FieldName = 'CodeBorden'
      Origin = 'CodeBorden'
      Size = 25
    end
    object qryAllCimsVisible: TBooleanField
      FieldName = 'Visible'
      Origin = 'Visible'
    end
    object qryAllCimsDist: TFloatField
      FieldName = 'Dist'
      Origin = 'Dist'
    end
  end
end
