program Descontos;

uses
  Forms,
  uPrincipal in 'src\uPrincipal.pas' {frmPrincipal},
  udmDescontos in 'src\udmDescontos.pas' {dmDescontos: TDataModule},
  uCartaoDesconto in 'src\uCartaoDesconto.pas' {frmCartaoDesconto},
  uSenha in 'src\uSenha.pas' {frmSenha},
  uBuscaUsuario in 'src\uBuscaUsuario.pas' {frmBuscaUsuario},
  uRelatorio in 'src\uRelatorio.pas' {frmRelatorioDesconto},
  uCodBarras in 'src\uCodBarras.pas' {frmCodBarrasMedicos},
  uBuscaFuncionario in 'src\busca\uBuscaFuncionario.pas' {frmBuscaFuncionario},
  usolicitacao in 'src\usolicitacao.pas' {frmSolicitacao},
  uCadastroMed in 'src\cadastro\uCadastroMed.pas' {frmCadMedico},
  uBuscaMedicos in 'src\busca\uBuscaMedicos.pas' {frmBuscaMedicos},
  uSolicitAbertas in 'src\uSolicitAbertas.pas' {frmSolicitacaoesAbertas},
  uConfirmCadastro in 'src\uConfirmCadastro.pas' {frmConfirmCadastroMed},
  uAlertas in 'src\uAlertas.pas' {frmAlertas},
  uRelatorioControle in 'src\uRelatorioControle.pas' {frmRelatorioControle},
  uBuscaFuncionarios in 'src\busca\uBuscaFuncionarios.pas' {frmBuscaFuncionarios},
  uDescontoCRM in 'src\uDescontoCRM.pas' {frmDescontoCRM},
  uImprimeCodBarrasCRM in 'src\uImprimeCodBarrasCRM.pas' {frmImprimeCodBarras},
  uEmailCRM in 'src\uEmailCRM.pas' {frmEmailCRM},
  uRelatCupomDesc in 'src\uRelatCupomDesc.pas' {frmRelatCupom},
  uDescontoMed in 'src\uDescontoMed.pas' {frmDescontoMedico},
  uCartaoDescontoGerente in 'src\uCartaoDescontoGerente.pas' {frmCartaoGerente},
  uInformaDesconto in 'src\uInformaDesconto.pas' {frmInformaDesconto},
  uDescComponente in 'src\uDescComponente.pas' {frmDescMedQtdCMP},
  uLinkCRMDesc in 'src\uLinkCRMDesc.pas' {frmLinkCRM},
  uCodBarrasGerente in 'src\uCodBarrasGerente.pas' {frmCodBarrasGerente},
  uSolicCortesiasAbertas in 'src\uSolicCortesiasAbertas.pas' {frmCortesiasAbertas},
  uCortesiaInclusao in 'src\uCortesiaInclusao.pas' {frmInclusaoCortesia},
  uBuscaFunCortesia in 'src\busca\uBuscaFunCortesia.pas' {frmBuscaFuncCortesia},
  upnlDescontosDetalhes in 'src\upnlDescontosDetalhes.pas' {frmCortesiaDetalhes},
  uImagemReceita in 'src\uImagemReceita.pas' {frmImagemReceita},
  uControleCortesias in 'src\uControleCortesias.pas' {frmControleCortesias},
  ufrmJustificativa in 'src\ufrmJustificativa.pas' {frmJustificativa},
  ufrmJustificativaDetalhe in 'src\ufrmJustificativaDetalhe.pas' {frmJustificativaDetalhe},
  uExtrato in 'src\uExtrato.pas' {frmExtrato},
  uBuscaCupom in 'src\busca\uBuscaCupom.pas' {frmBuscaCupom},
  uBuscaProdutos in 'src\busca\uBuscaProdutos.pas' {frmBuscaProdutos},
  ufrmDescontosAplicados in 'src\ufrmDescontosAplicados.pas' {frmDescontosAplicados},
  uCadDescontoCliente in 'src\cadastro\uCadDescontoCliente.pas' {frmCadDescontoCliente},
  uCadCampanha in 'src\cadastro\uCadCampanha.pas' {frmCadCampanha},
  uEnvioSMS in 'src\uEnvioSMS.pas' {frmEnvioSMS},
  uCarregaImagemCampanha in 'src\uCarregaImagemCampanha.pas' {frmCarregaImagemCampanha},
  uImagemEditar in 'src\uImagemEditar.pas' {frmEditarCupom},
  uGerarCupons in 'src\uGerarCupons.pas' {frmGerarCupons},
  uBuscaClienteDesconto in 'src\busca\uBuscaClienteDesconto.pas' {frmBuscaClienteDesconto},
  uRelatorioCampanha in 'src\uRelatorioCampanha.pas' {frmRelCampanhas},
  uAlunosCampanhas in 'src\uAlunosCampanhas.pas' {frmAlunosCampanha},
  uPlanilhaDescontos in 'src\uPlanilhaDescontos.pas' {frmPlanilhaDescontos},
  uConsultoriaPremium in 'src\uConsultoriaPremium.pas' {frmConsultoriaPremium},
  uCampanhaCliente in 'src\uCampanhaCliente.pas' {frmCampanhaCliente},
  Desconto.Base in '..\PriviCore\src\Desconto.Base.pas',
  Desconto.Tipos in '..\PriviCore\src\Desconto.Tipos.pas',
  Desconto.Constantes.Campanhas in '..\PriviCore\src\Desconto.Constantes.Campanhas.pas',
  Desconto.Constantes.Produtos in '..\PriviCore\src\Desconto.Constantes.Produtos.pas',
  Desconto.Constantes.Usuarios in '..\PriviCore\src\Desconto.Constantes.Usuarios.pas',
  Desconto.Variaveis in '..\PriviCore\src\Desconto.Variaveis.pas',
  Desconto.Sqls in '..\PriviCore\src\Desconto.Sqls.pas',
  Desconto.Utils in '..\PriviCore\src\Desconto.Utils.pas',
  Desconto.Constantes.Percentuais in '..\PriviCore\src\Desconto.Constantes.Percentuais.pas',
  Desconto.Constantes.Datas in '..\PriviCore\src\Desconto.Constantes.Datas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmDescontos, dmDescontos);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmCartaoDesconto, frmCartaoDesconto);
  Application.CreateForm(TfrmSenha, frmSenha);
  Application.CreateForm(TfrmRelatorioDesconto, frmRelatorioDesconto);
  Application.CreateForm(TfrmCodBarrasMedicos, frmCodBarrasMedicos);
  Application.CreateForm(TfrmBuscaFuncionario, frmBuscaFuncionario);
  Application.CreateForm(TfrmSolicitacao, frmSolicitacao);
  Application.CreateForm(TfrmCadMedico, frmCadMedico);
  Application.CreateForm(TfrmBuscaMedicos, frmBuscaMedicos);
  Application.CreateForm(TfrmSolicitacaoesAbertas, frmSolicitacaoesAbertas);
  Application.CreateForm(TfrmConfirmCadastroMed, frmConfirmCadastroMed);
  Application.CreateForm(TfrmAlertas, frmAlertas);
  Application.CreateForm(TfrmRelatorioControle, frmRelatorioControle);
  Application.CreateForm(TfrmBuscaFuncionarios, frmBuscaFuncionarios);
  Application.CreateForm(TfrmDescontoCRM, frmDescontoCRM);
  Application.CreateForm(TfrmImprimeCodBarras, frmImprimeCodBarras);
  Application.CreateForm(TfrmEmailCRM, frmEmailCRM);
  Application.CreateForm(TfrmRelatCupom, frmRelatCupom);
  Application.CreateForm(TfrmDescontoMedico, frmDescontoMedico);
  Application.CreateForm(TfrmCartaoGerente, frmCartaoGerente);
  Application.CreateForm(TfrmInformaDesconto, frmInformaDesconto);
  Application.CreateForm(TfrmDescMedQtdCMP, frmDescMedQtdCMP);
  Application.CreateForm(TfrmLinkCRM, frmLinkCRM);
  Application.CreateForm(TfrmCodBarrasGerente, frmCodBarrasGerente);
  Application.CreateForm(TfrmCortesiasAbertas, frmCortesiasAbertas);
  Application.CreateForm(TfrmInclusaoCortesia, frmInclusaoCortesia);
  Application.CreateForm(TfrmBuscaFuncCortesia, frmBuscaFuncCortesia);
  Application.CreateForm(TfrmCortesiaDetalhes, frmCortesiaDetalhes);
  Application.CreateForm(TfrmImagemReceita, frmImagemReceita);
  Application.CreateForm(TfrmControleCortesias, frmControleCortesias);
  Application.CreateForm(TfrmJustificativa, frmJustificativa);
  Application.CreateForm(TfrmJustificativaDetalhe, frmJustificativaDetalhe);
  Application.CreateForm(TfrmExtrato, frmExtrato);
  Application.CreateForm(TfrmBuscaCupom, frmBuscaCupom);
  Application.CreateForm(TfrmBuscaProdutos, frmBuscaProdutos);
  Application.CreateForm(TfrmDescontosAplicados, frmDescontosAplicados);
  Application.CreateForm(TfrmCadDescontoCliente, frmCadDescontoCliente);
  Application.CreateForm(TfrmCadCampanha, frmCadCampanha);
  Application.CreateForm(TfrmEnvioSMS, frmEnvioSMS);
  Application.CreateForm(TfrmCarregaImagemCampanha, frmCarregaImagemCampanha);
  Application.CreateForm(TfrmEditarCupom, frmEditarCupom);
  Application.CreateForm(TfrmGerarCupons, frmGerarCupons);
  Application.CreateForm(TfrmBuscaClienteDesconto, frmBuscaClienteDesconto);
  Application.CreateForm(TfrmRelCampanhas, frmRelCampanhas);
  Application.CreateForm(TfrmAlunosCampanha, frmAlunosCampanha);
  Application.CreateForm(TfrmPlanilhaDescontos, frmPlanilhaDescontos);
  Application.CreateForm(TfrmConsultoriaPremium, frmConsultoriaPremium);
  Application.CreateForm(TfrmCampanhaCliente, frmCampanhaCliente);
  Application.Run;
end.







