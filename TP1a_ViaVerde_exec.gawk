#
#Total Gasto por dia/mes/ano
#
# Exemplo do uso de split em gawk:
#--------------------------------- 
# {split($0, a, "<|>"}
#        ^^  ^  ^^^^^
#         |  |    |
#         |  |    delimitador, pode ser uma expressao regular
#         |  |
#         |  array para guardar string dividida
#         |
#         string para fazer split, $0 e a linha toda
#----------------------------------
#

BEGIN{
	print "\t ______________________________________________"
	print "\t/                                              \\"
	print "\t| Total Gasto         |   por: Daniel Malhadas |"
	print "\t| -----------         |      & Alexandre Silva |"
	print "\t|                     |                        |"
	print "\t|---------------------|------------------------|"
	print "\t|                     |                        |"
	print "\t|    objectivo        | Determinar total gasto |"
	print "\t|    ---------        | por dia/mes/ano.       |"
	print "\t|                     |                        |"
	print "\t\\______________________________________________/"
	print "\t/                                              \\"

	#Contador de total gasto. Inicializado a 0
	total_gasto = 0;

	#Contador de total desconto. Inicializado a 0
	total_desconto = 0;

    #Total pagamentos. Inicializado a 0
    pagamentos = 0;

}

#Expressao regular que identifica uma importancia
/<IMPORTANCIA>/{

	split ($0,importancia,">|<");
    sub(",",".",importancia[3]);
	total_gasto += importancia[3];
    gasto_agora  = importancia[3];

    getline;
	split ($0,desconto,">|<");
    sub(",",".",desconto[3]);
	total_desconto += desconto[3];
    gasto_agora    -= desconto[3];

    for(getline; (i=index($0,"DATA_DEBITO"))==0; getline);

	split($0,data,">|<");
    gasto_data[data[3]]+=gasto_agora;

    split(data[3],dma,"-");
    dia[dma[1]]+=gasto_agora;
    mes[dma[2]]+=gasto_agora;
    ano[dma[3]]+=gasto_agora;

    pagamentos++; 
}


END{ 
    print "\t|---------------------"
    print "\t| Pago em cada data"
    print "\t|---------------------"
	for (i in gasto_data)
		print "\t| Na Data " i " pago " gasto_data[i]; 

    print "\t|---------------------"
	print "\t| Pago em cada dia"
	print "\t|---------------------"
	for (i in dia)
        print "\t| No dia " i " pago " dia[i];

    print "\t|---------------------"
	print "\t| Pago em cada mes"
	print "\t|---------------------"
	for (i in mes) {
        print "\t| No mes " i " pago " mes[i];
    }

    print "\t|---------------------"
	print "\t| Pago em cada ano"
	print "\t|---------------------"
	for (i in ano) {
        print "\t| No ano " i " pago " ano[i]; 
    }

    print "\t|---------------------"
	print "\t| Total Pago      : " total_gasto
    print "\t| Total Desconto  : " total_desconto 
    print "\t| Total Pagamentos: " pagamentos
    print "\t\\______________________________________________/"
}


