#
#Total Gasto por dia/mes/ano em parques
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
	print "\t|                     | Determinar total gasto |"
	print "\t|    objectivo        | por dia/mes/ano apenas |"
	print "\t|    ---------        | em parques.            |"
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

    getline;
	split ($0,desconto,">|<");

    for(getline; ((i=index($0,"Parques de estacionamento"))==0) &&
                 (index($0,"/TRANSACCAO>")==0); 
        getline);

    if (i!=0){
        sub(",",".",importancia[3]);
        sub(",",".",desconto[3]);
        total_gasto += importancia[3];
        gasto_agora  = importancia[3];
	    total_desconto += desconto[3];
        gasto_agora    -= desconto[3];

        getline;
    	split($0,data,">|<");
        gasto_data[data[3]]+=gasto_agora;

        split(data[3],dma,"-");
        dia[dma[1]]+=gasto_agora;
        mes[dma[2]]+=gasto_agora;
        ano[dma[3]]+=gasto_agora;

        pagamentos++;
    } 
}


END{ 
    print "\t|----------------------------------------"
    print "\t| Pago em cada data (apenas em Parques)"
    print "\t|----------------------------------------"
	for (i in gasto_data)
		print "\t| Na Data " i " pago " gasto_data[i]; 

    print "\t|----------------------------------------"
	print "\t| Pago em cada dia (apenas em Parques)"
	print "\t|----------------------------------------"
	for (i in dia)
        print "\t| No dia " i " pago " dia[i];

    print "\t|----------------------------------------"
	print "\t| Pago em cada mes (apenas em Parques)"
	print "\t|----------------------------------------"
	for (i in mes) {
        print "\t| No mes " i " pago " mes[i];
    }

    print "\t|----------------------------------------"
	print "\t| Pago em cada ano (apenas em Parques)"
	print "\t|----------------------------------------"
	for (i in ano) {
        print "\t| No ano " i " pago " ano[i]; 
    }

    print "\t|----------------------------------------"
	print "\t| Total Pago apenas em Parques      : " total_gasto
    print "\t| Total Desconto apenas em Parques  : " total_desconto 
    print "\t| Total Pagamentos apenas em Parques: " pagamentos
    print "\t\\______________________________________________/"
}


