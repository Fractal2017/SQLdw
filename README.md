# SQL and default DB (Adventure Works DW)
Container that runs SQL Server on Linux (Platform: linux, x86_64, name=ubuntu, version=16.04 (Ubuntu16)) using the base image: [microsoft/mssql-server-linux](https://hub.docker.com/r/microsoft/mssql-server-linux), i.e Microsoft MSSQL Server 2017 for Linux Docker Edition and provides a default database

<center><img src="./images/Architecture.png" width="75%" height="75%"></center>

```
Server: localhost
User  : sa
pwd   : SqlDevOps2017
DB    : DemoData (or AdventureWorksDW2017 or master)
```

## TL;DR
1. Clone this repo https://github.com/Fractal2017/SQLdw
``` 
    $ gh repo clone Fractal2017/SQLdw 
    OR
    DOS> git clone https://github.com/Fractal2017/SQLdw
```
2. If you are under windows then please consider this:
    
    **Text line End:**<p>
    **Linux**: LF (Line Feed)<p>
    **Windows**: LF/CR (Line Feed+Carriage Return), ie ^J + ^M <p>

    Since Script *.sh files (entrypoint.sh and run-initialization.sh) will be executed in Linux, make sure to remove the ^M or [CR] characters before running docker compose. In **VS Code**: Files need to be edited with VS Code setting as LF
<center><img src="./images/VSCodeLF.png" width="75%" height="75%"></center>


3. Build Image
```
    $ cd SQLdw
    $ docker build -t db/sql .
```

4. Create Container
```
    $ docker-compose up -d
```
5. Check LOGS: Wait for 1 or 2 minutes
```
    $ docker logs --tail 1000 -f sqldw
```
        Until you see something similar to:
        > Processed 3 pages for database 'AdventureWorksDW2017', file 'AdventureWorksDW2017_log' on file 1.
        > RESTORE DATABASE successfully processed 12171 pages in 0.292 seconds (325.615 MB/sec).

## The Dockerfile
The Dockerfile uses the base image [microsoft/mssql-server-linux](https://hub.docker.com/r/microsoft/mssql-server-linux) and does three things:

1. Updates some OS commands like "apt-get" and certificates
2. Copies the custom scripts that will download (wget) the .bak database and creates a simple db
3. Updates the entrypoint.sh to run the custom scripts from step 2.

## The "scripts" directory
This directory ./scripts/ contains all the scripts to download sample databases (AdventureWorks, WorldWide Imports), and creates a simple one (demodata)

1. **entrypoint.sh**: This script calls subsequent other scripts i.e run-initialization.sh but more importantly it also starts the SQLServer database
2. **run-initialization.sh**: This script performs "wget" and execute two other scripts create-db.sql and restoreAdvWkrs.sql  
3. **create-db.sql**: Creates a simple table "demodata"
4. **restoreAdvWrks.sql**: AdventureWorks database backup
5. **restoreWWI.sql**: World Wide Imports database backup

## The "PowerBI" directory
1. **AdventureWorksDW_ER.pdf**: This is the entity relationship data model for the Adventureworks database
2. **AWS_InternetSales.pbix**: This is the PowerBI report that only models the star schema for the Internet Sales fact table

## The Image and Container
To get your container created and running you will have to execute the following commands in the order indicated:
### Create the Image
``` bash
$ docker build -t db/sql .
```
![Docker Build](./images/DockerBuild.png)
### Create the Container
``` bash
$ docker-compose up -d
```
![Docker Compose](./images/DockerCompose.png)

You can also do the above using Visual Studio Code (VS Code), as follows:

### VS-Code: Container creation

Use VS-Code and add the cloned git repo into your workspace. 

![Cloned Repository](./images/ClonedRepo.png)

Add the folder into VS-Code

![Dir2VSCode](./images/RepoIntoVSCode.png)

Click on **docker-compose.yml** and run the "docker-compose up" command

![DockerCompose](./images/VSCodeDockerCompose.png)

![ComposeUp](./images/VSCodeComposeUp.png)



### Verify DB is up and running
Switch to Docker view and inspect the log output

![DockerLogs](./images/ContainerLogs.png)

You should initially see this log messages

>2021-04-03 18:15:10.33 spid24s     The Database Mirroring endpoint is in disabled or stopped state.<p>
2021-04-03 18:15:10.34 spid24s     Service Broker manager has started.<p>
2021-04-03 18:15:10.43 spid6s      Recovery is complete. This is an informational message only. No user action is required.<p>
2021-04-03 18:15:10.45 spid21s     The default language (LCID 0) has been set for engine and full-text services.<p>

Wait for about 1 or 2 minutes until you see the additional lines coming up. Only then the sql server instance and the AdventureWorksDW db is ready

>2021-04-03 18:16:35.21 spid51      Starting up database 'DemoData'.<p>
2021-04-03 18:16:35.39 spid51      Parallel redo is started for database 'DemoData' with worker pool size [1].<p>
2021-04-03 18:16:35.41 spid51      Parallel redo is shutdown for database 'DemoData' with worker pool size [1].<p>
Changed database context to 'DemoData'.<p>
2021-04-03 18:16:36.16 spid51      Starting up database 'AdventureWorksDW2017'.<p>
2021-04-03 18:16:36.34 spid51      The database 'AdventureWorksDW2017' is marked RESTORING and is in a state that does not allow recovery to be run.<p>

...

>2021-04-03 18:16:36.95 Backup      RESTORE DATABASE successfully processed 12171 pages in 0.292 seconds (325.615 MB/sec).<p>
Processed 12168 pages for database 'AdventureWorksDW2017', file 'AdventureWorksDW2017' on file 1.<p>
Processed 3 pages for database 'AdventureWorksDW2017', file 'AdventureWorksDW2017_log' on file 1.<p>
RESTORE DATABASE successfully processed 12171 pages in 0.292 seconds (325.615 MB/sec).<p>

### Note:
As per the documentation, the base image [microsoft/mssql-server-linux](https://hub.docker.com/r/microsoft/mssql-server-linux) , which runs on linux/amd64 SQL Server 2017, is no longer updated since 2019.<p>

### References
1. All DB Samples
    - https://docs.microsoft.com/en-us/sql/samples/sql-samples-where-are?view=sql-server-ver15
    - Git: https://github.com/microsoft/sql-server-samples/tree/master/samples/databases

3. AdventureWorks (OLTP/DW)
    - https://docs.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver15&tabs=tsql
    - Git: https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/adventure-works

5. WorldwideImport (OLTP/DW)
    - https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-dw-install-configure?view=sql-server-ver15
    - Git: https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers

Note:
- Samples Release1.0: https://github.com/microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0
- Samples Pre-release: https://github.com/microsoft/sql-server-samples/releases/tag/wide-world-importers-v0.2

