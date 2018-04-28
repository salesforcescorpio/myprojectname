({
	doinit : function(component, event, helper) {
        
	  var actionAcc = component.get("c.get_currentAcc");
        actionAcc.setParams({
           recid :component.get("v.recordId")
        });
        actionAcc.setCallback(this,function(data){
               var Acc = data.getReturnValue();
         	component.set("v.CurrentAcc",Acc);
            
        });
               $A.enqueueAction(actionAcc);
      
    },
    
    EmailTypeChanged:function(component,event,helper){
        
        
   var selAcc = component.get("v.CurrentAcc");
        var emailType = component.get("v.TypeOfEmail");
         var inputCmp = component.find("inputCmp");

        if(emailType !='--None--'){
          //  component.set("v.isDisabled","false");
          //  
            if(emailType =='Personal Email' ){
                if( selAcc.Account_Personal_Email__c ==undefined || selAcc.Account_Personal_Email__c==''){
                    
                     component.set("v.EmailIs","");
                     component.set("v.isDisabled","true");
                     inputCmp.set("v.errors", [{message:"Personal Email Not exist for this Account"}]);
                }else{
                    component.set("v.isDisabled","false");
                    inputCmp.set("v.errors", null);
					 component.set("v.EmailIs",selAcc.Account_Personal_Email__c);
                }
            }
            
            else       if(emailType =='Official Email' ){
                if( selAcc.Account_Official_Email__c ==undefined || selAcc.Account_Official_Email__c==''){
                    
           			          inputCmp.set("v.errors", [{message:"Official Email Not exist for this Account"}]);
                    
                    component.set("v.isDisabled","true");
                    component.set("v.EmailIs",""); 
                }else{
                    component.set("v.EmailIs",selAcc.Account_Official_Email__c);
                    component.set("v.isDisabled","false");
                               inputCmp.set("v.errors", null);

          
                }
            }
        }else{
                      component.set("v.isDisabled","true");
          
                   inputCmp.set("v.errors", null);

        }
    },
    
    send_invite_fun:function(component){
       // alert();
         var action = component.get("c.send_invite");
        action.setParams({
            des:component.get('v.Descriptionis'),
            st:component.get('v.startDate'),
            et:component.get('v.endDate'),
            Loca : component.get('v.Locationis'),
            to : component.get("v.EmailIs"),
            ac : component.get('v.CurrentAcc'),
            Email_typeis:component.get("v.TypeOfEmail")
        });
        action.setCallback(this,function(data){
           // alert('call back 123') ;
            //console.log(data);
                     component.set("v.Success_msg",true);

        });
               $A.enqueueAction(action);
     
    },
})