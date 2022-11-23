unit Sg0021;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, Mask, DBCtrls,
  ComCtrls, DB, IBCustomDataSet, RDprint, Gauges;

type
  TSg_0021 = class(TForm)
    Pan_Botao: TPanel;
    Bbtn_Gerar: TBitBtn;
    Bbtn_Sair: TBitBtn;
    Bevel1: TBevel;
    Pan_Geral: TPanel;
    Pan_Cliente: TPanel;
    Edit_codSocio: TEdit;
    Edit_nome_socio: TEdit;
    Label1: TLabel;
    Pan_Periodo: TPanel;
    MEdit_dt1: TMaskEdit;
    MEdit_dt2: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    Speed_limpa_data: TSpeedButton;
    Pan_Dados: TPanel;
    Lbl_Titulo: TLabel;
    ListBox_Receber: TListBox;
    Pan_Baixar: TPanel;
    Edit_Desc: TEdit;
    Edit_Acres: TEdit;
    Edit_Pago: TEdit;
    MEdit_DtReceb: TMaskEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    SB_Selecao: TSpeedButton;
    SB_NSelecao: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Bevel2: TBevel;
    Speed_cli: TSpeedButton;
    Speed_limpa_cli: TSpeedButton;
    Pan_Botao2: TPanel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    bbtn_baixar: TBitBtn;
    bbtn_gravar: TBitBtn;
    Bbtn_Cancelar: TBitBtn;
    Label5: TLabel;
    Lbl_Total: TLabel;
    Bevel5: TBevel;
    RDprint1: TRDprint;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Label4: TLabel;
    Edit_Nosso: TEdit;
    GB_Retorno: TGroupBox;
    SB_Retorno: TSpeedButton;
    Edit_Retorno: TEdit;
    OpenDialog1: TOpenDialog;
    Pan_Mens: TPanel;
    Panel2: TPanel;
    Label6: TLabel;
    procedure Baixa_Arquivo;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure Speed_cliClick(Sender: TObject);
    procedure Edit_codSocioEnter(Sender: TObject);
    procedure Speed_limpa_cliClick(Sender: TObject);
    procedure MEdit_dt1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MEdit_dt2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Speed_limpa_dataClick(Sender: TObject);
    procedure Bbtn_SairClick(Sender: TObject);
    procedure SB_SelecaoClick(Sender: TObject);
    procedure SB_NSelecaoClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure Edit_DescKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit_DescKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_AcresKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit_PagoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MEdit_DtRecebKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Bbtn_GerarClick(Sender: TObject);
    procedure bbtn_baixarClick(Sender: TObject);
    procedure Bbtn_CancelarClick(Sender: TObject);
    procedure bbtn_gravarClick(Sender: TObject);
    procedure Edit_AcresKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_PagoKeyPress(Sender: TObject; var Key: Char);
    procedure RG_Cred_DebClick(Sender: TObject);
    procedure Edit_NossoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_RetornoClick(Sender: TObject);
  private
    sdata      : String;
    ComponAnt  : TEdit;
    ComponAnt2 : TMaskEdit;
    procedure ControlChange(Sender : TObject);
    { Private declarations }
  public
    sdtpagto :String;
  end;

var
  Sg_0021: TSg_0021;

implementation

uses Arquivos, Sg0000,Sg0020,Sg20, Sgf0002p, Sgf0003p, SGF0012P, IBQuery;


{$R *.dfm}

function Alltrim(Text : string) : string;
begin
   while Pos(' ',Text) > 0 do Delete(Text,Pos(' ',Text),1);
   Result := Text;
end;

procedure TSg_0021.ControlChange(Sender : TObject);
begin
   if Assigned(ComponAnt)  then ComponAnt.color  := clWhite;
   if Assigned(ComponAnt2) then ComponAnt2.color := clWhite;

   if ActiveControl is TEdit then
     begin
        TEdit(ActiveControl).Color := $0080FFFF;
        ComponAnt := TEdit(ActiveControl);
     end
   else
     ComponAnt := nil;

   if ActiveControl is TMaskEdit then
     begin
        TMaskEdit(ActiveControl).Color := $0080FFFF;
        ComponAnt2 := TMaskEdit(ActiveControl);
     end
   else
     ComponAnt2 := nil;
end;

procedure TSg_0021.FormShow(Sender: TObject);
begin
   Screen.OnActiveControlChange := ControlChange;

   // Limpa os 2 ListBox
   ListBox_Receber.Clear;

   // Inicializa Totais
   Lbl_Total.Caption := FloatToStrF(0,ffNumber,10,2);
   sdata             := DateToStr(Date);

   Bbtn_Gerar.SetFocus;
end;

procedure TSg_0021.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssAlt]) and (Key = VK_F4) then Key := VK_Clear;
  if key = vk_return   then Perform(wm_NextDlgCtl,0,0);
  if key = vk_escape   then Perform(wm_NextDlgCtl,1,0);
  if key = vk_f5       then if Pan_Geral.Enabled   = True then Speed_cli.Click;
  if key = vk_f6       then if Pan_Geral.Enabled   = True then MEdit_dt1.SetFocus;
  if key = vk_f7       then if Pan_Geral.Enabled   = True then Edit_Nosso.SetFocus;
  if key = vk_f8       then if Bbtn_Baixar.Enabled = True then Bbtn_Baixar.Click;
