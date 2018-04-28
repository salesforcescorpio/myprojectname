@isTest(SeeAllData=true) 
    public class TestSingleEmailLeadcontroller{
    public static testMethod void testPositive() {
    Test.StartTest();
    //create Lead
    Lead lead = New Lead();
    lead.FirstName ='FNAME';
    lead.LastName ='LnNAME';
    lead.Company='LEAD COMPANY';
    //lead.Type__c='Retirement Plan';  
    lead.Type__c=' Non-Retirement Plan ';
    lead.email='test.e@test.com';
    //List<Schema.PicklistEntry> ple = Schema.getGlobalDescribe().get('Lead').getDescribe().fields.getMap().get('Type').getDescribe().getPicklistValues();
   // String s =String.Valueof(ple);
    //if(s.contains('Both'))
   // {lead.Type__c=s;}
    insert lead;
    
    //Insert Attachment
    Attachment attachment =new Attachment();
    attachment.ParentId=lead.id;
    attachment.Name='dummy.txt';
    attachment.body=Blob.valueOf('Unit Test Attachment Body');
    insert attachment;
    
    
    //insert EmailTrackingObject
    Email_Tracking__c  emailObj1 = new Email_Tracking__c();
    emailObj1.Email_Type__c='--None--';
    emailObj1.lead__c=lead.id;
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    insert emailObj1;
    
    Apexpages.StandardController stdController = new Apexpages.StandardController(lead);  
    SingleEmailLeadcontroller controller= new   SingleEmailLeadcontroller(stdController);
    
    PageReference pageRef = Page.SendEmailOnOpportunity;
    pageRef.getParameters().put('id', String.valueOf(lead.Id));
    system.Test.setCurrentPage(pageRef);
        controller.emailObj.Email_Subject__c = 'test';
        controller.emailObj.Email_Body__c = 'test';
       controller.lead=lead;
       controller.AttachmentId=attachment.Id;
       controller.emailSubject='test subject';
       controller.emailBody='test body';
       controller.strImageBlob='str';
       controller.renderPeronsal=true;
       controller.renderwork=true;
       controller.emailObj=emailObj1;
       controller.getItems();
       controller.contentType ='application/vnd.oasis.opendocument.text';
       controller.dosubmit();
       controller.showEmail();
       controller.upload();
       
       try{
       controller.sendEmail();
       
       }catch(Exception ex){}
    
    Test.StopTest();   
    
    SingleEmailLeadcontroller ss =new  SingleEmailLeadcontroller();
    }
    
   /* public static testMethod void testPersonalEmail() {
    Test.StartTest();
    //create Lead
    Lead lead = New Lead();
    lead.Type__c='Retirement Plan';  
    insert lead;
    
    //Insert Attachment
    Attachment attachment =new Attachment();
    attachment.ParentId=lead.id;
    attachment.Name='dummy.txt';
    attachment.body=Blob.valueOf('Unit Test Attachment Body');
    insert attachment;
    
    
    //insert EmailTrackingObject
    Email_Tracking__c  emailObj1 = new Email_Tracking__c();
    emailObj1.Email_Type__c='Personal Email';
    emailObj1.lead__c=lead.id;
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    emailObj1.Email_Subject__c='Test Sub';
    emailObj1.Email_Body__c='Test Body';
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    insert emailObj1;
    
    Apexpages.StandardController stdController = new Apexpages.StandardController(lead);  
    SingleEmailLeadcontroller controller= new   SingleEmailLeadcontroller(stdController);
    
    PageReference pageRef = Page.SendEmailOnOpportunity;
    pageRef.getParameters().put('id', String.valueOf(lead.Id));
    system.Test.setCurrentPage(pageRef);
    
       controller.lead=lead;
       controller.AttachmentId=attachment.Id;
       controller.emailSubject='test subject';
       controller.emailBody='test body';
       controller.strImageBlob='str';
       controller.renderPeronsal=true;
       controller.renderwork=true;
       controller.emailObj=emailObj1;
       controller.getItems();
       controller.contentType ='application/vnd.oasis.opendocument.text';
         
        
        controller.showEmail();
        controller.dosubmit();
       
    
    Test.StopTest();   
    }
    
    
    public static testMethod void testWorkEmail() {
    Test.StartTest();
    //create Lead
    Lead lead = New Lead();
    lead.Type__c='Retirement Plan';  
    insert lead;
    
    //Insert Attachment
    Attachment attachment =new Attachment();
    attachment.ParentId=lead.id;
    attachment.Name='dummy.txt';
    attachment.body=Blob.valueOf('Unit Test Attachment Body');
    insert attachment;
    
    
    //insert EmailTrackingObject
    Email_Tracking__c  emailObj1 = new Email_Tracking__c();
    emailObj1.Email_Type__c='Work Email';
    emailObj1.lead__c=lead.id;
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    emailObj1.Email_Subject__c='Test Sub';
    emailObj1.Email_Body__c='Test Body';
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    insert emailObj1;
    
    Apexpages.StandardController stdController = new Apexpages.StandardController(lead);  
    SingleEmailLeadcontroller controller= new   SingleEmailLeadcontroller(stdController);
    
    PageReference pageRef = Page.SendEmailOnOpportunity;
    pageRef.getParameters().put('id', String.valueOf(lead.Id));
    system.Test.setCurrentPage(pageRef);
    
       controller.lead=lead;
       controller.AttachmentId=attachment.Id;
       controller.emailSubject='test subject';
       controller.emailBody='test body';
       controller.strImageBlob='str';
       controller.renderPeronsal=true;
       controller.renderwork=true;
       controller.emailObj=new Email_Tracking__c();
       controller.emailObj.Email_Type__c='Work Email';
       controller.emailObj.lead__c=lead.id;
       controller.emailObj.Attachment__c=String.valueOf(attachment.Id);
       controller.emailObj.Email_Subject__c='Test Sub';
       controller.emailObj.Email_Body__c='Test Body';
       controller.emailObj.Attachment__c=String.valueOf(attachment.Id);
       
       
       controller.getItems();
       controller.contentType ='application/vnd.oasis.opendocument.text';
         
        
        controller.showEmail();
        //controller.sendEmail();
         controller.dosubmit();
         controller.upload();
    
    Test.StopTest();   
    }
    
    
     public static testMethod void testNoneEmail() {
    Test.StartTest();
    //create Lead
    Lead lead = New Lead();
    lead.Type__c='Retirement Plan';  
    insert lead;
    
    //Insert Attachment
    Attachment attachment =new Attachment();
    attachment.ParentId=lead.id;
    attachment.Name='dummy.txt';
    attachment.body=Blob.valueOf('Unit Test Attachment Body');
    insert attachment;
    
    
    //insert EmailTrackingObject
    Email_Tracking__c  emailObj1 = new Email_Tracking__c();
    emailObj1.Email_Type__c='Work Email';
    emailObj1.lead__c=lead.id;
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    emailObj1.Email_Subject__c='Test Sub';
    emailObj1.Email_Body__c='Test Body';
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    insert emailObj1;
    
    Apexpages.StandardController stdController = new Apexpages.StandardController(lead);  
    SingleEmailLeadcontroller controller= new   SingleEmailLeadcontroller(stdController);
    
    PageReference pageRef = Page.SendEmailOnOpportunity;
    pageRef.getParameters().put('id', String.valueOf(lead.Id));
    system.Test.setCurrentPage(pageRef);
    
      
       controller.AttachmentId=attachment.Id;
       controller.emailSubject='test subject';
       controller.emailBody='test body';
       controller.strImageBlob='str';
       controller.renderPeronsal=true;
       controller.renderwork=true;
       controller.emailObj= new Email_Tracking__c();
       controller.emailObj.Email_Type__c='Work Email';
       controller.emailObj.lead__c=lead.id;
       controller.emailObj.Attachment__c=String.valueOf(attachment.Id);
       controller.emailObj.Email_Subject__c='Test Sub';
       controller.emailObj.Email_Body__c='Test Body';
       controller.emailObj.Attachment__c=String.valueOf(attachment.Id);
       
        controller.lead=lead;
        controller.getItems();
        controller.contentType ='application/vnd.oasis.opendocument.text';
         
        
        controller.showEmail();
        controller.sendEmail();
         controller.dosubmit();
         controller.upload();
    
    Test.StopTest();   
    } */
    
    }