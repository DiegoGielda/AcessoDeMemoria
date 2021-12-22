unit frmRAM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmTerceiroRAM = class(TForm)
    pnlSAM: TPanel;
    gbConfiguracoes: TGroupBox;
    btnImportarRAM: TSpeedButton;
    btnVoltarRAM: TSpeedButton;
    txtImportarRAM: TLabeledEdit;
    gbConsultaSAM: TGroupBox;
    btnConsultar: TSpeedButton;
    txtConsultaCampo: TLabeledEdit;
    gbResultadoSAM: TGroupBox;
    lblRAMResultadoRAM: TLabel;
    lblRAMResultadoSAM: TLabel;
    OpenArquivoTxt: TOpenDialog;
    txtValorTotalRAM: TLabeledEdit;
    btlLimparLabel: TSpeedButton;
    lblQtdSAM: TLabel;
    txtQtdSAM: TEdit;
    lblQtdRAM: TLabel;
    txtQtdRAM: TEdit;
    gridProcessos: TStringGrid;
    procedure btnVoltarRAMClick(Sender: TObject);
    procedure btnImportarRAMClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure txtValorTotalRAMKeyPress(Sender: TObject; var Key: Char);
    procedure btlLimparLabelClick(Sender: TObject);
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
  frmTerceiroRAM: TfrmTerceiroRAM;

implementation

uses
  frmEscolha;

{$R *.dfm}

procedure TfrmTerceiroRAM.AlteraLabel(pLabel: TLabel; pNovoTexto: String);
begin
  pLabel.Caption := pNovoTexto;
end;

procedure TfrmTerceiroRAM.btnConsultarClick(Sender: TObject);
var
  lCont, lRand: Integer;
begin
  ValidarCampo();
  for lCont := 1 to StrToInt(txtValorTotalRAM.Text) do
  begin
    lRand := Random(gridProcessos.RowCount);
    if (gridProcessos.Cells[0,lRand]  = (txtConsultaCampo.Text)) then
    begin
      FValorTotalConsultasSAM := FValorTotalConsultasSAM + (lCont);
      Inc(FContador);
      lblRAMResultadoRAM.Caption := 'Média de busca para RAM foi de: ' + FormatFloat('#.#',(FValorTotalConsultasSAM / FContador));
      txtQtdRAM.Text := IntToStr(FContador);
      txtConsultaCampo.Text := '';
      exit;
    end;
    AlteraLabel(lblRAMResultadoRAM, 'PALAVRA NÃO ENCONTRADA! VERIFIQUE.');
  end;
end;

procedure TfrmTerceiroRAM.btnImportarRAMClick(Sender: TObject);
begin
  if OpenArquivoTxt.Execute then
  begin
    txtImportarRAM.Text := ExtractFileName(OpenArquivoTxt.FileName);
    ImportarConteudo();
  end;
end;

procedure TfrmTerceiroRAM.btnVoltarRAMClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTerceiroRAM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FValorTotalConsultasSAM := 0;
  FContador := 0;
end;

procedure TfrmTerceiroRAM.FormCreate(Sender: TObject);
begin
  FValorTotalConsultasSAM := 0;
  FContador := 0;
end;

procedure TfrmTerceiroRAM.ImportarConteudo;
var
  lListaInformacao: TStrings;
  lRam, lCont: Integer;
begin
  try
    lListaInformacao := TStringList.Create();
     lListaInformacao.LoadFromFile((ExtractFilePath(Application.ExeName) + ExtractFileName(OpenArquivoTxt.FileName)), TEncoding.UTF8);
    gridProcessos.RowCount := lListaInformacao.Count;
    lCont := 0;
    Randomize;
    while not (lListaInformacao.Count = 0) do
    begin
      lRam := Random(lListaInformacao.Count);
      gridProcessos.Cells[0,lCont] := lListaInformacao[lRam];
      Inc(lCont);
      lListaInformacao.Delete(lRam);
    end;
    lListaInformacao.Free;
  except
    ShowMessage('Processo não ocorreu corretamente!');
  end;
end;

procedure TfrmTerceiroRAM.btlLimparLabelClick(Sender: TObject);
begin
  lblRAMResultadoRAM.Caption := 'Média de busca para RAM foi de: ';
  lblRAMResultadoSAM.Caption := 'Média de busca para SAM foi de: ';
  txtQtdSAM.Text := '';
  txtQtdRAM.Text := '';
  txtValorTotalRAM.Text := '';
  txtConsultaCampo.Text := '';
  FContador := 0;
  FValorTotalConsultasSAM := 0;
end;

procedure TfrmTerceiroRAM.txtValorTotalRAMKeyPress(Sender: TObject; var Key: Char);
begin
  if not(key in ['0'..'9']) then
    key := #0;
end;

procedure TfrmTerceiroRAM.ValidarCampo;
begin
  { Consulta de registro vazio
  if (txtConsultaCampo.Text = '') then
  begin
    raise Exception.Create('Informe um valor para consulta!');
  end;
  }
  if (txtValorTotalRAM.Text = '') then
  begin
    raise Exception.Create('Informe a quantidade de consultas!');
  end;
end;

end.
