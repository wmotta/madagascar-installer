#! /bin/bash
#limpado o terminal:
clear

echo ""
echo "========================================================================"
echo "	Instalador automatico do Madagascar criado por WILLIAM SMITH em 09/01/2020 "
echo "  ATUALIZADO EM 09/01/2021 "
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

#super usuario:
echo ""
echo "========================================================================"
echo "	Digite a senha de super usuario, para instalar os pacotes:"
echo "========================================================================"
echo ""
# fazendo update antes da instalacao dos pacotes
echo "Preparando Sistema com as devidas atualizações"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get update -y
sudo dpkg --configure -a
sudo apt-get install -f
sudo apt-get autoremove -y
sudo apt-get autoclean -y
#pacotes necessarios para instalacao:
sudo apt-get install libxaw7-dev freeglut3-dev libnetpbm10-dev libgd-dev libplplot-dev libavcodec-dev libcairo2-dev libjpeg-dev swig python-numpy g++ gfortran libopenmpi-dev libfftw3-dev libsuitesparse-dev scons git -y

sudo apt-get install libxaw7-dev freeglut3-dev libnetpbm10-dev libgd-dev libplplot-dev libavcodec-dev libcairo2-dev libjpeg-dev swig python-numpy g++ gfortran libopenmpi-dev libfftw3-dev libsuitesparse-dev libtirpc-dev git scons -y

# novas dependências adicionadas 08/07/2020

echo ""
echo "========================================================================"
echo "Aqui você irá escolher qual versão do python será instalado, é importante que caso você tenha o Anaconda instalado siga o mesmo python que há nele. Escolha entre Python 2 e Python 3"
echo "========================================================================"
echo ""
sleep 3

echo ""
echo "========================================================================"
echo "ATENÇÃO! se você colocar qualquer valor diferende de 2 ou 3 vai dar ruim, não tenho paciência pra ficar criando if pra barrar isso. Ecolha com sabedoria."
echo "========================================================================"
echo ""
sleep 5

echo "Digite 2 ou 3"
read py
sudo apt install python-dev-is-python${py} -y

# retirando dependências odsoletas 08/07/2020
# python-epydoc / emacs25 / python-dev

sudo apt-get install openjdk-14-jdk -y
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

source .bashrc

echo ""
echo "========================================================================"
echo "Verificaque se a instalação foi finalizada com sucesso."
echo "========================================================================"
echo ""

#echo ""
#echo "========================================================================"
#echo "Em 5 segundos deverá aparecer uma imagem do magascar, caso essa imagem apareca então está tudo funcionando."
#echo "========================================================================"
#echo ""
#sleep 5

#sfspike n1=1000 k1=300 | sfbandpass fhi=2 phase=y | sfwiggle clip=0.02 | sfpen

echo "========================================================================"
echo "Copie o comando abaixo, abra outro termial, cole e dê enter."
echo "sfspike n1=1000 k1=300 | sfbandpass fhi=2 phase=y | sfwiggle clip=0.02 | sfpen"
echo "Deverá aparecer uma imagem do magascar, caso essa imagem apareca então está tudo funcionando."
echo "========================================================================"
echo ""

