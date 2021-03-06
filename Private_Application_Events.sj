//USEUNIT Private_Log
//USEUNIT Private_Setup

function GeneralEvents_OnLogError(Sender, LogParams)
{
  if (ProjectSuite.Variables.TestExecute)
  {
    if(!ProjectSuite.Variables.VariableExists("TerminateATCs")) 
    {
      ProjectSuite.Variables.AddVariable("TerminateATCs", "Boolean");
      Private_Log.LogSystemState();
    }
    
    ProjectSuite.Variables.TerminateATCs = true;  
  }
  
  Runner.Stop(true);
}

function GeneralEvents_OnStartTest(Sender)
{
  var ATCName = aqFileSystem.GetFileNameWithoutExtension(Project.FileName);
  var SuiteName = aqFileSystem.GetFileNameWithoutExtension(ProjectSuite.FileName);
  
  //Initialize System Suites or CommonPreCondition in Test Suite
  if ((SuiteName === "InstallerSuite"
    || SuiteName === "InitializationSuite"
    || SuiteName === "FinalizationSuite"
    || ATCName === "CommonPreCondition")
    //Only for first item in Project
    && (Project.TestItems.ItemCount === 0
    || Project.TestItems.Current == null
    || Project.TestItems.Current.Name === Project.TestItems.TestItem(0).Name))
  {
    InitialiseSuite();
  }
  
  //Cleanup value for second run to debug after CB 
  if (ProjectSuite.Variables.VariableExists("TerminateATCs")
    && ATCName === "CommonPreCondition")
  {
    ProjectSuite.Variables.RemoveVariable("TerminateATCs");
  }
  
  if (ProjectSuite.Variables.TestExecute 
    && ProjectSuite.Variables.VariableExists("TerminateATCs")
    && ProjectSuite.Variables.TerminateATCs
    && ATCName !== "CommonPreCondition"
    && ATCName !== "CommonPostCondition"
    && ATCName !== "ReportGenerator")
  {
    Log.Error("ATC terminated because previous ATC failed."); 
  }
  
  //Only for first item in Project
  if (Project.TestItems.ItemCount === 0
    || Project.TestItems.Current == null
    || Project.TestItems.Current.Name === Project.TestItems.TestItem(0).Name)
  {
    Private_Setup.InitialiseProject();
  }
}

function GeneralEvents_OnStopTest(Sender)
{
  
}

function GeneralEvents_OnLogWarning(Sender , LogParams)
{
  if (LogParams.Str === "The mapped item has the Extended Find attribute enabled."
    || LogParams.Str ===  "Ambiguous recognition of the tested object.")
  {
    Log.Message(LogParams.Str);
    LogParams.Locked  = true;
  }
}