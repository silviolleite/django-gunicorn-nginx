# Montando servidor no Ubuntu para aplicações Django utilizando o Nginx, Guinicorn e Supervisor

As maiores dificuldades que os iniciantes tem quando começam a utilizar o Django são:

1. Como monto um servidor para rodar as minhas aplicações Django?
2. E se eu não quiser usar o Heroku ou PythonAnywhere?
3. Roda no Apache ou Nginx?
4. Consigo montar um servidor na minha máquina?

Okay! Este passo a passo irá ajudar você a configurar um servidor para sua aplicação Django no Ubuntu(Linux).

## Vamos lá!

1. [Requisitos](#1-requisitos)
2. [Criando o ambiente virtual](#2-criando-o-ambiente-virtual)
3. [Ativando a venv](#3-ativando-a-venv)
4. [Instalando o Gunicorn](#4-instalando-o-gunicorn)
5. [Configurando o servidor Nginx](#5-configurando-o-servidor-nginx)
6. [O arquivo start.sh](#6-o-arquivo-start.sh)
7. [Configurando o Supervisor](#7-configurando-o-supervisor)
8. [Executando a aplicação](#8-executando-a-aplicação)

#### 1. Requisitos
 

Para este tutorial considere que os seguintes softwares já estão instalados no seu Ubuntu
1. Python <= 3.6
2. Supervisor
3. Nginx

Segue comandos para certificar que os softwares estão instalados.

Verificando a versão do Python
```console
$ python3 -V
```
Verificando se o Nginx e Supervisor estão ativos
```console

$ systemctl status nginx
$ systemctl status supervisor.service
```

Caso alguns destes softwares não esteja instalado, os links abaixo podem te ajudar.

 - [Python](https://www.python.org/)
 - [Nginx](https://nginx.org/en/linux_packages.html#stable)
 - [Supervisor](https://www.digitalocean.com/community/tutorials/how-to-install-and-manage-supervisor-on-ubuntu-and-debian-vps)


#### 2. Criando o ambiente virtual
Dentro da pasta do projeto crie o ambiente virtual com o modulo `venv`, no exemplo abaixo criaremos uma `venv` com o nome de `.venv`, isso irá criar uma pasta oculta com o ambiente python isolado. 

```console
$ python -m venv .venv
```

#### 3. Ativando a venv
Para ativar a `venv` que acabamos de criar execute o comando: 

```console
$ source .venv/bin/activate
```

#### 4. Instalando o Gunicorn
Para instalar o Gunicorn execute o comando:

```console
$ pip install gunicorn
```

#### 5. Configurando o servidor Nginx
Por padrão o Nginx após instalado está na pasta `/etc/nginx/`, dentro desta pasta tem duas pastas que iremos trabalhar. `sites-enabled` e `sites-available`.

Primeiro iremos remover a configuração padrão do nginx com o comando:

```console
$ sudo rm -f /etc/nginx/sites-enabled/default
```

Depois, iremos criar o nosso arquivo de configuração na pasta `/etc/nginx/sites-available`:

Obs.: Você pode criar o arquivo com o nome da sua aplicação, neste tutorial irei usar o nome exemplo.

```console
$ sudo nano /etc/nginx/sites-available/exemplo 
```

Agora copie as configurações do arquivo `nginx-conf` para o arquivo `exemplo` alterando os caminhos das pastas conforme as suas necessidades.

Para salvar o arquivo no `nano` aperte a combinação de teclas `ctrl + o`, e para sair a combinação `ctrl + x`.

Agora temos que criar um link simbólico para que a nossa aplicação esteja na pasta de `sites-enabled`, para isso execute o comando:
```console
$ sudo ln -s /etc/nginx/sites-available/exemplo /etc/nginx/sites-enabled/
```
#### 6. O arquivo start.sh

Este arquivo trás as configurações para iniciar o Gunicorn, altere os caminhos das pastas de acordo com as necessidades do seu projeto.

É importante que você dê a permissão de execução para o arquivo.

```console
$ sudo chmod u+x /your_path/start.sh
```  


#### 7. Configurando o Supervisor
O Supervisor será o responsável por iniciar o Gunicorn e manter ele no ar sempre.

Bora lá, configurar o nosso supervisor!

Primeiro iremos criar um arquivo de configuração no supervisor com o comando:
```console
$ sudo nano /etc/supervisor/conf.d/exemplo.conf
```

Agora copie e cole as configurações do arquivo `supervisor.conf` para o seu arquivo, altere:
 - o nome do `program`, 
 - os caminhos do comando para a pasta do seu start.sh
 - onde deseja armazenar os logs.

Neste arquivo você pode setar as variáveis de ambientes se precisar na linha `environment`, colocando suas variáveis separadas por vírgulas.

Salve e feche o nano.

Precisamos agora, fazer com que o supervisor leia as nossas configurações, para isso execute os comandos:

```console
$ sudo supervisorctl reread
$ sudo supervisorctl update
$ sudo supervisorctl restart exemplo
```

Obs.: No restart, passamos o nome que colocamos no `program` para que nossa configuração seja iniciada.


#### 8. Executando a aplicação
Acesse o IP da máquina no seu Navegador e pronto!


##### Críticas e sugestões serão sempre bem vindas! ;)

