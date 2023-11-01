#!/bin/bash
#limpado o terminal:
clear

echo ""
echo "========================================================================"
echo "	Instalador automatico do Madagascar criado por WILLIAM SMITH em 09/01/2020 "
echo "  ATUALIZADO Em Novembro de 2023 "
echo "========================================================================" 
echo ""

#iniciando a instalacao:
echo ""
echo "========================================================================"
echo "	Instalação da ultima versão do madagascar (UBUNTU e derivados)"
echo "========================================================================"
sleep 5
#sleep 20
#download:
echo ""
echo "========================================================================"
echo "	Baixando o madagascar:"
echo "========================================================================" 
echo ""
#wget -c https://ufpr.dl.sourceforge.net/project/rsf/madagascar/madagascar-2.0/madagascar-2.0-1.tar.gz
if [ -f "madagascar_install.tar.gz" ]; then
	echo "Arquivo base madagascar_install.tar.gz existe, prosseguindo com a instalação."
	chown $USER:$USER -Rc madagascar_install.tar.gz
else
	echo "baixando madagascar_install.tar.gz, aguarde..."
	wget https://sourceforge.net/projects/rsf/files/latest/madagascar_install.tar.gz
	#mv download madagascar_install.tar.gz
	chown $USER:$USER -Rc madagascar_install.tar.gz
	#echo "madagascar_install.tar.gz baixado."
fi

#Confirmando o download do madagascar.
if [ -f "madagascar_install.tar.gz" ]; then
	echo "madagascar_install.tar.gz baixado."
	sleep 3
else
	echo "Erro ao baixar madagascar_install.tar.gz."
	echo "visite https://sourceforge.net/projects/rsf/files/latest/madagascar_install.tar.gz e tente baixar manualmente e coloque o arquivo junto com este programa"
	echo "ou visite https://www.reproducibility.org/wiki/Download"
	sleep 3
	exit/
fi
#descompactando pasta de instalação do madagascar na home:
echo ""
echo "========================================================================"
echo "Descompactando o madagascar:"
echo "========================================================================"
#tar -xzvf madagascar-2.0-1.tar.gz
tar -xzvf madagascar_install.tar.gz -C ${HOME}

#super usuario:
echo ""
echo "========================================================================"
echo "	Digite a senha de super usuario, para instalar os pacotes:"
echo "========================================================================"
echo ""

# fazendo update antes da instalacao dos pacotes
echo ""
echo "========================================================================"
echo " Preparando Sistema com as devidas atualizações"
echo "========================================================================"
echo ""
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get update -y
sudo dpkg --configure -a
sudo apt-get install -f
sudo apt-get autoremove -y
sudo apt-get autoclean -y
#pacotes necessarios para instalacao:
#sudo apt-get install libxaw7-dev freeglut3-dev libnetpbm10-dev libgd-dev libplplot-dev libavcodec-dev libcairo2-dev libjpeg-dev swig python-numpy g++ gfortran libopenmpi-dev libfftw3-dev libsuitesparse-dev scons git -y
sudo apt-get install libxaw7-dev freeglut3-dev libnetpbm10-dev libgd-dev libplplot-dev libavcodec-dev libcairo2-dev libjpeg-dev swig python-numpy g++ gfortran libopenmpi-dev libfftw3-dev libsuitesparse-dev libtirpc-dev scons git -y
sudo apt-get install openjdk-19-jdk -y

# novas dependências adicionadas 08/07/2020

# echo ""
echo "========================================================================"
echo " Será instalado o pyenv que gerenciará as versões do python usadas no sistema incluindo a versão que o madagascar usará "
echo " isso foi feito para que não haja conflito com versões já presentes no systema atual "
echo " Entretanto estas mudanças somente terão efeito au rodar a segunda parte do script madagascar-instaler_2.sh "
echo " É de suma importancia o usuário rodar o segundo script tal qual este para que o madagascar rode perfeitamente "
echo "========================================================================"
echo ""
sleep 5

#Instalando python3
sudo apt install python-dev-is-python3 -y

# instalaão do pyenv para facilitar o gerenciamento do uso do python e evitar conflitos com versões já existentes no sistema. defivindo o python para o madagascar na versão 3.10.13 o mais atual na data atual 27/10/2023
curl https://pyenv.run | bash

echo '#Caminhos para o pyenv' >> $HOME/.bashrc
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> $HOME/.bashrc
echo 'eval "$(pyenv init -)"' >> $HOME/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> $HOME/.bashrc

