1	Conceito
  Sistema para registro de número de série gravada em peças de forma automatizada. 
  Caso encontre algum número de série já gravado o sistema envia uma mensagem para o equipamento parar o processo de gravação.
  Estruturar o sistema para possibilitar a emissão de diferentes números de series obedecendo Normas pré-existentes. 
  Quando o produto for criado algumas informações como Tipo de Norma, Fornecedor e PartNumber.
  Gravação de mais de um numero por ciclo, este ciclo deve ser informado na tela de Gravação
  Enviar o número de série dentro de um padrão de linhas conforme os FCA’s.

  Sistema faz a geração do numero de serial de forma mais abstrada conforme mascara informada no cadastro do produto
    PN: Part Number
    CF:  Código do Fornecedor Metalkraft no cliente
    CJ:  Dia e ano no calendário Juliano
    SQ: Sequencial
    T1: Um texto fixo que faça parte do número serial.
    T2: Um segundo texto fixo que faça parte do número serial
    RD: A revisão do desenho do Produto
    SH: o turno de fabricação (SHIFT) 
    LN: Linha de Produção do Produto
        
        Ex: PN+CF+CJ+SQ+T1+T2+RD+SH+LN
    
2	Funcionalidades
	Cadastro de Usuário
  Sistema de permissão (Inserir/Alterar/Excluir/Visualizar)
	Cadastro de Produtos/Peças	
	Cadastro de números serial impressos.
	Interface de pesquisa dos dados registrados.

3	Especificações técnicas
  Requer Sistema operacional Windows 7 ou superior. 
  Banco de dados Interbase versão 2.5 instalado em servidor local.
  Linguagem de desenvolvimento Delphi Versão Tokyo.
