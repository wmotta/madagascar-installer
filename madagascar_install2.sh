#!/bin/bash
#limpado o terminal:
clear

echo ""
echo "========================================================================"
echo "	Segunda parte do Instalador automatico do Madagascar criado por WILLIAM SMITH em 09/01/2020 "
echo "  ATUALIZADO Em Outubro 2023 "
echo "========================================================================" 
echo ""

echo ""
echo "========================================================================"
echo "	Conclusão da instalação do gerenciador python pyenv para resover problemas de conflito entre"
echo "  diferentes versões do python presentes no sistema"
echo "========================================================================"
sleep 5

pyenv install 3.10.13

echo "========================================================================"
echo "Copie o comando abaixo, abra outro termial, cole e dê enter."
echo "sfspike n1=1000 k1=300 | sfbandpass fhi=2 phase=y | sfwiggle clip=0.02 | sfpen"
echo "Deverá aparecer uma imagem do magascar, caso essa imagem apareça então está tudo funcionando."
echo "========================================================================"
echo ""
sfspike n1=1000 k1=300 | sfbandpass fhi=2 phase=y | sfwiggle clip=0.02 title="Bem Vindo ao Madagascar" | sfpen
echo ""
echo "========================================================================"
echo "Lembre-se de periodicamente limpar os arquivos binários presente na pasta "
echo " madagascar.bin presente na sua home para evitar falta de espaço no seu armazenamento"
echo "========================================================================"
echo ""

