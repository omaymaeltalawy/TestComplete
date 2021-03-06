//********************************************************************************************
//  Description:    This function is used to verify the console text output
//  Arguments:      1- win:         The commandline window
//                  2- str:         The target string supposed showing in the console
//                  3- waitTime:    timeout for wait result
//  Developed By:   Zhe Yang
//  Scope:          Private
//  API :           void VerifyResult(win, waitTime)
//********************************************************************************************
function VerifyResult(win, str, waitTime)
{
    var timeOut = waitTime
    var time = 0
    do {
        aqUtils.Delay(500)
        time += 500
        if(time >= timeOut) {
            Log.Error("Failded to verify operation result in: " + win.wText)
            break
        }
    } while(!TextVerify(win, str))
}

//********************************************************************************************
//  Description:    This function is used to get the console`s wText and match it with given string
//  Arguments:      1- win:     The commandline window
//                  2- str:     The target string supposed showing in the console
//  Developed By:   Zhe Yang
//  Scope:          Private
//  API :           Boolean TextVerify(win, str)
//********************************************************************************************
function TextVerify(win, str)
{
    var text = win.wText
    var reg = new RegExp(str)
    var res = reg.test(text)
    return res
}