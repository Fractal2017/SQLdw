  
#!/bin/bash

/opt/mssql-tools/bin/sqlcmd -Smssql -Usa -PSqlDevOps2017 -i ./restoreWWI.sql
/opt/mssql-tools/bin/sqlcmd -Smssql -Usa -PSqlDevOps2017 -i ./restoreAdvWrks.sql