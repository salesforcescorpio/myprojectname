@isTest(seeAllData=true)
    public Class ReplyEmailHandlerMassLead_Test
   {
     //Test Method for main class
     static testMethod void TestinBoundEmail()
    {
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
     
     
     Lead l = new lead();
     l.FirstName= 'test';
     l.LastName= 'test';
     l.Email = 'someaddress@email.com';
     l.LeadSource = 'web';
     l.Company = 'test';
     insert l;
     
      // call the email service class and test it with the data in the testMethod
      ReplyEmailHandlerMassLead testInbound=new ReplyEmailHandlerMassLead();
      testInbound.handleInboundEmail(email, env);
       

   }
}