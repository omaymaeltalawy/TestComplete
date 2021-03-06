/**
 * Termiate all applications to have VM in clear state
 *
 */
function TerminateAllApplications()
{
  Log.AppendFolder("TerminateAllApplications");
  
  var applications = [
    //Default list
    {ObjectType: "Browser"},
    {ProcessName: "notepad"},
    {ProcessName: "notepad++"},
    {ProcessName: "EXCEL"},
    {ProcessName: "WINWORD"},
    {ProcessName: "TSVNCache"},
    //Application specified processes
    {ProcessName: "TenroxSoftware.DBAdmin.App"}
  ];
  
  //Terminate applications
  for (var i in applications)
  {
    var application = applications[i];
    
    var propNames = [];
    var propValues = [];
    
    for (var prop in application)
    {
      propNames.push(prop);
      propValues.push(application[prop]);
    }
    
    var process = Sys.FindChild(propNames, propValues);
    while (process.Exists)
    {
      delay(5000, "Validate is process in closing state");
      if(process.Exists)
      {
        Log.Message("Terminate process \"" + process.ProcessName + "\"");
        process.Terminate();
      }
      process = Sys.FindChild(propNames, propValues);  
    } 
  }
  
  //Closing all opened windows
  var explorers = Sys.FindAllChildren("ProcessName", "explorer");
  explorers = (new VBArray(explorers)).toArray();
  
  for (var i in explorers)
  {
    var explorer = explorers[i];
    
    var form = explorer.FindChild(["WndClass", "Visible"], ["CabinetWClass", true]);
    while (form.Exists)
    {
      delay(5000, "Validate is form in closing state");
      if(form.Exists)
      {
        Log.Message("Closing explorer form \"" + form.WndCaption + "\"");
        form.Close();
      }
      form = explorer.FindChild(["WndClass", "Visible"], ["CabinetWClass", true]);  
    }
  }
  
  Log.PopLogFolder();
}