unit Sg0023;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, Mask, DBCtrls,
  ComCtrls, DB, IBCustomDataSet, RDprint, ShellAPI;

type
  TSg_0023 = class(TForm)
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
    Edit_Obs1: TEdit;
    Edit_Obs3: TEdit;
    Edit_Juros: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    SB_Selecao: TSpeedButton;
    SB_NSelecao: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Bevel2: TBevel;
    Speed_cli: TSpeedButton;
    Speed_limpa_cli: TSpeedButton;
    Pan_Botao2: TPanel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    bbtn_gravar: TBitBtn;
    Bbtn_Cancelar: TBitBtn;
    Label5: TLabel;
    Lbl_Total: TLabel;
    Bevel5: TBevel;
    StatusBar1: TStatusBar;
    Edit_Obs2: TEdit;
    Pan_Mens: TPanel;
    Label6: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    Lbl_Tempo: TLabel;
    Edit_Retorno: TEdit;
    Edit1: TEdit;
    Panel1: TPanel;
    Label10: TLabel;
    Label12: TLabel;
    SB_Letra: TSpeedButton;
    Edit_Letra1: TEdit;
    Edit_Letra2: TEdit;
    Cb_Impressao: TCheckBox;
    Panel2: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    SB_Codigo: TSpeedButton;
    Edit_Codigo1: TEdit;
    Edit_Codigo2: TEdit;
    Timer1: TTimer;
    Panel3: TPanel;
    Bevel6: TBevel;
    Panel4: TPanel;
    LB_Socios: TListBox;
    Panel5: TPanel;
    SB_inserir: TSpeedButton;
    SB_retirar: TSpeedButton;
    Bevel7: TBevel;
    SB_limpa: TSpeedButton;
    procedure Abre_Arquivo;
    procedure Ver_Retorno;
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
    procedure Edit_JurosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Bbtn_GerarClick(Sender: TObject);
    procedure Bbtn_CancelarClick(Sender: TObject);
    procedure bbtn_gravarClick(Sender: TObject);
    procedure Edit_JurosKeyPress(Sender: TObject; var Key: Char);
    procedure RG_Cred_DebClick(Sender: TObject);
    procedure SB_LetraClick(Sender: TObject);
    procedure SB_CodigoClick(Sender: TObject);
    procedure SB_inserirClick(Sender: TObject);
    procedure SB_retirarClick(Sender: TObject);
    procedure SB_limpaClick(Sender: TObject);
  private
    slinha, sarq_sai, sarq_ent : String;
    Seq        : TextFile;
    ComponAnt  : TEdit;
    ComponAnt2 : TMaskEdit;
    procedure ControlChange(Sender : TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Sg_0023: TSg_0023;

implementation

uses Arquivos, Sg0000,Sg0020,Sg20, IBQuery;


{$R *.dfm}

procedure TSg_0023.ControlChange(Sender : TObject);
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

procedure TSg_0023.FormShow(Sender: TObject);
begin
   Screen.OnActiveControlChange := ControlChange;

   // Limpa os 2 ListBox
   ListBox_Receber.Clear;
   LB_Socios.Clear;


   // Inicializa Totais
   Lbl_Total.Caption := FloatToStrF(0,ffNumber,10,2);
   Bbtn_Gerar.SetFocus;
end;

procedure TSg_0023.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssAlt]) and (Key = VK_F4) then Key := VK_Clear;
  if key = vk_return   then Perform(wm_NextDlgCtl,0,0);
  if key = vk_escape   then Perform(wm_NextDlgCtl,1,0);
  if key = vk_f5       then if Pan_Geral.Enabled   = True then Speed_cli.Click;
  if key = vk_f6       then if Pan_Geral.Enabled   = True then MEdit_dt1.SetFocus;
  if key = vk_f7       then if Pan_Geral.Enabled   = True then Edit_Letra1.SetFocus;
  if key = vk_f8       then if Pan_Geral.Enabled   = True then Edit_Codigo1.SetFocus;
end;

procedure TSg_0023.FormDestroy(Sender: TObject);
begin
   Screen.OnActiveControlChange := Nil;
end;

procedure TSg_0023.Speed_cliClick(Sender: TObject);
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

procedure TSg_0023.Edit_codSocioEnter(Sender: TObject);
begin
   bbtn_gerar.SetFocus;
