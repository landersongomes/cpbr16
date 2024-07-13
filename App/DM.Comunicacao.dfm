object dmComunicacao: TdmComunicacao
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object RESTClient1: TRESTClient
    BaseURL = 'https://7f17-201-157-251-147.ngrok-free.app/workshop'
    Params = <>
    SynchronizedEvents = False
    Left = 128
    Top = 64
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Params = <>
    Resource = 'operacoes/'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 296
    Top = 64
  end
  object RESTResponse1: TRESTResponse
    Left = 472
    Top = 64
  end
end
