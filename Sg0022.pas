unit Sg0022;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, Mask, DBCtrls,
  ComCtrls, DB, IBCustomDataSet, IBQuery, RDprint, ExtDlgs, ComObj;

type
  TSg_0022 = class(TForm)
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
    Pan_grid: TPanel;
    DBG_Parc: TDBGrid;
    Label3: TLabel;
    Pan_Cliente: TPanel;
    DBEdit_CodSocio: TDBEdit;
    DBEdit_Nome_socio: TDBEdit;
    RG_Filtro: TRadioGroup;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    Pan_Total: TPanel;
    Label2: TLabel;
    Lbl_Vlr_Rec: TLabel;
    Pan_Dados: TPanel;
    Label7: TLabel;
    DBEdit_Dt_Emissao: TDBEdit;
    Label6: TLabel;
    DBEdit_Dt_Vencto: TDBEdit;
    Label8: TLabel;
    DBEdit_Valor: TDBEdit;
    Label5: TLabel;
    DBEdit_Historico: TDBEdit;
    Label4: TLabel;
    DBEdit_NOSSO_NRO: TDBEdit;
    Label10: TLabel;
    DBEdit_Mes: TDBEdit;
    Bevel3: TBevel;
    Bevel4: TBevel;
    DS_Socio: TDataSource;
    IBQ_Socio: TIBQuery;
    bbtn_pesq_socio: TBitBtn;
    SB_Localizar: TSpeedButton;
    Label9: TLabel;
    DBEdit_dt_pgto: TDBEdit;
    Label11: TLabel;
    DBEdit_vlr_parc: TDBEdit;
    Panel1: TPanel;
    SB_Estorno: TSpeedButton;
    SB_Baixa: TSpeedButton;
    Bevel2: TBevel;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    DBEdit_Ano: TDBEdit;
    Label12: TLabel;
    MEdit_Data: TMaskEdit;
    SB_Boleto: TSpeedButton;
    Panel3: TPanel;
    Label13: TLabel;
    procedure Ativa_Source;
    procedure Manutencao(Botao: Integer; Tabela: TIBDataSet);
    procedure Filtra;
    procedure Bbtn_IncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure IBQ_SocioAfterOpen(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject);
    procedure DBEdit_HistoricoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RG_FiltroClick(Sender: TObject);
    procedure SB_BaixaClick(Sender: TObject);
    procedure SB_EstornoClick(Sender: TObject);
    procedure SB_LocalizarClick(Sender: TObject);
    procedure DBEdit_ValorKeyPress(Sender: TObject; var Key: Char);
    procedure MEdit_DataKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_BoletoClick(Sender: TObject);
  private
    ComponAnt : TDBEdit;
    procedure ControlChange(Sender : TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Sg_0022: TSg_0022;

implementation

uses Arquivos, Sg0000, Sg20,Sg0021, Sg0022A, Sgf0002p, Sgf0003p, SGF0012P,
  Sg0023;

{$R *.dfm}

function Alltrim(Text : string) : string;
begin
   while Pos(' ',Text) > 0 do Delete(Text,Pos(' ',Text),1);
   Result := Text;
end;

procedure TSg_0022.ControlChange(Sender : TObject);
begin
   if Assigned(ComponAnt) then ComponAnt.color  := clWhite;

   if ActiveControl is TDBEdit then
     begin
        TDBEdit(ActiveControl).Color := $0080FFFF;
        ComponAnt := TDBEdit(ActiveControl);
     end
   else
     ComponAnt := nil;
end;

procedure TSg_0022.Manutencao(Botao: Integer; Tabela: TIBDataSet);
begin
  case Botao of
    // Incluir
    1 : begin
           if DBEdit_CodSocio.Text <> '' then
             begin
                Tabela.Open;
                Ativa_Source;
                Tabela.Append;
                Tabela.FieldByName('CODIGO').AsInteger       := 0;
                Tabela.FieldByName('COD_SOCIO').AsInteger    := StrToInt(DBEdit_CodSocio.Text);
                Tabela.FieldByName('DT_EMISSAO').AsDateTime  := Date;
                Tabela.FieldByName('DT_VENCTO').AsDateTime   := Date;
                Tabela.FieldByName('VLR_PARC').AsFloat       := 0;
                Tabela.FieldByName('VLR_ACRES').AsFloat      := 0;
                Tabela.FieldByName('VLR_DESC').AsFloat       := 0;
                Tabela.FieldByName('VLR_PAGTO').AsFloat      := 0;

                Pan_dados.Enabled := True;
                DBEdit_Nosso_nro.SetFocus;
             end;
        end;
    // Excluir
    2 : begin
          if Tabela.RecordCount > 0 then
            begin
               if Application.MessageBox('Confirma Exclus?o de Registro ??? ','Aten??o',4) = MrYes then
                  Tabela.Delete;
               Filtra;
            end
          else
            ShowMessage('N?o h? Registros para Excluir!!!');

          Bbtn_Pesquisar.SetFocus;
        end;
    // Alterar
    3 : begin
          if Tabela.RecordCount > 0 then
            begin
               if Tabela.FieldByName('VLR_PAGTO').AsFloat > 0 then
                 begin
                    ShowMessage('J? houve Baixa para essa Conta!!!');
                    Bbtn_Pesquisar.SetFocus;
                 end
               else
                 begin
                    Tabela.Edit;
                    Pan_dados.Enabled := True;
                    DBEdit_Nosso_Nro.SetFocus;
                 end;
            end
          else
            ShowMessage('N?o h? Registros para Alterar!!!');
        end;
    //  Gravar
    4 : begin
           Tabela.Post;
           Pan_Dados.Enabled := False;
           Filtra;
           DBG_Parc.SetFocus;
        end;
    // Cancelar
    5 : begin
           Tabela.Cancel;
           Pan_Dados.Enabled := False;
           DBG_Parc.SetFocus;
        end;
    // Imprimir
    6 : begin
           SG_0022A := TSG_0022A.Create(Self);
           SG_0022A.ShowModal;
           SG_0022A.Destroy;
           DBG_Parc.SetFocus;
        end;
    // Pesquisa Categorias
    7 : begin
          Dlg_Socio.SB_Nova.Visible := True;
          Dlg_Socio.Edit_pesquisa.Clear;                                             
          if Dlg_Socio.ShowModal = mrOk then
            begin
               Ativa_Source;
               Dm.IBDS_Receber.Close;
               with IBQ_Socio, SQL do
                 begin
                    Close;
                    Clear;
                    Add('select a.*, b.nome from receber a, socio b');
                    Add('where (b.codigo = :codigo) and (a.cod_socio = b.codigo)');
                    ParamByName('codigo').AsInteger := Dlg_Socio.SQL_pesquisa.FieldByName('CODIGO').AsInteger;
                    Open;
                 end;

               Ativa_Source;
               Filtra;
               Ativa_Source;
               DBG_Parc.SetFocus;
            end;
        end;
    // Finaliza Pesquisa
    8 : begin
          //99
        end;
    9 : Close;
  end;
end;

procedure TSg_0022.Bbtn_IncluirClick(Sender: TObject);
begin
  Manutencao((Sender as TBitBtn).Tag, Dm.IBDS_Receber);
end;

procedure TSg_0022.FormShow(Sender: TObject);
begin
   MEdit_Data.Text := DateToStr(Date);
   Dm.IBDS_Receber.DataSource   := DS_Socio;
   Dm.DS_Receber.OnStateChange  := StateChange;
   Screen.OnActiveControlChange := ControlChange;
end;

procedure TSg_0022.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (Dm.DS_Receber.State <> DsBrowse) and
     (Dm.IBDS_Receber.Active = True)   then
     CanClose := False;
end;

procedure TSg_0022.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssAlt])  and (Key = vk_f4)     then Key := VK_Clear;  // Alt  + F4     (n?o deixa fechar janela)
  if (Shift = [ssCtrl]) and (Key = vk_delete) then Key := VK_Clear;  // Ctrl + Delete (n?o deleta item do grid)
  if key = vk_return    then Perform(wm_NextDlgCtl,0,0);
  if key = vk_escape    then Perform(wm_NextDlgCtl,1,0);
  
