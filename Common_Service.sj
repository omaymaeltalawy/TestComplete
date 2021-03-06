//USEUNIT Private_Utils

/**
 * Start service by DisplayName during the pecified timeout or log an error
 *
 * @param ServiceDisplayName Display Name of service
 * @param Timeout Timeout 
 */
function StartService(ServiceDisplayName, Timeout)
{
  var service = GetService(ServiceDisplayName);
  if (service == null) 
  {
    Log.Error("The " + ServiceDisplayName + " service was not found");
  }
  
  //Start the Service
  service.StartService();
  
  Private_Utils.WaitFor(
    "Waiting for service to start",
    "Service \"" + ServiceDisplayName + "\" started",
    "Service \"" + ServiceDisplayName + "\" failed to start",
    function() { return ServiceState(ServiceDisplayName, "Running"); },
    Timeout);
}

/**
 * Stop service by DisplayName during the pecified timeout or log an error
 *
 * @param ServiceDisplayName Display Name of service
 * @param Timeout Timeout
 */
function StopService(ServiceDisplayName, Timeout)
{
  var service = GetService(ServiceDisplayName);
  if (service == null) 
  {
    Log.Error("The " + ServiceDisplayName + " service was not found");
  }

  //Stop the Service
  service.StopService();
  
  Private_Utils.WaitFor(
    "Waiting for service to stop",
    "Service \"" + ServiceDisplayName + "\" stopped",
    "Service \"" + ServiceDisplayName + "\" failed to stop",
    function() { return ServiceState(ServiceDisplayName, "Stopped"); },
    Timeout);
}

/**
 * Returns service WMI object by service Display Name
 *
 * @param ServiceDisplayName Display name of service
 * @returns WMIService
 */
function GetService(ServiceDisplayName)
{
  var wmiService = GetObject("WinMgmts:{impersonationLevel=impersonate}!\\\\.\\root\\cimv2");
  var objectsList = wmiService.InstancesOf("Win32_Service");

  if (objectsList.Count > 0) 
  {  
    var eObjectsList = new Enumerator(objectsList);
    for (; !eObjectsList.atEnd(); eObjectsList.moveNext()) 
    {
      var item = eObjectsList.item();
      if (Private_Utils.StringMatches(item.DisplayName, ServiceDisplayName))
      {
        return item;
      }
    }
  }
  return null;
}

/**
 * Verify service state
 *
 * @param ServiceDisplayName Display name of service
 * @param State Display name of service
 * @returns bool
 */
function ServiceState(ServiceDisplayName, State)
{
  var service = GetService(ServiceDisplayName);
  if (service == null) 
  {
    Log.Error("The " + ServiceDisplayName + " service was not found");
  }
  
  return service.State == State;
}

/**
 * Verify service state and log message or error
 *
 * @param ServiceDisplayName Display name of service
 * @param State Display name of service
 */
function VerifyServiceState(ServiceDisplayName, State)
{
  if(ServiceState(ServiceDisplayName, State))
  {
    Log.Checkpoint("The State of the Service is " + State);
  }
  else
  {
    Log.Error("The State of the Service is NOT " + State);
  }
}