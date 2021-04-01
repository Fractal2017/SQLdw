RESTORE DATABASE [AdventureWorksDW2017] 
FROM  DISK = "/tmp/backup/AdventureWorksDW2017.bak"
WITH  FILE = 1,
MOVE "AdventureWorksDW2017" TO "/var/opt/mssql/data/AdventureWorksDW2017.mdf",
MOVE "AdventureWorksDW2017_log" TO "/var/opt/mssql/data/AdventureWorksDW2017_log.ldf"