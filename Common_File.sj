//USEUNIT Private_Convert
//USEUNIT Private_Utils

/**
 * Return true if file exists, otherwise false
 * 
 * @param File Path to file
 * @return {bool} Result 
 */
function FileExists(File)
{
  return aqFile.Exists(File);
}

/**
 * Log a message is file exists
 * 
 * @param File Path to file
 */
function VerifyFileExists(File)
{
  if (FileExists(File))
  {
    Log.Checkpoint("File \"" + File + "\" exists");
  }
  else
  {
    Log.Error("File \"" + File + "\" NOT exists");
  }
}

/**
 * Log a message is file not exists
 * 
 * @param File Path to file
 */
function VerifyFileNotExists(File)
{
  if (!FileExists(File))
  {
    Log.Checkpoint("File \"" + File + "\" NOT exists");
  }
  else
  {
    Log.Error("File \"" + File + "\" exists");
  }
}

/**
 * Waits for file to exists
 * 
 * @param File Path to file
 * @param Timeout Timeout
 */
function WaitForFileToAppear(File, Timeout)
{
  Private_Utils.WaitFor(
    "Waiting for file to appear",
    "File \"" + File + "\" exists",
    "File \"" + File + "\" not exists",
    function() { return FileExists(File); },
    Timeout);
}

/**
 * Copy file from FromPath to ToPath
 *      alias for aqCopy 
 * 
 * @param FromPath Path to source
 * @param ToPath Destination path
 */
function CopyFileTo(FromPath, ToPath) 
{
  VerifyFileExists(FromPath);
  aqFile.Copy(FromPath , ToPath);
}

/**
 * Delete file
 * 
 * @param File Path to file
 */
function DeleteFile(File)
{
  VerifyFileExists(File);
  var status = false;
  if (aqFileSystem.CheckAttributes(File, aqFileSystem.faDirectory))
  {
    status = aqFileSystem.DeleteFolder(File, true);
    if (status) Log.Checkpoint("Directory \"" + File + "\" was deleted succesfully");
  }
  else
  {
    status = aqFileSystem.DeleteFile(File);
    if (status) Log.Checkpoint("File \"" + File + "\" was deleted succesfully");
  }
  if (!status)
  {
    Log.Error("Delete operation attempt failed"); 
  }
}

/**
 * Append string to existing file
 * 
 * @param File Path to file
 * @param String Text to append
 * @param Encoding Encoding by default UTF-8
 */
function AppendToFile(File, String, Encoding) 
{
  VerifyFileExists(File);
  
  //Verify Encoding value
  if (Encoding != aqFile.ctANSI && Encoding != aqFile.ctUnicode && Encoding != aqFile.ctUTF8)
    Encoding = aqFile.ctUTF8;
  
  if (aqFile.WriteToTextFile(File, String, Encoding, false))
  {
    Log.Checkpoint("String was appended to file");
  }
  else
  {
    Log.Error("String was not appended to file");
  }
}

/**
 * Replace string(s) in specified file
 * 
 * @param File Path to file
 * @param SearchStrings String or array of strings to search
 * @param ReplaceStrings String or array of strings to replace with
 * @param Encoding Encoding by default UTF-8
 */
function ReplaceFileStrings(File, SearchStrings, ReplaceStrings, Encoding)
{
  VerifyFileExists(File);
  
  //Verify Encoding value
  if (Encoding != aqFile.ctANSI && Encoding != aqFile.ctUnicode && Encoding != aqFile.ctUTF8)
    Encoding = aqFile.ctUTF8;
  
  var arr = Private_Convert.ObjectsToArray(SearchStrings, ReplaceStrings);

  var s = aqFile.ReadWholeTextFile(File, Encoding);
  for(var key in arr)
  {
    s = aqString.Replace(s, key, arr[key]);
  }
  if (aqFile.WriteToTextFile(File, s, Encoding, true))
  {
    Log.Checkpoint("String(s) was replaced in file");
  }
  else
  {
    Log.Error("String(s) was not replaced in file");
  }
}

/**
 * Return true if file contains string, otherwise false
 * 
 * @param File Path to file
 * @param String Text to search
 * @param Encoding Encoding by default UTF-8
 * @return {bool} Result 
 */
function FileContainsString(File, String, Encoding)
{
  //VerifyFileExists in a loop keep logs message
  if (!FileExists(File))
  {
    Log.Error("File \"" + File + "\" NOT exists");
  }
  
  //Verify Encoding value
  if (Encoding != aqFile.ctANSI && Encoding != aqFile.ctUnicode && Encoding != aqFile.ctUTF8)
    Encoding = aqFile.ctUTF8;
  
  //Read the entire file 
  var s = aqFile.ReadWholeTextFile(File, Encoding);
  
  //Search for the 'String' in the file and return true if found,else false
  return aqString.Find(s, String) !== -1;
}

/**
 * Log a message is file contains string
 * 
 * @param File Path to file
 * @param String Text to search
 * @param Encoding Encoding by default UTF-8
 */
function VerifyFileContainsString(File, String, Encoding)
{
  if (FileContainsString(File, String, Encoding))
  {
    Log.Checkpoint("File \"" + File + "\" contains \"" + String + "\"");
  }
  else
  {
    Log.Error("File \"" + File + "\" NOT contains \"" + String + "\"");
  }
}

/**
 * Waits for file to exists and contains string
 * 
 * @param File Path to file
 * @param String Text to search
 * @param Encoding Encoding by default UTF-8
 * @param Timeout Timeout
 */
function WaitForFileToContainsString(File, String, Encoding, Timeout)
{
  var start = GetTickCount();
  WaitForFileToAppear(File, Timeout);
  var timeout = Timeout - (GetTickCount() - start); 

  Private_Utils.WaitFor(
    "Waiting for file to appear",
    "File \"" + File + "\" exists",
    "File \"" + File + "\" not exists",
    function() { return FileContainsString(File, String, Encoding); },
    timeout);
}

/**
 * Create empty file
 *      alias for aqCopy 
 * 
 * @param File Path to file
 */
function CreateFile(File) 
{
  aqFile.Create(File);
}
