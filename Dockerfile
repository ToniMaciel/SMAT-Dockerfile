FROM alpine:3.7

#Variáveis de ambiente para diretório 
ARG DIRPATH
ENV DIRPATH=$DIRPATH
ARG DEST_CSV
ENV DEST_CSV=$DIRPATH/$DEST_CSV

#Ferramentas necessárias: openjdk8, git, jq e nano
RUN apk update \
&& apk upgrade \
&& apk add --no-cache openjdk8 \
&& apk add --no-cache git \
&& apk add --no-cache jq \
&& apk add --no-cache nano

#Baixando e configurando o python
RUN apk add --no-cache python3 \
&& python3 -m ensurepip \
&& pip3 install --upgrade pip setuptools \
&& rm -r /usr/lib/python*/ensurepip && \
if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
rm -r /root/.cache

#Script para baixar ferramenta no git e setar o env-config.json
WORKDIR $DIRPATH/infra
RUN git clone https://github.com/tonimaciel/SMAT \
&& cd SMAT/nimrod/tests \
&& git checkout fast-test \
&& contents="$(jq '.path_hash_csv = "'${DEST_CSV}'" | .java_home = "/usr/lib/jvm/java-1.8-openjdk"' env-config.template.json)" \
&& echo "${contents}" > env-config.json
#pip3 install -r requirements.txt -> Para baixar as dependencias

#Variáveis de ambiente para execução
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV PATH="$JAVA_HOME/bin:${PATH}"
ENV PYTHONPATH="$DIRPATH/infra/SMAT"

#Mudança do diretório de trabalho, após as atualizações da infra, será necessário mudar isso
WORKDIR $DIRPATH/infra/SMAT