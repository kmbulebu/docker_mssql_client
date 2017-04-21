# Introduction
A container to run Transact-SQL scripts against a Microsoft SQL server database.
This image is useful for bootstrapping a clean MSSQL instance.

# Using

The image is configured entirely through environment variables.

`SQL_SLEEP_TIME` Time in seconds to wait before executing.
`SQL_FILES_MANIFEST` Path to a text file with each line specifying a name of a SQL file in the same directory. The scripts will be executed in the order specified.

Use sqlcmd's environment variables to configure the server connection parameters. See https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility for full list of supported environment variables.

### Sample docker-compose usage:
```
database-setup:
    image: "kmbulebu/mssql_client"
    environment:
      - "SQL_SLEEP_TIME=15"
      - "SQL_FILES_MANIFEST=/sql/manifest"
      - "SQLCMDSERVER=database"
      - "SQLCMDUSER=sa"
      - "SQLCMDPASSWORD=N0tStr0ngPassw0rd!"
      - "SQLCMDDBNAME=mydb"
    depends_on:
      - database
```
