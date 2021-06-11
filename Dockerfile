FROM python:alpine3.7

#Variáveis de ambiente para diretório 
ARG DIRPATH
ENV DIRPATH=$DIRPATH
ARG DEST_CSV
ENV DEST_CSV=$DIRPATH/$DEST_CSV

#Ferramentas necessárias: openjdk8, git e jq
RUN apk update \
&& apk upgrade \
&& apk fetch openjdk8 \
&& apk add --no-cache openjdk8 \
&& apk add --no-cache git \
&& apk add --no-cache jq

#Variáveis de ambiente para execução
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV PATH="$JAVA_HOME/bin:${PATH}"
ENV PYTHONPATH="$DIRPATH/infra/SMAT"

#Script para baixar ferramenta no git e setar o env-config.json
WORKDIR $DIRPATH/infra
RUN git clone https://github.com/tonimaciel/SMAT \
&& cd SMAT/nimrod/tests \
&& git checkout second-criteria \
&& contents="$(jq '.path_hash_csv = "'${DEST_CSV}'" | .java_home = "/usr/lib/jvm/java-1.8-openjdk"' env-config.template.json)" \
&& echo "${contents}" > env-config.json

#Mudança do diretório de trabalho, após as atualizações da infra, será necessário mudar isso
WORKDIR $DIRPATH/output/output

#Comando que será executado ao dar run. É necessário colocar o path para o arquivo que será executado
ENTRYPOINT [ "python3" ]
