@isTest(SeeAllData=true) 
    public class TestSingleEmailOpportunitycontroller{
    public static testMethod void testPositive() {
    Test.StartTest();
    //create Opportunity
    Opportunity opp = New Opportunity();
    opp.Name='Test Opportunity';
    opp.Type__c='Retirement Plan';  
    opp.Account_Type__c='401(k)';
    opp.Selling_Business__c='Yes';
    opp.Personal_Email__c='Test@richtext.com';
    opp.Personal_Phone__c='9765342167';
    opp.StageName='Qualification';
    opp.closedate=Date.newInstance(2017, 12, 9);
    insert opp;
    
    //Insert Attachment
    Attachment attachment =new Attachment();
    attachment.ParentId=opp.id;
    attachment.Name='dummy.txt';
    attachment.body=Blob.valueOf('Unit Test Attachment Body');
    insert attachment;
    
    
    //insert EmailTrackingObject
    Email_Tracking__c  emailObj1 = new Email_Tracking__c();
    emailObj1.Email_Type__c='--None--';
    emailObj1.Opportunity__c=opp.id;
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    insert emailObj1;
    
    Apexpages.StandardController stdController = new Apexpages.StandardController(opp);  
    SingleEmailOpportunitycontroller controller= new   SingleEmailOpportunitycontroller(stdController);
    
    PageReference pageRef = Page.SendEmailOnOpportunity;
    pageRef.getParameters().put('id', String.valueOf(opp.Id));
    system.Test.setCurrentPage(pageRef);
    
       controller.acc=opp;
       controller.AttachmentId=attachment.Id;
       controller.selectedEmail='--None--';
       controller.emailSubject='test subject';
       controller.emailBody='test body';
       controller.strImageBlob='str';
       controller.renderPeronsal=true;
       controller.renderwork=true;
       controller.emailObj=emailObj1;
       controller.getItems();
       controller.contentType ='application/vnd.oasis.opendocument.text';
       controller.dosubmit();
       
    
    Test.StopTest();   
    }
    
    public static testMethod void testPersonalEmail() {
    Test.StartTest();
    //create Opportunity
    Opportunity opp = New Opportunity();
    opp.Name='Test Opportunity';
    opp.Type__c='Retirement Plan';  
    opp.Account_Type__c='401(k)';
    opp.Selling_Business__c='Yes';
    opp.Personal_Email__c='Test@richtext.com';
    opp.Personal_Phone__c='9765342167';
    opp.StageName='Qualification';
    opp.closedate=Date.newInstance(2017, 12, 9);
    insert opp;
    
    //Insert Attachment
    Attachment attachment =new Attachment();
    attachment.ParentId=opp.id;
    attachment.Name='dummy.txt';
    attachment.body=Blob.valueOf('Unit Test Attachment Body');
    insert attachment;
    
    
    //insert EmailTrackingObject
    Email_Tracking__c  emailObj1 = new Email_Tracking__c();
    emailObj1.Email_Type__c='Personal Email';
    emailObj1.Opportunity__c=opp.id;
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    emailObj1.Email_Subject__c='Test Sub';
    emailObj1.Email_Body__c='Test Body';
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    insert emailObj1;
    
    Apexpages.StandardController stdController = new Apexpages.StandardController(opp);  
    SingleEmailOpportunitycontroller controller= new   SingleEmailOpportunitycontroller(stdController);
    
    PageReference pageRef = Page.SendEmailOnOpportunity;
    pageRef.getParameters().put('id', String.valueOf(opp.Id));
    system.Test.setCurrentPage(pageRef);
    
       controller.acc=opp;
       controller.AttachmentId=attachment.Id;
       controller.selectedEmail='--None--';
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
    //create Opportunity
    Opportunity opp = New Opportunity();
    opp.Name='Test Opportunity';
    opp.Type__c='Retirement Plan';  
    opp.Account_Type__c='401(k)';
    opp.Selling_Business__c='Yes';
    opp.Personal_Email__c='Test@richtext.com';
    opp.Personal_Phone__c='9765342167';
    opp.StageName='Qualification';
    opp.closedate=Date.newInstance(2017, 12, 9);
    opp.Work_Email__c='Test@richtexts.com';
    insert opp;
    
    //Insert Attachment
    Attachment attachment =new Attachment();
    attachment.ParentId=opp.id;
    attachment.Name='dummy.txt';
    attachment.body=Blob.valueOf('Unit Test Attachment Body');
    insert attachment;
    
    
    //insert EmailTrackingObject
    Email_Tracking__c  emailObj1 = new Email_Tracking__c();
    emailObj1.Email_Type__c='Work Email';
    emailObj1.Opportunity__c=opp.id;
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    emailObj1.Email_Subject__c='Test Sub';
    emailObj1.Email_Body__c='Test Body';
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    insert emailObj1;
    
    Apexpages.StandardController stdController = new Apexpages.StandardController(opp);  
    SingleEmailOpportunitycontroller controller= new   SingleEmailOpportunitycontroller(stdController);
    
    PageReference pageRef = Page.SendEmailOnOpportunity;
    pageRef.getParameters().put('id', String.valueOf(opp.Id));
    system.Test.setCurrentPage(pageRef);
    
       controller.acc=opp;
       controller.AttachmentId=attachment.Id;
       controller.selectedEmail='Work Email';
       controller.emailSubject='test subject';
       controller.emailBody='test body';
       controller.strImageBlob='str';
       controller.renderPeronsal=true;
       controller.renderwork=true;
       controller.emailObj=new Email_Tracking__c();
       controller.emailObj.Email_Type__c='Work Email';
       controller.emailObj.Opportunity__c=opp.id;
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
    //create Opportunity
    Opportunity opp = New Opportunity();
    opp.Name='Test Opportunity';
    opp.Type__c='Retirement Plan';  
    opp.Account_Type__c='401(k)';
    opp.Selling_Business__c='Yes';
    opp.Personal_Email__c='Test@richtext.com';
    opp.Personal_Phone__c='9765342167';
    opp.StageName='Qualification';
    opp.closedate=Date.newInstance(2017, 12, 9);
    opp.Work_Email__c='Test@richtexts.com';
    insert opp;
    
    //Insert Attachment
    Attachment attachment =new Attachment();
    attachment.ParentId=opp.id;
    attachment.Name='dummy.txt';
    attachment.body=Blob.valueOf('Unit Test Attachment Body');
    insert attachment;
    
    
    //insert EmailTrackingObject
    Email_Tracking__c  emailObj1 = new Email_Tracking__c();
    emailObj1.Email_Type__c='Work Email';
    emailObj1.Opportunity__c=opp.id;
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    emailObj1.Email_Subject__c='Test Sub';
    emailObj1.Email_Body__c='Test Body';
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    insert emailObj1;
    
    Apexpages.StandardController stdController = new Apexpages.StandardController(opp);  
    SingleEmailOpportunitycontroller controller= new   SingleEmailOpportunitycontroller(stdController);
    
    PageReference pageRef = Page.SendEmailOnOpportunity;
    pageRef.getParameters().put('id', String.valueOf(opp.Id));
    system.Test.setCurrentPage(pageRef);
    
      
       controller.AttachmentId=attachment.Id;
       controller.selectedEmail='Work Email';
       controller.emailSubject='test subject';
       controller.emailBody='test body';
       controller.strImageBlob='str';
       controller.renderPeronsal=true;
       controller.renderwork=true;
       controller.emailObj= new Email_Tracking__c();
       controller.emailObj.Email_Type__c='Work Email';
       controller.emailObj.Opportunity__c=opp.id;
       controller.emailObj.Attachment__c=String.valueOf(attachment.Id);
       controller.emailObj.Email_Subject__c='Test Sub';
       controller.emailObj.Email_Body__c='Test Body';
       controller.emailObj.Attachment__c=String.valueOf(attachment.Id);
       
        controller.acc=opp;
        /*controller.acc.Name='Test Opportunity';
        controller.acc.Type__c='Retirement Plan';  
        controller.acc.Account_Type__c='401(k)';
        controller.acc.Selling_Business__c='Yes';
        controller.acc.Personal_Email__c='Test@richtext.com';
        controller.acc.Personal_Phone__c='9765342167';
        controller.acc.StageName='Qualification';
        controller.acc.closedate=Date.newInstance(2017, 12, 9);
        controller.acc.Work_Email__c='Test@richtexts.com';*/
        controller.getItems();
        controller.contentType ='application/vnd.oasis.opendocument.text';
         
        
        controller.showEmail();
        controller.sendEmail();
         controller.dosubmit();
         controller.upload();
    
    Test.StopTest();   
    }
    
    }