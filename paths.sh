#!/bin/bash
# paths.sh
# Caminhos utilizados pelo script functions.sh


CONFIG_ID="CONFIG/id.txt" 				#Lista de pontos

TEMP_ID="TEMP/id.txt"                          		# Lista de pontos com contador de linhas
TEMP_ID_BH_DEPOIS="TEMP/id_bh_chave_depois"    		# ID dos pontos concatenado com o bh_chave (antes da virada) de cada ponto.
TEMP_ID_BH_ANTES="TEMP/id_bh_chave_antes"      		# ID dos pontos concatenado com o bh_chave (depois da virada) de cada ponto.
TEMP_BH_CHAVE_ANTES="TEMP/bh_chave_antes"      		# bh_chave coletado do arquivo pas (antes da virada).
TEMP_BH_CHAVE_ANTES_2="TEMP/bh_chave_antes_2"  		# bh_chave com delimitador (antes da virada).
TEMP_BH_CHAVE_DEPOIS="TEMP/bh_chave_depois"    		# bh_chave coletado do arquivo pas (antes da virada).
TEMP_BH_CHAVE_DEPOIS_2="TEMP/bh_chave_depois_2" 	# bh_chave com delimitador (depois da virada).
TEMP="TEMP/temp"					# Dados temporários.

PAS_DEPOIS="SRC/pas_depois/pas_r_2022_01_07_16_51_43.dados"	# Arquivo pas depois da virada.
PAS_ANTES="SRC/pas_antes/pas_r_2022_02_01_16_31_50.dados"	# Arquivo pas antes da virada.

BHARQS_ANTES="/bharqs/BHARQS_Antes_Virada_2022"	 	#Diretório contendo os arquivos bhpas_h*.dados(antes da virada).
BHARQS_DEPOIS="/bharqs/BHARQS_2022"             	#Diretório contendo os arquivos bhpas_h*.dados(depois da virada).

LOG="LOG/log"						# Arquivo de log principal do script.
RESULT="RESULT/"					# Diretório contendo o(s) arquivo(s) csv com os dados processados.