end;

procedure TSg_0022.StateChange(Sender: TObject);
begin
  Pan_dados.Enabled      :=     (Dm.DS_Receber.State in [DSEDIT,DSINSERT]);
  BBtn_Incluir.Enabled   := not (Dm.DS_Receber.State in [DSINSERT,DSEDIT]);
  BBtn_Excluir.Enabled   :=     (Dm.DS_Receber.State in [DSBROWSE]);
  BBtn_Alterar.Enabled   :=     (Dm.DS_Receber.State in [DSBROWSE]);
  BBtn_Gravar.Enabled    :=      Dm.DS_Receber.State in [DSINSERT,DSEDIT];
  BBtn_Cancelar.Enabled  :=      Dm.DS_Receber.State in [DSINSERT,DSEDIT];

  BBtn_imprimir.Enabled  := not (Dm.DS_Receber.State in [DSINSERT,DSEDIT]);
  BBtn_pesquisar.Enabled := not (Dm.DS_Receber.State in [DSINSERT,DSEDIT]);
  BBtn_sair.Enabled      := not (Dm.DS_Receber.State in [DSINSERT,DSEDIT]);
end;

procedure TSg_0022.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dm.DS_Receber.OnStateChange := nil;
  Dm.IBDS_Receber.DataSource  := nil;
  Dm.IBDS_Receber.close;
