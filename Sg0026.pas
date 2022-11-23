unit Sg0026;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, Mask, DBCtrls,
  ComCtrls, DB, IBCustomDataSet, sSpeedButton;

type
  TSg_0026 = class(TForm)
    Pan_Botao: TPanel;
    Bbtn_Incluir: TBitBtn;
    Bbtn_Excluir: TBitBtn;
    Bbtn_Alterar: TBitBtn;
    Bbtn_Gravar: TBitBtn;
    Bbtn_Cancelar: TBitBtn;
    Bbtn_Imprimir: TBitBtn;
    Bbtn_Sair: TBitBtn;
    Bbtn_Pesquisar: TBitBtn;
    Bevel1: TBevel;
    Pan_dados: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    DBEdit_Nome: TDBEdit;
    DBEdit_Endereco: TDBEdit;
    DBEdit_bairro: TDBEdit;
    DBEdit_cep: TDBEdit;
    DBEdit_cnpj: TDBEdit;
    Label1: TLabel;
    DBEdit_nome_cid: TDBEdit;
    DBEdit_uf_cid: TDBEdit;
    Label14: TLabel;
    DBEdit_observ: TDBEdit;
    DBEdit_NRO: TDBEdit;
    Label15: TLabel;
    DBRG_tipo: TDBRadioGroup;
    Label10: TLabel;
    DBEdit_Complemento: TDBEdit;
    Label17: TLabel;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Label21: TLabel;
    DBT_codigo: TDBText;
    sSpeedButton1: TsSpeedButton;
    procedure Ativa_Source;
    procedure Manutencao(Botao: Integer; Tabela: TIBDataSet);
    procedure Bbtn_IncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure DBRG_pessoaExit(Sender: TObject);
    procedure DBEdit_cnpjKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBEdit_dt_nascKeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit_dt_nascEnter(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
  private
    ComponAnt : TDBEdit;
    procedure ControlChange(Sender : TObject);
    { Private declarations }
  public
    bDlg_Inc : Boolean;
    { Public declarations }
  end;

var
  Sg_0026: TSg_0026;

implementation

uses Arquivos, Sg0000, Sg21, IBQuery;

{$R *.dfm}

function cpf(num: string): Boolean;
var n1,n2,n3,n4,n5,n6,n7,n8,n9: Integer;
    d1,d2 : Integer;
    digitado, calculado : String;
begin
   n1 := StrToInt(num[1]);
   n2 := StrToInt(num[2]);
   n3 := StrToInt(num[3]);
   n4 := StrToInt(num[4]);
   n5 := StrToInt(num[5]);
   n6 := StrToInt(num[6]);
   n7 := StrToInt(num[7]);
   n8 := StrToInt(num[8]);
   n9 := StrToInt(num[9]);
   d1 := n9*2+n8*3+n7*4+n6*5+n5*6+n4*7+n3*8+n2*9+n1*10;
   d1 := 11-(d1 mod 11);
   if d1 >= 10 then d1 := 0;
   d2 := d1*2+n9*3+n8*4+n7*5+n6*6+n5*7+n4*8+n3*9+n2*10+n1*11;
   d2 := 11-(d2 mod 11);
   if d2 >= 10 then d2 := 0;
   calculado := inttostr(d1)+inttostr(d2);
   digitado  := num[10]+num[11];

   if (n1 = n2) and (n1 = n3) and (n1 = n4) and (n1 = n5) and
      (n1 = n6) and (n1 = n7) and (n1 = n8) and (n1 = n9) then
      cpf := False
   else
      if calculado = digitado then
         cpf := True
      else
         cpf := False;
end;

function cnpj(num: string): boolean;
var n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12: Integer;
    d1,d2: Integer;
    digitado, calculado: String;
begin
   n1  := StrToInt(num[1]);
   n2  := StrToInt(num[2]);
   n3  := StrToInt(num[3]);
   n4  := StrToInt(num[4]);
   n5  := StrToInt(num[5]);
   n6  := StrToInt(num[6]);
   n7  := StrToInt(num[7]);
   n8  := StrToInt(num[8]);
   n9  := StrToInt(num[9]);
   n10 := StrToInt(num[10]);
   n11 := StrToInt(num[11]);
   n12 := StrToInt(num[12]);
   d1  := n12*2+n11*3+n10*4+n9*5+n8*6+n7*7+n6*8+n5*9+n4*2+n3*3+n2*4+n1*5;
   d1  := 11-(d1 mod 11);
   if d1 >= 10 then d1 := 0;
   d2  := d1*2+n12*3+n11*4+n10*5+n9*6+n8*7+n7*8+n6*9+n5*2+n4*3+n3*4+n2*5+n1*6;
   d2  := 11-(d2 mod 11);
   if d2 >= 10 then d2 := 0;
   calculado := inttostr(d1) + inttostr(d2);
   digitado  := num[13] + num[14];

   if (n1 = n2) and (n1 = n3) and (n1 = n4)  and (n1 = n5)  and (n1 = n6)  and (n1 = n7) and
      (n1 = n8) and (n1 = n9) and (n1 = n10) and (n1 = n11) and (n1 = n12) then
      cnpj := False
   else
      if calculado = digitado then
         cnpj := True
      else
         cnpj := False;
end;

procedure TSg_0026.ControlChange(Sender : TObject);
begin
   if Assigned(ComponAnt)  then ComponAnt.color  := clWhite;

   if ActiveControl is TDBEdit then
     begin
        TDBEdit(ActiveControl).Color := $0080FFFF;
        ComponAnt := TDBEdit(ActiveControl);
     end
   else
     ComponAnt := nil;
end;

procedure TSg_0026.Manutencao(Botao: Integer; Tabela: TIBDataSet);
var cod : integer;
begin
  case Botao of
    // Incluir
    1 : begin
          Tabela.Open;
          Ativa_Source;
          Tabela.Append;
          Tabela.FieldByName('CODIGO').AsInteger   := 0;
          Tabela.FieldByName('FLG_ATIVO').AsString    := 'A';
          DBEdit_Nome.SetFocus;
          DBEdit_Nome.SelectAll;
        end;
    // Excluir
    2 : begin
          if Tabela.RecordCount > 0 then
            begin
                 if Application.MessageBox('Confirma Exclus�o de Registro ??? ','Aten��o',4) = MrYes then
                 begin
                    Tabela.Delete;
                    Tabela.Close;
                 end;
            end;
          Bbtn_Pesquisar.SetFocus;
        end;
    // Alterar
    3 : begin
          if Tabela.RecordCount > 0 then
            begin
               Tabela.Edit;
               DBEdit_Nome.SetFocus;
            end;
        end;
    //  Gravar
    4 : begin
          cod := StrToInt(DBT_Codigo.Caption);

          Tabela.Post;
          Tabela.Close;

          if cod <> 0 then
             Tabela.ParamByName('CODIGO').AsInteger := cod
          else
            begin
               with Dm.IBQ_Pesquisa, sql do
               begin
                 close;
                 clear;
                 add('select max(codigo) cod from SOCIO ');
                 open;
               end;
               Tabela.ParamByName('CODIGO').AsInteger := Dm.IBQ_Pesquisa.FieldByName('COD').AsInteger;
            end;

          Tabela.Open;

          // Verifica se entrou atrav�s da DLG
          if bDlg_Inc = False then
             Bbtn_Pesquisar.SetFocus
          else
             Bbtn_Sair.Click;
        end;
    // Cancelar
    5 : begin
          Tabela.Cancel;
          Tabela.Close;

          // Verifica se entrou atrav�s da DLG
          if bDlg_Inc = False then
             Bbtn_Pesquisar.SetFocus
          else
             Bbtn_Sair.Click;
        end;
    // Imprimir
    6 : begin

        end;
    // Pesquisa Categorias
    7 : begin
          Dlg_Empresa.Edit_pesquisa.Clear;
          if Dlg_Empresa.ShowModal = mrOk then
            begin
               Tabela.Close;
               Tabela.ParamByName('CODIGO').AsInteger := Dlg_Empresa.SQL_Pesquisa.FieldByName('CODIGO').AsInteger;
               Tabela.Open;
               Ativa_Source;
            end;
        end;
    // Finaliza Pesquisa
    8 : begin
          //99
        end;
    9 : Close;
  end;
end;

procedure TSg_0026.sSpeedButton1Click(Sender: TObject);
begin
  with Sg_0000.IBQ_PesqSocio, SQL do
    begin
      Close;
      Clear;
      Add('update socio set empresa = ''SPECIAL DOG''');
      Add('where (empresa like ''MANF%'')');
      Add('or (empresa like ''SPECI%'')');
      Add('or (empresa like ''Special%'')');
      Open;
    end;
end;

procedure TSg_0026.Bbtn_IncluirClick(Sender: TObject);
begin
  Manutencao((Sender as TBitBtn).Tag, Dm.IBDS_Socio);
end;

procedure TSg_0026.FormShow(Sender: TObject);
begin
   Dm.DS_Socio.OnStateChange    := StateChange;
   Screen.OnActiveControlChange := ControlChange;

  // Verifica se entrou atrav�s da DLG
  if bDlg_Inc = False then
     Bbtn_Pesquisar.SetFocus
  else
     Bbtn_Incluir.Click;
end;

procedure TSg_0026.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (Dm.DS_Socio.State <> DsBrowse) and
     (Dm.IBDS_Socio.Active = True)   then
     CanClose := False;
end;

procedure TSg_0026.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssAlt]) and (Key = VK_F4) then Key := VK_Clear;
  if key = vk_return   then Perform(wm_NextDlgCtl,0,0);
  if key = vk_escape   then Perform(wm_NextDlgCtl,1,0);
