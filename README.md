
# Instalador automatico do Madagascar criado por WILLIAM SMITH

---

## ATUALIZADO EM NOVEMBRO DE 2023, MADAGASCAR - 4.0

---

Este script foi concebido para instalação automatica do Software Madagascar no sistema operacional Ubuntu e derivados, note que é possível usar-lo em outras distros, porém será necessário que o usuário faça as devidas alterações para tal.

Primeiramente é extritamente aconselhavel obter os arquivos de instalação do Madagascar em questão renomeado como "madagascar_install.tar.gz". Isto pode ser feito ao acessar a página:

https://sourceforge.net/projects/rsf/

AVISO! o programa verificará a existência do "madagascar_install.tar.gz" e caso não esteja disponível ele executaŕa o download. Caso você já possua os arquivos do Madagascar, basta colocar o instalador "madagascar_install.sh" e o "madagascar_install.tar.gz" na mesma pasta e prosseguir a instalação.

Note que o arquivo base baixado no sourceforge possui o nome da versão, neste caso renomeie-o para madagascar_install.tar.gz

### PROSSEGUINDO PARA A INSTALAÇÃO

Primeiramente torne o "madagascar_install.sh" como um arquivo executável habilitando a caixa de diálogo "permitir a execução do arquivo como um programa" nas propriedades ou simplesmente abra um terminal na pasta onde se encontra o instalador e o Madagascar e digite o seguinte comando:

```sh
chmod +x madagascar_install1.sh
```
após isso é só executar o comando abaixo:

```sh
./madagascar_install1.sh
```
após o primeiro script finalizar, abra outro terminal e repita o processo:

```sh
chmod +x madagascar_install2.sh
./madagascar_install2.sh
```

para dar continuidade à instalação.

Para testar se o Madagascar está funcinando, copie o comando abaixo, abra outro termial, cole e dê enter.

```sh
sfspike n1=1000 k1=300 | sfbandpass fhi=2 phase=y | sfwiggle clip=0.02 | sfpen
```
caso apareça uma imagem, o programa Madagascar o instalado com sucesso.

Se por acaso a imagem não aparecer, reinicie o computador, abra um terminal e digite o comando acima novamente. Se mesmo assim não aparecer imagem. É provável que suas dependências do apt-get estejam quebradas ou que tenha alguma falha em seu sistema, tente corrigir-las e rode o sript novamente. Boa sorte

Para mais informações sobre a instalação acesse: https://www.reproducibility.org/wiki/Installation
