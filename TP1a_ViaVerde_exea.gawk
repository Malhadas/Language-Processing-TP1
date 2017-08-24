#
#ENTRADAS
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
	print "\t| ENTRADAS             |  por: Daniel Malhadas |"
	print "\t| --------             |     & Alexandre Silva |"
	print "\t|                      |                       |"
	print "\t|----------------------|-----------------------|"
	print "\t|                      |  Determinar quantas   |"
	print "\t|    objectivo         |  entradas em cada     |"
	print "\t|    ---------         |  dia, em cada mes e   |"	
	print "\t|                      |  em cada ano.         |"
	print "\t\\______________________________________________/"
	print "\t/                                              \\"

	#Contador de Entradas. Inicializado a 0
	entradas = 0;
}

#Expressao regular que identifica uma entrada
/<DATA_ENTRADA>/{

	#Contador de data
        split ($0,data,">|<");
	datas[data[3]]++;

	#Contadores dia, mes e ano
	split (data[3],dma,"-");
        dia[dma[1]]++;
        mes[dma[2]]++;
        ano[dma[3]]++;

        entradas++; 
}

END{ 
    print "\t|---------------------"
    print "\t| Entradas em cada data"
    print "\t|---------------------"
	for (i in datas)
		print "\t| Na Data " i ": " datas[i] " entradas"; 

    print "\t|---------------------"
	print "\t| Entradas em cada dia"
	print "\t|---------------------"
	for (i in dia)
        print "\t| No dia " i ": " dia[i] " entradas";

    print "\t|---------------------"
	print "\t| Entradas em cada mes"
	print "\t|---------------------"
	for (i in mes) {
        if(length(i)==0) print "\t| No mes null: " mes[i] " entradas"; 
		else        print "\t| No mes " i ": " mes[i] " entradas";
    }

    print "\t|---------------------"
	print "\t| Entradas em cada ano"
	print "\t|---------------------"
	for (i in ano) {
        if(length(i)==0) print "\t| No ano null: " ano[i] " entradas"; 
		else        print "\t| No ano " i ": " ano[i] " entradas"; 
    }

    print "\t|---------------------"
	print "\t| Total Entradas: " entradas 
    print "\t\\______________________________________________/"
}