#esses comando vão para o final desse script ou para o próximo.
#source ~/.bashrc
#pyenv install 3.10.13

# este trecho foi alterado para a instlaçao do pyenv para gerenciar as versões do python
# echo ""
# echo "========================================================================"
# echo "Aqui você irá escolher qual versão do python será instalado, é importante que caso você tenha o Anaconda instalado siga o mesmo python que há nele. Escolha entre Python 2 e Python 3"
# echo "========================================================================"
# echo ""
# sleep 3

# echo ""
# echo "========================================================================"
# echo "ATENÇÃO! se você colocar qualquer valor diferende de 2 ou 3 vai dar ruim, não tenho paciência pra ficar criando if pra barrar isso. Ecolha com sabedoria."
# echo "========================================================================"
# echo ""
# sleep 5

#echo "Digite 2 ou 3"
#read py
#sudo apt install python-dev-is-python${py} -y
#Sudo apt install python-dev-is-python3 -y


# retirando dependências odsoletas 08/07/2020
# python-epydoc / emacs25 / python-dev

#entrando na pasta:
echo ""
echo "========================================================================"
echo " Digite a versão do Madagascar baixado"
echo " Você deverá ir na sua pasta home (ou olhar para os arquivos desconpactados acima) e procurar por uma pasta nomeada madagascar-4.0 por exemplo"
echo " 4.0 é o exemplo de versão, digite a numeração que aparecer. na pasta madagascar-"
echo "========================================================================"
echo ""
read name

#criando diretorio de instalacao:
echo ""
echo "========================================================================"
echo "	Criando diretorio de instalacao:"
echo "${PWD}"
echo "========================================================================" 

cd ${HOME}
mkdir madagascar
mkdir madagascar.bin
cd ${HOME}/madagascar-${name}

#setando python 3.10.13 no pyenv para ser o python usado na pasta do madagascar
#ativando python 3 no localmente na pasta do madagascar
echo '3.10.13' >> ${HOME}/madagascar/.python-version
#pyenv activate 3.10.13

#configurando o madagascar:
echo ""
echo "========================================================================"
echo "	Configurando o madagascar para instalação:"
echo "========================================================================"
echo ""
sleep 5
./configure --prefix=/home/$USER/madagascar
#sudo make install:
echo ""
echo "========================================================================"
echo "	sudo make install:"
echo "========================================================================"
echo ""
sudo make install
echo ""
echo "========================================================================"
echo "	Configurando o seu bash: "
echo "========================================================================"
echo ""
#cd ${HOME}
#verificar futuramente uma nova iplementacao 
#source /home/$USER/madagascar/share/madagascar/etc/env.sh


echo '#Caminhos para Madagscar' >> $HOME/.bashrc
echo 'export PATH="$PATH:$HOME/.matlab/bin"' >> $HOME/.bashrc
echo 'export RSFROOT=$HOME/madagascar' >> $HOME/.bashrc
echo 'source "$RSFROOT/share/madagascar/etc/env.sh"' >> $HOME/.bashrc
echo 'export TMPDATAPATH=/tmp/' >> $HOME/.bashrc
echo 'export PATH="$PATH:$RSFROOT/bin"' >> $HOME/.bashrc
echo '#Caminhos para os binários do Madagscar' >> $HOME/.bashrc
echo 'export DATAPATH=$HOME/madagascar.bin/' >> $HOME/.bashrc

echo  '#Variável dos modulos do python 3.10.13'
echo 'export PYTHONPATH=$PYTHONPATH:$HOME:/home/will/madagascar/lib/:$HOME/madagascar/lib/python3.10/site-packages/rsf:$HOME/madagascar/lib/python3.10/site-packages/rsf/recipes' >> $HOME/.bashrc

cd $HOME

sudo chown $USER:$USER madagascar -R -v

sudo rm -rf madagascar-${name}

source .bashrc

echo ""
echo "========================================================================"
echo " Para conclusão da instalação, este terminal será fechado. " 
echo " Abra outro terminal e rode o arquivo madagascar-install2 pra que as alterações tenham efeito "
echo "========================================================================"
echo ""
sleep 5
exit


#echo ""
#echo "========================================================================"
#echo "Em 5 segundos deverá aparecer uma imagem do magascar, caso essa imagem apareca então está tudo funcionando."
#echo "========================================================================"
#echo ""
#sleep 5
