unit frmEscolha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls;

type
  TfrmPrincipalEscolha = class(TForm)
    pnlPrincipal: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FValorRAM: string;
    FValorSAM: string;
    FQuantidadeRAM: string;
    FQuantidadeSAM: string;
  end;

var
  frmPrincipalEscolha: TfrmPrincipalEscolha;

implementation

uses
  frmSAM, frmRAM;

{$R *.dfm}

procedure TfrmPrincipalEscolha.Button1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipalEscolha.FormCreate(Sender: TObject);
begin
    FValorRAM := 'Média de busca para RAM foi de: ';
    FValorSAM := 'Média de busca para SAM foi de: ';
end;

procedure TfrmPrincipalEscolha.SpeedButton1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmTerceiroRAM, frmTerceiroRAM);

  frmTerceiroRAM.lblRAMResultadoRAM.Caption := FValorRAM;
  frmTerceiroRAM.lblRAMResultadoSAM.Caption := FValorSAM;
  frmTerceiroRAM.txtQtdRAM.Text := FQuantidadeRAM;
  frmTerceiroRAM.txtQtdSAM.Text := FQuantidadeSAM;

  frmTerceiroRAM.ShowModal;

  FValorRAM := frmTerceiroRAM.lblRAMResultadoRAM.Caption;
  FValorSAM := frmTerceiroRAM.lblRAMResultadoSAM.Caption;
  FQuantidadeRAM := frmTerceiroRAM.txtQtdRAM.Text;
  FQuantidadeSAM := frmTerceiroRAM.txtQtdSAM.Text;
end;

procedure TfrmPrincipalEscolha.SpeedButton2Click(Sender: TObject);
begin
  Application.CreateForm(TfrmSecundarioSAM, frmSecundarioSAM);

  frmSecundarioSAM.lblSAMResultadoSAM.Caption := FValorSAM;
  frmSecundarioSAM.lblSAMResultadoRAM.Caption := FValorRAM;
  frmSecundarioSAM.txtQtdRAM.Text := FQuantidadeRAM;
  frmSecundarioSAM.txtQtdSAM.Text := FQuantidadeSAM;

  frmSecundarioSAM.ShowModal;

  FValorRAM := frmSecundarioSAM.lblSAMResultadoRAM.Caption;
  FValorSAM := frmSecundarioSAM.lblSAMResultadoSAM.Caption;
  FQuantidadeRAM := frmSecundarioSAM.txtQtdRAM.Text;
  FQuantidadeSAM := frmSecundarioSAM.txtQtdSAM.Text;
end;

end.