end;

procedure TSg_0026.StateChange(Sender: TObject);
begin
  Pan_dados.Enabled      :=     (Dm.DS_Socio.State in [DSEDIT,DSINSERT]);
  BBtn_Incluir.Enabled   := not (Dm.DS_Socio.State in [DSINSERT,DSEDIT]);
  BBtn_Excluir.Enabled   :=     (Dm.DS_Socio.State in [DSBROWSE]);
  BBtn_Alterar.Enabled   :=     (Dm.DS_Socio.State in [DSBROWSE]);
  BBtn_Gravar.Enabled    :=      Dm.DS_Socio.State in [DSINSERT,DSEDIT];
  BBtn_Cancelar.Enabled  :=      Dm.DS_Socio.State in [DSINSERT,DSEDIT];

  BBtn_imprimir.Enabled  := not (Dm.DS_Socio.State in [DSINSERT,DSEDIT]);
  BBtn_pesquisar.Enabled := not (Dm.DS_Socio.State in [DSINSERT,DSEDIT]);
  BBtn_sair.Enabled      := not (Dm.DS_Socio.State in [DSINSERT,DSEDIT]);
end;

procedure TSg_0026.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dm.DS_Socio.OnStateChange := nil;
  Dm.IBDS_Socio.close;
end;

procedure TSg_0026.FormDestroy(Sender: TObject);
begin
   Screen.OnActiveControlChange := Nil;