end;

procedure TSg_0023.Speed_limpa_cliClick(Sender: TObject);
begin
   Edit_codSocio.Text   := '000000';
   Edit_nome_socio.Text := 'TODOS';
end;

procedure TSg_0023.MEdit_dt1KeyDown(Sender: TObject; var Key: Word;
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

procedure TSg_0023.MEdit_dt2KeyDown(Sender: TObject; var Key: Word;
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

procedure TSg_0023.Speed_limpa_dataClick(Sender: TObject);
begin
   MEdit_dt1.Text := '  /  /    ';
   MEdit_dt2.Text := '  /  /    ';
end;

procedure TSg_0023.Bbtn_SairClick(Sender: TObject);
begin
   Close;
end;

procedure TSg_0023.SB_SelecaoClick(Sender: TObject);
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
             Lbl_Total.Caption := FloatToStrF(StrToFloat(Lbl_Total.Caption) - StrToFloat(Copy(ListBox_Receber.Items.Strings[k],93,09)),ffFixed,9,2);
             ListBox_Receber.Items.Delete(k);
             j := j + 1;
          end;
     end;

   if ListBox_Receber.Count = 0 then
     begin
        ShowMessage('Todas as Notas foram Exclu�das!');
        SB_Cancelar.Click;
     end
   else
      bbtn_gravar.SetFocus;
end;

procedure TSg_0023.SB_NSelecaoClick(Sender: TObject);
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
              Lbl_Total.Caption   := FloatToStrF(StrToFloat(Lbl_Total.Caption)   - StrToFloat(Copy(ListBox_Receber.Items.Strings[k],93,09)),ffFixed,9,2);
              ListBox_Receber.Items.Delete(k);
             j := j + 1;
          end;
     end;

   if ListBox_Receber.Count = 0 then
     begin
        ShowMessage('Todas as Parcelas foram Exclu�das!');
        SB_Cancelar.Click;
     end
   else
      bbtn_gravar.SetFocus;
end;

procedure TSg_0023.SB_retirarClick(Sender: TObject);
var i, k, j : Integer;
begin
   // Verifica o item selecionado
   k := 0;
   j := 0;
   for i := 0 to (LB_Socios.Items.Count - 1) do
     begin
        k := i - j;
        if LB_Socios.Selected[k] = True then
          begin
             LB_Socios.Items.Delete(k);
             j := j + 1;
          end;
     end;

end;

procedure TSg_0023.SB_CancelarClick(Sender: TObject);
begin
   // Desabilita/Habilita Bot�es
   Pan_dados.Enabled     := False;
   Pan_Baixar.Enabled    := True;
   Pan_Botao2.Enabled    := False;
   Pan_Geral.Enabled     := True;
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
   Edit_codsocio.Text    := '000000';
   Edit_Nome_socio.Text  := 'TODOS';
   MEdit_dt1.Text        := '  /  /    ';
   MEdit_dt2.Text        := '  /  /    ';
   Edit_Juros.Text       := '    0,00';
   Edit_Obs1.Text        := '';
   Edit_Obs2.Text        := '';
   Edit_Obs3.Text        := '';
   ListBox_Receber.Clear;
   Bbtn_Sair.SetFocus;
end;

procedure TSg_0023.Edit_JurosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_return then
     begin
        // Formata Campos
        Edit_Juros.Text := FloatToStrF(StrToFloat(Edit_Juros.Text) ,ffFixed,8,2);
        while Length(Edit_Juros.Text) < 8 do Edit_Juros.Text := ' ' + Edit_Juros.Text;
        bbtn_gravar.SetFocus;
     end;
end;

procedure TSg_0023.Bbtn_GerarClick(Sender: TObject);
var scodigo,  scodcli, snomecli, sdocumento,
    sdtemissao, sdtvencto, svalor : String;
    a : Integer;
begin
   if Edit_codSocio.Text = '' then
     begin
        Edit_codSocio.Text   := '000000';
        Edit_nome_socio.Text := 'TODOS';
     end;
  if LB_Socios.Items.Count = 0 then
  Begin
    with Dm.IBQ_Pesquisa,SQL do
     begin
        close;
        clear;
        add('select a.*, b.* from receber a, socio b ');
        add('where (a.cod_socio = b.codigo)  ');

        if (MEdit_dt1.Text <> '  /  /    ') and (MEdit_dt2.Text <> '  /  /    ') then Add('and a.dt_vencto between :dt1 and :dt2 ');
        if Edit_nome_socio.Text <> 'TODOS'    then Add('and (a.cod_socio  = :cod) ');
        if (Edit_Letra1.Text  <> '') and (Edit_Letra2.Text  <> '') then Add('and (substring(b.nome from 1 for 1) between :letra1 and :letra2) ');
        if (Edit_Codigo1.Text <> '') and (Edit_Codigo2.Text <> '') then Add('and (b.codigo between :codigo1 and :codigo2) ');
        if (Cb_Impressao.Checked) then
           Add('and b.flg_boleto = ''S'' ')
        else
           Add('and b.flg_boleto = ''N'' ');

        add('order by b.nome, a.dt_vencto, a.nosso_nro, a.mes, a.cod_socio ');

        if (MEdit_dt1.Text <> '  /  /    ') and (MEdit_dt2.Text <> '  /  /    ') then
          begin
             ParamByName('DT1').AsDateTime := StrToDate(MEdit_dt1.Text);
             ParamByName('DT2').AsDateTime := StrToDate(MEdit_dt2.Text);
          end;
        if (Edit_Letra1.Text <> '') and (Edit_Letra2.Text <> '') then
          begin
             ParamByName('letra1').AsString := Edit_Letra1.Text;
             ParamByName('letra2').AsString := Edit_Letra2.Text;
          end;
        if (Edit_Codigo1.Text <> '') and (Edit_Codigo2.Text <> '') then
          begin
             ParamByName('codigo1').AsInteger := StrToInt(Edit_Codigo1.Text);
             ParamByName('codigo2').AsInteger := StrToInt(Edit_Codigo2.Text);
          end;
        if Edit_nome_socio.Text <> 'TODOS'  then ParamByName('COD').AsInteger  := StrToInt(Edit_codSocio.text);
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
             snomecli   := Copy(Dm.IBQ_Pesquisa.FieldByName('NOME').AsString     ,1,37);
             sdocumento := Copy(Dm.IBQ_Pesquisa.FieldByName('NOSSO_NRO').AsString,1,20);
             sdtemissao := Dm.IBQ_Pesquisa.FieldByName('DT_EMISSAO').AsString;
             sdtvencto  := Dm.IBQ_Pesquisa.FieldByName('DT_VENCTO').AsString;
             svalor     := FloatToStrF(Dm.IBQ_Pesquisa.FieldByName('VLR_PARC').AsFloat ,ffFixed,9,2);


             // Formata Vari�veis
             while Length(scodigo)    < 06 do scodigo    := '0' + scodigo;
             while Length(scodcli)    < 06 do scodcli    := '0' + scodcli;
             while Length(snomecli)   < 37 do snomecli   := snomecli   + ' ';
             while Length(sdocumento) < 20 do sdocumento := sdocumento + ' ';
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

             //Cliente                                          Nosso Numero          Mes Ano   Vencto     Vl.Parc.
             //999999-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  99999999999999999999  99/99/9999  99/99/9999  999999,99     999999
             //1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
             //         1         2         3         4         5         6         7         8         9        10        11
          end;
       End
    else
     begin
        ShowMessage('N�O H� PARCELAS PARA OS DADOS INFORMADOS!');
        Bbtn_Gerar.SetFocus;
     end;
  End
  Else
  Begin
  for a := 0 to (LB_Socios.Items.Count - 1) do
  begin
    With Dm.IBQ_Pesquisa, sql do
    Begin
      Clear;
      Close;
      add('select a.*, b.* from receber a, socio b ');
      add('where (a.cod_socio = b.codigo)  ');
      if (MEdit_dt1.Text <> '  /  /    ') and (MEdit_dt2.Text <> '  /  /    ') then Add('and a.dt_vencto between :dt1 and :dt2 ');
      add('and (a.cod_socio  = :cod) ');
      if (Cb_Impressao.Checked) then
          Add('and b.flg_boleto = ''S'' ')
      else
         Add('and b.flg_boleto = ''N'' ');
        add('order by b.nome, a.dt_vencto, a.nosso_nro, a.mes, a.cod_socio ');
        if (MEdit_dt1.Text <> '  /  /    ') and (MEdit_dt2.Text <> '  /  /    ') then
        begin
          ParamByName('DT1').AsDateTime := StrToDate(MEdit_dt1.Text);
          ParamByName('DT2').AsDateTime := StrToDate(MEdit_dt2.Text);
       end;
          ParamByName('COD').AsString   := Copy(LB_Socios.Items.Strings[a],01,06);
      Open;
    End;
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
             snomecli   := Copy(Dm.IBQ_Pesquisa.FieldByName('NOME').AsString     ,1,37);
             sdocumento := Copy(Dm.IBQ_Pesquisa.FieldByName('NOSSO_NRO').AsString,1,20);
             sdtemissao := Dm.IBQ_Pesquisa.FieldByName('DT_EMISSAO').AsString;
             sdtvencto  := Dm.IBQ_Pesquisa.FieldByName('DT_VENCTO').AsString;
             svalor     := FloatToStrF(Dm.IBQ_Pesquisa.FieldByName('VLR_PARC').AsFloat ,ffFixed,9,2);


             // Formata Vari�veis
             while Length(scodigo)    < 06 do scodigo    := '0' + scodigo;
             while Length(scodcli)    < 06 do scodcli    := '0' + scodcli;
             while Length(snomecli)   < 37 do snomecli   := snomecli   + ' ';
             while Length(sdocumento) < 20 do sdocumento := sdocumento + ' ';
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

        Bbtn_Gerar.Enabled    := False;
        Bbtn_Sair.Enabled     := True;
        Pan_Geral.Enabled     := False;
        Pan_dados.Enabled     := True;
        Pan_Baixar.Enabled    := True;
        Pan_Botao2.Enabled    := True;
        bbtn_gravar.Enabled   := True;
        Bbtn_Cancelar.Enabled := True;
        SB_Cancelar.Enabled   := True;
        SB_Selecao.Enabled    := True;
        SB_NSelecao.Enabled   := True;
        Edit_Obs1.SetFocus;
     end
  End
   else
     begin
        ShowMessage('N�O H� PARCELAS PARA O ASSOCIADO '+sCodCli+' - '+sNomeCli);
        Continue;
//        Bbtn_Gerar.SetFocus;
     end;
  end;
  End;
end;

procedure TSg_0023.Bbtn_CancelarClick(Sender: TObject);
begin
   // Habilita Bot�es
   Pan_Baixar.Enabled    := False;
   Bbtn_Gravar.Enabled   := False;
   Bbtn_Cancelar.Enabled := False;
   Bbtn_Sair.Enabled     := True;
   Bbtn_Gerar.Enabled    := True;
   SB_Cancelar.Enabled   := True;
   SB_Selecao.Enabled    := True;
   SB_NSelecao.Enabled   := True;

   LB_Socios.Clear;
   Edit_Juros.Text       := '    0,00';
   Edit_Obs1.Text        := '';
   Edit_Obs2.Text        := '';
   Edit_Obs3.Text        := '';

   Bbtn_Gerar.SetFocus;
end;

procedure TSG_0023.Abre_Arquivo;
begin
   // Mostra Panel de Mensagem de espera
   Pan_Mens.Left    := 32;
   Pan_Mens.Top     := 141;
   Pan_Mens.Height  := 240;
   Pan_Mens.Width   := 736;
   Pan_Mens.Visible := True;
   Edit1.SetFocus;
   Application.ProcessMessages;

   // Verifica se existe e deleta arquivo
   if FileExists(sarq_sai) then DeleteFile(sarq_sai);
   if FileExists(sarq_ent) then DeleteFile(sarq_ent);
   if not FileExists(sarq_ent) then AssignFile(Seq,sarq_ent);

   // Cria novo arquivo de Entrada
   //AssignFile(Seq,sarq_ent);
   ReWrite(Seq);
end;

procedure TSG_0023.Ver_Retorno;
var itempo, iret : Integer;
    stempo : String;
begin
   Lbl_Tempo.Caption := '60';
   stempo := Lbl_Tempo.Caption;
   itempo := (StrToInt(Copy(TimeToStr(Time),1,2)) * 3600) + (StrToInt(Copy(TimeToStr(Time),4,2)) * 60) + (StrToInt(Copy(TimeToStr(Time),7,2)));
   Application.ProcessMessages;

   while StrToFloat(Lbl_Tempo.Caption) > 0 do
     begin
        Lbl_Tempo.Caption := FloatToStrF(60 - ((StrToInt(Copy(TimeToStr(Time),1,2)) * 3600) + (StrToInt(Copy(TimeToStr(Time),4,2)) * 60) + (StrToInt(Copy(TimeToStr(Time),7,2))) - itempo),ffFixed,8,0);
        Application.ProcessMessages;

        // Faz verifica��o do tempo, para permitir apenas uma consulta por segundo (antes fazia v�rias consultas e estava dando erro no arquivo TXT)
        if StrToInt(stempo) = StrToInt(Lbl_Tempo.Caption) then Continue;
        stempo := Lbl_Tempo.Caption;

        try
          if not FileExists(sarq_sai) then
            begin
               Edit_Retorno.Text := 'Retorno n�o encontrado.';
               Application.ProcessMessages;
            end
          else
            begin
               AssignFile(Seq,sarq_sai);
               Reset(Seq);
               iret := 0;
               while not Eof(Seq) do
                 begin
                    Readln(Seq,slinha);
                    Edit_Retorno.Text := slinha;
                    Break;
                 end;
               CloseFile(Seq);
               WinExec('cmd /c move c:\ACBrmonitor\Sai2.TXT c:\ACBrmonitor\Sai.TXT',SW_HIDE);
               Pan_Mens.Visible := False;
               Application.ProcessMessages;
               Break;
            end;
        except
        end;
     end;


   if StrToFloat(Lbl_Tempo.Caption) = 0 then
     begin
        ShowMessage('TEMPO DE RESPOSTA EXCEDIDO!');
        Pan_Mens.Visible := False;
        Application.ProcessMessages;
     end;
end;

procedure TSg_0023.bbtn_gravarClick(Sender: TObject);
var i, limitadorBoletos : Integer;
    snosso_nro, scodigo, svalor, svencto, scodcli : String;
begin
   if Application.MessageBox('Deseja gerar o boleto para a(s) parcela(s) selecionada(s)?','Aten��o',4) = MrNo then Exit;

   sarq_sai := 'C:\ACBrMonitor\SAI2.TXT';
   sarq_ent := 'C:\ACBrMonitor\ENT2.TXT';

   // Limpa Lista de Titulos
   Abre_Arquivo;
   Writeln(Seq,'BOLETO.LimparLista');
   CloseFile(Seq);
   RenameFile('C:\ACBrMonitor\Ent2.TXT','C:\ACBrMonitor\Ent.TXT');
   Application.ProcessMessages;
   Ver_Retorno;
   Application.ProcessMessages;
   if Copy(Edit_Retorno.Text,1,2) <> 'OK' then
     begin
        ShowMessage('Erro ao tentar: LIMPAR LISTA DE T�TULOS! Tente Novamente!');
        Exit;
     end;

   // Pesquisa Dados do Associado
   with Dm.IBQ_PesqAux, Sql do
     begin
        Close;
        Clear;
        Add('select max(nosso_nro) nosso_nro from receber where codigo > 54433 ');
        Open;
     end;
   if Dm.IBQ_PesqAux.FieldByName('NOSSO_NRO').AsString = '' then
      snosso_nro := '1'
   else
      snosso_nro := FloatToStrF(Dm.IBQ_PesqAux.FieldByName('NOSSO_NRO').AsFloat + 1,ffFixed,13,0);

   limitadorBoletos := -1;
   Abre_Arquivo;
   Writeln(Seq,'BOLETO.IncluirTitulos("');

   // L� Dados para Baixar...
   for i := 0 to (ListBox_Receber.Items.Count - 1) do
     begin
        // Abre Inclus�o de Titulos
        if (limitadorBoletos = 0) then
          begin
            CloseFile(Seq);
            WinExec('cmd /c move C:\ACBrMonitor\Ent2.TXT C:\ACBrMonitor\Ent.TXT',SW_HIDE);
            Application.ProcessMessages;
            Ver_Retorno;
            Application.ProcessMessages;

            Abre_Arquivo;
            Writeln(Seq,'BOLETO.LimparLista');
            CloseFile(Seq);
            WinExec('cmd /c move C:\ACBrMonitor\Ent2.TXT C:\ACBrMonitor\Ent.TXT',SW_HIDE);
            Application.ProcessMessages;
            Ver_Retorno;
            Application.ProcessMessages;

            //Timer1.Enabled := True;
            Abre_Arquivo;
            Writeln(Seq,'BOLETO.IncluirTitulos("');
          end
        else                        //dr. joao 3372-1859
          if (limitadorBoletos = -1) then
              limitadorBoletos := 0;

        //Abre_Arquivo;
        //Writeln(Seq,'BOLETO.IncluirTitulos("');

        // Captura Dados
        svalor  := Copy(ListBox_Receber.Items.Strings[i],093,09);
        svencto := Copy(ListBox_Receber.Items.Strings[i],081,10);
        scodigo := Copy(ListBox_Receber.Items.Strings[i],107,06);
        scodcli := Copy(ListBox_Receber.Items.Strings[i],001,06);

        // Pesquisa Dados do Associado
        with Dm.IBQ_PesqAux, Sql do
          begin
             Close;
             Clear;
             Add('select * from socio where codigo = :codigo ');
             ParamByName('codigo').AsInteger := StrToInt(scodcli);
             Open;
          end;

        // Inclui Titulos
        Writeln(Seq,'[Titulo' + IntToStr(i+1) + ']');
        Writeln(Seq,'NumeroDocumento='    + Copy(ListBox_Receber.Items.Strings[i],087,04) + Copy(scodcli,3,4) + FormatFloat('00',i+1)); //ANO+CODCLI+SEQUENCIAL
        Writeln(Seq,'NossoNumero='        + snosso_nro);
        Writeln(Seq,'Carteira=06');
        Writeln(Seq,'ValorDocumento='     + Trim(svalor));
        Writeln(Seq,'Sacado.NomeSacado='  + Dm.IBQ_PesqAux.FieldByName('NOME').AsString);
        Writeln(Seq,'Sacado.CNPJCPF='     + Dm.IBQ_PesqAux.FieldByName('CPF_CNPJ').AsString);
        Writeln(Seq,'Sacado.Logradouro='  + Dm.IBQ_PesqAux.FieldByName('ENDERECO').AsString);
        Writeln(Seq,'Sacado.Numero='      + Dm.IBQ_PesqAux.FieldByName('NRO').AsString);
        Writeln(Seq,'Sacado.Bairro='      + Dm.IBQ_PesqAux.FieldByName('BAIRRO').AsString);
        Writeln(Seq,'Sacado.Complemento=' + Dm.IBQ_PesqAux.FieldByName('COMPLEMENTO').AsString);
        Writeln(Seq,'Sacado.Cidade='      + Dm.IBQ_PesqAux.FieldByName('CIDADE').AsString);
        Writeln(Seq,'Sacado.UF='          + Dm.IBQ_PesqAux.FieldByName('UF').AsString);
        Writeln(Seq,'Sacado.CEP='         + Dm.IBQ_PesqAux.FieldByName('CEP').AsString);
        Writeln(Seq,'Mensagem='           + (Edit_Obs1.Text +' - '+ Edit_Obs2.Text +' - '+ Edit_Obs3.Text));
        Writeln(Seq,'ValorMoraJuros='     + Trim(Edit_Juros.Text));
        Writeln(Seq,'Vencimento='         + svencto);



        with dm.IBQ_PesqAux,SQL do
          begin
             Close;
             Clear;
             Add('update receber set nosso_nro = :nosso_nro where codigo = :codigo ');
             ParamByName('nosso_nro').AsString := snosso_nro;
             ParamByName('codigo').AsInteger   := StrToInt(scodigo);
             Open;
          end;
        snosso_nro := FloatToStrF(StrToFloat(snosso_nro) + 1,ffFixed,13,0);

        inc(limitadorBoletos);
        if limitadorBoletos > 50 then
          begin
             limitadorBoletos := 0;
             // Fecha Inclus�o de Titulos
             if (Cb_Impressao.Checked) then
                Writeln(Seq,'","P"')
             else
                Writeln(Seq,'"');
          end;
     end;

{   if (limitadorBoletos > 0) then
     begin
       //CloseFile(Seq);
       //Timer1.Enabled := True;
       //limitadorBoletos := 0;
       CloseFile(Seq);
       Abre_Arquivo;
       Writeln(Seq,'BOLETO.LimparLista');
       CloseFile(Seq);
       limitadorBoletos := 0;
     end;}

   Application.ProcessMessages;
   Ver_Retorno;
   Application.ProcessMessages;
   if Copy(Edit_Retorno.Text,1,2) <> 'OK' then
     begin
        ShowMessage('Erro ao tentar: INCLUIR T�TULO! Tente Novamente!');
        Exit;
     end;


   // Abre Impriss�o Titulos
   if (Cb_Impressao.Checked) then
     begin
       if FileExists('c:\AcBrMonitor\Boleto.pdf') then
          ShellExecute(Handle, nil, 'c:\AcBrMonitor\Boleto.pdf' ,nil,nil, SW_SHOWNORMAL)
       else
          ShowMessage('Boleto n�o encontrado!');
     end;


   Dm.IBT_SgEdu.Commit;
   if Dm.IBDS_Empresa.Active = False then Dm.IBDS_Empresa.Active := True;

   // Desabilita/Habilita Bot�es
   Pan_dados.Enabled     := False;
   Pan_Baixar.Enabled    := True;
   Pan_Botao2.Enabled    := False;
   Pan_Geral.Enabled     := True;
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
   Edit_codSocio.Text    := '000000';
   Edit_Nome_socio.Text  := 'TODOS';
   MEdit_dt1.Text        := '  /  /    ';
   MEdit_dt2.Text        := '  /  /    ';
   Edit_Juros.Text       := '    0,00';
   Edit_Obs1.Text        := '';
   Edit_Obs2.Text        := '';
   Edit_Obs3.Text        := '';
   ListBox_Receber.Clear;
   Bbtn_Sair.SetFocus;
end;

procedure TSg_0023.Edit_JurosKeyPress(Sender: TObject; var Key: Char);
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
        for i := 1 to Length(Edit_Juros.Text) do
          begin
             if Copy(Edit_Juros.Text,i,1) = chr(44) then
               begin
                  key := chr(0);
                  Exit;
               end;
          end;
     end;

   // Rotina que n�o permite ter dois '-' no Edit
   if (key = chr(45)) then
     begin
        for i := 1 to Length(Edit_Juros.Text) do
          begin
             if Copy(Edit_Juros.Text,i,1) = chr(45) then
               begin
                  key := chr(0);
                  Exit;
               end;
          end;
     end;
end;

procedure TSg_0023.RG_Cred_DebClick(Sender: TObject);
begin
   if bbtn_gerar.Enabled then bbtn_gerar.SetFocus;
end;

procedure TSg_0023.SB_LetraClick(Sender: TObject);
begin
   Edit_Letra1.Clear;
   Edit_Letra2.Clear;
end;

procedure TSg_0023.SB_limpaClick(Sender: TObject);
begin
  LB_Socios.Clear;
end;

procedure TSg_0023.SB_CodigoClick(Sender: TObject);
begin
   Edit_Codigo1.Clear;
   Edit_Codigo2.Clear;
end;

procedure TSg_0023.SB_inserirClick(Sender: TObject);
var sCod, sNome, sLinha : String;
begin
 while True do
 Begin
   Dlg_Socio.SB_Nova.Visible := False;
   Dlg_Socio.Edit_pesquisa.Clear;
   if Dlg_Socio.ShowModal = mrOk then
   Begin
      sCod   := DLG_Socio.SQL_pesquisa.FieldByName('CODIGO').AsString;
      sNome  := DLG_Socio.SQL_pesquisa.FieldByName('NOME').AsString;
      while Length(scod)   < 06 do scod  := '0'   + scod;
      while Length(snome)  < 100 do snome := snome + ' ';

      sLinha := scod + ' - ' + sNome +FormatFloat('R$#,##0.00',DLG_Socio.SQL_pesquisa.FieldByName('VALOR').AsFloat);
      LB_Socios.Items.Add(sLinha);
   End;

   if Application.MessageBox('Selecionar outro Associado?','Confirme',4) = MrNo then
    Break;
 End;
end;

end.