end;

procedure TSg_0021.FormDestroy(Sender: TObject);
begin
   Screen.OnActiveControlChange := Nil;
end;

procedure TSg_0021.Speed_cliClick(Sender: TObject);
begin
   Dlg_Socio.SB_Nova.Visible := False;
   Dlg_Socio.Edit_pesquisa.Clear;
   if Dlg_Socio.ShowModal = MrOk then
     begin
        Edit_codSocio.Text  := Dlg_Socio.SQL_pesquisa.FieldByName('CODIGO').AsString;
        Edit_nome_socio.Text := Dlg_Socio.SQL_pesquisa.FieldByName('NOME').AsString;
        while length(Edit_codSocio.Text) < 6 do Edit_codSocio.Text := '0' + Edit_codSocio.Text;
     end;
   bbtn_gerar.SetFocus;
end;

procedure TSg_0021.Edit_codSocioEnter(Sender: TObject);
begin
   bbtn_gerar.SetFocus;
end;

procedure TSg_0021.Speed_limpa_cliClick(Sender: TObject);
begin
   Edit_codSocio.Text  := '000000';
   Edit_nome_socio.Text := 'TODOS';
end;

procedure TSg_0021.MEdit_dt1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = vk_return) and (MEdit_dt1.Text <> '  /  /    ') then
     begin
        try
           MEdit_dt1.Text := DateToStr(StrToDate(MEdit_dt1.Text));
        except
           ShowMessage('Data Inv�lida!!!');
           MEdit_dt1.SetFocus;
           exit;
        end;
        MEdit_dt2.SetFocus;
     end;
end;

procedure TSg_0021.MEdit_dt2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = vk_return) and (MEdit_dt2.Text <> '  /  /    ') then
     begin
        try
           MEdit_dt2.Text := DateToStr(StrToDate(MEdit_dt2.Text));
           if StrToDate(MEdit_dt2.Text) < StrToDate(MEdit_dt1.Text) then
             begin
                ShowMessage('Data Final est� MAIOR que Data Inicial!!!');
                MEdit_dt2.SetFocus;
             end
           else
             bbtn_gerar.SetFocus;
        except
           ShowMessage('Data Inv�lida!!!');
           MEdit_dt2.SetFocus;
           exit;
        end;
     end;
end;

procedure TSg_0021.Speed_limpa_dataClick(Sender: TObject);
begin
   MEdit_dt1.Text := '  /  /    ';
   MEdit_dt2.Text := '  /  /    ';
end;

procedure TSg_0021.Bbtn_SairClick(Sender: TObject);
begin
   Close;
end;

procedure TSg_0021.SB_SelecaoClick(Sender: TObject);
var i, k, j : Integer;
begin
   // Verifica o item selecionado
   k := 0;
   j := 0;
   for i := 0 to (ListBox_Receber.Items.Count - 1) do
     begin
        k := i - j;
        if ListBox_Receber.Selected[k] = True then
          begin
             Lbl_Total.Caption := FloatToStrF(StrToFloat(Lbl_Total.Caption) - StrToFloat(Copy(ListBox_Receber.Items.Strings[k],94,09)),ffFixed,9,2);
             ListBox_Receber.Items.Delete(k);
             j := j + 1;
          end;
     end;

   if ListBox_Receber.Count = 0 then
     begin
        ShowMessage('Todas as Notas foram Exclu�das!!! Baixa ser� Cancelada!!!');
        SB_Cancelar.Click;
     end
   else
      bbtn_baixar.SetFocus;
end;

procedure TSg_0021.SB_NSelecaoClick(Sender: TObject);
var i, k, j : Integer;
begin
   // Verifica o item selecionado
   k := 0;
   j := 0;
   for i := 0 to (ListBox_Receber.Items.Count - 1) do
     begin
        k := i - j;
        if ListBox_Receber.Selected[k] = False then
          begin
              Lbl_Total.Caption   := FloatToStrF(StrToFloat(Lbl_Total.Caption)   - StrToFloat(Copy(ListBox_Receber.Items.Strings[k],94,09)),ffFixed,9,2);
              ListBox_Receber.Items.Delete(k);
             j := j + 1;
          end;
     end;

   if ListBox_Receber.Count = 0 then
     begin
        ShowMessage('Todas as Notas foram Exclu�das!!! Baixa ser� Cancelada!!!');
        SB_Cancelar.Click;
     end
   else
      bbtn_baixar.SetFocus;
end;

procedure TSg_0021.SB_CancelarClick(Sender: TObject);
begin
   // Desabilita/Habilita Bot�es
   Pan_dados.Enabled     := False;
   Pan_Baixar.Enabled    := True;
   Pan_Botao2.Enabled    := False;
   Pan_Geral.Enabled     := True;
   bbtn_baixar.Enabled   := False;
   Bbtn_Gravar.Enabled   := False;
   Bbtn_Cancelar.Enabled := False;
   Bbtn_Gerar.Enabled    := True;
   Bbtn_Sair.Enabled     := True;
   SB_Cancelar.Enabled   := False;
   SB_Selecao.Enabled    := False;
   SB_NSelecao.Enabled   := False;

   // Limpa Campos
   Lbl_Total.Caption     := FloatToStrF(0,ffFixed,9,2);
   Pan_dados.Enabled     := True;
   Edit_codsocio.Text     := '000000';
   Edit_Nome_socio.Text    := 'TODOS';
   MEdit_dt1.Text        := '  /  /    ';
   MEdit_dt2.Text        := '  /  /    ';
   MEdit_DtReceb.Text    := '  /  /    ';
   Edit_Desc.Text        := '      0,00';
   Edit_Acres.Text       := '      0,00';
   Edit_Pago.Text        := '      0,00';
   ListBox_Receber.Clear;
   Bbtn_Sair.SetFocus;