end;

procedure TSg_0026.DBRG_pessoaExit(Sender: TObject);
begin
   if (Trim(Copy(DBEdit_Cnpj.Text,1,1)) = '') and (Trim(Copy(DBEdit_insc_rg.Text,1,1)) = '') then
     begin
        if DBRG_pessoa.ItemIndex = 0 then // Pessoa F�sica
          begin
             Dm.IBDS_Socio.FieldByName('CPF_CNPJ').EditMask := '999.999.999-99;1';
             Dm.IBDS_Socio.FieldByName('RG_IE').EditMask    := '99.999.999-c;1'; // 788 - 'c' Permite o uso de qualquer caracter para a posi��o
          end
        else
          begin
             Dm.IBDS_Socio.FieldByName('CPF_CNPJ').EditMask := '99.999.999/9999-99;1';
             Dm.IBDS_Socio.FieldByName('RG_IE').EditMask    := '999.999.999.999;1';
          end;
    end;
end;

procedure TSg_0026.DBEdit_cnpjKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var snum : String;
begin
   if key = vk_return then
     begin
        if DBRG_Pessoa.ItemIndex = 0 then
          begin
             // Tira os Pontos
             snum := Copy(DBEdit_cnpj.Text,1,3) + Copy(DBEdit_cnpj.Text,5,3) + Copy(DBEdit_cnpj.Text,9,3) + Copy(DBEdit_cnpj.Text,13,2);

             // Verifica se digitou
             if Length(Trim(snum)) = 11 then
               begin
                  // Verifica se � V�lido
                  if cpf(snum) = False then
                    begin
                       ShowMessage('Este n�mero de CPF n�o � v�lido!!!');
                       DBEdit_cnpj.SetFocus;
                       Exit;
                    end
                  else
                    begin
                       // Antes de Gravar, verifica se existe cadastro para esse CPF
                       with Dm.IBQ_Pesquisa, sql do
                         begin
                            close;
                            clear;
                            add('select * from SOCIO where CPF_CNPJ = :cpf ');
                            ParamByName('cpf').AsString := DBEdit_cnpj.Text;
                            open;
                         end;
                       if Dm.IBQ_Pesquisa.RecordCount > 0 then
                         begin
                            if (Dm.IBDS_Socio.State <> dsInsert) and (Dm.IBQ_Pesquisa.FieldByName('CODIGO').AsInteger = StrToInt(DBT_Codigo.Caption)) then
                               Exit;

                            if Application.MessageBox('J� existe cadastro para esse CPF! Deseja Continuar?','Aten��o',4) = MrNo then
                               Bbtn_Cancelar.Click;
                         end;
                    end;
               end
             else
               begin
                  if Length(Trim(snum)) > 0 then
                    begin
                       ShowMessage('Este n�mero de CPF n�o � v�lido!!!');
                       DBEdit_cnpj.SetFocus;
                       Exit;
                    end;
               end;
          end
        else
          begin
             // Tira os Pontos
             snum := Copy(DBEdit_cnpj.Text,1,2) + Copy(DBEdit_cnpj.Text,4,3) + Copy(DBEdit_cnpj.Text,8,3) + Copy(DBEdit_cnpj.Text,12,4) + Copy(DBEdit_cnpj.Text,17,2);

             // Verifica se digitou
             if Length(Trim(snum)) = 14 then
               begin
                  // Verifica se � V�lido
                  if cnpj(snum) = False then
                    begin
                       ShowMessage('Este n�mero de CNPJ n�o � v�lido!!!');
                       DBEdit_cnpj.SetFocus;
                       Exit;
                    end
                  else
                    begin
                       // Antes de Gravar, verifica se existe cadastro para esse CNPF
                       with Dm.IBQ_Pesquisa, sql do
                         begin
                            close;
                            clear;
                            add('select * from SOCIO where CPF_CNPJ = :cpf ');
                            ParamByName('cpf').AsString := DBEdit_cnpj.Text;
                            open;
                         end;
                       if Dm.IBQ_Pesquisa.RecordCount > 0 then
                         begin
                            if (Dm.IBDS_Socio.State <> dsInsert) and (Dm.IBQ_Pesquisa.FieldByName('CODIGO').AsInteger = StrToInt(DBT_Codigo.Caption)) then
                               Exit;

                            if Application.MessageBox('J� existe cadastro para esse CNPJ! Deseja Continuar?','Aten��o',4) = MrNo then
                               Bbtn_Cancelar.Click;
                         end;
                    end;
               end
             else
               begin
                  if Length(Trim(snum)) > 0 then
                    begin
                       ShowMessage('Este n�mero de CNPJ n�o � v�lido!!!');
                       DBEdit_cnpj.SetFocus;
                       Exit;
                    end;
               end;
          end;
     end;
