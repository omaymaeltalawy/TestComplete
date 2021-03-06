
/**
 * Log list of Windows Events
 *
 * @param FromDateTime Log events starting from this date
 */
function LogEvents(FromDateTime)
{
  Log.AppendFolder("Windows Event Log");
  var wmiService = GetObject("WinMgmts:{impersonationLevel=impersonate}!\\\\.\\root\\cimv2"); 
  var objectsList = wmiService.ExecQuery("Select * from Win32_NTLogEvent where TimeWritten > '" 
    + aqConvert.DateTimeToFormatStr(FromDateTime, "%c") + "'"); 

  if (objectsList.Count > 0) 
  {
    var objSWbemDateTime = new ActiveXObject("WbemScripting.SWbemDateTime"); 
    var eObjectsList = new Enumerator(objectsList); 
    for (; !eObjectsList.atEnd(); eObjectsList.moveNext()) { 
      var item = eObjectsList.item(); 
      objSWbemDateTime.Value = item.TimeWritten; 
       
      Log.Message(objSWbemDateTime.GetVarDate(false) + ", LogFile: " + item.Logfile + ", SRC: " + item.SourceName + ", Type: " + item.Type + ", MSG: " + item.Message); 
    }
  } 
  
  Log.PopLogFolder();
}

/**
 * Log list of runnning processes ordered by CPU 
 *
 * @param Max amount of loged processes, -1 for all
 */
function LogProcesses(Max)
{
  Log.AppendFolder("Windows Rinning Processes");
  
  var wmiService = GetObject("WinMgmts:{impersonationLevel=impersonate}!\\\\.\\root\\cimv2");
  var objectsList = wmiService.ExecQuery("select * from win32_perfformatteddata_perfproc_process");

  if (objectsList.Count > 0) 
  { 
    var topProcess = new Array(); 
    var eObjectsList = new Enumerator(objectsList);
    
    for (; !eObjectsList.atEnd(); eObjectsList.moveNext()) {
      var item = eObjectsList.item();
      var memory = 0;
      
      var perfDataList = wmiService.ExecQuery("Select * from Win32_Process Where ProcessID = " + item.IDProcess );
      var ePerfDataList = new Enumerator(perfDataList);
      for (;!ePerfDataList.atEnd();ePerfDataList.moveNext())
      {
        var objPerfData=ePerfDataList.item();
        memory = objPerfData.WorkingSetSize/1048576 ;
      }
      topProcess.push({Name:item.Name, CPU:item.PercentProcessorTime, Memory:memory});
    }
    topProcess.sort(function sort(a,b)
      {
        return b.CPU - a.CPU;
      });

    if (Max == -1) Max = topProcess.length; 
    for(var i = 0; i < Max; i++)
    {
      Log.Message("PROCESS: " + topProcess[i].Name + ", MEMORY:" + aqString.Format("%.2f" ,topProcess[i].Memory) + ", CPU: " + topProcess[i].CPU);
    }
  }
  Log.PopLogFolder();
}

/**
 * Log System State
 *
 */
function LogSystemState()
{
  Log.AppendFolder("System State");
  LogEvents(aqDateTime.AddDays(aqDateTime.Now(), -2));
  LogProcesses(-1);
  Log.PopLogFolder();
}

function VarToStr(data) {
  var typeID = GetVarType(data) 
  switch (typeID) {
    case 9:
      var res = "";
      for (var i in data){
        for (var j in data[i]){
          res += j + ":" + data[i][j] + " ";
        }
      }
      return res;
    default:
      return aqConvert.VarToStr(data);
  }
} 