end;

procedure TSg_0021.Edit_DescKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_return then
     begin
        // Formata Campos
        Edit_Desc.Text := FloatToStrF(StrToFloat(Edit_Desc.Text) ,ffFixed,10,2);
        while Length(Edit_Desc.Text) < 10 do Edit_Desc.Text := ' ' + Edit_Desc.Text;

        // Calcular Valor
        Edit_Pago.Text := FloatToStrF(StrToFloat(Lbl_Total.Caption) - StrToFloat(Edit_Desc.Text) + StrToFloat(Edit_Acres.Text),ffFixed,10,2);
        while Length(Edit_Pago.Text) < 10 do Edit_Pago.Text := ' ' + Edit_Pago.Text;

        // Direciona Foco
        Edit_Acres.Text := Trim(Edit_Acres.Text);
        Edit_Acres.SelectAll;
        Edit_Acres.SetFocus;
     end;
end;

procedure TSg_0021.Edit_DescKeyPress(Sender: TObject; var Key: Char);
var i : Integer;
begin
   // Se digitar 'ponto', substitui por 'virgula'
   if key = chr(46) then key := chr(44);

   // N�o permite digitar 'letra'
   if (not (key in ['0'..'9'])) and (key <> chr(8)) and (key <> chr(44)) then
     key := chr(0);

   // Rotina que n�o permite ter duas 'v�rgulas' no Edit
   if (key = chr(46)) or (key = chr(44)) then
     begin
        for i := 1 to Length(Edit_Desc.Text) do
          begin
             if Copy(Edit_Desc.Text,i,1) = chr(44) then
               begin
                  key := chr(0);
                  Exit;
               end;
          end;
     end;
end;

procedure TSg_0021.Edit_AcresKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_return then
     begin
        // Formata Campos
        Edit_Desc.Text  := FloatToStrF(StrToFloat(Edit_Desc.Text) ,ffFixed,10,2);
        Edit_Acres.Text := FloatToStrF(StrToFloat(Edit_Acres.Text),ffFixed,10,2);
        while Length(Edit_Desc.Text)  < 10 do Edit_Desc.Text  := ' ' + Edit_Desc.Text;
        while Length(Edit_Acres.Text) < 10 do Edit_Acres.Text := ' ' + Edit_Acres.Text;

        // Calcular Valor
        Edit_Pago.Text := FloatToStrF(StrToFloat(Lbl_Total.Caption) - StrToFloat(Edit_Desc.Text) + StrToFloat(Edit_Acres.Text),ffFixed,10,2);
        while Length(Edit_Pago.Text) < 10 do Edit_Pago.Text := ' ' + Edit_Pago.Text;

        // Direciona Foco
        Edit_Pago.Text := Trim(Edit_Pago.Text);
        Edit_Pago.SelectAll;
        Edit_Pago.SetFocus;
     end;
end;

procedure TSg_0021.Edit_PagoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_return then
     begin
        // Formata Campos
        Edit_Pago.Text := FloatToStrF(StrToFloat(Edit_Pago.Text) ,ffFixed,10,2);
        while Length(Edit_Pago.Text) < 10 do Edit_Pago.Text := ' ' + Edit_Pago.Text;

        MEdit_DtReceb.SelectAll;
        MEdit_DtReceb.SetFocus;
     end;
end;

procedure TSg_0021.MEdit_DtRecebKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = vk_return) and (MEdit_DtReceb.Text <> '  /  /    ') then
     begin
        try
           MEdit_DtReceb.Text := DateToStr(StrToDate(MEdit_DtReceb.Text));
        except
           ShowMessage('Data Inv�lida!!!');
           MEdit_DtReceb.SetFocus;
           Exit;
        end;
        bbtn_gravar.SetFocus;
     end;
end;

procedure TSg_0021.Bbtn_GerarClick(Sender: TObject);
var slinha, scodigo,  scodcli, snomecli, sdocumento,
    sdtemissao, sdtvencto, svalor, sdtpagto : String;
