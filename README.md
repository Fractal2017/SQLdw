# SQL and default DB
Container that runs SQL Server on Linux (Platform: linux, x86_64, name=ubuntu, version=16.04 (Ubuntu16)) using the base image: [microsoft/mssql-server-linux](https://hub.docker.com/r/microsoft/mssql-server-linux), i.e Microsoft MSSQL Server 2017 for Linux Docker Edition and provides a default database

## The Dockerfile
The Dockerfile uses the base image [microsoft/mssql-server-linux](https://hub.docker.com/r/microsoft/mssql-server-linux) and does three things:

1. Updates some OS commands like "apt-get" and certificates
2. Copies the custom scripts that will download (wget) the .bak database and creates a simple db
3. Updates the entrypoint.sh to run the custom scripts from step 2.

## The Scripts
This directory ./scripts/ contains all the scripts to downdload sample databases (AdventureWorks, WorldWide Imports), and creates a simple one (demodata)

1. entrypoint.sh: This script calls subsequent other scripts i.e run-initialization.sh but more importantly it also starts the SQLServer database
2. run-initialization.sh: This script performs "wget" and execute two other scripts create-db.sql and restoreAdvWkrs.sql  
3. create-db.sql: Creates a simple table "demodata"
4. restoreAdvWrks.sql: AdventureWorks database backup
5. restoreWWI.sql: World Wide Imports database backup

## The Image and Container
To get your container created and running you will have to execute the following commands in the order indicated:
### Create the Image
``` bash
>$ docker build -t sqldwimage .
```

### Create the Container
``` bash
>$ docker-compose up -d
```
#### Note
> As per the documentation, the base image [microsoft/mssql-server-linux](https://hub.docker.com/r/microsoft/mssql-server-linux) , which runs on linux/amd64 SQL Server 2017, is no longer updated since 2019.