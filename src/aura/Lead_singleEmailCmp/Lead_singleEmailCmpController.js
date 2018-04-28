({
	doinit : function(component, event, helper) {
        //get_currentAcc
	  var action = component.get("c.get_email_body");
        action.setCallback(this,function(data){
               var emailBody = data.getReturnValue();
         	component.set("v.email_body",emailBody);
            
        });
               $A.enqueueAction(action);
      
        
        
	  var actionAcc = component.get("c.get_currentLead");
        actionAcc.setParams({
           recid :component.get("v.recordId")
        });
        actionAcc.setCallback(this,function(data){
               var Acc = data.getReturnValue();
         	component.set("v.CurrentAcc",Acc);
            
        });
               $A.enqueueAction(actionAcc);
      
    },
    send_email : function(component, event, helper){
       
        var allids = [];
     //   alert('component.get("v.recordId") '+component.get("v.recordId"));
        allids.push(component.get("v.recordId"));
         var action = component.get("c.sendEmail");
        action.setParams({
            EmailSubject:component.get("v.Subject"),
            EmailBody:component.get("v.email_body"),
            TypeOfEmail:component.get("v.TypeOfEmail"),
            sel_account:allids,
            attachmentbody:  encodeURIComponent(component.get('v.fileString')),
            attachmentName:component.get('v.fileName'),
            listAtts:JSON.stringify(component.get('v.All_attachments'))
        });
        action.setCallback(this,function(data){
               var return_val = data.getReturnValue();
       //    alert(return_val+'rt');
         component.set("v.Success_msg",true);
       
        });
               $A.enqueueAction(action);
        
    },
    upload_attachment:function(component,event,helper){
        
        var fileInput = component.find("myFile").getElement();
    	var file = fileInput.files[0];
        console.log('file ',file);
   		var helperis = helper;
   var fileName = file.name;
        var fr = new FileReader();
      //  fr.readAsText(file);  
       fr.readAsDataURL(file);  
       	fr.onload = function() {
       //     alert();
            var fileContents = fr.result;
    	    var base64Mark = 'base64,';
            var dataStart = fileContents.indexOf(base64Mark) + base64Mark.length;
		//	var dataStart = fileContents.indexOf(base64Mark) + base64Mark.length;

            fileContents = fileContents.substring(dataStart);
          
            component.set('v.fileString',fileContents);
            component.set('v.fileName',fileName);
           var allAtt =  component.get('v.All_attachments');
           // alert(allAtt.length);
            var newAtt = {
                fileOrder: allAtt.length+1,
                FileName :fileName,
                FileBody :fileContents
            };
           allAtt.push(newAtt);
            component.set('v.All_attachments',allAtt);
            
            allAtt.length == 5 ? component.set('v.Max_attachmentsAdded',true):component.set('v.Max_attachmentsAdded',false);
         

        };
    },
    removeAttahment : function(component,event,helper){
      //  alert(event.target.id);
        var removed_att = event.target.id;
    var allAtt =  component.get('v.All_attachments');
        for(var i=0;i<allAtt.length;i++){
            if(allAtt[i].fileOrder == removed_att){
                alert('Yes sddsds');
              //  allAtt.pop[allAtt[i].fileOrder];
                allAtt.splice(i, 1);
                component.set('v.Max_attachmentsAdded',false);
            }
            
        }
        component.set('v.All_attachments',allAtt);
    
},
    EmailTypeChanged:function(component,event,helper){
        
        
   var selAcc = component.get("v.CurrentAcc");
        var emailType = component.get("v.TypeOfEmail");
         var inputCmp = component.find("inputCmp");

        if(emailType !='--None--'){
          //  component.set("v.isDisabled","false");
          //  
            if(emailType =='Personal Email' ){
                if( selAcc.Email ==undefined || selAcc.Email==''){
                    
                    
                     component.set("v.isDisabled","true");
                     inputCmp.set("v.errors", [{message:"Personal Email Not exist for this Account"}]);
                }else{
                    component.set("v.isDisabled","false");
                    inputCmp.set("v.errors", null);

                }
            }
            
            else       if(emailType =='Official Email' ){
                if( selAcc.Official_Email__c ==undefined || selAcc.Official_Email__c==''){
                    
           			          inputCmp.set("v.errors", [{message:"Official Email Not exist for this Account"}]);
                    
                    component.set("v.isDisabled","true");
                    
                }else{
                    component.set("v.isDisabled","false");
                               inputCmp.set("v.errors", null);

          
                }
            }
        }else{
                      component.set("v.isDisabled","true");
          
                   inputCmp.set("v.errors", null);

        }
    },
})