begin
   if Edit_Retorno.Text <> '' then
     begin
        Baixa_Arquivo;
        Exit;
     end;


   if Edit_codSocio.Text = '' then
     begin
        Edit_codSocio.Text   := '000000';
        Edit_nome_socio.Text := 'TODOS';
     end;

   with Dm.IBQ_Pesquisa,SQL do
     begin
        close;
        clear;
        add('select a.*, b.nome from receber a, socio b ');
        add('where (a.cod_socio = b.codigo) and (a.dt_pagto is null) ');

        if (MEdit_dt1.Text <> '  /  /    ') and (MEdit_dt2.Text <> '  /  /    ') then Add('and a.dt_vencto between :dt1 and :dt2 ');
        if Edit_nome_socio.Text <> 'TODOS'  then Add('and (a.cod_socio = :cod) ');
        if Edit_Nosso.Text <> '' then Add('and (a.nosso_nro = :nosso) ');

        add('order by a.dt_vencto, a.nosso_nro, a.mes, a.cod_socio ');

        if (MEdit_dt1.Text <> '  /  /    ') and (MEdit_dt2.Text <> '  /  /    ') then
          begin
             ParamByName('DT1').AsDateTime := StrToDate(MEdit_dt1.Text);
             ParamByName('DT2').AsDateTime := StrToDate(MEdit_dt2.Text);
          end;
        if Edit_nome_socio.Text <> 'TODOS'  then ParamByName('COD').AsInteger  := StrToInt(Edit_codSocio.text);
        if Edit_Nosso.Text <> '' then ParamByName('NOSSO').AsString := Edit_Nosso.Text;
        Open;
     end;

   // Verifica se tem Parcelas a Receber
   if Dm.IBQ_Pesquisa.RecordCount > 0 then
     begin
        // Mostra as Parcelas a Receber
        Dm.IBQ_Pesquisa.First;
        while not Dm.IBQ_Pesquisa.Eof do
          begin
             // Move Dados para Vari�veis
             scodigo    := Dm.IBQ_Pesquisa.FieldByName('CODIGO').AsString;
             scodcli    := Dm.IBQ_Pesquisa.FieldByName('COD_SOCIO').AsString;
             snomecli   := Copy(Dm.IBQ_Pesquisa.FieldByName('NOME').AsString     ,1,38);
             sdocumento := Copy(Dm.IBQ_Pesquisa.FieldByName('NOSSO_NRO').AsString,1,11);
             sdtemissao := Dm.IBQ_Pesquisa.FieldByName('DT_EMISSAO').AsString;
             sdtvencto  := Dm.IBQ_Pesquisa.FieldByName('DT_VENCTO').AsString;
             svalor     := FloatToStrF(Dm.IBQ_Pesquisa.FieldByName('VLR_PARC').AsFloat ,ffFixed,9,2);
             sdtpagto   := '';


             // Formata Vari�veis
             while Length(scodigo)    < 06 do scodigo    := '0' + scodigo;
             while Length(scodcli)    < 06 do scodcli    := '0' + scodcli;
             while Length(snomecli)   < 38 do snomecli   := snomecli   + ' ';
             while Length(sdocumento) < 11 do sdocumento := '0' + sdocumento;
             while Length(sdtpagto)   < 10 do sdtpagto   := sdtpagto   + ' ';
             while Length(sdtemissao) < 10 do sdtemissao := sdtemissao + ' ';
             while Length(sdtvencto)  < 10 do sdtvencto  := sdtvencto  + ' ';
             while Length(svalor)     < 09 do svalor     := ' ' + svalor;


             // Adiciona Dados
             slinha := scodcli+'-'+snomecli+' '+sdocumento+'  '+sdtpagto+' '+sdtemissao+'  '+sdtvencto+'  '+svalor+'     '+scodigo;
             ListBox_Receber.Items.Add(slinha);

             // Soma Total
             Lbl_Total.Caption := FloatToStrF(StrToFloat(Lbl_Total.Caption) + Dm.IBQ_Pesquisa.FieldByName('VLR_PARC').AsFloat,ffFixed,9,2);

             // Pr�ximo Registro
             Dm.IBQ_Pesquisa.Next;

             //S�cio                                         Nosso N�mero  Pagamento Emiss�o     Vencimento  Valor Parc.
             //999999-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99999999999  99/99/9999 99/99/9999  99/99/9999  999999,99     999999
             //123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
            //         1         2         3         4         5         6         7         8         9        10        11        12

             //Cliente                                          Nosso Numero          Mes Ano   Vencto     Vl.Parc.
             //999999-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  99999999999999999999  99/99/9999  99/99/9999  999999,99     999999
             //123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
             //         1         2         3         4         5         6         7         8         9        10        11        12
          end;

        Bbtn_Gerar.Enabled    := False;
        Bbtn_Sair.Enabled     := True;
        Pan_Geral.Enabled     := False;
        Pan_dados.Enabled     := True;
        Pan_Baixar.Enabled    := False;
        Pan_Botao2.Enabled    := True;
        bbtn_baixar.Enabled   := True;
        bbtn_gravar.Enabled   := False;
        Bbtn_Cancelar.Enabled := False;
        SB_Cancelar.Enabled   := True;
        SB_Selecao.Enabled    := True;
        SB_NSelecao.Enabled   := True;
        bbtn_baixar.SetFocus;
     end
   else
     begin
        ShowMessage('N�O H� PARCELAS A RECEBER PARA OS DADOS INFORMADOS!!!');
        Bbtn_Gerar.SetFocus;
     end;
end;

