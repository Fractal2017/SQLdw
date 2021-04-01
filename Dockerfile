FROM microsoft/mssql-server-linux:latest

ENV SA_PASSWORD SqlDevOps2017
ENV MSSQL_PID Developer

EXPOSE 1433

#RUN apt-get update && apt-get install -y unzip
RUN apt-get --no-install-recommends install -y ca-certificates

WORKDIR /tmp/backup

#Below commands can be placed here or in the script "entrypoint.sh"
#RUN wget --no-check-certificate https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v0.2/WideWorldImporters-Full.bak
#RUN wget --no-check-certificate https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2017.bak

COPY ./scripts/* .
CMD /bin/bash ./entrypoint.sh
#RUN  ./provision.sh

