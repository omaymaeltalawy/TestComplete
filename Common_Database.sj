//USEUNIT Private_Database
/** @function

    @name Common_Database.BackupMSSQLDatabase

    @description Backup MSSQL DB.

    @param {String} serverName Database server name.
    @param {String} databaseName Database name.
    @param {String} backupFilePathWithName Full backup filename with path.
    @param {String} logFilePathWithName Full log filename with path.
    @param {String} timeout Milliseonds wait timeout.
*/
function BackupMSSQLDatabase(serverName, databaseName, backupFilePathWithName, logFilePathWithName, timeout) {
  var backupCommand = "SQLCMD -S " + serverName + " -Q \"BACKUP DATABASE " +
    databaseName + " TO DISK='" + backupFilePathWithName + "'\" -o " + logFilePathWithName;
  ExeDbCmdAndWait(backupCommand, logFilePathWithName, "Database backup", timeout);
}

/** @function

    @name Common_Database.RestoreMSSQLDatabase

    @description Restore MSSQL DB.

    @param {String} serverName Database server name.
    @param {String} databaseName Database name.
    @param {String} backupFilePathWithName Full backup filename with path.
    @param {String} logFilePathWithName Full log filename with path.
    @param {String} timeout Milliseonds wait timeout.
*/
function RestoreMSSQLDatabase(serverName, databaseName, backupFilePathWithName, logFilePathWithName, timeout) {
  var restoreCommand = "SQLCMD -S " + serverName + " -Q \"Use Master Alter Database "+
  databaseName +" SET SINGLE_USER With ROLLBACK IMMEDIATE RESTORE DATABASE " +
    databaseName + " FROM DISK='" + backupFilePathWithName + "' WITH REPLACE\" -o " + logFilePathWithName;
  ExeDbCmdAndWait(restoreCommand, logFilePathWithName, "Database restore", timeout);
}