procedure TSg_0021.bbtn_baixarClick(Sender: TObject);
begin
   // Habilita Bot�es
   Pan_Baixar.Enabled    := True;
   Bbtn_Baixar.Enabled   := False;
   Bbtn_Gravar.Enabled   := True;
   Bbtn_Cancelar.Enabled := True;
   Bbtn_Sair.Enabled     := False;
   SB_Cancelar.Enabled   := False;
   SB_Selecao.Enabled    := False;
   SB_NSelecao.Enabled   := False;

   if Edit_Retorno.Text <> '' then
       MEdit_DtReceb.Text   := sdtpagto
   else
      MEdit_DtReceb.Text    :=  sdata;
      
   Edit_Pago.Text        := Lbl_Total.Caption;
   Edit_Acres.Text       := FloatToStrF(0,ffFixed,13,2);
   while Length(Edit_Pago.Text)  < 10 do Edit_Pago.Text  := ' ' + Edit_Pago.Text;
   while Length(Edit_Acres.Text) < 10 do Edit_Acres.Text := ' ' + Edit_Acres.Text;

   Edit_Desc.SetFocus;
   Edit_Desc.SelectAll;
end;

procedure TSg_0021.Bbtn_CancelarClick(Sender: TObject);
begin
   // Habilita Bot�es
   Pan_Baixar.Enabled    := False;
   Bbtn_Baixar.Enabled   := True;
   Bbtn_Gravar.Enabled   := False;
   Bbtn_Cancelar.Enabled := False;
   Bbtn_Sair.Enabled     := True;
   SB_Cancelar.Enabled   := True;
   SB_Selecao.Enabled    := True;
   SB_NSelecao.Enabled   := True;

   Edit_Desc.Text        := '      0,00';
   Edit_Acres.Text       := '      0,00';
   Edit_Pago.Text        := '      0,00';
   MEdit_DtReceb.Text    := '';

   bbtn_baixar.SetFocus;
end;

procedure TSg_0021.bbtn_gravarClick(Sender: TObject);
var i, Result : Integer;
    scodigo, svalor, semissao, svencto, sconcil : String;
