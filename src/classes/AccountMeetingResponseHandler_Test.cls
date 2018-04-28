@isTest
    public Class AccountMeetingResponseHandler_Test
   {
     //Test Method for main class
     static testMethod void TestinBoundEmail()
    {
    Account a = new Account();
a.name = 'test';
a.Account_Plan_Type__c = '401(k)';
a.Class__c = 'Tier - 1';
a.Client_Type__c = 'client';
a.Email__c = 'test@test.com';
a.First_Name__c = 'first';
a.Last_Name__c = 'last';
a.Source__c = 'Created From Lead';
a.Type__c = 'Retirement Plan';
a.Account_Official_Email__c = 'test@est.com';

insert a;

    
    
       Test.startTest();
      // create a new email and envelope object
       Messaging.InboundEmail email = new Messaging.InboundEmail() ;
       Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
      
       // setup the data for the email
      email.subject = 'Create Contact';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'email body\n2225256325\nTitle';
     
      // add an Binary attachment

      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

 
      // add an Text atatchment
 
      Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
      attachmenttext.body = 'my attachment text';
      attachmenttext.fileName = 'textfiletwo3.txt';
      attachmenttext.mimeTypeSubType = 'texttwo/plain';
      email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };
     
     
     Account l = new Account();
     l.Name= 'test';
     l.First_Name__c= 'test';
     l.Last_Name__c= 'test';
     l.Account_Personal_Email__c= 'someaddress@email.com';
    
     insert l;
     
      // call the email service class and test it with the data in the testMethod
      AccountMeetingResponseHandler testInbound=new AccountMeetingResponseHandler();
      testInbound.handleInboundEmail(email, env);
       

   }
}