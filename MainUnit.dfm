object MainForm: TMainForm
  Left = 895
  Top = 327
  Width = 555
  Height = 112
  Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1089#1087#1088#1072#1074#1086#1082
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LabelCurrNumber: TLabel
    Left = 24
    Top = 16
    Width = 101
    Height = 13
    Caption = #1054#1078#1080#1076#1072#1085#1080#1077' '#1082#1086#1084#1072#1085#1076#1099
  end
  object ButtonPrint: TButton
    Left = 200
    Top = 40
    Width = 139
    Height = 25
    Caption = #1056#1072#1089#1087#1077#1095#1072#1090#1072#1090#1100' '#1089#1087#1088#1072#1088#1074#1082#1080
    TabOrder = 0
    OnClick = ButtonPrintClick
  end
  object IBDatabaseMain: TIBDatabase
    Connected = True
    DatabaseName = 'C:\Users\'#1040#1083#1077#1082#1089#1072#1085#1076#1088'\Dropbox\'#1055#1088#1086#1075#1088#1072#1084#1084#1099'\TestResults\TEST_VSMA.GDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = IBTransactionMain
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 184
    Top = 8
  end
  object IBQueryResults: TIBQuery
    Database = IBDatabaseMain
    Transaction = IBTransactionMain
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select r.*, sp.fio, sp.fak ,'
      
        'right_ans_count*100/(select n.kol_vopr_tst from nastr n) as perc' +
        'ent_of_right'
      'from'
      '('
      'select distinct os.n_stud,'
      
        '(select count(*) from otvet_st os2 where os.n_stud = os2.n_stud)' +
        ' ans_count,'
      
        '(select count(*) from otvet_st os2, otvet o where os.n_stud = os' +
        '2.n_stud and os2.n_otv = o.n_otv and o.pr_pr = 1) right_ans_coun' +
        't'
      'from otvet_st os'
      ')r, spisok_st sp'
      'where sp.n_stud = r.n_stud')
    Left = 224
    Top = 8
    object IBQueryResultsN_STUD: TIntegerField
      FieldName = 'N_STUD'
      Required = True
    end
    object IBQueryResultsANS_COUNT: TIntegerField
      FieldName = 'ANS_COUNT'
    end
    object IBQueryResultsRIGHT_ANS_COUNT: TIntegerField
      FieldName = 'RIGHT_ANS_COUNT'
    end
    object IBQueryResultsFIO: TIBStringField
      FieldName = 'FIO'
      Origin = 'SPISOK_ST.FIO'
      Size = 45
    end
    object IBQueryResultsFAK: TIBStringField
      FieldName = 'FAK'
      Origin = 'SPISOK_ST.FAK'
      Size = 30
    end
    object IBQueryResultsPERCENT_OF_RIGHT: TFloatField
      FieldName = 'PERCENT_OF_RIGHT'
    end
  end
  object IBTransactionMain: TIBTransaction
    Active = False
    DefaultDatabase = IBDatabaseMain
    AutoStopAction = saNone
    Left = 144
    Top = 8
  end
  object IBQuerySetup: TIBQuery
    Database = IBDatabaseMain
    Transaction = IBTransactionMain
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from sys_ball')
    Left = 264
    Top = 8
    object IBQuerySetupSIS_BAL: TIntegerField
      FieldName = 'SIS_BAL'
      Origin = 'SYS_BALL.SIS_BAL'
    end
    object IBQuerySetupOTL: TIntegerField
      FieldName = 'OTL'
      Origin = 'SYS_BALL.OTL'
    end
    object IBQuerySetupCHOR: TIntegerField
      FieldName = 'CHOR'
      Origin = 'SYS_BALL.CHOR'
    end
    object IBQuerySetupUDOVL: TIntegerField
      FieldName = 'UDOVL'
      Origin = 'SYS_BALL.UDOVL'
    end
  end
  object IBQueryThemeName: TIBQuery
    Database = IBDatabaseMain
    Transaction = IBTransactionMain
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from nastr')
    Left = 304
    Top = 8
    object IBQueryThemeNameKOL_VOPR_TST: TIntegerField
      FieldName = 'KOL_VOPR_TST'
      Origin = 'NASTR.KOL_VOPR_TST'
    end
    object IBQueryThemeNameKURS: TIBStringField
      FieldName = 'KURS'
      Origin = 'NASTR.KURS'
      Size = 255
    end
  end
end
