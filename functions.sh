#!/bin/bash
# functions.sh
# Script para coletar todos os dados dos arquivos 'bhpas_h*.dados' antes e/ou depois da virada.
# Preencher o arquivo CONFIG/id.txt com o id de cada ponto.

source paths.sh		# Caminhos utilizados pelo script

log_tempo() {
	date +"%d/%m/%Y %H:%M:%S" >> $LOG
}

insere_indice_id() {	
	#Insere um índice à direita de cada id em CONFIG/id.txt enviando a saída para TEMP/id.txt	
	nl $CONFIG_ID > $TEMP_ID
}

################################# Coleta de Dados #################################

coleta_bh_chave_depois() {
	# Coleta o bh_chave de cada ponto.
	# Atenção: Executar a função 'insere_indice_id' para gerar o arquivo com indice, pois a função precisa do arquivo para funcionar.
	echo "" >$TEMP_BH_CHAVE_DEPOIS
	for i in $(cat $CONFIG_ID); do
		grep "$i" $PAS_DEPOIS | head -1 | awk -F "," '{print ","$4}' >>$TEMP_BH_CHAVE_DEPOIS
	done
	sed -i '1d' $TEMP_BH_CHAVE_DEPOIS	#Remove a linha em branco
	nl $TEMP_BH_CHAVE_DEPOIS >$TEMP_BH_CHAVE_DEPOIS_2	#Insere um índice à direita de cada bh_chave em TEMP/temp_bh_chave_depois enviando para TEMP/temp_bh_chave_depois_2
	join -j1 $TEMP_ID $TEMP_BH_CHAVE_DEPOIS_2 >$TEMP_ID_BH_DEPOIS
	awk -F " " '{print $2$3}' $TEMP_ID_BH_DEPOIS >$TEMP
	cat $TEMP >$TEMP_ID_BH_DEPOIS
}

coleta_bh_chave_antes() {
	# Coleta o bh_chave de cada ponto.
	# Atenção: Executar a função 'insere_indice_id' para gerar o arquivo com indice, pois a função precisa do arquivo para funcionar.
	echo "" >$TEMP_BH_CHAVE_ANTES
	for i in $(cat $CONFIG_ID); do
		grep "$i" $PAS_ANTES | head -1 | awk -F "," '{print ","$4}' >>$TEMP_BH_CHAVE_ANTES
	done
	sed -i '1d' $TEMP_BH_CHAVE_ANTES
	nl $TEMP_BH_CHAVE_ANTES >$TEMP_BH_CHAVE_ANTES_2
	join -j1 $TEMP_ID $TEMP_BH_CHAVE_ANTES_2 >$TEMP_ID_BH_ANTES
	awk -F " " '{print $2$3}' $TEMP_ID_BH_ANTES >$TEMP
	cat $TEMP >$TEMP_ID_BH_ANTES
}

coleta_dados_antes() {
	# Coleta os dados de cada bhpas*.dados.
	# Atenção: Executar a função 'coleta_bh_chave_antes' para gerar o arquivo com o(s) bh_chave(s), pois a função precisa do arquivo com o(s) bh_chave(s) para encontrar os dados.
	for i in $(cat $TEMP_ID_BH_ANTES); do
		ID=$(echo "$i" | cut -d, -f1)
		BH_CHAVE=$(echo "$i" | cut -d, -f2)
		for f in $(ls "$BHARQS_ANTES"); do
			echo "Coletando dados: $f" >> "$LOG"
			grep ",$BH_CHAVE," "$BHARQS_ANTES/$f" | cut -d, -f1,10  >>"$RESULT/$ID".csv
			echo "Concluído: $f" >> "$LOG"
		done
	done
}

coleta_dados_depois() {
	# Coleta os dados de cada bhpas*.dados.
	# Atenção: Executar a função 'coleta_bh_chave_depois' para gerar o arquivo com o(s) bh_chave(s), pois a função precisa do arquivo com o(s) bh_chave(s) para encontrar os dados.
	for i in $(cat $TEMP_ID_BH_DEPOIS); do
		ID=$(echo "$i" | cut -d, -f1)
		BH_CHAVE=$(echo "$i" | cut -d, -f2)
		for f in $(ls "$BHARQS_DEPOIS"); do
			echo "Coletando dados: $f" >> "$LOG"
			grep ",$BH_CHAVE," "$BHARQS_DEPOIS/$f" | cut -d, -f1,9 >> "$RESULT/$ID".csv
			echo "Concluído: $f" >> "$LOG"
		done
	done
}

################################# Inicializadores #################################

inicializa_coleta_antes_virada(){
	log_tempo
	
	insere_indice_id
	
	coleta_bh_chave_antes
	coleta_dados_antes
	
	log_tempo
}

inicializa_coleta_depois_virada(){
	log_tempo
	
	insere_indice_id

	coleta_bh_chaves_depois
	coleta_dados_depois
	
	log_tempo
}

inicializa_coleta_geral(){
	log_tempo

	insere_indice_id

	coleta_bh_chave_antes
	coleta_bh_chave_depois

	coleta_dados_antes
	coleta_dados_depois

	log_tempo
}
