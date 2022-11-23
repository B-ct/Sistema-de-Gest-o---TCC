unit Sg0024;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, Mask, DBCtrls,
  ComCtrls, DB, IBCustomDataSet, RDprint, IBQuery;

type
  TSg_0024 = class(TForm)
    Pan_Botao: TPanel;
    bbtn_gerar: TBitBtn;
    bbtn_sair: TBitBtn;
    Pan_dados: TPanel;
    GB_Periodo: TGroupBox;
    MEdit_Data1: TMaskEdit;
    MEdit_Data2: TMaskEdit;
    GB_Socio: TGroupBox;
    Edit_CodSocio1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Bevel3: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Edit_CodSocio2: TEdit;
    Bevel7: TBevel;
    GB_Associado: TGroupBox;
    SB_Socio: TSpeedButton;
    SB_Limpa_Socio: TSpeedButton;
    Edit_CodSocio: TEdit;
    Edit_NomeSocio: TEdit;
    GB_Vencimento: TGroupBox;
    Label5: TLabel;
    Edit_Vencto: TEdit;
    GroupBox1: TGroupBox;
    Edit_Valor: TEdit;
    IBQ_Pesquisa: TIBQuery;
    Label6: TLabel;
    Edit_Letra1: TEdit;
    Label7: TLabel;
    Edit_Letra2: TEdit;
    Panel3: TPanel;
    Label13: TLabel;
    Panel1: TPanel;
    LB_Socios: TListBox;
    Panel2: TPanel;
    SB_inserir: TSpeedButton;
    SB_retirar: TSpeedButton;
    SB_limpa: TSpeedButton;
    Bevel1: TBevel;
    Label8: TLabel;
    GroupBox2: TGroupBox;
    Edit_Empresa: TEdit;
    SB_Empresa: TSpeedButton;
    SB_LimpaEmpresa: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure bbtn_sairClick(Sender: TObject);
    procedure MEdit_Data1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MEdit_Data2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bbtn_gerarClick(Sender: TObject);
    procedure Edit_CodSocio1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit_CodSocio2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_Limpa_SocioClick(Sender: TObject);
    procedure SB_SocioClick(Sender: TObject);
    procedure Edit_VenctoExit(Sender: TObject);
    procedure MEdit_Data1Exit(Sender: TObject);
    procedure MEdit_Data2Exit(Sender: TObject);
    procedure Edit_ValorExit(Sender: TObject);
    procedure Edit_ValorEnter(Sender: TObject);
    procedure Edit_Letra1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit_Letra2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit_Letra1KeyPress(Sender: TObject; var Key: Char);
    procedure SB_inserirClick(Sender: TObject);
    procedure SB_retirarClick(Sender: TObject);
    procedure SB_limpaClick(Sender: TObject);
    procedure SB_EmpresaClick(Sender: TObject);
    procedure SB_LimpaEmpresaClick(Sender: TObject);
  private
    ComponAnt  : TMaskEdit;
    ComponAnt2 : TEdit;
    procedure ControlChange(Sender : TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Sg_0024: TSg_0024;

implementation

uses Arquivos, Sg0000, Sg20, Sg21;

{$R *.dfm}

procedure TSg_0024.ControlChange(Sender : TObject);
begin
   if Assigned(ComponAnt)  then ComponAnt.color  := clWhite;
   if Assigned(ComponAnt2) then ComponAnt2.color := clWhite;

   if ActiveControl is TMaskEdit then
     begin
        TMaskEdit(ActiveControl).Color := $0080FFFF;
        ComponAnt := TMaskEdit(ActiveControl);
     end
   else
     ComponAnt := nil;

   if ActiveControl is TEdit then
     begin
        TEdit(ActiveControl).Color := $0080FFFF;
        ComponAnt2 := TEdit(ActiveControl);
     end
   else
     ComponAnt2 := nil;
end;

procedure TSg_0024.FormShow(Sender: TObject);
begin
   Screen.OnActiveControlChange := ControlChange;
   LB_Socios.Clear;
   // Iniciliza Campos
   SB_Limpa_Socio.Click;
   MEdit_Data1.SetFocus;
end;

procedure TSg_0024.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssAlt]) and (Key = VK_F4) then Key := VK_Clear;
  if key = vk_return   then Perform(wm_NextDlgCtl,0,0);
  if key = vk_escape   then Perform(wm_NextDlgCtl,1,0);
  if key = vk_f6       then SB_Socio.Click;
  if Key = vk_f7       then SB_Empresa.Click;