begin
   // Pergunta o que deseja fazer
   with CreateMessageDialog('Confirma Recebimento de Contas: ', mtConfirmation,[mbYes,mbNo]) do
     try
       for i := 0 to ComponentCount - 1 do
         if Components[i] is TButton then
           with TButton(Components[i]) do
             case ModalResult of  // X da Janela = result = 2
               mrYes    : Caption := 'N�O'; // result = 6
               mrNo     : Caption := 'SIM'; // result = 7
             end;
       Result := ShowModal;
     finally
       Free;
   end;
   if result <> 7 then Exit;


   // L� Dados para Baixar...
   for i := 0 to (ListBox_Receber.Items.Count - 1) do
     begin
        // Captura Dados

         //S�cio                                         Nosso N�mero  Pagamento Emiss�o     Vencimento  Valor Parc.
         //999999-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99999999999  99/99/9999 99/99/9999  99/99/9999  999999,99     999999
         //123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
         //         1         2         3         4         5         6         7         8         9        10        11        12

         svalor  := Copy(ListBox_Receber.Items.Strings[i],094,09);
         scodigo := Copy(ListBox_Receber.Items.Strings[i],108,07);
         
        with dm.IBQ_PesqAux,SQL do
          begin
             Close;
             Clear;
             Add('update receber set vlr_pagto = :vlr_pagto, vlr_desc = :vlr_desc, vlr_acres = :vlr_acres, dt_pagto = :dt_pagto ');
             Add('where codigo = :codigo');
             ParamByName('vlr_pagto').AsFloat := StrToFloat(svalor) - StrToFloat(Edit_Desc.Text) + StrToFloat(Edit_Acres.Text);
             ParamByName('vlr_desc').AsFloat  := StrToFloat(Edit_Desc.Text);
             ParamByName('vlr_acres').AsFloat := StrToFloat(Edit_Acres.Text);

             if Trim(Copy(ListBox_Receber.Items.Strings[i],60,10)) <> '' then
                ParamByName('dt_pagto').AsString := Copy(ListBox_Receber.Items.Strings[i],60,10)
             else
                ParamByName('dt_pagto').AsString := MEdit_DtReceb.Text;

             ParamByName('codigo').AsInteger  := StrToInt(scodigo);
             Open;
          end;
     end;


   if Application.MessageBox('Deseja gravar lan�amento no Financeiro?','Confirme',4) = MrYes then
     begin
       while True do
         begin
            // Escolhe Conta
            if Dlg_Conta.Showmodal = mrOk then
              begin
                 if (Dlg_Conta.SQL_pesquisa.FieldByName('CODIGO').AsString = '') then
                   begin
                      ShowMessage('Op��o escolhida n�o � v�lida como uma Conta!!!');
                      Continue;
                   end;

                 Dlg_ccusto.e_s := 'E'; // Entrada de dinheiro no Financeiro

                 // Escolhe Centro de Custo
                 if dlg_ccusto.showModal = MrOk then
                   begin
                      if (Dlg_ccusto.SQL_pesquisa.FieldByName('COD_CCUSTO').AsString   = '') or
                         (Dlg_ccusto.SQL_pesquisa.FieldByName('COD_CCUSTO').AsInteger <= 4)  then
                        begin
                           ShowMessage('Op��o escolhida n�o � v�lida como um Centro de Custo!!!');
                           Continue;
                        end;

                      // Escolhe Filial
                      if Dlg_Filiais.Showmodal = mrOk then
                        begin
                           if (Dlg_Filiais.SQL_pesquisa.FieldByName('CODIGO').AsString = '') then
                             begin
                                ShowMessage('Op��o escolhida n�o � v�lida como uma Filial!!!');
                                Continue;
                             end;

                           semissao := MEdit_DtReceb.Text;
                           svencto  := MEdit_DtReceb.Text;
                           sconcil  := MEdit_DtReceb.Text;
                           InputQuery('Dados da Baixa','Informe a Data de Emiss�o: '    ,semissao);
                           InputQuery('Dados da Baixa','Informe a Data de Vencimento: ' ,svencto);
                           InputQuery('Dados da Baixa','Informe a Data de Concilia��o: ',sconcil);
                           if Trim(semissao) = '' then semissao := MEdit_DtReceb.Text;
                           if Trim(svencto)  = '' then svencto  := MEdit_DtReceb.Text;

                           // Verifica Data de Emiss�o
                           try
                             semissao := DateToStr(StrToDate(semissao));
                           except
                             ShowMessage('Data de Emiss�o estava inv�lida e foi corrigida! Favor conferir!');
                             semissao := DateToStr(Date);
                           end;

                           // Verifica Data de Vencimento
                           try
                             svencto := DateToStr(StrToDate(svencto));
                           except
                             ShowMessage('Data de Vencimento estava inv�lida e foi corrigida! Favor conferir!');
                             svencto := DateToStr(Date);
                           end;

                           // Verifica Data de Concilia��o
                           if Trim(sconcil) <> '' then
                             begin
                                try
                                  sconcil := DateToStr(StrToDate(sconcil));
                                except
                                  ShowMessage('Data de Concilia��o estava inv�lida e foi corrigida! Favor conferir!');
                                  sconcil := DateToStr(Date);
                                end;
                             end;


                           // Grava lan�amento...
                           with Dm.IBQ_PesqFinanc, SQL do
                             begin
                                Close;
                                Clear;
                                Add('insert into movto (cod_conta,codigo,data,flg_e_s,valor,cod_ccusto,nro_cheque,historico,cod_conta_movto,cod_movto,data_vencto,data_pagto,cod_filial) ');
                                Add('values (:cod_conta,:codigo,:data,:flg_e_s,:valor,:cod_ccusto,:nro_cheque,:historico,:cod_conta_movto,:cod_movto,:data_vencto,:data_pagto,:cod_filial) ');
                                ParamByName('cod_conta').AsInteger      := Dlg_conta.SQL_pesquisa.fieldbyname('CODIGO').AsInteger;
                                ParamByName('codigo').AsInteger         := 0;
                                ParamByName('data').AsDateTime          := StrToDate(semissao);
                                ParamByName('flg_e_s').AsString         := Dlg_ccusto.e_s;
                                ParamByName('valor').AsFloat            := StrToFloat(Edit_Pago.Text);
                                ParamByName('cod_ccusto').AsInteger     := Dlg_ccusto.SQL_pesquisa.FieldByName('CODIGO').AsInteger;
                                ParamByName('nro_cheque').AsString      := '';
                                if Edit_nome_socio.Text <> 'TODOS' then
                                   ParamByName('historico').AsString    := Dlg_ccusto.SQL_pesquisa.FieldByName('NOME').AsString + ' - ' + Copy(Edit_Nome_socio.Text,1,45-Length(Dlg_ccusto.SQL_pesquisa.FieldByName('NOME').AsString))
                                else
                                   ParamByName('historico').AsString    := Dlg_ccusto.SQL_pesquisa.FieldByName('NOME').AsString;
                                ParamByName('cod_conta_movto').AsString := '';
                                ParamByName('cod_movto').AsString       := '';
                                ParamByName('data_vencto').AsDateTime   := StrToDate(svencto);
                                ParamByName('data_pagto').AsString      := sconcil;
                                ParamByName('cod_filial').AsInteger     := Dlg_Filiais.SQL_pesquisa.FieldByName('CODIGO').AsInteger;
                                Open;
                             end;
                           Dm.IBT_Financ.Commit;
                           ShowMessage('Lan�amento gravado no Financeiro com Sucesso!!!');
                           Break;
                        end;
                   end;
              end;
         end;
     end;

     

   Dm.IBT_SgEdu.Commit;
   if Dm.IBDS_Empresa.Active = False then Dm.IBDS_Empresa.Active := True;

   // Desabilita/Habilita Bot�es
   Pan_dados.Enabled     := False;
   Pan_Baixar.Enabled    := True;
   Pan_Botao2.Enabled    := False;
   Pan_Geral.Enabled     := True;
   bbtn_baixar.Enabled   := False;
   Bbtn_Gravar.Enabled   := False;
   Bbtn_Cancelar.Enabled := False;
   Bbtn_Gerar.Enabled    := True;
   Bbtn_Sair.Enabled     := True;
   SB_Cancelar.Enabled   := False;
   SB_Selecao.Enabled    := False;
   SB_NSelecao.Enabled   := False;


   // Limpa Campos
   sdata                 := MEdit_DtReceb.Text;
   Lbl_Total.Caption     := FloatToStrF(0,ffFixed,9,2);
   Pan_dados.Enabled     := True;
   Edit_codSocio.Text     := '000000';
   Edit_Nome_socio.Text    := 'TODOS';
   MEdit_dt1.Text        := '  /  /    ';
   MEdit_dt2.Text        := '  /  /    ';
   MEdit_DtReceb.Text    := '  /  /    ';
   Edit_Desc.Text        := '      0,00';
   Edit_Acres.Text       := '      0,00';
   Edit_Pago.Text        := '      0,00';
   ListBox_Receber.Clear;


   if Application.MessageBox('Deseja Baixar Outra Parcela ?','Aten��o',4) = MrYes then
      Speed_cli.Click
   else
      Bbtn_Sair.SetFocus;
