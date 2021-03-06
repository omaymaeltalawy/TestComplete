//USEUNIT Private_Utils

/**
 * Return true if clipboard contains text, otherwise false
 * 
 * @param Text Text to search, could be regular expression
 * @return {bool} Result 
 */
function ClipboardContents(Text)
{
  return Private_Utils.StringMatches(NameMapping.Sys.Clipboard, Text);
}

/**
 * Log a message is clipboard contains text
 * 
 * @param Text Text to search, could be regular expression
 */
function VerifyClipboardContents(Text)
{ 
  if(ClipboardContents(Text))
  {
    Log.Checkpoint("The Clipboard Contents contains the Text " + Text);
  }
  else
  {
    Log.Error("The Clipboard Contents NOT contains the Text " + Text);
  }
}

/**
 * Waits for clipboard to contains text and log message
 * 
 * @param Text Text to search, could be regular expression
 * @param Timeout Timeout
 */
function WaitForClipboardContents(Text, Timeout)
{
  Private_Utils.WaitFor(
    "Waiting for clipboard to contains test \"" + Text + "\"",
    "The Clipboard Contents contains the Text \"" + Text + "\"",
    "The Clipboard Contents NOT contains the Text \"" + Text + "\"",
    function() { return ClipboardContents(Text); },
    Timeout);
}