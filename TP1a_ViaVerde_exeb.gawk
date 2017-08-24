#
#SAIDAS
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
	print "\t| SAIDAS              |  por: Daniel Malhadas  |"
	print "\t| ------              |     & Alexandre Silva  |"
	print "\t|                     |                        |"
	print "\t|---------------------|------------------------|"
	print "\t|                     | Determinar que saidas  |"
	print "\t|    objectivo        | se realizaram, quantas |"
	print "\t|    ---------        | de cada e quantas no   |"	
	print "\t|                     | total.                 |"
	print "\t\\______________________________________________/"
	print "\t/                                              \\"

	#Contador de saidas. Inicializado a 0
	saidas = 0;
}

#Expressao regular que identifica uma saida
/<SAIDA>/{
	#Contador de data
    split ($0,local,">|<");
	locais[local[3]]++;

    saidas++;
}

END{ 
    print "\t|---------------------"
    print "\t| Locais de saidas"
    print "\t|---------------------"
	for (i in locais)
		print "\t| Saidas em " i ": " locais[i] " entradas"; 
    print "\t|---------------------"
	print "\t| Total Saidas: " saidas 
    print "\t\\______________________________________________/"
}


