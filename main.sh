#!/bin/bash
# main.sh
# Script para coletar os dados dos arquivos 'bhpas_h*.dados' antes e depois da virada.
# Preencher o arquivo 'CONFIG/id.txt' com os pontos a serem coletados. Obs: Um ponto por linha.
#
# Opções:
#	inicializa_coleta_geral
#	inicializa_coleta_depois_virada
#	inicializa_coleta_antes_virada

source functions.sh		# Funções utilizadas pelo script

inicializa_coleta_geral
