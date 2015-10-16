object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 540
  Width = 798
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\DataGL\Projets\Cimetieres\Db\Cimetieres.db'
      'DriverID=SQLite')
    LoginPrompt = False
    BeforeConnect = FDConnection1BeforeConnect
    Left = 40
    Top = 168
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 96
    Top = 376
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evMode, evItems, evRowsetSize, evRecordCountMode, evUnidirectional, evCursorKind, evAutoFetchAll, evLiveWindowParanoic, evLiveWindowFastFirst]
    FetchOptions.RowsetSize = 200
    FetchOptions.AutoFetchAll = afDisable
    FetchOptions.RecordCountMode = cmFetched
    FetchOptions.Items = [fiDetails]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvRefreshMode]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.RefreshMode = rmAll
    SQL.Strings = (
      
        'SELECT CimNo,   CimCaption,Ville, Quartier,  Adresse_1,Adresse_2' +
        ',Latitude, Longitude, CalcDist(Latitude, Longitude) as Dist, tbl' +
        'MRCs.MRC_Nom AS MRC_Nom '
      #9'FROM tblMRCs, tblCimetieres , tblPhotos'
      ''
      
        'WHERE (( tblMRCs.MRC_No = tblCimetieres.CimMRCNo ) AND  (tblCime' +
        'tieres.RecordActif <> 0)  AND (Visible= 1) and (tblCimetieres.Ci' +
        'mNo = tblPhotos.PicCimNo ))'
      'ORDER BY !Ordre1, !Ordre2 , !Ordre3'
      ''
      ''
      'limit 100 offset 100'
      ''
      ''
      ''
      ''
      ''
      '')
    Left = 128
    Top = 192
    MacroData = <
      item
        Value = 'Dist'
        Name = 'ORDRE1'
      end
      item
        Value = 'Ville'
        Name = 'ORDRE2'
      end
      item
        Value = 'CimCaption'
        Name = 'ORDRE3'
      end>
    object FDQuery1CimNo: TIntegerField
      FieldName = 'CimNo'
      Origin = 'CimNo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQuery1CimCaption: TWideStringField
      FieldName = 'CimCaption'
      Origin = 'CimCaption'
      Size = 75
    end
    object FDQuery1Ville: TWideStringField
      FieldName = 'Ville'
      Origin = 'Ville'
      Size = 50
    end
    object FDQuery1Quartier: TWideStringField
      FieldName = 'Quartier'
      Origin = 'Quartier'
      Size = 50
    end
    object FDQuery1Adresse_1: TWideStringField
      FieldName = 'Adresse_1'
      Origin = 'Adresse_1'
      Size = 100
    end
    object FDQuery1Adresse_2: TWideStringField
      FieldName = 'Adresse_2'
      Origin = 'Adresse_2'
      Size = 100
    end
    object FDQuery1Latitude: TFloatField
      FieldName = 'Latitude'
      Origin = 'Latitude'
    end
    object FDQuery1Longitude: TFloatField
      FieldName = 'Longitude'
      Origin = 'Longitude'
    end
    object FDQuery1MRC_Nom: TWideStringField
      FieldName = 'MRC_Nom'
      Origin = 'MRC_Nom'
      Size = 30
    end
    object FDQuery1Dist: TFloatField
      FieldName = 'Dist'
      Origin = 'Dist'
      DisplayFormat = '0.0'
    end
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 40
    Top = 240
  end
  object FDSQLiteFunction1: TFDSQLiteFunction
    DriverLink = FDPhysSQLiteDriverLink1
    Active = True
    FunctionName = 'CalcDist'
    ArgumentsCount = 2
    OnCalculate = FDSQLiteFunction1Calculate
    Left = 96
    Top = 320
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
  object qryGetCimDetail: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT tblCimetieres . * , tblComtes . ComteNom AS ComteNom ,'
      
        ' tblComtes . ComteNo AS CimComteNo , tblConfessions . Confession' +
        'Fr AS ConfessionFr ,'
      '  tblConfessions . ConfessionEng AS ConfessionEng ,'
      '   tblConfessions . ConfessionLongFr AS ConfessionLongFr ,'
      '    tblConfessions . ConfessionLongEng AS ConfessionLongEng ,'
      
        '     tblConfessions . LevelNo AS LevelNo , tblConfessions . Pare' +
        'ntNo AS ParentNo ,'
      
        '      tblRegions . RegionNom AS RegionNom , tblMRCs . MRC_Nom AS' +
        ' MRC_Nom '
      
        '      FROM tblMRCs , tblRegions , tblConfessions , tblComtes , t' +
        'blCimetieres '
      '      '
      '      '
      '      '
      '      '
      '      WHERE ( tblComtes . ComteNo = tblCimetieres . ComteNo ) '
      
        '      AND ( tblConfessions . ConfessionNo = tblCimetieres . Conf' +
        'essionNo ) '
      
        '      AND ( tblRegions . RegionNo = tblCimetieres . CimRegionNo ' +
        ') '
      '      AND ( tblMRCs . MRC_No = tblCimetieres . CimMRCNo ) '
      '      AND ( tblCimetieres.CimNo=:CimID )')
    Left = 432
    Top = 248
    ParamData = <
      item
        Name = 'CIMID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    object qryGetCimDetailCimNo: TIntegerField
      FieldName = 'CimNo'
      Origin = 'CimNo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryGetCimDetailCimCaption: TWideStringField
      FieldName = 'CimCaption'
      Origin = 'CimCaption'
      Size = 75
    end
    object qryGetCimDetailCimLongName: TWideStringField
      FieldName = 'CimLongName'
      Origin = 'CimLongName'
      Size = 150
    end
    object qryGetCimDetailComteNo: TSmallintField
      FieldName = 'ComteNo'
      Origin = 'ComteNo'
    end
    object qryGetCimDetailConfessionNo: TSmallintField
      FieldName = 'ConfessionNo'
      Origin = 'ConfessionNo'
    end
    object qryGetCimDetailProprioNo: TSmallintField
      FieldName = 'ProprioNo'
      Origin = 'ProprioNo'
    end
    object qryGetCimDetailEglise: TWideStringField
      FieldName = 'Eglise'
      Origin = 'Eglise'
      Size = 1
    end
    object qryGetCimDetailEntryType: TSmallintField
      FieldName = 'EntryType'
      Origin = 'EntryType'
    end
    object qryGetCimDetailLatitude: TFloatField
      FieldName = 'Latitude'
      Origin = 'Latitude'
    end
    object qryGetCimDetailLongitude: TFloatField
      FieldName = 'Longitude'
      Origin = 'Longitude'
    end
    object qryGetCimDetailQuartier: TWideStringField
      FieldName = 'Quartier'
      Origin = 'Quartier'
      Size = 50
    end
    object qryGetCimDetailVille: TWideStringField
      FieldName = 'Ville'
      Origin = 'Ville'
      Size = 50
    end
    object qryGetCimDetailAdresseCivique: TWideStringField
      FieldName = 'AdresseCivique'
      Origin = 'AdresseCivique'
      Size = 100
    end
    object qryGetCimDetailAdresse_1: TWideStringField
      FieldName = 'Adresse_1'
      Origin = 'Adresse_1'
      Size = 100
    end
    object qryGetCimDetailAdresse_2: TWideStringField
      FieldName = 'Adresse_2'
      Origin = 'Adresse_2'
      Size = 100
    end
    object qryGetCimDetailSituation: TWideStringField
      FieldName = 'Situation'
      Origin = 'Situation'
      Size = 100
    end
    object qryGetCimDetailNotes: TWideStringField
      FieldName = 'Notes'
      Origin = 'Notes'
      Size = 250
    end
    object qryGetCimDetailNomLieu: TWideStringField
      FieldName = 'NomLieu'
      Origin = 'NomLieu'
      Size = 50
    end
    object qryGetCimDetailParoisse: TWideStringField
      FieldName = 'Paroisse'
      Origin = 'Paroisse'
      Size = 50
    end
    object qryGetCimDetailEgliseNom: TWideStringField
      FieldName = 'EgliseNom'
      Origin = 'EgliseNom'
      Size = 50
    end
    object qryGetCimDetailRecordActif: TBooleanField
      FieldName = 'RecordActif'
      Origin = 'RecordActif'
    end
    object qryGetCimDetailPosPrecision: TSmallintField
      FieldName = 'PosPrecision'
      Origin = 'PosPrecision'
    end
    object qryGetCimDetailCaptionEng: TWideStringField
      FieldName = 'CaptionEng'
      Origin = 'CaptionEng'
      Size = 75
    end
    object qryGetCimDetailCimRegionNo: TSmallintField
      FieldName = 'CimRegionNo'
      Origin = 'CimRegionNo'
    end
    object qryGetCimDetailCimMRCNo: TSmallintField
      FieldName = 'CimMRCNo'
      Origin = 'CimMRCNo'
    end
    object qryGetCimDetailFirstDate: TWideStringField
      FieldName = 'FirstDate'
      Origin = 'FirstDate'
      Size = 10
    end
    object qryGetCimDetailLastDate: TWideStringField
      FieldName = 'LastDate'
      Origin = 'LastDate'
      Size = 10
    end
    object qryGetCimDetailWikimapia: TSmallintField
      FieldName = 'Wikimapia'
      Origin = 'Wikimapia'
    end
    object qryGetCimDetailWikimapiaID: TWideStringField
      FieldName = 'WikimapiaID'
      Origin = 'WikimapiaID'
      Size = 10
    end
    object qryGetCimDetailCimQCLink: TWideStringField
      FieldName = 'CimQCLink'
      Origin = 'CimQCLink'
      Size = 80
    end
    object qryGetCimDetailVisited: TWideStringField
      FieldName = 'Visited'
      Origin = 'Visited'
      Size = 1
    end
    object qryGetCimDetailPhotosNET: TWideStringField
      FieldName = 'PhotosNET'
      Origin = 'PhotosNET'
      Size = 1
    end
    object qryGetCimDetailNbNodes: TSmallintField
      FieldName = 'NbNodes'
      Origin = 'NbNodes'
    end
    object qryGetCimDetailPerimeter: TIntegerField
      FieldName = 'Perimeter'
      Origin = 'Perimeter'
    end
    object qryGetCimDetailArea: TIntegerField
      FieldName = 'Area'
      Origin = 'Area'
    end
    object qryGetCimDetailAltitude: TSmallintField
      FieldName = 'Altitude'
      Origin = 'Altitude'
    end
    object qryGetCimDetailGenHCN_Net: TSmallintField
      FieldName = 'GenHCN_Net'
      Origin = 'GenHCN_Net'
    end
    object qryGetCimDetailChapelle: TWideStringField
      FieldName = 'Chapelle'
      Origin = 'Chapelle'
      Size = 1
    end
    object qryGetCimDetailNbMausolees: TSmallintField
      FieldName = 'NbMausolees'
      Origin = 'NbMausolees'
    end
    object qryGetCimDetailPosEglise: TSmallintField
      FieldName = 'PosEglise'
      Origin = 'PosEglise'
    end
    object qryGetCimDetailOrgSpatiale: TSmallintField
      FieldName = 'OrgSpatiale'
      Origin = 'OrgSpatiale'
    end
    object qryGetCimDetailInterLink: TSmallintField
      FieldName = 'InterLink'
      Origin = 'InterLink'
    end
    object qryGetCimDetailGarminFrCaption: TWideStringField
      FieldName = 'GarminFrCaption'
      Origin = 'GarminFrCaption'
      Size = 30
    end
    object qryGetCimDetailRouteNo: TSmallintField
      FieldName = 'RouteNo'
      Origin = 'RouteNo'
    end
    object qryGetCimDetailViewOrder: TSmallintField
      FieldName = 'ViewOrder'
      Origin = 'ViewOrder'
    end
    object qryGetCimDetailNotesRecherches: TWideStringField
      FieldName = 'NotesRecherches'
      Origin = 'NotesRecherches'
      Size = 250
    end
    object qryGetCimDetailConfirme: TWideStringField
      FieldName = 'Confirme'
      Origin = 'Confirme'
      Size = 1
    end
    object qryGetCimDetailInactif: TWideStringField
      FieldName = 'Inactif'
      Origin = 'Inactif'
      Size = 1
    end
    object qryGetCimDetailNbInhumations: TIntegerField
      FieldName = 'NbInhumations'
      Origin = 'NbInhumations'
    end
    object qryGetCimDetailNbMonuments: TIntegerField
      FieldName = 'NbMonuments'
      Origin = 'NbMonuments'
    end
    object qryGetCimDetailDatePremiereInhumation: TWideStringField
      FieldName = 'DatePremiereInhumation'
      Origin = 'DatePremiereInhumation'
      Size = 10
    end
    object qryGetCimDetailDateDerniereInhumation: TWideStringField
      FieldName = 'DateDerniereInhumation'
      Origin = 'DateDerniereInhumation'
      Size = 10
    end
    object qryGetCimDetailDateNbInhumations: TWideStringField
      FieldName = 'DateNbInhumations'
      Origin = 'DateNbInhumations'
      Size = 10
    end
    object qryGetCimDetailCodeBorden: TWideStringField
      FieldName = 'CodeBorden'
      Origin = 'CodeBorden'
      Size = 25
    end
    object qryGetCimDetailVisible: TBooleanField
      FieldName = 'Visible'
      Origin = 'Visible'
    end
    object qryGetCimDetailDist: TFloatField
      FieldName = 'Dist'
      Origin = 'Dist'
    end
    object qryGetCimDetailComteNom: TWideStringField
      FieldName = 'ComteNom'
      Origin = 'ComteNom'
      Size = 25
    end
    object qryGetCimDetailCimComteNo: TSmallintField
      FieldName = 'CimComteNo'
      Origin = 'CimComteNo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryGetCimDetailConfessionFr: TWideStringField
      FieldName = 'ConfessionFr'
      Origin = 'ConfessionFr'
      Size = 40
    end
    object qryGetCimDetailConfessionEng: TWideStringField
      FieldName = 'ConfessionEng'
      Origin = 'ConfessionEng'
      Size = 40
    end
    object qryGetCimDetailConfessionLongFr: TWideStringField
      FieldName = 'ConfessionLongFr'
      Origin = 'ConfessionLongFr'
      Size = 100
    end
    object qryGetCimDetailConfessionLongEng: TWideStringField
      FieldName = 'ConfessionLongEng'
      Origin = 'ConfessionLongEng'
      Size = 100
    end
    object qryGetCimDetailLevelNo: TSmallintField
      FieldName = 'LevelNo'
      Origin = 'LevelNo'
    end
    object qryGetCimDetailParentNo: TSmallintField
      FieldName = 'ParentNo'
      Origin = 'ParentNo'
    end
    object qryGetCimDetailRegionNom: TWideStringField
      FieldName = 'RegionNom'
      Origin = 'RegionNom'
      Size = 30
    end
    object qryGetCimDetailMRC_Nom: TWideStringField
      FieldName = 'MRC_Nom'
      Origin = 'MRC_Nom'
      Size = 30
    end
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
    Left = 592
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
  object cmdCimClearAllVisible: TFDCommand
    Connection = FDConnection1
    CommandText.Strings = (
      'update tblCimetieres SET Visible=0;')
    Left = 628
    Top = 320
  end
  object cmdCimSetVisibleByVille: TFDCommand
    Connection = FDConnection1
    CommandText.Strings = (
      'update tblCimetieres SET Visible=1 where Ville=:LaVille')
    ParamData = <
      item
        Name = 'LAVILLE'
        DataType = ftString
        ParamType = ptInput
        Value = 'Montr'#233'al'
      end>
    Left = 548
    Top = 384
  end
  object cmdCimSetAllVisible: TFDCommand
    Connection = FDConnection1
    CommandText.Strings = (
      'update tblCimetieres SET Visible=1;')
    Left = 628
    Top = 264
  end
  object qrySelectCimsCount: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 100
    SQL.Strings = (
      ''
      'SELECT Count(CimNo)'
      #9'FROM tblCimetieres  '
      ''
      'WHERE ( (RecordActif <> 0)  AND (Visible= 1)   )'
      ''
      ''
      ''
      '')
    Left = 384
    Top = 416
  end
  object cmdCimSetVisibleByMRC: TFDCommand
    Connection = FDConnection1
    CommandText.Strings = (
      'update tblCimetieres SET Visible=1 where CimMRCNo=:MrcID'
      ''
      ''
      '')
    ParamData = <
      item
        Name = 'MRCID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    Left = 548
    Top = 448
  end
  object cmdCimSetVisibleByRegion: TFDCommand
    Connection = FDConnection1
    CommandText.Strings = (
      'update tblCimetieres SET Visible=1 where CimRegionNo=:RegionID')
    ParamData = <
      item
        Name = 'REGIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    Left = 700
    Top = 440
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
    Left = 700
    Top = 112
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
    Left = 200
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
    Left = 328
    Top = 248
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
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 512
    Top = 160
  end
end
