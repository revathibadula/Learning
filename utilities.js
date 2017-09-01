function fnPopupWindow(URL,h,w)
{ 
    var strTitle ='Details';
    var strUrl = URL;
    var strOptions= 'menubar=no,toolbar=no,scrollbars=yes,status=yes,resizable=yes,height='+h+',width='+w+',left=300,top=0';
    window.open(strUrl,strTitle,strOptions).focus();
}
function fnValidateTime(StartTimeHH,StartTimeMM,EndTimeHH,EndTimeMM)
{
    var sh = parseInt(StartTimeHH);
    
    var sm = parseInt(StartTimeMM);
    
    var eh = parseInt(EndTimeHH);
    
    var em = parseInt(EndTimeMM);
    
    if(sh>eh){
        alert("Invalid Time. Please select again");
        return false;
    }else if(sh == eh && sm >= em){
        alert("Invalid Time. Please select again");
        return false;
    }else{
        return true;
    }
}  
function fnValidateDateTime(FromDate,ToDate,StartTimeHH,StartTimeMM,EndTimeHH,EndTimeMM)
{
    
    var sh = parseInt(StartTimeHH);
  
    var sm = parseInt(StartTimeMM);
    
    var eh = parseInt(EndTimeHH);
    
    var em = parseInt(EndTimeMM);
    if(FromDate > ToDate){
        alert("Start Date exceeds End Date. Please select again");
        return false;
    }else if(FromDate == ToDate){
            //Same day, validating time
            if(sh>eh){
                alert("Start Date exceeds End Date. Please select again");
                return false;
            }else if(sh == eh && sm >= em){
                alert("Start Date exceeds End Date. Please select again");
                return false;
            }else{
                return true;
            }
    }else{
        return true;
    }
}
function fnValidateDate(FromDate,ToDate)
{

    if(FromDate >= ToDate){
        alert("Start Date exceeds End Date. Please select again");
        return false;
    }else{
        return true;
    }
   
} 