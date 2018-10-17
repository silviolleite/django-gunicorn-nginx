#!/bin/bash
# Diretorio e arquivo de log
LOGFILE=/your_path_to/logs/gunicorn.log
LOGDIR=$(dirname $LOGFILE)
# Numero de processo simultaneo, modifique de acordo com seu processador
NUM_WORKERS=3
# Usuario/Grupo que vai rodar o gunicorn
USER=your_user
#GROUP=root
# Endereço local que o gunicorn irá rodar
ADDRESS=127.0.0.1:8001
# Ativando ambiente virtual e executando o gunicorn para este projeto
source /your_path_to/.venv/bin/activate
# Abrindo a pasta do projeto
cd /project_path/
test -d $LOGDIR || mkdir -p $LOGDIR
# executando o gunicorn instalado na venv com as configurações básicas e apontando para o wsgi da sua aplicação
exec .venv/bin/gunicorn -w $NUM_WORKERS --bind=$ADDRESS --user=$USER --log-level=debug --log-file=$LOGFILE 2>>$LOGFILE yourapp.wsgi:application
