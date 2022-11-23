program SgEdu;

uses
  Forms,
  Sg0000 in 'Sg0000.pas' {Sg_0000},
  Sg0020 in 'Sg0020.pas' {Sg_0020},
  Arquivos in 'Arquivos.pas' {Dm: TDataModule},
  Sg0022 in 'Sg0022.pas' {Sg_0022},
  Sg0021 in 'Sg0021.pas' {Sg_0021},
  Sg0022A in 'Sg0022A.pas' {Sg_0022A},
  Sg20 in 'Sg20.pas' {Dlg_Socio},
  R0022A in 'R0022A.pas' {R_0022A: TQuickRep},
  R0022B in 'R0022B.pas' {R_0022B: TQuickRep},
  R0022C in 'R0022C.pas' {R_0022C: TQuickRep},
  SgSen in 'SgSen.pas' {Sg_Sen},
  Sg0023 in 'Sg0023.pas' {Sg_0023},
  Sg0024 in 'Sg0024.pas' {Sg_0024},
  SGF0012P in 'SGF0012P.PAS' {Dlg_Filiais},
  Sgf0003p in 'Sgf0003p.pas' {Dlg_ccusto},
  Sgf0002p in 'Sgf0002p.pas' {Dlg_Conta},
  Sg21 in 'Sg21.pas' {Dlg_Empresa},
  Sg0025 in 'Sg0025.pas' {Sg_0025};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TSg_0000, Sg_0000);
  Application.CreateForm(TSg_0020, Sg_0020);
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TSg_0022, Sg_0022);
  Application.CreateForm(TSg_0021, Sg_0021);
  Application.CreateForm(TSg_0022A, Sg_0022A);
  Application.CreateForm(TDlg_Socio, Dlg_Socio);
  Application.CreateForm(TR_0022A, R_0022A);
  Application.CreateForm(TR_0022B, R_0022B);
  Application.CreateForm(TR_0022C, R_0022C);
  Application.CreateForm(TSg_Sen, Sg_Sen);
  Application.CreateForm(TSg_0023, Sg_0023);
  Application.CreateForm(TSg_0024, Sg_0024);
  Application.CreateForm(TDlg_Filiais, Dlg_Filiais);
  Application.CreateForm(TDlg_ccusto, Dlg_ccusto);
  Application.CreateForm(TDlg_Conta, Dlg_Conta);
  Application.CreateForm(TDlg_Empresa, Dlg_Empresa);
  Application.CreateForm(TSg_0025, Sg_0025);
  Application.Run;
end.