end;

procedure TSg_0024.FormDestroy(Sender: TObject);
begin
   Screen.OnActiveControlChange := Nil;
end;

procedure TSg_0024.bbtn_sairClick(Sender: TObject);
begin
   Close;
end;

procedure TSg_0024.MEdit_Data1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_escape then
      bbtn_sair.SetFocus;

   if key = vk_return then
     begin
        if MEdit_Data1.Text <> '  /    ' then
          begin
             try
                if Copy(MEdit_Data1.Text,1,2) = '00' then
                   MEdit_Data1.Text := '00/' + Copy(DateToStr(StrToDate('01/01/'+Copy(MEdit_Data1.Text,4,4))),7,4)
                else
                   MEdit_Data1.Text := Copy(DateToStr(StrToDate('01/'+MEdit_Data1.Text)),4,7);
                MEdit_Data2.SetFocus;
             except
                ShowMessage('M�s/Ano Inicial Inv�lido!!!');
                MEdit_Data1.SetFocus;
             end;
          end
        else
          begin
             MEdit_Data1.Text := DateToStr(Date);
             MEdit_Data2.SetFocus;
          end;
     end;
end;

procedure TSg_0024.MEdit_Data2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_escape then
      MEdit_Data1.SetFocus;

   if key = vk_return then
     begin
        if MEdit_Data2.Text <> '  /    ' then
          begin
             try
                if Copy(MEdit_Data2.Text,1,2) = '00' then
                   MEdit_Data2.Text := '00/' + Copy(DateToStr(StrToDate('01/01/'+Copy(MEdit_Data2.Text,4,4))),7,4)
                else
                   MEdit_Data2.Text := Copy(DateToStr(StrToDate('01/'+MEdit_Data2.Text)),4,7);
                Edit_Vencto.SetFocus;
             except
                ShowMessage('M�s/Ano Final Inv�lido!!!');
                MEdit_Data2.SetFocus;
             end;
          end
        else
          begin
             MEdit_Data2.Text := DateToStr(Date);
             Edit_Vencto.SetFocus;
          end;
     end;
end;

