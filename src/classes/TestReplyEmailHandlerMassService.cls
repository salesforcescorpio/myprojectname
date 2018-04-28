@isTest(SeeAllData=true) 
    public class TestReplyEmailHandlerMassService{

static testMethod void myTestMethod() {

   // Create a new email, envelope object and Attachment
   Messaging.InboundEmail email = new Messaging.InboundEmail();
   Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
   Messaging.InboundEmail.BinaryAttachment inAtt = new Messaging.InboundEmail.BinaryAttachment();
   Messaging.InboundEmail.textAttachment txtAtt = new Messaging.InboundEmail.textAttachment();
   
   email.subject = 'test';
   env.fromAddress = 'user@acme.com';
   

   // set the body of the attachment
   inAtt.body = blob.valueOf('test');
   inAtt.fileName = 'my attachment name';
   inAtt.mimeTypeSubType = 'plain/txt';
   
   
   txtAtt.body='test';
   txtAtt.fileName = 'my attachment name';
   txtAtt.mimeTypeSubType = 'plain/txt';
   

   email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] {inAtt }; 
   email.HTMLbody='testingggg the body'; 
   email.plainTextBody='testingggg the body';
   
   email.textAttachments = new Messaging.inboundEmail.TextAttachment[] { txtAtt };
   email.HTMLbody='testingggg the body'; 
   email.plainTextBody='testingggg the body';
   
   
   // call the class and test it with the data in the testMethod
   ReplyEmailHandlerMass edr = new ReplyEmailHandlerMass();

   edr.handleInboundEmail(email, env );                      
}    
}