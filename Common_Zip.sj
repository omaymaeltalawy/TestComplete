//USEUNIT Common_File

/**
 * Extract a Zip file
 * 
 * @param ZipFile Path to file
 * @param ExtractPath Destination path, by default same ZipFile directory
 */
function ExtractZipFile(ZipFile, ExtractPath)
{
  Common_File.VerifyFileExists(ZipFile);

  //Veriy ExtractPath
  if (ExtractPath == null || ExtractPath == "")
  {
    ExtractPath = aqFileSystem.GetFileFolder(ZipFile);
  }
  
  //Set the command to extract the zip file to a temporary variable and execute the command
  var command = "7z.exe x \"" + ZipFile + "\" -o\"" + ExtractPath + "\" -y";
  
  WScriptObj = Sys.OleObject("WScript.Shell");
  var ExecOperation = WScriptObj.Exec(command);
  while (ExecOperation.Status == 0)
  {
    delay(100, "Extracting zip file");
  }
  
  //Read the output of execution
  var output = ExecOperation.StdOut.ReadAll();
  if (ExecOperation.ExitCode == 0)
  {
    Log.Checkpoint("File was extracted successfully");
  }
  else
  {
    Log.Error(output);
  }
}