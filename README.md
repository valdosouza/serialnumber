1 - Conceito

	1.1 - Sistema para registro de número de série gravada em peças de forma automatizada. 
  
  	1.2 - Caso encontre algum número de série já gravado o sistema envia uma mensagem para o equipamento parar o processo de gravação.
  
	1.3 - Estruturar o sistema para possibilitar a emissão de diferentes números de series obedecendo Normas pré-existentes. 
  
	1.4 - Quando o produto for criado algumas informações como Tipo de Norma, Fornecedor e PartNumber.
  
  	1.5 - Gravação de mais de um numero por ciclo, este ciclo deve ser informado na tela de Gravação.
  
  	1.6 - Enviar o número de série dentro de um padrão de linhas conforme os FCA’s.

  	1.7 - Sistema faz a geração do numero de serial de forma mais abstrada conforme mascara informada no cadastro do produto.

  		PN: Part Number

	    	CF:  Código do Fornecedor Metalkraft no cliente

		CJ:  Dia e ano no calendário Juliano

		SQ: Sequencial.

		T1: Um texto fixo que faça parte do número serial.

		T2: Um segundo texto fixo que faça parte do número serial
  
		RD: A revisão do desenho do Produto.

		SH: o turno de fabricação (SHIFT) .

		LN: Linha de Produção do Produto.

		Ex: PN+CF+CJ+SQ+T1+T2+RD+SH+LN
    
2 - Funcionalidades

  	2.1 - Cadastro de Usuário
	  
  	2.2 - Sistema de permissão (Inserir/Alterar/Excluir/Visualizar)
  
  	2.3 - Cadastro de Produtos/Peças	
  
  	2.4 - Cadastro de números serial impressos.
  
  	2.5 - Interface de pesquisa dos dados registrados.

3 - Especificações técnicas
  	
   	3.1 - Requer Sistema operacional Windows 7 ou superior. 
  
  	3.2 - Banco de dados Interbase versão 2.5 instalado em servidor local.
  
  	3.3 - Linguagem de desenvolvimento Delphi Versão Tokyo.
