unit Sg0000;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ExtCtrls, jpeg, StdCtrls, Grids, DBGrids,
  RDprint, Buttons, Mask, DBCtrls, DB, ExtDlgs, IBX.IBCustomDataSet, IBX.IBQuery,
  sBitBtn, Vcl.ButtonGroup, sPanel, sSpeedButton;

type
  TSg_0000 = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Sair1: TMenuItem;
    StatusBar1: TStatusBar;
    Image1: TImage;
    Timer1: TTimer;
    AClientes1: TMenuItem;
    AFinalizarSistema1: TMenuItem;
    BNovoLogin1: TMenuItem;
    RDprint1: TRDprint;
    ESTOQUES1: TMenuItem;
    EContasReceber1: TMenuItem;
    Manuteno1: TMenuItem;
    Baixa1: TMenuItem;
    Relatrio1: TMenuItem;
    BBoletos1: TMenuItem;
    GerarBoleto1: TMenuItem;
    GerarParcelas1: TMenuItem;
    IBQ_PesqSocio: TIBQuery;
    DS_PesqSocio: TDataSource;
    N1: TMenuItem;
    sPanel1: TsPanel;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    sSpeedButton4: TsSpeedButton;
    N2: TMenuItem;
    procedure Acessa_Sistema;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure AFinalizarSistema1Click(Sender: TObject);
    procedure BNovoLogin1Click(Sender: TObject);
    procedure AClientes1Click(Sender: TObject);
    procedure Manuteno1Click(Sender: TObject);
    procedure Baixa1Click(Sender: TObject);
    procedure Relatrio1Click(Sender: TObject);
    procedure GerarBoleto1Click(Sender: TObject);
    procedure GerarParcelas1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    i, j : Integer;
  public

  end;

var
  Sg_0000: TSg_0000;

implementation

uses SgSen, Arquivos, Sg0020, Sg0022, Sg0021, Sg0022A,
  Sg0023, Sg0024, Sg0025;


{$R *.dfm}

procedure TSg_0000.FormActivate(Sender: TObject);
begin
   // Coloca Tela de FundO
   if FileExists('c:\windows\tela.jpg') then
      Image1.Picture.LoadFromFile('c:\windows\tela.jpg');

   if FileExists('c:\windows\tela.bmp') then
      Image1.Picture.LoadFromFile('c:\windows\tela.bmp');

   Image1.Align := alClient;

   // PazPrev = s� tem acesso � Agenda
   if Dm.IBDS_Empresa.FieldByName('NIVEL').AsInteger = 4 then
     begin
        Cadastros1.Visible    := False;

        ESTOQUES1.Visible     := False;
       // RELATRIOS1.Visible    := False;
     end;
  end;

procedure TSg_0000.FormCreate(Sender: TObject);
begin
   // Verifica se o Programa j� est� em execu��o
   if FindWindow('TSG_Sen', nil) > 0 then
     begin
        ShowMessage('O SISTEMA J� EST� SENDO EXECUTADO!!!');
        Application.Terminate;
     end;

   Acessa_Sistema;
end;

procedure TSg_0000.Timer1Timer(Sender: TObject);
begin
   // Faz Nome Movimentar
   StatusBar1.Panels.Items[0].Text := Copy(Dm.IBDS_Empresa.FieldByName('RAZAO_SOCIAL').AsString, Length(Dm.IBDS_Empresa.FieldByName('RAZAO_SOCIAL').AsString) - i, j);
   inc(i);
   inc(j);

   if i = Length(Dm.IBDS_Empresa.FieldByName('RAZAO_SOCIAL').AsString) then
      Timer1.Enabled := False;
end;

procedure TSg_0000.AFinalizarSistema1Click(Sender: TObject);
begin
   Application.Terminate;
end;

procedure TSg_0000.BNovoLogin1Click(Sender: TObject);
begin
   SG_Sen.Destroy;
   Acessa_Sistema;
end;

procedure TSg_0000.Acessa_Sistema;
begin
   // Tela de Senha
   SG_Sen := TSG_Sen.create(self);
   SG_Sen.Timer1.Enabled := True;
   SG_Sen.ShowModal;
   SG_Sen.Timer1.Enabled := False;

   // Mostra Status
   StatusBar1.Panels.Items[1].Text := 'Data Acesso: '    + DateToStr(Date);
   StatusBar1.Panels.Items[2].Text := 'Hora Acesso: '    + TimeToStr(Time);;

   // Timer
   Timer1.Enabled := True;
   i := 0;
   j := 1;
end;

procedure TSg_0000.AClientes1Click(Sender: TObject);
begin
   SG_0020 := TSG_0020.Create(Self);
   SG_0020.ShowModal;
   SG_0020.Destroy;
end;

procedure TSg_0000.Manuteno1Click(Sender: TObject);
begin
   SG_0022 := TSG_0022.Create(Self);
   SG_0022.ShowModal;
   SG_0022.Destroy;
end;

procedure TSg_0000.N1Click(Sender: TObject);
begin
   SG_0025 := TSG_0025.Create(Self);
   SG_0025.ShowModal;
   SG_0025.Destroy;
end;

procedure TSg_0000.Baixa1Click(Sender: TObject);
begin
   SG_0021 := TSG_0021.Create(Self);
   SG_0021.ShowModal;
   SG_0021.Destroy;
end;

procedure TSg_0000.Relatrio1Click(Sender: TObject);
begin
   SG_0022A := TSG_0022A.Create(Self);
   SG_0022A.ShowModal;

   SG_0022A.Destroy;
end;

procedure TSg_0000.GerarBoleto1Click(Sender: TObject);
begin
   SG_0023 := TSG_0023.Create(Self);
   SG_0023.ShowModal;
   SG_0023.Destroy;
end;

procedure TSg_0000.GerarParcelas1Click(Sender: TObject);
begin
   SG_0024 := TSG_0024.Create(Self);
   SG_0024.ShowModal;
   SG_0024.Destroy;
end;

end.


//senha 111950
