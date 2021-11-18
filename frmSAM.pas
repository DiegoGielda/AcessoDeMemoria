unit frmSAM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  RzGrids;

type
  TfrmSecundarioSAM = class(TForm)
    pnlSAM: TPanel;
    txtImportar: TLabeledEdit;
    gbConfiguracoes: TGroupBox;
    btnImportarSAM: TSpeedButton;
    btnVoltar: TSpeedButton;
    OpenArquivoTxt: TOpenDialog;
    gridProcessos: TRzStringGrid;
    gbConsultaSAM: TGroupBox;
    txtConsultaCampo: TLabeledEdit;
    btnConsultar: TSpeedButton;
    gbResultadoSAM: TGroupBox;
    lblSAMResultadoSAM: TLabel;
    lblSAMResultadoRAM: TLabel;
    txtValorTotalSAM: TLabeledEdit;
    btnLimparLabel: TSpeedButton;
    lblQtdSAM: TLabel;
    lblQtdRAM: TLabel;
    txtQtdRAM: TEdit;
    txtQtdSAM: TEdit;
    procedure btnVoltarClick(Sender: TObject);
    procedure btnImportarSAMClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtValorTotalSAMKeyPress(Sender: TObject; var Key: Char);
    procedure btnLimparLabelClick(Sender: TObject);
  private
    { Private declarations }
    FValorTotalConsultasSAM: Integer;
    FContador: Integer;
    procedure ImportarConteudo();
    procedure AlteraLabel(pLabel: TLabel; pNovoTexto: String);
    procedure ValidarCampo();
  public
    { Public declarations }
  end;

var
  frmSecundarioSAM: TfrmSecundarioSAM;

implementation

{$R *.dfm}

procedure TfrmSecundarioSAM.AlteraLabel(pLabel: TLabel; pNovoTexto: String);
begin
  pLabel.Caption := pNovoTexto;
end;


procedure TfrmSecundarioSAM.btnConsultarClick(Sender: TObject);
var
  lCont: Integer;
begin
  ValidarCampo();
  for lCont := 1 to StrToInt(txtValorTotalSAM.Text) do
  begin
    if(gridProcessos.Cells[0,lCont -1] = (txtConsultaCampo.Text)) then
    begin
      FValorTotalConsultasSAM := FValorTotalConsultasSAM + (lCont);
      Inc(FContador);
      lblSAMResultadoSAM.Caption := 'Média de busca para SAM foi de: ' + FormatFloat('#.#',(FValorTotalConsultasSAM / FContador));
      txtQtdSAM.Text := IntToStr(FContador);
      txtConsultaCampo.Text := '';
      exit;
    end;
    AlteraLabel(lblSAMResultadoSAM, 'PALAVRA NÃO ENCONTRADA! VERIFIQUE.');
  end;
end;

procedure TfrmSecundarioSAM.btnImportarSAMClick(Sender: TObject);
begin
  if OpenArquivoTxt.Execute then
  begin
    txtImportar.Text := ExtractFileName(OpenArquivoTxt.FileName);
    ImportarConteudo();
  end;
end;

procedure TfrmSecundarioSAM.btnLimparLabelClick(Sender: TObject);
begin
  lblSAMResultadoRAM.Caption := 'Média de busca para RAM foi de: ';
  lblSAMResultadoSAM.Caption := 'Média de busca para SAM foi de: ';
  txtQtdSAM.Text := '';
  txtQtdRAM.Text := '';
  txtValorTotalSAM.Text := '';
  txtConsultaCampo.Text := '';
  FContador := 0;
  FValorTotalConsultasSAM := 0;
end;

procedure TfrmSecundarioSAM.ImportarConteudo;
var
  lListaInformacao: TStrings;
  lCont: Integer;
begin
  lListaInformacao := TStringList.Create();
  lListaInformacao.LoadFromFile((ExtractFilePath(Application.ExeName) + ExtractFileName(OpenArquivoTxt.FileName)), TEncoding.UTF8);
  gridProcessos.RowCount := lListaInformacao.Count;
  for lCont := 0 to Pred(lListaInformacao.Count) do
  begin
    gridProcessos.Cells[0,lCont] :=  lListaInformacao[lCont];
  end;
  lListaInformacao.Free;
end;

procedure TfrmSecundarioSAM.txtValorTotalSAMKeyPress(Sender: TObject; var Key: Char);
begin
  if not(key in ['0'..'9']) then
    key := #0;
end;

procedure TfrmSecundarioSAM.ValidarCampo;
begin
  { Consulta de registro vazio
  if (txtConsultaCampo.Text = '') then
  begin
    raise Exception.Create('Informe um valor para consulta!');
  end;
  }
  if (txtValorTotalSAM.Text = '') then
  begin
    raise Exception.Create('Informe a quantidade de consultas!');
  end;
end;

procedure TfrmSecundarioSAM.btnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSecundarioSAM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FValorTotalConsultasSAM := 0;
  FContador := 0;
end;

procedure TfrmSecundarioSAM.FormCreate(Sender: TObject);
begin
  FValorTotalConsultasSAM := 0;
  FContador := 0;
end;

end.
