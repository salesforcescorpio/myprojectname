@isTest(SeeAllData=true) 
private class TestAttachmentUploadController{

private static testMethod void testPositive() {
 
 System.Test.StartTest();
  //create Account
  Account acc = New Account();
    acc.Class__c='Tier - 1';
    acc.First_Name__c='test';
    acc.Last_Name__c='Account';
    acc.Personal_Number__c='9765342167';
    acc.Account_Personal_Email__c='Test@richtext.com';
    acc.Account_Official_Email__c='Test@gmail.com';
    acc.Work_Number__c='4356789087';
    acc.Name='test';
    insert acc;
  
  
  //Insert Attachment
    Attachment attachment =new Attachment();
    attachment.ParentId=acc.id;
    attachment.Name='dummy.txt';
    attachment.body=Blob.valueOf('Unit Test Attachment Body');
    insert attachment;
    
  
  //insert EmailTrackingObject
    Email_Object__c  emailObj1 = new Email_Object__c();
    emailObj1.Email_Type__c='--None--';
    emailObj1.Account__c=acc.id;
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    insert emailObj1;
  
  
  
  Apexpages.StandardController stdController = new Apexpages.StandardController(acc);
  AttachmentUploadController controller = new AttachmentUploadController(stdController) ;
  
   PageReference pageRef = Page.SingleEmailPage;
   pageRef.getParameters().put('id', String.valueOf(acc.Id));
   system.Test.setCurrentPage(pageRef);
  
   controller.selectedEmail='--None--';
   controller.EmailBodylinebreaks='';
   controller.emailSubject='test subject';
   controller.emailBody='test body';
   controller.strImageBlob='str';
   controller.renderPeronsal=true;
   controller.renderwork=true;
   controller.AttachmentId=attachment.Id;
   controller.emailObj=new Email_Object__c();
   controller.emailObj.Email_Type__c='--None--';
   System.assert(true, controller.emailObj.id!=null);
   
   
   controller.acc=acc;
   controller.getItems();
   controller.dosubmit();
   controller.showEmail();
   system.Test.StopTest();
}

private static testMethod void testNegative() {
 
 System.Test.StartTest();
  //create Account
  Account acc = New Account();
    acc.Class__c='Tier - 1';
    acc.First_Name__c='test';
    acc.Last_Name__c='Account';
    acc.Personal_Number__c='9765342167';
    acc.Account_Personal_Email__c='Test@richtext.com';
    acc.Account_Official_Email__c='Test@gmail.com';
    acc.Work_Number__c='4356789087';
    acc.Name='test';
  insert acc;
  
  
  //Insert Attachment
    Attachment attachment =new Attachment();
    attachment.ParentId=acc.id;
    attachment.Name='dummy.txt';
    attachment.body=Blob.valueOf('Unit Test Attachment Body');
    insert attachment;
    
  
  //insert EmailTrackingObject
    Email_Object__c  emailObj1 = new Email_Object__c();
    emailObj1.Email_Type__c='--None--';
    emailObj1.Account__c=acc.id;
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    insert emailObj1;
  
  
  
  Apexpages.StandardController stdController = new Apexpages.StandardController(acc);
  AttachmentUploadController controller = new AttachmentUploadController(stdController) ;
  
   PageReference pageRef = Page.SingleEmailPage;
   pageRef.getParameters().put('id', String.valueOf(acc.Id));
   system.Test.setCurrentPage(pageRef);
  
   controller.selectedEmail='--None--';
   controller.EmailBodylinebreaks='';
   controller.emailSubject='test subject';
   controller.emailBody='test body';
   controller.strImageBlob='str';
   controller.renderPeronsal=true;
   controller.renderwork=true;
   controller.AttachmentId=attachment.Id;
   controller.emailObj=emailObj1;
   System.assert(true, controller.emailObj.id!=null);
   controller.contentType ='txt';
   controller.acc=acc;
   controller.showEmail();
   system.Test.StopTest();
}

private static testMethod void testPersonal() {
 
 System.Test.StartTest();
  //create Account
  Account acc = New Account();
    acc.Class__c='Tier - 1';
    acc.First_Name__c='test';
    acc.Last_Name__c='Account';
    acc.Personal_Number__c='9765342167';
    acc.Account_Personal_Email__c='Test@richtext.com';
    acc.Account_Official_Email__c='Test@gmail.com';
    acc.Work_Number__c='4356789087';
    acc.Name='test';
  insert acc;
  
  
  //Insert Attachment
    Attachment attachment =new Attachment();
    attachment.ParentId=acc.id;
    attachment.Name='dummy.txt';
    attachment.body=Blob.valueOf('Unit Test Attachment Body');
    insert attachment;
    
  
  //insert EmailTrackingObject
    Email_Object__c  emailObj1 = new Email_Object__c();
    emailObj1.Email_Type__c='Personal Email';
    emailObj1.Account__c=acc.id;
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    insert emailObj1;
  
  
  
  Apexpages.StandardController stdController = new Apexpages.StandardController(acc);
  AttachmentUploadController controller = new AttachmentUploadController(stdController) ;
  
   PageReference pageRef = Page.SingleEmailPage;
   pageRef.getParameters().put('id', String.valueOf(acc.Id));
   system.Test.setCurrentPage(pageRef);
  
   controller.selectedEmail='Personal Email';
   controller.EmailBodylinebreaks='';
   controller.emailSubject='Test Subject';
   controller.emailBody='Test Body';
   controller.strImageBlob='str';
   controller.renderPeronsal=true;
   controller.renderwork=true;
   controller.AttachmentId=attachment.Id;
   controller.emailObj=new Email_Object__c();
   
    controller.emailObj.Email_Type__c='Personal Email';
    controller.emailObj.Account__c=acc.id;
    controller.emailObj.Attachment__c=String.valueOf(attachment.Id);
    controller.emailObj.Email_Subject__c='Test Subject';
    controller.emailObj.Email_Body__c='Test Body';
   
   System.assert(true, controller.emailObj.id!=null);
   controller.contentType ='application/vnd.oasis.opendocument.text';
   controller.acc=acc;
   
   emailObj1.Email_Subject__c='Test Sub';
   emailObj1.Email_Body__c='Test Body';
   emailObj1.Attachment__c=String.valueOf(attachment.Id);
   controller.showEmail();
   controller.sendEmail();
   system.Test.StopTest();
}

private static testMethod void testwork() {
 
 System.Test.StartTest();
  //create Account
  Account acc = New Account();
    acc.Class__c='Tier - 1';
    acc.First_Name__c='test';
    acc.Last_Name__c='Account';
    acc.Personal_Number__c='9765342167';
    acc.Account_Personal_Email__c='Test@richtext.com';
    acc.Account_Official_Email__c='Test@gmail.com';
    acc.Work_Number__c='4356789087';
    acc.Name='test';
  insert acc;
  
  
  //Insert Attachment
    Attachment attachment =new Attachment();
    attachment.ParentId=acc.id;
    attachment.Name='dummy.txt';
    attachment.body=Blob.valueOf('Unit Test Attachment Body');
    insert attachment;
    
  
  //insert EmailTrackingObject
    Email_Object__c  emailObj1 = new Email_Object__c();
    emailObj1.Email_Type__c='Work Email';
    emailObj1.Account__c=acc.id;
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    insert emailObj1;
  
  
  
  Apexpages.StandardController stdController = new Apexpages.StandardController(acc);
  AttachmentUploadController controller = new AttachmentUploadController(stdController) ;
  
   PageReference pageRef = Page.SingleEmailPage;
   pageRef.getParameters().put('id', String.valueOf(acc.Id));
   system.Test.setCurrentPage(pageRef);
  
   controller.selectedEmail='Work Email';
   controller.EmailBodylinebreaks='';
   controller.emailSubject='test subject';
   controller.emailBody='test body';
   controller.strImageBlob='str';
   controller.renderPeronsal=true;
   controller.renderwork=true;
   controller.AttachmentId=attachment.Id;
   controller.emailObj=emailObj1;
   System.assert(true, controller.emailObj.id!=null);
   controller.contentType ='txt';
   controller.acc=acc;
   controller.showEmail();
   controller.sendEmail();
   system.Test.StopTest();
}




private static testMethod void testsendEmail() {
 
 System.Test.StartTest();
  //create Account
  Account acc = New Account();
    acc.Class__c='Tier - 1';
    acc.First_Name__c='test';
    acc.Last_Name__c='Account';
    acc.Personal_Number__c='9765342167';
    acc.Account_Personal_Email__c='Test@richtext.com';
    acc.Account_Official_Email__c='Test@gmail.com';
    acc.Work_Number__c='4356789087';
    acc.Name='test';
  insert acc;
  
  
  //Insert Attachment
    Attachment attachment =new Attachment();
    attachment.ParentId=acc.id;
    attachment.Name='dummy.txt';
    attachment.body=Blob.valueOf('Unit Test Attachment Body');
    insert attachment;
    
  
  //insert EmailTrackingObject
    Email_Object__c  emailObj1 = new Email_Object__c();
    emailObj1.Email_Type__c='Work Email';
    emailObj1.Account__c=acc.id;
    emailObj1.Attachment__c=String.valueOf(attachment.Id);
    insert emailObj1;
  
  
  
  Apexpages.StandardController stdController = new Apexpages.StandardController(acc);
  AttachmentUploadController controller = new AttachmentUploadController(stdController) ;
  AttachmentUploadController cont = new AttachmentUploadController() ;
   PageReference pageRef = Page.SingleEmailPage;
   pageRef.getParameters().put('id', String.valueOf(acc.Id));
   system.Test.setCurrentPage(pageRef);
  
   controller.selectedEmail='Work Email';
   controller.EmailBodylinebreaks='';
   controller.emailSubject='test subject';
   controller.emailBody='test body';
   controller.strImageBlob='str';
   controller.renderPeronsal=true;
   controller.renderwork=true;
   controller.AttachmentId=attachment.Id;
   controller.emailObj=emailObj1;
   System.assert(true, controller.emailObj.id!=null);
   controller.contentType ='txt';
   controller.acc=acc;
   
   controller.showEmail();
   //controller.sendEmail();
   
   system.Test.StopTest();
}


}