end;

procedure TSg_0021.Edit_AcresKeyPress(Sender: TObject; var Key: Char);
var i : Integer;
begin
   // Se digitar 'ponto', substitui por 'virgula'
   if key = chr(46) then key := chr(44);

   // N�o permite digitar 'letra'
   if (not (key in ['0'..'9'])) and (key <> chr(8)) and (key <> chr(44)) then
     key := chr(0);

   // Rotina que n�o permite ter duas 'v�rgulas' no Edit
   if (key = chr(46)) or (key = chr(44)) then
     begin
        for i := 1 to Length(Edit_Acres.Text) do
          begin
             if Copy(Edit_Acres.Text,i,1) = chr(44) then
               begin
                  key := chr(0);
                  Exit;
               end;
          end;
     end;
end;

procedure TSg_0021.Edit_PagoKeyPress(Sender: TObject; var Key: Char);
var i : Integer;
begin
   // Se digitar 'ponto', substitui por 'virgula'
   if key = chr(46) then key := chr(44);

   // N�o permite digitar 'letra'
   if (not (key in ['0'..'9'])) and (key <> chr(8)) and (key <> chr(44)) and (key <> chr(45)) then
     key := chr(0);

   // Rotina que n�o permite ter duas 'v�rgulas' no Edit
   if (key = chr(46)) or (key = chr(44)) then
     begin
        for i := 1 to Length(Edit_Pago.Text) do
          begin
             if Copy(Edit_Pago.Text,i,1) = chr(44) then
               begin
                  key := chr(0);
                  Exit;
               end;
          end;
     end;

   // Rotina que n�o permite ter dois '-' no Edit
   if (key = chr(45)) then
     begin
        for i := 1 to Length(Edit_Pago.Text) do
          begin
             if Copy(Edit_Pago.Text,i,1) = chr(45) then
               begin
                  key := chr(0);
                  Exit;
               end;
          end;
     end;
end;

procedure TSg_0021.RG_Cred_DebClick(Sender: TObject);
begin
   if bbtn_gerar.Enabled then bbtn_gerar.SetFocus;
end;

procedure TSg_0021.Edit_NossoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var slinha, scodigo,  scodcli, snomecli, sdocumento,
    sdtemissao, sdtvencto, spagto, svalor : String;
begin
   if (key = vk_return) and (Trim(Edit_Nosso.Text) <> '') then
     begin
       with Dm.IBQ_Pesquisa,SQL do
         begin
            close;
            clear;
            add('select a.*, b.nome from receber a, socio b ');
            add('where (a.cod_socio = b.codigo) and (a.dt_pagto is null) and (a.nosso_nro = :nosso) ');
            add('order by a.dt_vencto, a.nosso_nro, a.mes, a.cod_socio ');
            ParamByName('NOSSO').AsString := Edit_Nosso.Text;
            Open;
         end;

       // Verifica se tem Parcelas a Receber
        Dm.IBQ_Pesquisa.First;
        while not Dm.IBQ_Pesquisa.Eof do
          begin
             // Move Dados para Vari�veis
             scodigo    := Dm.IBQ_Pesquisa.FieldByName('CODIGO').AsString;
             scodcli    := Dm.IBQ_Pesquisa.FieldByName('COD_SOCIO').AsString;
             snomecli   := Copy(Dm.IBQ_Pesquisa.FieldByName('NOME').AsString     ,1,38);
             sdocumento := Copy(Dm.IBQ_Pesquisa.FieldByName('NOSSO_NRO').AsString,1,20);
             sdtemissao := Dm.IBQ_Pesquisa.FieldByName('DT_EMISSAO').AsString;
             sdtvencto  := Dm.IBQ_Pesquisa.FieldByName('DT_VENCTO').AsString;
             svalor     := FloatToStrF(Dm.IBQ_Pesquisa.FieldByName('VLR_PARC').AsFloat ,ffFixed,9,2);


             // Formata Vari�veis
             while Length(scodigo)    < 06 do scodigo    := '0' + scodigo;
             while Length(scodcli)    < 06 do scodcli    := '0' + scodcli;
             while Length(snomecli)   < 38 do snomecli   := snomecli   + ' ';
             while Length(sdocumento) < 20 do sdocumento := '0' + sdocumento;
             while Length(sdtemissao) < 10 do sdtemissao := sdtemissao + ' ';
             while Length(sdtvencto)  < 10 do sdtvencto  := sdtvencto  + ' ';
             while Length(svalor)     < 09 do svalor     := ' ' + svalor;


             // Adiciona Dados
             slinha := scodcli+'-'+snomecli+'  '+sdocumento+'  '+sdtemissao+'  '+sdtvencto+'  '+svalor+'     '+scodigo;
             ListBox_Receber.Items.Add(slinha);

             // Soma Total
             Lbl_Total.Caption := FloatToStrF(StrToFloat(Lbl_Total.Caption) + Dm.IBQ_Pesquisa.FieldByName('VLR_PARC').AsFloat,ffFixed,9,2);

             // Pr�ximo Registro
             Dm.IBQ_Pesquisa.Next;

          end;

        Bbtn_Sair.Enabled   := True;
        Pan_dados.Enabled   := True;
        Pan_Botao2.Enabled  := True;
        bbtn_baixar.Enabled := True;
        SB_Cancelar.Enabled := True;
        SB_Selecao.Enabled  := True;
        SB_NSelecao.Enabled := True;

        Edit_Nosso.SetFocus;
        Edit_Nosso.SelectAll;
     end;
