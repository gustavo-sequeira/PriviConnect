object dmDescontos: TdmDescontos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 452
  Width = 200
  object bdFcerta: TIBDatabase
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    ServerType = 'IBServer'
    Left = 24
    Top = 16
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = bdFcerta
    Left = 112
    Top = 16
  end
  object IBTransaction2: TIBTransaction
    DefaultDatabase = bdDescontos
    Left = 112
    Top = 72
  end
  object bdDescontos: TIBDatabase
    DatabaseName = '10.10.1.218:D:\SISTEMAS\PRIVILEGE\DB\descontos.IB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction2
    ServerType = 'IBServer'
    Left = 24
    Top = 80
  end
  object bdFcerta2: TIBDatabase
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction3
    ServerType = 'IBServer'
    Left = 24
    Top = 144
  end
  object IBTransaction3: TIBTransaction
    DefaultDatabase = bdFcerta2
    Left = 112
    Top = 144
  end
  object IBTransaction4: TIBTransaction
    DefaultDatabase = bdDescontos2
    Left = 112
    Top = 208
  end
  object bdDescontos2: TIBDatabase
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction4
    ServerType = 'IBServer'
    Left = 24
    Top = 208
  end
  object bdImagens: TIBDatabase
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction5
    ServerType = 'IBServer'
    Left = 24
    Top = 280
  end
  object IBTransaction5: TIBTransaction
    DefaultDatabase = bdImagens
    Left = 112
    Top = 280
  end
  object bdFcerta3: TFDConnection
    Params.Strings = (
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'DriverID=FB')
    Left = 24
    Top = 344
  end
end
