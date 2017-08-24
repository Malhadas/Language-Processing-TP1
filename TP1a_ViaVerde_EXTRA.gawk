#
#Registos ViaVerde
#

BEGIN{
	print "\t ______________________________________________"
	print "\t/                                              \\"
	print "\t| Registos ViaVerde   |   por: Daniel Malhadas |"
	print "\t| -----------------   |      & Alexandre Silva |"
	print "\t|                     |                        |"
	print "\t|---------------------|------------------------|"
	print "\t|                     | Constroi ficheiros     |"
	print "\t|    objectivo        | html que organizam de  |"
	print "\t|    ---------        | uma maneira facil de   |"  
	print "\t|                     | ler toda a informacao  |"
    print "\t|                     | em viaverde.xml.       |"
	print "\t\\______________________________________________/"
	print "\t/                                              \\"


    #Constroi a base/home page dos registos ViaVerde
    base        = "index.html"       #ficheiro base
    extractos   = "extractos.html"   #ficheiro com os extractos
    transaccoes = "transaccoes.html" #ficheiro com transaccoes 
    viagens     = "viagens.html"     #ficheiro com viagens
    parques     = "parques.html"     #ficheiro com parques

    print "<!DOCTYPE html>" > base;
    print "<html>" > base;
    print "<body>" > base;
    print "<body style=\"background-color:lightgreen\">" > base;
    print "<img src=\"viaverde.jpg\" width=\"200\" height=\"200\">" > base;
    print "<h1 style=\"color:darkgreen;font-size:300%;text-align:center\">Registos ViaVerde</h1>" > base;
    print "<p style=\"color:red;font-size:160%;text-align:center\">Funcionalidades:</p>" > base;
    print "<a href=\"" extractos "\">Consultar extractos</a>" > base;
    print "</body>" > base;
    print "</html>" > base;
    #Ficheiro base terminado

}

#Expressao regular que identifica uma importancia
/<EXTRACTO/{

#Identificar extracto
split ($0,idaux,">|<");
split (idaux[2],extracto_id,"=");
id = extracto_id[2];

getline;
split ($0,data,">|<");
data_emissao[id] = data[3];

getline;
split ($0,id_clienteaux,">|<");
split (id_clienteaux[2],id_cliente,"=");
clientes_id[id] = id_cliente[2];

getline;
split ($0,nif,">|<");
nifs[id] = nif[3];

getline;
split ($0,nome_cliente,">|<");
nome_clientes[id] = nome_cliente[3];

getline;
split ($0,morada,">|<");
moradas[id] = morada[3];

getline;
split ($0,localidade,">|<");
localidades[id] = localidade[3];

getline;
split ($0,cod_postal,">|<");
codigos_postais[id] = cod_postal[3];

getline;
getline;
split ($0,identificador_aux,">|<");
split (identificador_aux[2],identificador,"=");
identificadores[id] = identificador[2];

getline;
split ($0,mat,">|<");
matriculas[id] = mat[3];

getline;
split ($0,ref,">|<");
referencia_pagamento[id] = ref[3];

#Identificar transaccoes
t=0;
while(1){
    for(getline; (i=index($0,"<TRANSACCAO>"))==0 &&
                  (j=index($0,"</EXTRACTO>"))==0 ;getline);

    if (i==0) break;

    t++;

    getline;
    split ($0,t_data_e,">|<");
    t_datas_e[id,t] = t_data_e[3];

    getline;
    split ($0,horas_e,">|<");
    t_horas_entrada[id,t] = horas_e[3];

    getline;
    split ($0,e,">|<");
    t_entradas[id,t] = e[3];

    getline;
    split ($0,data_s,">|<");
    t_datas_s[id,t] = data_s[3];

    getline;
    split ($0,horas_s,">|<");
    t_horas_saida[id,t] = horas_s[3];

    getline;
    split ($0,s,">|<");
    t_saidas[id,t] = s[3];

    getline;
    split ($0,imp,">|<");
    sub(",",".",imp[3]);
    t_importancias[id,t] = imp[3];

    getline;
    split ($0,desc,">|<");
    sub(",",".",desc[3]);
    t_descontos[id,t] = desc[3];

    getline;
    split ($0,iva,">|<");
    t_ivas[id,t] = iva[3];

    getline;
    split ($0,o,">|<");
    t_operadores[id,t] = o[3];

    getline;
    split ($0,tipo,">|<");
    t_tipos[id,t] = tipo[3];

    getline;
    split ($0,deb,">|<");
    t_datas_debito[id,t] = deb[3];

    getline;
    split ($0,cart,">|<");
    t_cartao[id,t] = cart[3];
}

n_transaccoes[id] = t;

}