procedure TSg_0024.bbtn_gerarClick(Sender: TObject);
var sdata, sdia, smesi, sanoi, smesf, sanof : String;
var a : integer;
begin
   if Application.MessageBox('Deseja realmente gerar parcelas?','ATEN��O!',4) = MrNo then Exit;

   // Confirma Datas
   if (Copy(MEdit_Data1.Text,1,2) <> '00') and (Copy(MEdit_Data2.Text,1,2) <> '00') then
     begin
        if (MEdit_Data1.Text <> '  /    ') and (MEdit_Data2.Text <> '  /    ') then
          begin
             if StrToDate('01/'+MEdit_Data1.Text) > StrToDate('01/'+MEdit_Data2.Text) then
               begin
                  ShowMessage('M�s/Ano Inicial est� menor que M�s/Ano Final!!!');
                  MEdit_Data1.SetFocus;
                  Exit;
               end;
          end
        else
          begin
             ShowMessage('M�s/Ano Inv�lido!!!');
             MEdit_Data1.SetFocus;
             Exit;
          end;
     end;

   // Confirma Datas
   if ((Copy(MEdit_Data1.Text,1,2)  = '00') and (Copy(MEdit_Data2.Text,1,2) <> '00')) or
      ((Copy(MEdit_Data1.Text,1,2) <> '00') and (Copy(MEdit_Data2.Text,1,2)  = '00')) then
     begin
        ShowMessage('M�s/Ano Inv�lido!!!');
        MEdit_Data1.SetFocus;
        Exit;
     end;



   // Confirma Dia de Vencimento
   if Edit_Vencto.Text = '' then Edit_Vencto.Text := '01';
   if (StrToInt(Edit_Vencto.Text) < 1) or (StrToInt(Edit_Vencto.Text) > 31) then
     begin
        ShowMessage('Dia de Vencimento inv�lido!');
        Edit_Vencto.SetFocus;
        Exit;
     end;

   if LB_Socios.Items.Count > 0 then
   Begin
     for a := 0 to (LB_Socios.Items.Count - 1) do
     begin
             if Copy(MEdit_Data1.Text,1,2) <> '00' then
          begin
             smesi := Copy(MEdit_Data1.Text,1,2);
             sanoi := Copy(MEdit_Data1.Text,4,4);
             smesf := Copy(MEdit_Data2.Text,1,2);
             sanof := Copy(MEdit_Data2.Text,4,4);

             while StrToDate('01/'+smesi+'/'+sanoi) <= StrToDate('01/'+smesf+'/'+sanof) do
               begin
                  sdia := Edit_Vencto.Text;
                  while True do
                    begin
                       try
                         sdata := DateToStr(StrToDate(sdia +'/'+ smesi +'/'+ sanoi));
                         Break;
                       except
                         sdia := IntToStr(StrToInt(sdia)-1);
                       end;
                    end;


                  // Verifica se j� existe mensalidade para este s�cio neste m�s/ano
                  with Dm.IBQ_Pesquisa, Sql do
                    begin
                       Close;
                       Clear;
                       Add('select * from receber where (cod_socio = :cod_socio) and (ano = :ano) and (mes = :mes) ');
                       ParamByName('cod_socio').AsString  := Copy(LB_Socios.Items.Strings[a],01,06);
                       ParamByName('mes').AsInteger       := StrToInt(smesi);
                       ParamByName('ano').AsInteger       := StrToInt(sanoi);
                       Open;
                    end;

                  if Dm.IBQ_Pesquisa.RecordCount = 0 then
                    begin
                       if ((Copy(LB_Socios.Items.Strings[a],112,06) <> '') or
                           (StrToFloat(Edit_Valor.Text) > 0)) and
                           (StrToInt(sanoi) <= (StrToInt(Copy(DateToStr(Date),7,4))+1)) then
                         begin
                            // Grava M�s/Ano (Mensalidade)
                            with Dm.IBQ_Pesquisa, Sql do
                              begin
                                 Close;
                                 Clear;
                                 Add('insert into receber (codigo,cod_socio,dt_emissao,dt_vencto,vlr_parc,vlr_acres,vlr_desc,vlr_pagto,dt_pagto,historico,nosso_nro,mes,ano) ');
                                 Add('values (:codigo,:cod_socio,:dt_emissao,:dt_vencto,:vlr_parc,:vlr_acres,:vlr_desc,:vlr_pagto,:dt_pagto,:historico,:nosso_nro,:mes,:ano) ');
                                 ParamByName('codigo').AsInteger      := 0;
                                 ParamByName('cod_socio').AsString    := Copy(LB_Socios.Items.Strings[a],01,06);
                                 ParamByName('dt_emissao').AsDateTime := Date;
                                 ParamByName('dt_vencto').AsString    := sdata;
                                 if StrToFloat(Edit_Valor.Text) > 0 then
                                    ParamByName('vlr_parc').AsFloat   := StrToFloat(Edit_Valor.Text)
                                 else
                                 if Copy(LB_Socios.Items.Strings[a],112,06) <> '' then
                                  ParamByName('vlr_parc').AsFloat := StrToFloat(Copy(LB_Socios.Items.Strings[a],112,06));
                                 ParamByName('vlr_acres').AsFloat     := 0;
                                 ParamByName('vlr_desc').AsFloat      := 0;
                                 ParamByName('vlr_pagto').AsFloat     := 0;
                                 ParamByName('dt_pagto').AsString     := '';
                                 ParamByName('historico').AsString    := '';
                                 ParamByName('nosso_nro').AsString    := '';
                                 ParamByName('mes').AsInteger         := StrToInt(smesi);
                                 ParamByName('ano').AsInteger         := StrToInt(sanoi);
                                 Open;
                              end;
                         end;
                    end;


                  // Pr�ximo M�s/Ano
                  smesi := FormatFloat('00',StrToInt(smesi) + 1);
                  if smesi = '13' then
                    begin
                       smesi := '01';
                       sanoi := IntToStr(StrToInt(sanoi) + 1);
                    end;
               end;
          end
        else
          begin
             // Gera Parcela �nica
             smesi := Copy(MEdit_Data1.Text,1,2);
             sanoi := Copy(MEdit_Data1.Text,4,4);

             // Verifica se j� existe mensalidade para este s�cio neste m�s/ano
             with Dm.IBQ_Pesquisa, Sql do
               begin
                  Close;
                  Clear;
                  Add('select * from receber where (cod_socio = :cod_socio) and (ano = :ano) and (mes = :mes) ');
                  ParamByName('cod_socio').AsString := Copy(LB_Socios.Items.Strings[a],01,06);
                  ParamByName('mes').AsInteger       := StrToInt(smesi);
                  ParamByName('ano').AsInteger       := StrToInt(sanoi);
                  Open;
               end;


             if Dm.IBQ_Pesquisa.RecordCount = 0 then
               begin
                  if (StrToFloat(Edit_Valor.Text) > 0) and
                     (StrToInt(sanoi) <= (StrToInt(Copy(DateToStr(Date),7,4))+1)) then
                    begin
                       // Grava M�s/Ano
                       with Dm.IBQ_Pesquisa, Sql do
                         begin
                            Close;
                            Clear;
                            Add('insert into receber (codigo,cod_socio,dt_emissao,dt_vencto,vlr_parc,vlr_acres,vlr_desc,vlr_pagto,dt_pagto,historico,nosso_nro,mes,ano) ');
                            Add('values (:codigo,:cod_socio,:dt_emissao,:dt_vencto,:vlr_parc,:vlr_acres,:vlr_desc,:vlr_pagto,:dt_pagto,:historico,:nosso_nro,:mes,:ano) ');
                            ParamByName('codigo').AsInteger      := 0;
                            ParamByName('cod_socio').AsString    := Copy(LB_Socios.Items.Strings[a],01,06);
                            ParamByName('dt_emissao').AsDateTime := Date;
                            ParamByName('dt_vencto').AsDateTime  := Date;
                            if StrToFloat(Edit_Valor.Text) > 0 then
                               ParamByName('vlr_parc').AsFloat   := StrToFloat(Edit_Valor.Text)
                            else
                               if Copy(LB_Socios.Items.Strings[a],112,06) <> '' then
                                  ParamByName('vlr_parc').AsFloat := StrToFloat(Copy(LB_Socios.Items.Strings[a],112,06));
                            ParamByName('vlr_acres').AsFloat     := 0;
                            ParamByName('vlr_desc').AsFloat      := 0;
                            ParamByName('vlr_pagto').AsFloat     := 0;
                            ParamByName('dt_pagto').AsString     := '';
                            ParamByName('historico').AsString    := 'PARCELA UNICA ANUAL';
                            ParamByName('nosso_nro').AsString    := '';
                            ParamByName('mes').AsInteger         := StrToInt(smesi);
                            ParamByName('ano').AsInteger         := StrToInt(sanoi);
                            Open;
                         end;
                    end;
               end;
          end;
     end;
   End
   Else
   Begin
   // Captura Dados do S�cio
   with Dm.IBQ_PesqAux, Sql do
     begin
        Close;
        Clear;
        Add('select * from socio where (flg_ativo = :ativo) ');
        if (Edit_CodSocio1.Text <> '') and (Edit_CodSocio2.Text <> '') then
           Add('and (codigo between :cod1 and :cod2) ');
        if (Edit_Letra1.Text <> '') and (Edit_Letra2.Text <> '') then
           Add('and (substring(nome from 1 for 1) between :letra1 and :letra2) ');
        if Edit_NomeSocio.Text <> 'TODOS' then Add('and (codigo = :cod_socio) ');
        if Edit_Empresa.Text <> '' then Add('and (empresa = :empresa)');


        if (Edit_CodSocio1.Text <> '') and (Edit_CodSocio2.Text <> '') then
          begin
             ParamByName('cod1').AsInteger := StrToInt(Edit_CodSocio1.Text);
             ParamByName('cod2').AsInteger := StrToInt(Edit_CodSocio2.Text);
          end;
        if (Edit_Letra1.Text <> '') and (Edit_Letra2.Text <> '') then
          begin
             ParamByName('letra1').AsString := Edit_Letra1.Text;
             ParamByName('letra2').AsString := Edit_Letra2.Text;
          end;
        ParamByName('ativo').AsString := 'A'; // somente os ativos
        if Edit_NomeSocio.Text <> 'TODOS' then ParamByName('cod_socio').AsInteger := StrToInt(Edit_CodSocio.Text);
        if Edit_Empresa.Text <> '' then ParamByName('EMPRESA').AsString := Edit_Empresa.Text;

        Add('order by codigo ');
        Open;
     end;


   Dm.IBQ_PesqAux.First;
   while not Dm.IBQ_PesqAux.Eof do
     begin
        if Copy(MEdit_Data1.Text,1,2) <> '00' then
          begin
             smesi := Copy(MEdit_Data1.Text,1,2);
             sanoi := Copy(MEdit_Data1.Text,4,4);
             smesf := Copy(MEdit_Data2.Text,1,2);
             sanof := Copy(MEdit_Data2.Text,4,4);

             while StrToDate('01/'+smesi+'/'+sanoi) <= StrToDate('01/'+smesf+'/'+sanof) do
               begin
                  sdia := Edit_Vencto.Text;
                  while True do
                    begin
                       try
                         sdata := DateToStr(StrToDate(sdia +'/'+ smesi +'/'+ sanoi));
                         Break;
                       except
                         sdia := IntToStr(StrToInt(sdia)-1);
                       end;
                    end;


                  // Verifica se j� existe mensalidade para este s�cio neste m�s/ano
                  with Dm.IBQ_Pesquisa, Sql do
                    begin
                       Close;
                       Clear;
                       Add('select * from receber where (cod_socio = :cod_socio) and (ano = :ano) and (mes = :mes) ');
                       ParamByName('cod_socio').AsInteger := Dm.IBQ_PesqAux.FieldByName('CODIGO').AsInteger;
                       ParamByName('mes').AsInteger       := StrToInt(smesi);
                       ParamByName('ano').AsInteger       := StrToInt(sanoi);
                       Open;
                    end;

                  if Dm.IBQ_Pesquisa.RecordCount = 0 then
                    begin
                       if ((Dm.IBQ_PesqAux.FieldByName('VALOR').AsFloat     > 0) or
                           (StrToFloat(Edit_Valor.Text) > 0)) and
                           (StrToInt(sanoi) <= (StrToInt(Copy(DateToStr(Date),7,4))+1)) then
                         begin
                            // Grava M�s/Ano (Mensalidade)
                            with Dm.IBQ_Pesquisa, Sql do
                              begin
                                 Close;
                                 Clear;
                                 Add('insert into receber (codigo,cod_socio,dt_emissao,dt_vencto,vlr_parc,vlr_acres,vlr_desc,vlr_pagto,dt_pagto,historico,nosso_nro,mes,ano) ');
                                 Add('values (:codigo,:cod_socio,:dt_emissao,:dt_vencto,:vlr_parc,:vlr_acres,:vlr_desc,:vlr_pagto,:dt_pagto,:historico,:nosso_nro,:mes,:ano) ');
                                 ParamByName('codigo').AsInteger      := 0;
                                 ParamByName('cod_socio').AsInteger   := Dm.IBQ_PesqAux.FieldByName('CODIGO').AsInteger;
                                 ParamByName('dt_emissao').AsDateTime := Date;
                                 ParamByName('dt_vencto').AsString    := sdata;
                                 if StrToFloat(Edit_Valor.Text) > 0 then
                                    ParamByName('vlr_parc').AsFloat   := StrToFloat(Edit_Valor.Text)
                                 else
                                    if Dm.IBQ_PesqAux.FieldByName('VALOR').AsFloat > 0 then
                                       ParamByName('vlr_parc').AsFloat := Dm.IBQ_PesqAux.FieldByName('VALOR').AsFloat;
                                 ParamByName('vlr_acres').AsFloat     := 0;
                                 ParamByName('vlr_desc').AsFloat      := 0;
                                 ParamByName('vlr_pagto').AsFloat     := 0;
                                 ParamByName('dt_pagto').AsString     := '';
                                 ParamByName('historico').AsString    := '';
                                 ParamByName('nosso_nro').AsString    := '';
                                 ParamByName('mes').AsInteger         := StrToInt(smesi);
                                 ParamByName('ano').AsInteger         := StrToInt(sanoi);
                                 Open;
                              end;
                         end;
                    end;


                  // Pr�ximo M�s/Ano
                  smesi := FormatFloat('00',StrToInt(smesi) + 1);
                  if smesi = '13' then
                    begin
                       smesi := '01';
                       sanoi := IntToStr(StrToInt(sanoi) + 1);
                    end;
               end;
          end
        else
          begin
             // Gera Parcela �nica
             smesi := Copy(MEdit_Data1.Text,1,2);
             sanoi := Copy(MEdit_Data1.Text,4,4);

             // Verifica se j� existe mensalidade para este s�cio neste m�s/ano
             with Dm.IBQ_Pesquisa, Sql do
               begin
                  Close;
                  Clear;
                  Add('select * from receber where (cod_socio = :cod_socio) and (ano = :ano) and (mes = :mes) ');
                  ParamByName('cod_socio').AsInteger := Dm.IBQ_PesqAux.FieldByName('CODIGO').AsInteger;
                  ParamByName('mes').AsInteger       := StrToInt(smesi);
                  ParamByName('ano').AsInteger       := StrToInt(sanoi);
                  Open;
               end;

             if Dm.IBQ_Pesquisa.RecordCount = 0 then
               begin
                  if (StrToFloat(Edit_Valor.Text) > 0) and
                     (StrToInt(sanoi) <= (StrToInt(Copy(DateToStr(Date),7,4))+1)) then
                    begin
                       // Grava M�s/Ano
                       with Dm.IBQ_Pesquisa, Sql do
                         begin
                            Close;
                            Clear;
                            Add('insert into receber (codigo,cod_socio,dt_emissao,dt_vencto,vlr_parc,vlr_acres,vlr_desc,vlr_pagto,dt_pagto,historico,nosso_nro,mes,ano) ');
                            Add('values (:codigo,:cod_socio,:dt_emissao,:dt_vencto,:vlr_parc,:vlr_acres,:vlr_desc,:vlr_pagto,:dt_pagto,:historico,:nosso_nro,:mes,:ano) ');
                            ParamByName('codigo').AsInteger      := 0;
                            ParamByName('cod_socio').AsInteger   := Dm.IBQ_PesqAux.FieldByName('CODIGO').AsInteger;
                            ParamByName('dt_emissao').AsDateTime := Date;
                            ParamByName('dt_vencto').AsDateTime  := Date;
                            if StrToFloat(Edit_Valor.Text) > 0 then
                               ParamByName('vlr_parc').AsFloat   := StrToFloat(Edit_Valor.Text)
                            else
                               if Dm.IBQ_PesqAux.FieldByName('VALOR').AsFloat > 0 then
                                  ParamByName('vlr_parc').AsFloat := Dm.IBQ_PesqAux.FieldByName('VALOR').AsFloat;
                            ParamByName('vlr_acres').AsFloat     := 0;
                            ParamByName('vlr_desc').AsFloat      := 0;
                            ParamByName('vlr_pagto').AsFloat     := 0;
                            ParamByName('dt_pagto').AsString     := '';
                            ParamByName('historico').AsString    := 'PARCELA UNICA ANUAL';
                            ParamByName('nosso_nro').AsString    := '';
                            ParamByName('mes').AsInteger         := StrToInt(smesi);
                            ParamByName('ano').AsInteger         := StrToInt(sanoi);
                            Open;
                         end;
                    end;
               end;
          end;

        Dm.IBQ_PesqAux.Next;
     end;
   End;

   ShowMessage('Parcelas geradas com Sucesso!');
   bbtn_sair.SetFocus;