end;

procedure TSg_0022.FormDestroy(Sender: TObject);
begin
   Screen.OnActiveControlChange := Nil;
end;

procedure TSg_0022.Filtra;
begin
   with Dm.IBQ_Pesquisa, SQL do
     begin
        Close;
        Clear;
        Add ('select sum(vlr_parc) parc_total from receber ');
        Add ('where (cod_Socio = :cod_Socio) ');
        ParamByName('COD_SOCIO').AsInteger := IBQ_Socio.FieldByName('COD_SOCIO').AsInteger;
        Open;
     end;
   Lbl_Vlr_Rec.Caption := 'R$ ' + FloatToStrF(Dm.IBQ_Pesquisa.FieldByName('parc_total').AsFloat,ffFixed,15,2);


   // Filtra Documentos
   with Dm.IBDS_Receber, SelectSQL do
     begin
        Close;
        Clear;
        Add('select * from receber ');
        Add('where (cod_socio = :cod_socio) ');
        if RG_Filtro.ItemIndex = 1 then Add('and (vlr_pagto = 0) ');
        if RG_Filtro.ItemIndex = 2 then Add('and (vlr_pagto > 0) ');
        Add('order by dt_emissao, nosso_nro, mes ');
        ParamByName('COD_SOCIO').AsInteger := IBQ_Socio.FieldByName('COD_SOCIO').AsInteger;
        Open;
     end;

   Dm.IBDS_Receber.Open;
end;

procedure TSg_0022.IBQ_SocioAfterOpen(DataSet: TDataSet);
begin
  (IBQ_Socio.FieldByName('COD_SOCIO') As TIntegerfield).DisplayFormat := '000000';
end;

procedure TSg_0022.FormActivate(Sender: TObject);
begin
   Bbtn_Pesquisar.Click;
end;

procedure TSg_0022.DBEdit_HistoricoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_return then
      Bbtn_Gravar.SetFocus;
end;

procedure TSg_0022.RG_FiltroClick(Sender: TObject);
begin
   Filtra;
   DBG_Parc.SetFocus;
end;

