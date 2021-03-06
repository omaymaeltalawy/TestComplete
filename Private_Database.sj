/** @function

    @name Private_Database.ExeDbCmdAndWait

    @description Executes DB command and waits for completion.

    @param {String} dbCommand Database command.
    @param {String} logFilePathWithName Full log filename with path.
    @param {String} commandExecuting Label of DB command shown in success/failure message.
    @param {String} timeout Milliseonds wait timeout.
*/
function ExeDbCmdAndWait(dbCommand, logFileNameWithPath, commandExecuting, timeout) {
  var totalWaitTimeout = 0,
    delayMillis = 1000,
    searchString = "successfully",
    processObj = TestedApps.Common_ComandPrompt.Run(),
    windowObj = processObj.Window("*", "*", 1),
    logText;
  windowObj.Keys(dbCommand + "[Enter]exit[Enter]");

  Delay(delayMillis);
  logText = aqFile.ReadWholeTextFile(logFileNameWithPath, aqFile.ctUTF8);

  while (aqString.Find(logText, searchString) === -1) {
    Delay(delayMillis);
    totalWaitTimeout = totalWaitTimeout + delayMillis;

    if (totalWaitTimeout > timeout || aqString.Find(logText, "terminating abnormally") !== -1) { Log.Error(commandExecuting + " was not successful"); }
    logText = aqFile.ReadWholeTextFile(logFileNameWithPath, aqFile.ctUTF8);
  }
  Log.Message(commandExecuting + " was successful");
}
