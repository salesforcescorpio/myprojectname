({
	doinit : function(component, event, helper) {
        
	  var actionOpp = component.get("c.get_currentOpp");
        actionOpp.setParams({
           recid :component.get("v.recordId")
        });
        actionOpp.setCallback(this,function(data){
               var Opp = data.getReturnValue();
         	component.set("v.CurrentOpp",Opp);
            
        });
               $A.enqueueAction(actionOpp);
      
    },
    
    EmailTypeChanged:function(component,event,helper){
        
        
   var selAcc = component.get("v.CurrentOpp");
        var emailType = component.get("v.TypeOfEmail");
         var inputCmp = component.find("inputCmp");

        if(emailType !='--None--'){
          //  component.set("v.isDisabled","false");
          //  
            if(emailType =='Personal Email' ){
                if( selAcc.Personal_Email__c ==undefined || selAcc.Personal_Email__c==''){
                    
                     component.set("v.EmailIs","");
                     component.set("v.isDisabled","true");
                     inputCmp.set("v.errors", [{message:"Personal Email Not exist for this Opportunity"}]);
                }else{
                    component.set("v.isDisabled","false");
                    inputCmp.set("v.errors", null);
					 component.set("v.EmailIs",selAcc.Personal_Email__c);
                }
            }
            
            else       if(emailType =='Work Email' ){
                if( selAcc.Work_Email__c ==undefined || selAcc.Work_Email__c==''){
                    
           			          inputCmp.set("v.errors", [{message:"Work Email Not exist for this Opportunity"}]);
                    
                    component.set("v.isDisabled","true");
                    component.set("v.EmailIs",""); 
                }else{
                    component.set("v.EmailIs",selAcc.Work_Email__c);
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
            ac : component.get('v.CurrentOpp'),
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