procedure TSg_0022.SB_BaixaClick(Sender: TObject);
var semissao, svencto, sconcil : String;
begin
   // Confirma Estorno
   if Application.MessageBox('Deseja Baixar Boleto?','Confirme',4) = MrYes then
     begin
        if (Dm.IBDS_Receber.RecordCount > 0) and (Dm.IBDS_Receber.FieldByName('DT_PAGTO').AsString = '') then
          begin
             Dm.IBDS_Receber.Edit;
             Dm.IBDS_Receber.FieldByName('VLR_PAGTO').AsFloat := Dm.IBDS_Receber.FieldByName('VLR_PARC').AsFloat;
             Dm.IBDS_Receber.FieldByName('DT_PAGTO').AsString := MEdit_Data.Text;
             Dm.IBDS_Receber.Post;


             if Application.MessageBox('Deseja gravar lan?amento no Financeiro?','Confirme',4) = MrYes then
               begin
                 while True do
                   begin
                      // Escolhe Conta
                      if Dlg_Conta.Showmodal = mrOk then
                        begin
                           if (Dlg_Conta.SQL_pesquisa.FieldByName('CODIGO').AsString = '') then
                             begin
                                ShowMessage('Op??o escolhida n?o ? v?lida como uma Conta!!!');
                                Continue;
                             end;

                           Dlg_ccusto.e_s := 'E'; // Entrada de dinheiro no Financeiro

                           // Escolhe Centro de Custo
                           if dlg_ccusto.showModal = MrOk then
                             begin
                                if (Dlg_ccusto.SQL_pesquisa.FieldByName('COD_CCUSTO').AsString   = '') or
                                   (Dlg_ccusto.SQL_pesquisa.FieldByName('COD_CCUSTO').AsInteger <= 4)  then
                                  begin
                                     ShowMessage('Op??o escolhida n?o ? v?lida como um Centro de Custo!!!');
                                     Continue;
                                  end;

                                // Escolhe Filial
                                if Dlg_Filiais.Showmodal = mrOk then
                                  begin
                                     if (Dlg_Filiais.SQL_pesquisa.FieldByName('CODIGO').AsString = '') then
                                       begin
                                          ShowMessage('Op??o escolhida n?o ? v?lida como uma Filial!!!');
                                          Continue;
                                       end;

                                     semissao := MEdit_Data.Text;
                                     svencto  := MEdit_Data.Text;
                                     sconcil  := MEdit_Data.Text;
                                     InputQuery('Dados da Baixa','Informe a Data de Emiss?o: '    ,semissao);
                                     InputQuery('Dados da Baixa','Informe a Data de Vencimento: ' ,svencto);
                                     InputQuery('Dados da Baixa','Informe a Data de Concilia??o: ',sconcil);
                                     if Trim(semissao) = '' then semissao := MEdit_Data.Text;
                                     if Trim(svencto)  = '' then svencto  := MEdit_Data.Text;

                                     // Verifica Data de Emiss?o
                                     try
                                       semissao := DateToStr(StrToDate(semissao));
                                     except
                                       ShowMessage('Data de Emiss?o estava inv?lida e foi corrigida! Favor conferir!');
                                       semissao := DateToStr(Date);
                                     end;

                                     // Verifica Data de Vencimento
                                     try
                                       svencto := DateToStr(StrToDate(svencto));
                                     except
                                       ShowMessage('Data de Vencimento estava inv?lida e foi corrigida! Favor conferir!');
                                       svencto := DateToStr(Date);
                                     end;

                                     // Verifica Data de Concilia??o
                                     if Trim(sconcil) <> '' then
                                       begin
                                          try
                                            sconcil := DateToStr(StrToDate(sconcil));
                                          except
                                            ShowMessage('Data de Concilia??o estava inv?lida e foi corrigida! Favor conferir!');
                                            sconcil := DateToStr(Date);
                                          end;
                                       end;


                                     // Grava lan?amento...
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
                                          ParamByName('valor').AsFloat            := Dm.IBDS_Receber.FieldByName('VLR_PARC').AsFloat;
                                          ParamByName('cod_ccusto').AsInteger     := Dlg_ccusto.SQL_pesquisa.FieldByName('CODIGO').AsInteger;
                                          ParamByName('nro_cheque').AsString      := '';
                                          ParamByName('historico').AsString       := Dlg_ccusto.SQL_pesquisa.FieldByName('NOME').AsString + ' - ' + Copy(DBEdit_Nome_socio.Text,1,35-Length(Dlg_ccusto.SQL_pesquisa.FieldByName('NOME').AsString)) +' ('+ DBEdit_NOSSO_NRO.Text + ')';
                                          ParamByName('cod_conta_movto').AsString := '';
                                          ParamByName('cod_movto').AsString       := '';
                                          ParamByName('data_vencto').AsDateTime   := StrToDate(svencto);
                                          ParamByName('data_pagto').AsString      := sconcil;
                                          ParamByName('cod_filial').AsInteger     := Dlg_Filiais.SQL_pesquisa.FieldByName('CODIGO').AsInteger;
                                          Open;
                                       end;
                                     Dm.IBT_Financ.Commit;
                                     ShowMessage('Lan?amento gravado no Financeiro com Sucesso!!!');
                                     Break;
                                  end;
                             end;
                        end;
                   end;
               end;


             Filtra;
          end
        else
          ShowMessage('N?o h? Boleto selecionado para Baixar!')
     end;
end;

procedure TSg_0022.SB_EstornoClick(Sender: TObject);
begin
   // Confirma Estorno
   if Application.MessageBox('Deseja Estornar Recebimento?','Confirme',4) = MrYes then
     begin
        if Dm.IBDS_Receber.RecordCount > 0 then
          begin
             Dm.IBDS_Receber.Edit;
             Dm.IBDS_Receber.FieldByName('VLR_ACRES').AsFloat := 0;
             Dm.IBDS_Receber.FieldByName('VLR_DESC').AsFloat  := 0;
             Dm.IBDS_Receber.FieldByName('VLR_PAGTO').AsFloat := 0;
             Dm.IBDS_Receber.FieldByName('DT_PAGTO').AsString := '';
             Dm.IBDS_Receber.Post;
             Filtra;
          end
        else
          ShowMessage('Parcela N?o Foi Recebida!!!')
     end;

   DBG_Parc.SetFocus;