end;

procedure TSg_0024.Edit_CodSocio1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_escape then
      bbtn_gerar.SetFocus;

   if key = vk_return then
     begin
        if Trim(Edit_CodSocio1.Text) = '' then
           Edit_CodSocio1.Text := '000000'
        else
           while Length(Edit_CodSocio1.Text) < 6 do Edit_CodSocio1.Text := '0' + Edit_CodSocio1.Text;

        Edit_CodSocio2.SetFocus;
     end;
end;

procedure TSg_0024.Edit_CodSocio2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_escape then
      Edit_CodSocio1.SetFocus;

   if key = vk_return then
     begin
        if Trim(Edit_CodSocio2.Text) = '' then
           Edit_CodSocio2.Text := '999999'
        else
          begin
             while Length(Edit_CodSocio2.Text) < 6 do Edit_CodSocio2.Text := '0' + Edit_CodSocio2.Text;

             if StrToInt(Edit_CodSocio1.Text) > StrToInt(Edit_CodSocio2.Text) then
               begin
                  ShowMessage('N�mero Inicial n�o pode ser maior que N�mero Final!');
                  Edit_CodSocio1.SetFocus;
                  Exit;
               end;
          end;

        bbtn_gerar.SetFocus;
     end;
end;

procedure TSg_0024.SB_inserirClick(Sender: TObject);
var sCod, sNome, sLinha : String;
a : integer;
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

      a := Length(snome);

      sLinha := scod + ' - ' + sNome +FormatFloat('R$#,##0.00',DLG_Socio.SQL_pesquisa.FieldByName('VALOR').AsFloat);
      LB_Socios.Items.Add(sLinha);
   End;

   if Application.MessageBox('Selecionar outro Associado?','Confirme',4) = MrNo then
    Break;
 End;
