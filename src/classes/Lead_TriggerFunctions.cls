public without sharing class Lead_TriggerFunctions {

        /*
        *  Method name:                 SendEmailToLead
        *  @description:                Sends an email to lead when a lead source is web to lead
        *  @param -                     List of new Leads

        */ 
        public static void SendEmailToLead(List<Lead> lstNewCases){
        system.debug('in here  at the apex class');
        RecordType callTaskRecordType;
        Task initialCall;        
        List<String> lstCasesActiveStatus = new List<String>();
        List<Lead> lstCasesInActiveStatus = new List<Lead>();
        List<Task> lstTasks = new List<Task>(); 
        blob b;
      //  String strImageBlob;
        Id leadId;
        Lead objLead = new Lead();
        EmailTemplate E = new Emailtemplate();
        E = [select id,body,Subject,HtmlValue 
             from Emailtemplate where name =: 'Duplicate Lead Template'];
        system.debug('-----------------------'+E);
        for(Lead objCase : lstNewCases){ 
               system.debug('objCase.LeadSource'+objCase.LeadSource); 
               system.debug('Email'+objCase.Email); 
          if(objCase.LeadSource!=null && objCase.LeadSource=='Web-to-lead' && (objCase.Email!=null ||objCase.Phone!=null) ){
               lstCasesActiveStatus.add(objCase.Email);  }  
                leadId = objCase.id;
                objLead =objCase;
        }
            //List<Lead> lstLead =new List<Lead>( [Select id,phone,email from lead]); 
            if(!Test.isRunningTest()){
            for(Lead o :[Select id,phone,email from lead]){
                if(objLead!=null){
                    //if((objLead.Phone!=null || objLead.email!=null ) && o.phone!=null || o.email!=null){
                       if((objLead.Phone!=null || objLead.email!=null ) && (o.phone!=null || o.email!=null)){ 
                        if(objLead.phone==o.phone ||objLead.email==o.email){
                        system.debug('objLead.phone'+objLead.phone);
                        system.debug('objLead.email'+objLead.email);
                        system.debug('o.phone'+o.phone);
                        system.debug('o.email'+o.email);
                        system.debug('>>>>>>>>if this is dupe do not send first email again!!!');
                            return;
                        }
                    }
                }
            
            }   
        }
            
            
           /*Send mail */
            system.debug('>>>>>>>>>>>>>>>>>>>>>>'+lstCasesActiveStatus);
            system.debug('>>>>>>>>>>>>>>>>>>>>>>'+lstCasesActiveStatus.size());
            //if(lstCasesActiveStatus!=null && lstCasesActiveStatus.size()>0){
             //  b = [select id, Name, isPublic,body, FolderID from Document where Name='Mark Broucher' ].body;
            //   strImageBlob=EncodingUtil.base64Encode(b);
               Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
               mail.setToAddresses(lstCasesActiveStatus);
               mail.setSenderDisplayName('Arlington Hall Support');
               //EmailTemplate et=[Select id,name from EmailTemplate where DeveloperName=:'Duplicate_Lead_Template'];
               //mail.setTemplateId(E.id);
             //  mail.setTargetObjectId(leadId);
               Messaging.EmailFileAttachment attachment= new Messaging.EmailFileAttachment();
               attachment.setBody(b);
               attachment.setFileName('broucher.pdf');
               //mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment});
               string replacedname =  E.HtmlValue;
               //replacedname = replacedname.Replace('{!Leadname}',lstNewCases[0].FirstName+'&nbsp;'+lstNewCases[0].LastName);
                  replacedname = replacedname.Replace('{!Leadname}','&nbsp;'+lstNewCases[0].LastName);
               mail.setHtmlBody(replacedname); 
               mail.setSubject(E.Subject);
               
               system.debug('replacedname'+replacedname);
               system.debug('FName'+objLead.First_Name__c);
               system.debug('LName'+objLead.Last_Name__c);
               system.debug('lstNewCases              '+lstNewCases[0].FirstName);
               system.debug('lstNewCases     '+lstNewCases[0].LastName);
               //mail.setHtmlBody(E.body);
             /*  mail.setHtmlBody('Hi </br>'+ ''+ 'Thanks for visiting Investing at Arlington Hall and expressing interest in our current investment opportunities at Arlington Hall. We want to let  you know that we have received your application for the investment information.</br>'+
                                              +'What happens next?  You will receive a [pdf][link to the video] shortly.  Should you need to contact us, you may do so at info.arlingtonhall@gmail.com. </br>'
                                              +'Thanks, and Great job on reaching out to boost your investment savvy!'); 
               
               mail.setHtmlBody('<html><body> Hi  &nbsp;&nbsp;' +objLead.First_Name__c+'&nbsp;'+objLead.Last_Name__c+ '<br>' +'<br>'   +'Thanks for visiting Investing at Arlington Hall and expressing interest in our current investment opportunities at Arlington Hall.' +'<br>'+'We want to let  you know that we have received your application for the investment information.' +'<br>'+
                                                            +'<br>' +'What happens next?  You will receive a [pdf][link to the video] shortly.Should you need to contact us, you may do so at' +'<br>'+' info.arlingtonhall@gmail.com.'+'<br>' +
                                                             +'<br>'+'Thanks, and Great job on reaching out to boost your investment savvy!'+'<br>'+'Arlington Hall Support'); 
                   */                                                        
               if(lstCasesActiveStatus!=null && lstCasesActiveStatus.size()>0){
               
               Messaging.SendEmailResult[] result =Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                    if(result[0].success){
                        System.debug('The email was sent successfully.');
                     }
                else {
                        System.debug('The email failed to send: '
                          + result[0].errors[0].message);
                     }
                     }
                   //} 
                   
                }


            
            
            /*
              Method name:                 SendEmailToLeadOnDuplicateDetection
            *  @description:                Send an email when a duplicate email/phone number is given by user 
            *  @param - LstCasesnew:           Lst of new Leads
            *  
            */ 
                public static void SendEmailToLeadOnDuplicateDetection(List<Lead> lstLeadsnew){
                    system.debug('inside SendEmailToLeadOnDuplicateDetection method');
                    List<Lead> lstLead =new List<Lead>( [Select id,phone,email from lead]);
                    system.debug('>>>'+lstLead.size());
                    List<Lead> lstLeaddupe = new List<Lead>();
                    List<Messaging.SingleEmailMessage> messages=new list<Messaging.SingleEmailMessage>();
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    List<String> toAddresses = new List<String>();
                    List<Id> lstids = new List<Id>();
            for(Lead objlead: lstLeadsnew){
            system.debug('objlead.email>>> ' + objlead.email +'>>>'+'objlead.phone >>'+ objlead.phone);
            system.debug('FName'+objLead.First_Name__c);
               system.debug('LName'+objLead.Last_Name__c);
               system.debug('FName'+objLead.FirstName);
               system.debug('LName'+objLead.LastName);
            
            for(Lead objleadInstance: lstLead){
            system.debug('objleadInstance.email>>> ' + objleadInstance.email +'>>>'+'objleadInstance.phone >>'+ objleadInstance.phone);
                 if(objlead.email!= null || objlead.Phone!=null){
                    system.debug('if entered values are not nulls');
                if( (objlead.email!=null && objlead.email == objleadInstance.email) || (objlead.phone!=null && objlead.Phone == objleadInstance.phone)){
                    System.debug('lead Exist');
                    objlead.IsDuplicate__c=true;
                    lstLeaddupe.add(objleadInstance);
                }
               } 
            }
            
            }
            system.debug(' to find the dup' + lstLeaddupe.size());
            Emailtemplate E1 = new Emailtemplate();
            E1 = [select id,name,htmlvalue,Subject from Emailtemplate where name ='Duplicate Lead Template2'];
            if(lstLeaddupe!=null || lstLeaddupe.size()>0){
             for(Lead ob: lstLeaddupe ){
                   toAddresses.add(ob.email);
                   lstids.add(ob.id);
                    }
                    system.debug(' toAddresses >>'+ toAddresses.size());           
               }
               mail.setToAddresses(toAddresses);
               mail.setSenderDisplayName('Arlington Hall Support');
              // EmailTemplate et=[Select id,name from EmailTemplate where DeveloperName=:'Duplicate_Lead_Template'];
             //  mail.setTemplateId(et.id);
             //  mail.setTargetObjectId(lstids[0]);
             // system.debug('Template Name'+et.name);
             //mail.setSubject('Thank you for contacting Arlington Hall financial advisor once again!!!');
             
               string replacedname1 =  E1.HtmlValue;
               //replacedname1 = replacedname1.Replace('{!Lead.First_Name__c}',lstLeadsnew[0].FirstName+'&nbsp;'+lstLeadsnew[0].LastName);
               replacedname1 = replacedname1.Replace('{!Lead.First_Name__c}','&nbsp;'+lstLeadsnew[0].LastName);
               mail.setHtmlBody(replacedname1 );
              
               
              
              
              try{
              Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail}); 
            if(r[0].success){
                System.debug('The email was sent successfully.');
            }
            else {
                    System.debug('The email failed to send: '
              + r[0].errors[0].message);
            }
        }
           Catch(Exception e){
                  system.debug('in exception'+e);
            }
    }
            
            
          /*  public static void SendEmailToDuplicateLead(List<Lead> lstLeadsnew){
                 List<Lead> lstLeaddupe = new List<Lead>();
                 List<String> toAddresses= new List<String>();
                 Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                //You may need to filter this a bit more if you have a very large number of accounts    
                map<Id,Lead> existingLeadMap = new  map<Id,Lead>([Select Id, Name,phone,email From Lead Where phone!= null and email !=null]); 
                for(Lead objlead: lstLeadsnew){
                    if(objlead.phone== existingLeadMap.get(objlead.Id).Phone || objlead.email == existingLeadMap.get(objlead.Id).email ){
                       lstLeaddupe.add(existingLeadMap.get(objlead.Id));
                }
                
            }
           
            for(Lead ob: lstLeaddupe){
                   toAddresses.add(ob.email);
                   
                    }
                mail.setToAddresses(toAddresses);
                mail.setSenderDisplayName('Arlington Hall Support');
                mail.setSubject('Thank you for contacting Arlington Hall financial advisor once again!!!');
             mail.setHtmlBody('Hi'+'<br/>'+ ''+ 'Thankyou for contacting us again!! We have already got your request and we are processing it.'+'<br/>'+'Arlington Hall Support'); 
              try{
                    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail}); 
                    if(r[0].success){
                        System.debug('The email was sent successfully.');
                    }
                    else {
                        System.debug('The email failed to send: '
                              + r[0].errors[0].message);
                    }
            
                }
                Catch(Exception e){
                  system.debug('in exception'+e);
              }
        } */
        
        /*
      *  Method name:                 deleteDuplicateLead
      *  @description:                This method is declared future as it has to delete the duplicate leads
      *  @param -                     List of lead Ids  which are created are duplicate
      
    */
    @Future
    Public Static void deleteDuplicateLead(List<ID> LstLeadID){
    System.debug('>>>>>>> '+LstLeadID );
        Id userId = userinfo.getUserId();  
        //Added condition to delete duplicate lead records.
        List<Lead> LstLead = [select id,IsDuplicate__c from Lead where id in : LstLeadID and IsDuplicate__c=true];
        delete LstLead;     
    } 
}