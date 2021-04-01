#!/bin/bash

# We can place the wget here below or inside the image (so it is installed in each image)
#wget --no-check-certificate https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v0.2/WideWorldImporters-Full.bak
wget --no-check-certificate https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2017.bak

# Wait to be sure that SQL Server came up
sleep 90s

# Run the setup script to create the DB and the schema in the DB
# Note: make sure that your password matches what is in the Dockerfile

/opt/mssql-tools/bin/sqlcmd -Slocalhost -Usa -PSqlDevOps2017 -i ./create-db.sql
/opt/mssql-tools/bin/sqlcmd -Slocalhost -Usa -PSqlDevOps2017 -i ./restoreAdvWrks.sql
#/opt/mssql-tools/bin/sqlcmd -Smssql -Usa -PSqlDevOps2017 -i ./restoreWWI.sql