end;

procedure TSg_0024.SB_limpaClick(Sender: TObject);
begin
  LB_Socios.Clear;
end;

procedure TSg_0024.SB_LimpaEmpresaClick(Sender: TObject);
begin
   Edit_Empresa.Text := '';
end;

procedure TSg_0024.SB_Limpa_SocioClick(Sender: TObject);
begin
   Edit_NomeSocio.Text := 'TODOS';
   Edit_CodSocio.Text  := '000000';
end;

procedure TSg_0024.SB_retirarClick(Sender: TObject);
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

procedure TSg_0024.SB_SocioClick(Sender: TObject);
begin
   Dlg_Socio.SB_Nova.Visible := False;
   Dlg_Socio.Edit_pesquisa.Clear;
   if Dlg_Socio.ShowModal = mrOk then
     begin
        Edit_CodSocio.Text  := FormatFloat('000000',Dlg_Socio.SQL_Pesquisa.FieldByName('CODIGO').AsInteger);
        Edit_NomeSocio.Text := Dlg_Socio.SQL_Pesquisa.FieldByName('NOME').AsString;
        Screen.OnActiveControlChange := ControlChange;
     end;

   bbtn_gerar.SetFocus;
end;

procedure TSg_0024.SB_EmpresaClick(Sender: TObject);
begin
  Dlg_Empresa.Edit_pesquisa.Clear;
  if Dlg_Empresa.ShowModal = mrOk then
    begin
       Edit_Empresa.Text := Dlg_Empresa.SQL_Pesquisa.FieldByName('NOME').AsString;
       Screen.OnActiveControlChange := ControlChange;
    end;

 bbtn_gerar.SetFocus;
