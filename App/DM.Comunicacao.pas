unit DM.Comunicacao;

interface

uses
  System.SysUtils, System.Classes, REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  TdmComunicacao = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
  private
    { Private declarations }
  public
    { Public declarations }
    function GerarJSONCarregamento (ARequest: TRESTRequest; AEtiqueta: string; AEmpresa, ABase: integer): string;
    procedure ConfigurarConexaoCarregamento(AClient: TRESTClient; ARequest: TRESTRequest; ABody: string);

  end;

var
  dmComunicacao: TdmComunicacao;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
uses
  System.JSON.Types,
  System.JSON.Writers;

{$R *.dfm}

{ TdmComunicacao }

CONST
  // NGROK const for Server Adrress
  // Muda constantemente, deve apontar para o servidor:porta,
  // que no caso utilizamos o NGROK (FREE) para redirecionar - CPBR16
  NGROK = 'https://c9cf-201-157-251-183.ngrok-free.app/'  ;

procedure TdmComunicacao.ConfigurarConexaoCarregamento(AClient: TRESTClient; ARequest: TRESTRequest; ABody: string);
begin
  AClient.BaseURL := NGROK + 'workshop'; //como nomeado na criação do Servidor CPBR16
  ARequest.Method :=  rmPost;
  ARequest.Resource := 'operacoes/' ;  //como definido o sufixo para a tabela de OPERACOES
  ARequest.Body.Add(ABody, DefaultRESTContentType.ctAPPLICATION_JSON);
end;

function TdmComunicacao.GerarJSONCarregamento(ARequest: TRESTRequest; AEtiqueta: string; AEmpresa, ABase: integer): string;
var
  Writer: TJsonTextWriter;
  StringWriter: TStringWriter;
begin
  Result := EmptyStr;
  ARequest.Body.ClearBody;
  ARequest.Body.JSONWriter.WriteStartObject;
  ARequest.Body.JSONWriter.WritePropertyName('ID_OPERACAO');
  ARequest.Body.JSONWriter.WriteValue(-1);
  ARequest.Body.JSONWriter.WritePropertyName('REGISTRO');
  ARequest.Body.JSONWriter.WriteValue(AEtiqueta);
  ARequest.Body.JSONWriter.WritePropertyName('DATA');
  ARequest.Body.JSONWriter.WriteValue(FormatDateTime('dd/mm/yyyy', Now));
  ARequest.Body.JSONWriter.WritePropertyName('HORA');
  ARequest.Body.JSONWriter.WriteValue(FormatDateTime('HH:MM:SS', Now));
  ARequest.Body.JSONWriter.WritePropertyName('ID_BASE');
  ARequest.Body.JSONWriter.WriteValue(ABase);
  ARequest.Body.JSONWriter.WritePropertyName('ID_EMPRESA');
  ARequest.Body.JSONWriter.WriteValue(AEmpresa);
  ARequest.Body.JSONWriter.WriteEndObject;
  Result := ARequest.Body.JSONWriter.ToString;


{$region 'Modelo de JSON usado'}

//{
//    "ID_OPERACAO": -1,
//    "REGISTRO": "9788532635792",
//    "DATA": "13/07/2024",
//    "HORA": "12:36:26",
//    "ID_BASE": 1,
//    "ID_EMPRESA": 1
//}

{$endregion}

end;

end.