end;

procedure TSg_0026.DBEdit_dt_nascKeyPress(Sender: TObject; var Key: Char);
begin
  if key = chr(8) then // BackSpace
     begin
        if DBEdit_DT_NASC.Text = '  /  /    ' then
          begin
             Dm.IBDS_SOCIO.FieldByName('DT_NASC').EditMask := '';
             Dm.IBDS_SOCIO.FieldByName('DT_NASC').AsString := '';
         end;
     end;
end;

procedure TSg_0026.DBEdit_dt_nascEnter(Sender: TObject);
begin
    Dm.IBDS_Socio.fieldByName('DT_NASC').EditMask := '99/99/9999;1';
end;

procedure TSg_0026.Ativa_Source;
begin
   DBT_codigo.DataField           := 'CODIGO';
   DBT_codigo.DataSource          := Dm.DS_Socio;
   DBEdit_Nome.DataSource         := Dm.DS_Socio;
   DBEdit_Nome.DataField          := 'NOME';
   DBEdit_Dt_Nasc.DataSource      := Dm.DS_Socio;
   DBEdit_Dt_Nasc.DataField       := 'DT_NASC';
   DBEdit_Endereco.DataSource     := Dm.DS_Socio;
   DBEdit_Endereco.DataField      := 'ENDERECO';
   DBEdit_Nro.DataSource          := Dm.DS_Socio;
   DBEdit_Nro.DataField           := 'NRO';
   DBEdit_Bairro.DataSource       := Dm.DS_Socio;
   DBEdit_Bairro.DataField        := 'BAIRRO';
   DBEdit_Nome_Cid.DataSource     := Dm.DS_Socio;
   DBEdit_Nome_Cid.DataField      := 'CIDADE';
   DBEdit_uf_Cid.DataSource       := Dm.DS_Socio;
   DBEdit_uf_Cid.DataField        := 'UF';
   DBEdit_CEP.DataSource          := Dm.DS_Socio;
   DBEdit_CEP.DataField           := 'CEP';
   DBEdit_Complemento.DataSource  := Dm.DS_Socio;
   DBEdit_Complemento.DataField   := 'COMPLEMENTO';
   DBEdit_Empresa.DataSource      := Dm.DS_Socio;
   DBEdit_Empresa.DataField       := 'EMPRESA';
   DBEdit_Profissao.DataSource    := Dm.DS_Socio;
   DBEdit_Profissao.DataField     := 'PROFISSAO';
   DBEdit_Fone.DataSource         := Dm.DS_Socio;
   DBEdit_Fone.DataField          := 'FONE';
   DBEdit_Fone1.DataSource        := Dm.DS_Socio;
   DBEdit_Fone1.DataField         := 'FONE1';
   DBEdit_Celular.DataSource      := Dm.DS_Socio;
   DBEdit_Celular.DataField       := 'CELULAR';
   DBEdit_Email.DataSource        := Dm.DS_Socio;
   DBEdit_Email.DataField         := 'EMAIL';
   DBEdit_CNPJ.DataSource         := Dm.DS_Socio;
   DBEdit_CNPJ.DataField          := 'CPF_CNPJ';
   DBEdit_INSC_RG.DataSource      := Dm.DS_Socio;
   DBEdit_INSC_RG.DataField       := 'RG_IE';
   DBEdit_INSC_RG.DataSource      := Dm.DS_Socio;
   DBEdit_INSC_RG.DataField       := 'RG_IE';
   DBEdit_Valor.DataSource        := Dm.DS_Socio;
   DBEdit_Valor.DataField         := 'VALOR';
   DBCB_Sexo.DataSource           := Dm.DS_Socio;
   DBCB_Sexo.DataField            := 'SEXO';
   DBRG_Pessoa.DataSource         := Dm.DS_Socio;
   DBRG_Pessoa.DataField          := 'FLG_TIPO';
   DBRG_Tipo.DataSource           := Dm.DS_Socio;
   DBRG_Tipo.DataField            := 'FLG_ATIVO';
   DBEdit_Observ.DataSource       := Dm.DS_Socio;
   DBEdit_Observ.DataField        := 'OBSERV';
   DBRG_boleto.DataSource         := Dm.DS_Socio;
   DBRG_boleto.DataField          := 'FLG_BOLETO';
end;

end.