end;

procedure TSg_0024.Edit_VenctoExit(Sender: TObject);
begin
   if Edit_Vencto.Text = '' then Edit_Vencto.Text := '01';

   if (StrToInt(Edit_Vencto.Text) < 1) or (StrToInt(Edit_Vencto.Text) > 31) then
     begin
        ShowMessage('Dia de Vencimento inv�lido!');
        Edit_Vencto.SetFocus;
     end;
end;

procedure TSg_0024.MEdit_Data1Exit(Sender: TObject);
begin
   if MEdit_Data1.Text <> '  /    ' then
     begin
        if (StrToInt(Copy(MEdit_Data1.Text,4,4)) > 2030) or
           (StrToInt(Copy(MEdit_Data1.Text,4,4)) < 2010) then
          begin
             ShowMessage('M�s/Ano Inicial Inv�lido!!!');
             MEdit_Data1.SetFocus;
             Exit;
          end;
     end;
end;

procedure TSg_0024.MEdit_Data2Exit(Sender: TObject);
begin
   if MEdit_Data2.Text <> '  /    ' then
     begin
        if (StrToInt(Copy(MEdit_Data2.Text,4,4)) > 2030) or
           (StrToInt(Copy(MEdit_Data2.Text,4,4)) < 2010) then
          begin
             ShowMessage('M�s/Ano Final Inv�lido!!!');
             MEdit_Data2.SetFocus;
             Exit;
          end;
     end;
