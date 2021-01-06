#! /bin/bash
#limpado o terminal:
clear

#iniciando a instalacao:
echo ""
echo "========================================================================"
echo "	Instalação da ultima versão do madagascar (UBUNTU e derivados)"
echo "========================================================================"
sleep 5

# fazendo update antes da instalacao dos pacotes
echo "Preparando Sistema com as devidas atualizações"
#sudo dpkg --configure -a
#sudo apt-get install -f
#sudo apt-get autoremove -y
#sudo apt-get autoclean -y
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get update -y

# Instalação do pyenv | Adicionando em 06/01/2021
echo ""
echo "========================================================================"
echo "	Pode ser que você já tenha em seu sistema uma versão do python que lhe agrade ou seja-lhe mais útil, para não haver problemas de compatibilidade com o MADAGASCAR será instalado um gerenciador de versões python chamado PYENV que definirá uma versão local apenas para o MADAGASCAR."
echo "========================================================================"
sleep 5

#instalando as dependências do pyen
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev git -y

echo "export PATH="$HOME/.pyenv/bin:$PATH"" >> $HOME/.bashrc
echo "eval "$(pyenv init -)"" >> $HOME/.bashrc
echo "eval "$(pyenv virtualenv-init -)"" >> $HOME/.bashrc

source /home/$USER/.bashrc

curl https://pyenv.run | bash

exec "$SHELL"

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
	echo "Erro ao baixar madagascar_install.tar.gz tente novamente."
	sleep 3
	exit
fi
#descompactando:
echo ""
echo "========================================================================"
echo "Descompactando o madagascar:"
echo "========================================================================"
#tar -xzvf madagascar-2.0-1.tar.gz
tar -xzvf madagascar_install.tar.gz -C ${HOME}

#criando diretorio de instalacao:
cd ${HOME}
mkdir madagascar
mkdir rsfdata

echo ""
echo "========================================================================"
echo "	Criando diretorio de instalacao:"
echo "${PWD}"
echo "========================================================================" 

# definindo a versão do python na pasta do madagascar

pyenv install 3.9.1

cd madagascar
pyenv local 3.9.1

#super usuario:
echo ""
echo "========================================================================"
echo "	Digite a senha de super usuario, para instalar os pacotes:"
echo "========================================================================"
echo ""

#pacotes necessarios para instalacao:
sudo apt-get install libxaw7-dev freeglut3-dev libnetpbm10-dev libgd-dev libplplot-dev libavcodec-dev libcairo2-dev libjpeg-dev swig python-numpy g++ gfortran libopenmpi-dev libfftw3-dev libsuitesparse-dev libtirpc-dev scons -y

# ESTA SEÇÃO FOI REMOVIDA PARA INSERÇÃO DO PYENV

# novas dependências adicionadas 08/07/2020 
# retirado por causa do pyenv em 06/01/2021

#echo ""
#echo "========================================================================"
#echo "Aqui você irá escolher qual versão do python será instalado, é importante que caso você tenha o Anaconda instalado siga o mesmo python que há nele. Escolha entre Python 2 e Python 3"
#echo "========================================================================"
#echo ""
#sleep 3

#echo ""
#echo "========================================================================"
#echo "ATENÇÃO! se você colocar qualquer valor diferende de 2 ou 3 vai dar ruim, não tenho paciência pra ficar criando if pra barrar isso. Ecolha com sabedoria."
#echo "========================================================================"
#echo ""
#sleep 5

#echo "Digite 2 ou 3"
#read py
#sudo apt install python-dev-is-python${py} -y

# retirando dependências odsoletas 08/07/2020
# python-epydoc / emacs25 / python-dev

sudo apt-get install openjdk-8-jdk -y
#entrando na pasta:
echo ""
echo "========================================================================"
echo "Digite a versão do Madagascar baixado"
echo "Você deverá ir na sua pasta home (ou olhar para os arquivos desconpactados acima) e procurar por uma pasta nomeada madagascar-3.0 por exemplo"
echo "3.0 é o exemplo de versão, digite a numeração que aparecer. na pasta madagascar-"
echo "========================================================================"
echo ""
read name
cd ${HOME}/madagascar-${name}
#configurando o madagascar:
echo ""
echo "========================================================================"
echo "	Configurando o madagascar para instalacao:"
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


export PYTHONPATH=$PYTHONPATH:/home/$USER/madagascar/lib/python2.7/dist-packages/rsf:/home/$USER/madagascar/lib/python2.7/distpackages/rsf/recipes
export DATAPATH=/home/$USER/rsfdata/

echo "#Caminhos para Madagscar" >> $HOME/.bashrc
echo "export PATH="'$PATH':$HOME/.matlab/bin"" >> $HOME/.bashrc
echo "export RSFROOT=$HOME/madagascar" >> $HOME/.bashrc
echo "source "'$RSFROOT'/share/madagascar/etc/env.sh"" >> $HOME/.bashrc
echo "export TMPDATAPATH=/tmp/" >> $HOME/.bashrc
echo "export PATH="'$PATH':'$RSFROOT'/bin"" >> $HOME/.bashrc


cd $HOME

sudo chown $USER:$USER madagascar -R -v

sudo rm -rf madagascar-${name}

source /home/$USER/.bashrc
exec "$SHELL"

echo ""
echo "========================================================================"
echo "Verificando se a instalação foi finalizada com sucesso."
echo "========================================================================"
echo ""

echo ""
echo "========================================================================"
echo "Em 5 segundos deverá aparecer uma imagem do magascar, caso essa imagem apareca então está tudo funcionando."
echo "========================================================================"
echo ""
sleep 5

sfspike n1=1000 k1=300 | sfbandpass fhi=2 phase=y | sfwiggle clip=0.02 | sfpen

echo "========================================================================"
echo "Caso a imagem não tenha aparecido, copie o comando abaixo, abra outro termial, cole e dê enter."
echo "sfspike n1=1000 k1=300 | sfbandpass fhi=2 phase=y | sfwiggle clip=0.02 | sfpen"
echo "========================================================================"
echo ""