END{ 
    n = 0;

    #Construir ficheiro de extractos
    print "<!DOCTYPE html>" > extractos;
    print "<html>" > extractos;
    print "<body>" > extractos;
    print "<body style=\"background-color:lightgreen\">" > extractos;
    print "<img src=\"viaverde.jpg\" width=\"200\" height=\"200\">" > extractos;
    print "<h1 style=\"font-size:300%\">Lista de Extractos</h1>" > extractos;
    
    for (i in data_emissao){
        n++;
        print "" > (n transaccoes);
        print "<p style=\"color:red;font-size:160%;\">Extracto " n ":</p>" > extractos;
        print "<p><b>ID do Extracto:</b></p>" > extractos;
        print "<p>"i  "</p>" > extractos;
        print "<p><b>Mes de Emissao:</b></p>" > extractos;
        print "<p>"data_emissao[i]  "</p>" > extractos;
        print "<p><b>ID do Cliente:</b></p>" > extractos;
        print "<p>"clientes_id[i]  "</p>" > extractos;
        print "<p><b>NIF do Cliente:</b></p>" > extractos;
        print "<p>"nifs[i]  "</p>" > extractos;
        print "<p><b>Nome do Cliente:</b></p>" > extractos;
        print "<p>"nome_clientes[i]  "</p>" > extractos;
        print "<p><b>Morada:</b></p>" > extractos;
        print "<p>"moradas[i]  "</p>" > extractos;
        print "<p><b>Localidade:</b></p>" > extractos;
        print "<p>"localidades[i]  "</p>" > extractos;
        print "<p><b>Codigo Postal:</b></p>" > extractos;
        print "<p>"codigos_postais[i]  "</p>" > extractos;
        print "<p><b>Identificador:</b></p>" > extractos;
        print "<p>"identificadores[i]  "</p>" > extractos;
        print "<p><b>Matricula:</b></p>" > extractos;
        print "<p>" matriculas[i]  "</p>" > extractos;
        print "<p><b>Referencia de Pagamento:</b></p>" > extractos;
        print "<p>"referencia_pagamento[i]  "</p>" > extractos;
        print "<a href=\"" (n transaccoes) "\">Consultar transaccoes deste extracto</a>" > extractos;
        print "<p></p>" > extractos;
        print "<a href=\"" (n viagens) "\">Consultar viagens realizadas neste extracto</a>" > extractos;
        print "<p></p>" > extractos;
        print "<a href=\"" (n parques) "\">Consultar parques utilizados neste extracto</a>" > extractos;

        #Construir ficheiro de transaccoes para este extracto
        print "<!DOCTYPE html>" > (n transaccoes);
        print "<html>" > (n transaccoes);
        print "<body>" > (n transaccoes);
        print "<body style=\"background-color:lightgreen\">" > (n transaccoes);
        print "<img src=\"viaverde.jpg\" width=\"200\" height=\"200\">" > (n transaccoes);
        print "<h1 style=\"font-size:300%\">Lista de Transaccoes do Extracto "n"</h1>" > (n transaccoes);
        
        for (j=1;j<=n_transaccoes[id];j++){
            print "" > (n transaccoes);
            print "<p style=\"color:red;font-size:160%;\">Transaccao " j ":</p>" > (n transaccoes);
            print "<p><b>Data de Entrada:</b></p>" > (n transaccoes);
            print "<p>" t_datas_e[i,j]  "</p>" > (n transaccoes);
            print "<p><b>Hora de Entrada:</b></p>" > (n transaccoes);
            print "<p>" t_horas_entrada[i,j]  "</p>" > (n transaccoes);
            print "<p><b>Local de Entrada:</b></p>" > (n transaccoes);
            print "<p>" t_entradas[i,j]  "</p>" > (n transaccoes);
            print "<p><b>Data de Saida:</b></p>" > (n transaccoes);
            print "<p>" t_datas_s[i,j]  "</p>" > (n transaccoes);
            print "<p><b>Hora de Saida:</b></p>" > (n transaccoes);
            print "<p>" t_horas_saida[i,j]  "</p>" > (n transaccoes);
            print "<p><b>Local de Saida:</b></p>" > (n transaccoes);
            print "<p>" t_saidas[i,j]  "</p>" > (n transaccoes);
            print "<p><b>Importancia:</b></p>" > (n transaccoes);
            print "<p>" t_importancias[i,j]  "</p>" > (n transaccoes);
            print "<p><b>Desconto:</b></p>" > (n transaccoes);
            print "<p>" t_descontos[i,j]  "</p>" > (n transaccoes);
            print "<p><b>IVA:</b></p>" > (n transaccoes);
            print "<p>" t_ivas[i,j]  "</p>" > (n transaccoes);
            print "<p><b>Operador:</b></p>" > (n transaccoes);
            print "<p>" t_operadores[i,j]  "</p>" > (n transaccoes);
            print "<p><b>Tipo de Transaccao:</b></p>" > (n transaccoes);
            print "<p>" t_tipos[i,j]  "</p>" > (n transaccoes);
            print "<p><b>Data de Debito:</b></p>" > (n transaccoes);
            print "<p>" t_datas_debito[i,j]  "</p>" > (n transaccoes);
            print "<p><b>Cartao Usado:</b></p>" > (n transaccoes);
            print "<p>" t_cartao[i,j]  "</p>" > (n transaccoes);
        }
        print "</body>" > (n transaccoes);
        print "</html>" > (n transaccoes);
        #Ficheiro de transaccoes deste extracto terminado

        #Construir ficheiro de viagens para este extracto
        print "<!DOCTYPE html>" > (n viagens);
        print "<html>" > (n viagens);
        print "<body>" > (n viagens);
        print "<body style=\"background-color:lightgreen\">" > (n viagens);
        print "<img src=\"viaverde.jpg\" width=\"200\" height=\"200\">" > (n viagens);
        print "<h1 style=\"font-size:300%\">Lista de Viagens do Extracto "n"</h1>" > (n viagens);
        tempo_total = 0;
        jj=0;
        for (j=1;j<=n_transaccoes[id];j++){
            if (t_tipos[i,j]!="Portagens") continue;
            jj++;
            print "<p style=\"color:red;font-size:160%;\">Viagem " jj ":</p>" > (n viagens);
            print "<p><b>Data de Entrada:</b></p>" > (n viagens);
            print "<p>" t_datas_e[i,j]  "</p>" > (n viagens);
            print "<p><b>Data de Saida:</b></p>" > (n viagens);
            print "<p>" t_datas_s[i,j]  "</p>" > (n viagens);
            if (t_datas_e[i,j]!="null" && t_datas_s[i,j]!="null"){
                print "<p><b>Tempo de Viagem:</b></p>" > (n viagens); 
                split(t_datas_e[i,j],d,"-");
                split(t_horas_entrada[i,j],h,":");
                de = mktime(d[3] " " d[2] " " d[1] " " h[1] " " h[2] " 00");
                split(t_datas_s[i,j],d,"-");
                split(t_horas_saida[i,j],h,":");
                ds = mktime(d[3] " " d[2] " " d[1] " " h[1] " " h[2] " 00");
                tempo_total+=((ds - de)/60);
                print "<p>"((ds - de)/60)" minutos</p>" > (n viagens);
            }
            print "<p><b>Percurso Realizado (clique para ver no google maps):</b></p>" > (n viagens);
            print "<a href=\"https://www.google.pt/maps/dir/"t_entradas[i,j]"/"t_saidas[i,j]"/\"/>De " t_entradas[i,j] " ate " t_saidas[i,j]  "</a>" > (n viagens);
        }
        print "<p><p/><p style=\"color:red;font-size:160%;\">Tempo Total de Viagem "tempo_total" minutos</p>" > (n viagens);
        print "</body>" > (n viagens);
        print "</html>" > (n viagens);
        #Ficheiro de viagens deste extracto terminado

        #Construir ficheiro de parques para este extracto
        print "<!DOCTYPE html>" > (n parques);
        print "<html>" > (n parques);
        print "<body>" > (n parques);
        print "<body style=\"background-color:lightgreen\">" > (n parques);
        print "<img src=\"viaverde.jpg\" width=\"200\" height=\"200\">" > (n parques);
        print "<h1 style=\"font-size:300%\">Lista de Parques do Extracto "n"</h1>" > (n parques);
        tempo_total = 0;
        jj=0;
        for (j=1;j<=n_transaccoes[id];j++){
            if (t_tipos[i,j]!="Parques de estacionamento") continue;
            jj++;
            print "<p style=\"color:red;font-size:160%;\">Parque de Estacionamento " jj ":</p>" > (n parques);
            print "<p><b>Data de Entrada:</b></p>" > (n parques);
            print "<p>" t_datas_e[i,j]  "</p>" > (n parques);
            print "<p><b>Data de Saida:</b></p>" > (n parques);
            print "<p>" t_datas_s[i,j]  "</p>" > (n parques);
            if (t_datas_e[i,j]!="null" && t_datas_s[i,j]!="null"){ 
                print "<p><b>Tempo de Estadia:</b></p>" > (n parques);
                split(t_datas_e[i,j],d,"-");
                split(t_horas_entrada[i,j],h,":");
                de = mktime(d[3] " " d[2] " " d[1] " " h[1] " " h[2] " 00");
                split(t_datas_s[i,j],d,"-");
                split(t_horas_saida[i,j],h,":");
                ds = mktime(d[3] " " d[2] " " d[1] " " h[1] " " h[2] " 00");
                tempo_total+=((ds - de)/60);
                print "<p>"((ds - de)/60)" minutos</p>" > (n parques);
            }
            print "<p><b>Local do Parque (clique para ver no google maps):</b></p>" > (n parques);
            print "<a href=\"https://www.google.pt/maps/place/"t_saidas[i,j]"/\"/>"t_saidas[i,j]"</a>" > (n parques);
        }
        print "<p><p/><p style=\"color:red;font-size:160%;\">Tempo Total em Parques "tempo_total" minutos</p>" > (n parques);
        print "</body>" > (n parques);
        print "</html>" > (n parques);
        #Ficheiro de parques deste extracto terminado

    }
    print "</body>" > extractos;
    print "</html>" > extractos;
    #Ficheiro de extractos terminado



    print "\t|       Ficheiros Construidos com Sucesso      |";
    print "\t|       ---------------------------------      |";
    print "\t\\______________________________________________/"
}


