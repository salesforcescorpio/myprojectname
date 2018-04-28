({
	doinit : function(component, event, helper) {
		console.log('All Accounts ');
        console.log(component.get("v.AllAccounts"));
        var action = component.get("c.get_email_body");
        action.setCallback(this,function(data){
               var emailBody = data.getReturnValue();
         	component.set("v.email_body",emailBody);
            
        });
               $A.enqueueAction(action);
        
        
         var actionAcc = component.get("c.get_AccountsforPopup");
        actionAcc.setParams({
            AccIds:component.get("v.Sel_accounts")
        });
        actionAcc.setCallback(this,function(data){
              console.log('>>>>>>>> <<<<<< ',data.getReturnValue());
         	component.set("v.AllAccounts", data.getReturnValue());
            
        });
               $A.enqueueAction(actionAcc);
   
    },close_popup:function(component, event, helper){
        component.set("v.show_popup",false);
    },
    send_email : function(component, event, helper){
       
        alert('send email');
        debugger;
         var action = component.get("c.sendEmail");
        action.setParams({
            EmailSubject:component.get("v.Subject"),
            EmailBody:component.get("v.email_body"),
            TypeOfEmail:component.get("v.TypeOfEmail"),
            sel_account:component.get("v.Sel_accounts"),
            attachmentbody:  encodeURIComponent(component.get('v.fileString')),
            attachmentName:component.get('v.fileName'),
            listAtts:JSON.stringify(component.get('v.All_attachments'))
        });
        action.setCallback(this,function(data){
               var return_val = data.getReturnValue();
           alert(return_val+' rt');
         component.set("v.Success_msg",true);
       
        });
               $A.enqueueAction(action);
        
    },
    
    switch_tab:function(component,event,helper){
    //    alert(event.target.id);
        component.set("v.tab_selected",event.target.id);
        if(event.target.id =='TabA'){
            component.set("v.tab_A",true);
             component.set("v.tab_B",false);
        }else{
            component.set("v.tab_A",false);
             component.set("v.tab_B",true);
        }
    },
    
    upload_attachment_new:function(component,event,helper){
    helper.save(component);
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
            if(allAtt[i].FileBody == removed_att){
         //       alert('Yes sddsds');
              //  allAtt.pop[allAtt[i].fileOrder];
                allAtt.splice(i, 1);
                component.set('v.Max_attachmentsAdded',false);
            }
            
        }
        component.set('v.All_attachments',allAtt);
        var action =component.get("c.delete_att");
        action.setParams({
            "att":removed_att
        });
        
        action.setCallback(this,function(data){
            
        });
        $A.enqueueAction(action);
    
},
})