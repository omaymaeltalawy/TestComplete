/**
 * Reads command line arguments and set values in suite variables
 *
 */
function InitialiseSuite()
{
  Log.AppendFolder("Suite Initialisation");
  var nArgs = BuiltIn.ParamCount();
  Log.Message("Total number of command-line arguments: " + nArgs);
  Log.Message("The fully-qualified name of the TestComplete executable: " + BuiltIn.ParamStr(0));
  
  var allowedValues = [
    {Name: "Browser", Type: "String", Default: "IE_32"},
    {Name: "RunType", Type: "String", Default: ""},
    {Name: "TestExecute", Type: "Boolean", Default: false},
    {Name: "Coverage", Type: "Boolean", Default: false}
  ];
  
  //Create variables if not exists
  for (var i = 0; i < allowedValues.length; i++)
  {
    if(!ProjectSuite.Variables.VariableExists(allowedValues[i].Name))
    {
      ProjectSuite.Variables.AddVariable(allowedValues[i].Name, allowedValues[i].Type);
      ProjectSuite.Variables.VariableByName(allowedValues[i].Name) = allowedValues[i].Default;
    }
  }
  
  if (aqString.Find(BuiltIn.ParamStr(0), "Bin\\TestExecute.exe") > -1)
  {
    ProjectSuite.Variables.TestExecute = true;
  }
  
  if (ProjectSuite.Variables.TestExecute)
  {
    //Init defaile values
    for (var i = 0; i < allowedValues.length; i++)
    {
      ProjectSuite.Variables.VariableByName(allowedValues[i].Name) = allowedValues[i].Default;
    }
    
    var tmpListSeparator = aqString.ListSeparator;
    aqString.ListSeparator = "=";
  
    //Override default values by command line paramters
    for (var i = 1; i <= nArgs ; i++)
    {
      Log.Message("Arg " + i + ": " + BuiltIn.ParamStr(i));
    
      for (var j = 0; j < allowedValues.length; j++)
      {
        if(aqString.Compare(aqString.GetListItem(BuiltIn.ParamStr(i), 0), "/" + allowedValues[j].Name, true) == 0)
        {
          switch (allowedValues[j].Type)
          {
            case "Boolean":
              ProjectSuite.Variables.VariableByName(allowedValues[j].Name) = aqConvert.VarToBool(aqString.GetListItem(BuiltIn.ParamStr(i), 1));
              break;
            default:  
              ProjectSuite.Variables.VariableByName(allowedValues[j].Name) = aqString.GetListItem(BuiltIn.ParamStr(i), 1);
              break;
          }
          break;
        }
      }
    }
    aqString.ListSeparator = tmpListSeparator;
  }
  
  Log.PopLogFolder();
}

/**
 * Setup projects based on Suite variables
 *
 */
function InitialiseProject()
{
  Log.AppendFolder("Project Initialisation")
  
  //Checking is TestedApps exists
  if (typeof TestedApps !== "undefined")
  {
  
    Log.Message("Browser: " + ProjectSuite.Variables.Browser);
    switch (ProjectSuite.Variables.Browser)
    {
      case "FF":
        if (Sys.OSInfo.Windows64bit)
        {
          path = "C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe";
        }
        else
        {
          path = "C:\\Program Files\\Mozilla Firefox\\firefox.exe";
        }
        break;
      case "IE_64":
        if (Sys.OSInfo.Windows64bit)
          path = "C:\\Program Files\\Internet Explorer\\IEXPLORE.exe";
        else
          Log.Error("64 bit browser not supported in non 64 bit OS.");
        break;
      case "IE_32":
      default:
        if (Sys.OSInfo.Windows64bit)
          path = "C:\\Program Files (x86)\\Internet Explorer\\IEXPLORE.exe";
        else
          path = "C:\\Program Files\\Internet Explorer\\IEXPLORE.exe";
        break; 
    }

    for (var i = 0; i < TestedApps.Count; i++)
    {
      var testedApplication = TestedApps.Items(i);
      
      if (testedApplication.Params == null
        && aqObject.IsSupported(testedApplication, "BrowserExecutable"))
      {
        Log.Error("Please uncheck \"Use special runtime object\" in TestedApps for \""
         + testedApplication.ItemName + "\"");
      }  
        
      if (testedApplication.Params != null
        && testedApplication.Params.ActiveParams.Name == "Web")
      {
        testedApplication.Params.ActiveParams.BrowserExecutable = path; 
      }
    }
  }
  Log.PopLogFolder();
}