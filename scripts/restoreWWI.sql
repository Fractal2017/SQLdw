RESTORE DATABASE [WWImporters]
FROM DISK = "/tmp/backup/WideWorldImporters-Full.bak" 
WITH FILE=1,
MOVE "WWI_Primary" TO "/var/opt/mssql/data/WideWorldImporters.mdf", 
MOVE "WWI_Userdata" TO "/var/opt/mssql/data/WideWorldImporters_Userdata.mdf", 
MOVE "WWI_Log" TO "/var/opt/mssql/data/WideWorldImporters.ldf", 
MOVE "WWI_InMemory_Data_1" TO "/var/opt/mssql/data/WideWorldImporters_InMemory_Data_1"