FROM alpine:3.7

# Important environment variables 
ARG DIRPATH
ENV DIRPATH=$DIRPATH
ARG DEST_CSV
ENV DEST_CSV=$DEST_CSV
ENV MAVEN_HOME=/usr/share/java/maven-3
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV PATH="$JAVA_HOME/bin:${PATH}"
ENV PYTHONPATH="$DIRPATH/infra/SMAT"
ENV SMAT="$DIRPATH/infra/SMAT/nimrod/proj/semantic_study.py"

#Getting necessary tools: openjdk8, git, jq, nano and maven
RUN apk update \
&& apk upgrade \
&& apk add --no-cache openjdk8 \
&& apk add --no-cache git \
&& apk add --no-cache jq \
&& apk add --no-cache nano \
&& apk add --no-cache maven

#Getting and configuring python
RUN apk add --no-cache python3 \
&& python3 -m ensurepip \
&& pip3 install --upgrade pip setuptools \
&& rm -r /usr/lib/python*/ensurepip && \
if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
rm -r /root/.cache

#Script to clone SMAT tool in git and configuring env-config.json
WORKDIR $DIRPATH/infra
RUN git clone https://github.com/tonimaciel/SMAT \
&& cd SMAT \
&& git checkout ci \
&& if [ -f requirements.txt ]; then pip3 install -r requirements.txt; fi \
&& cd nimrod/tests \
&& contents="$(jq '.path_hash_csv = "'${DEST_CSV}'" | .java_home = "/usr/lib/jvm/java-1.8-openjdk"' env-config.json)" \
&& echo "${contents}" > env-config.json

#Alter permission in files 
RUN chmod -R 777 $DIRPATH

#The directory where you should run the tool
WORKDIR $DIRPATH/output