end;

procedure TSg_0021.SB_RetornoClick(Sender: TObject);
begin
   if OpenDialog1.Execute then Edit_Retorno.Text := OpenDialog1.FileName;
   Baixa_Arquivo;
end;

procedure TSg_0021.Baixa_Arquivo;
var slinha,scodigo, scodcli, snomecli, sdocumento,
    sdtemissao, sdtvencto, svalor : String;
    arq : TextFile;
begin
  if FileExists(Edit_Retorno.Text) then
    begin
       AssignFile(Arq, Edit_Retorno.Text);
       Reset(Arq);

       while not eof(Arq) do
         begin
            Bbtn_Gerar.Enabled := False;
            Bbtn_Sair.Enabled  := False;

            Readln(Arq, slinha);
            if Trim(slinha) = '' then Break;

            Pan_Mens.Visible := True;
            Pan_Mens.Caption := 'Aguarde a leitura dos Arquivos....' + '   ' +slinha;
            Application.ProcessMessages;

            {
             Modificar onde tem Copy(slinha... para os valores que o bruno passar (do SICOOB)
             e se poss�vel comentar a parte do bradesco
            }


            with Dm.IBQ_Pesquisa,SQL do
              begin
                 close;
                 clear;
                 add('select a.*, b.nome from receber a, socio b ');
                 add('where (a.cod_socio = b.codigo) and (a.dt_pagto is null) and (a.nosso_nro = :nosso) ');
                 add('order by a.dt_vencto, a.nosso_nro, a.mes, a.cod_socio ');
                 ParamByName('NOSSO').AsString := Copy(slinha,38,09);   //Copy(slinha,1,11);
                 Open;
                 First;
              end;

            if (Dm.IBQ_Pesquisa.RecordCount = 0) then Continue;

            // Move Dados para Vari�veis
            scodigo    := Dm.IBQ_Pesquisa.FieldByName('CODIGO').AsString;
            scodcli    := Dm.IBQ_Pesquisa.FieldByName('COD_SOCIO').AsString;
            snomecli   := Copy(Dm.IBQ_Pesquisa.FieldByName('NOME').AsString     ,1,38);
            sdocumento := Copy(Dm.IBQ_Pesquisa.FieldByName('NOSSO_NRO').AsString,1,11);
            sdtemissao := Dm.IBQ_Pesquisa.FieldByName('DT_EMISSAO').AsString;
            sdtvencto  := Dm.IBQ_Pesquisa.FieldByName('DT_VENCTO').AsString;
            svalor     := FloatToStrF(Dm.IBQ_Pesquisa.FieldByName('VLR_PARC').AsFloat ,ffFixed,9,2);
            sdtpagto   := Copy(slinha,138,02) +'/'+ Copy(slinha,140,02) +'/20'+ Copy(slinha,144,02);//Copy(slinha,13,10);

            // Formata Vari�veis
            while Length(scodigo)    < 06 do scodigo    := '0' + scodigo;
            while Length(scodcli)    < 06 do scodcli    := '0' + scodcli;
            while Length(snomecli)   < 38 do snomecli   := snomecli   + ' ';
            while Length(sdocumento) < 11 do sdocumento := '0' + sdocumento;
            while Length(sdtpagto)   < 10 do sdtpagto   := sdtpagto   + ' ';
            while Length(sdtemissao) < 10 do sdtemissao := sdtemissao + ' ';
            while Length(sdtvencto)  < 10 do sdtvencto  := sdtvencto  + ' ';
            while Length(svalor)     < 09 do svalor     := ' ' + svalor;

            // Adiciona Dados
            slinha := scodcli+'-'+snomecli+' '+sdocumento+'  '+sdtpagto+' '+sdtemissao+'  '+sdtvencto+'  '+svalor+'     '+scodigo;
            ListBox_Receber.Items.Add(slinha);

            // Soma Total
            Lbl_Total.Caption := FloatToStrF(StrToFloat(Lbl_Total.Caption) + Dm.IBQ_Pesquisa.FieldByName('VLR_PARC').AsFloat,ffFixed,9,2);
         end;
       CloseFile(Arq);

       Bbtn_Sair.Enabled   := True;
       Pan_dados.Enabled   := True;
       Pan_Botao2.Enabled  := True;
       bbtn_baixar.Enabled := True;
       SB_Cancelar.Enabled := True;
       SB_Selecao.Enabled  := True;
       SB_NSelecao.Enabled := True;
       Pan_Mens.Visible    := False;
       Bbtn_Gerar.Enabled  := True;
       Bbtn_Sair.Enabled   := True;

       ShowMessage('Final da Leitura do Arquivo Retorno!');

    end
  else
    ShowMessage('Arquivo ' + Edit_Retorno.Text + ' n�o encontrado.');
end;

end.