end;

procedure TSg_0022.SB_LocalizarClick(Sender: TObject);
var snro_doc : String;
begin
   // Verifica se tabela est? em edi??o
   if (Dm.IBDS_Receber.State <> dsBrowse) and (Dm.IBDS_Receber.State <> dsInactive) then
      Exit;

   // Digita o n?mero do documento
   snro_doc := '';
   if InputQuery('Informe N?mero do Boleto','Localiza??o de Boletos',snro_doc) = False then
      Exit;


   // Localiza n?mero
   with Dm.IBQ_Pesquisa, Sql do
     begin
        Close;
        Clear;
        Add('select * from receber where nosso_nro = :nro');
        ParamByName('NRO').AsString := snro_doc;
        Open;
     end;

   if Dm.IBQ_Pesquisa.RecordCount > 0 then
     begin
        Dm.IBDS_Receber.Close;
        IBQ_Socio.Close;
        IBQ_Socio.ParamByName('CODIGO').AsInteger := Dm.IBQ_Pesquisa.FieldByName('COD_SOCIO').AsInteger;
        IBQ_Socio.Open;
        Dm.IBDS_Receber.Open;

        RG_filtro.ItemIndex := 0;

        Dm.IBDS_Receber.Locate('NOSSO_NRO',VarArrayOf([StrToFloat(snro_doc)]),[loPartialKey]);
     end
   else
     ShowMessage('Boleto n?o encontrado!');
end;

procedure TSg_0022.DBEdit_ValorKeyPress(Sender: TObject; var Key: Char);
begin
   // Se digitar 'ponto', substitui por 'virgula'
   if key = chr(46) then key := chr(44);
end;

procedure TSg_0022.Ativa_Source;
begin
   DBG_Parc.DataSource            := Dm.DS_Receber;
   DBEdit_codSocio.DataSource     := DS_Socio;
   DBEdit_codSocio.DataField      := 'COD_SOCIO';
   DBEdit_Nome_socio.DataSource   := DS_Socio;
   DBEdit_Nome_socio.DataField    := 'NOME';
   DBEdit_Nosso_Nro.DataSource    := Dm.DS_Receber;
   DBEdit_Nosso_Nro.DataField     := 'NOSSO_NRO';
   DBEdit_Dt_Emissao.DataSource   := Dm.DS_Receber;
   DBEdit_Dt_Emissao.DataField    := 'DT_EMISSAO';
   DBEdit_Dt_Vencto.DataSource    := Dm.DS_Receber;
   DBEdit_Dt_Vencto.DataField     := 'DT_VENCTO';
   DBEdit_Valor.DataSource        := Dm.DS_Receber;
   DBEdit_Valor.DataField         := 'VLR_PARC';
   DBEdit_Mes.DataSource          := Dm.DS_Receber;
   DBEdit_Mes.DataField           := 'MES';
   DBEdit_Ano.DataSource          := Dm.DS_Receber;
   DBEdit_Ano.DataField           := 'ANO';
   DBEdit_Dt_Pgto.DataSource      := Dm.DS_Receber;
   DBEdit_Dt_Pgto.DataField       := 'DT_PAGTO';
   DBEdit_Vlr_Parc.DataSource     := Dm.DS_Receber;
   DBEdit_Vlr_Parc.DataField      := 'VLR_PAGTO';
   DBEdit_Historico.DataSource    := Dm.DS_Receber;
   DBEdit_Historico.DataField     := 'HISTORICO';
end;

procedure TSg_0022.MEdit_DataKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_return then
     begin
        if MEdit_Data.Text <> '  /  /    ' then
          begin
             try
                MEdit_Data.Text := DateToStr(StrToDate(MEdit_Data.Text));
             except
                ShowMessage('Data Inv?lida!!!');
                MEdit_Data.SetFocus;
             end;
          end
        else
          MEdit_Data.Text := DateToStr(Date);
     end;
end;

procedure TSg_0022.SB_BoletoClick(Sender: TObject);
begin
   SG_0023 := TSG_0023.Create(Self);
   SG_0023.Edit_codSocio.Text   := DBEdit_CodSocio.Text;
   SG_0023.Edit_Nome_Socio.Text := DBEdit_Nome_socio.Text;
   SG_0023.ShowModal;
   SG_0023.Destroy;
end;

end.