end;

procedure TSg_0024.Edit_ValorExit(Sender: TObject);
begin
   try
     Edit_Valor.Text := FloatToStrF(StrToFloat(Edit_Valor.Text),ffFixed,7,2);
     while Length(Edit_Valor.Text) < 7 do Edit_Valor.Text := ' ' + Edit_Valor.Text;
     bbtn_gerar.SetFocus;
   except
     ShowMessage('Valor inv�lido!');
     Edit_Valor.Text := '   0,00';
     Edit_Valor.SetFocus;
   end;
end;

procedure TSg_0024.Edit_ValorEnter(Sender: TObject);
begin
   Edit_Valor.SelectAll;
   Edit_Valor.SetFocus;
end;

procedure TSg_0024.Edit_Letra1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_escape then
      Edit_CodSocio2.SetFocus;

   if key = vk_return then
      Edit_Letra2.SetFocus;
end;

procedure TSg_0024.Edit_Letra2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_escape then
      Edit_Letra1.SetFocus;

   if key = vk_return then
      bbtn_gerar.SetFocus;
end;

procedure TSg_0024.Edit_Letra1KeyPress(Sender: TObject; var Key: Char);
begin
   // S� permite digitar 'letra'
//   if not (key in ['A'..'Z']) then
//   if not (key in ['A'..'Z']) and (key <> chr(8)) and (key <> chr(44)) then
//     key := chr(0);
end;

end.
