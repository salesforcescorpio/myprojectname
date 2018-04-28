global class ReplyEmailHandlerMassOpportunity implements Messaging.InboundEmailHandler {
    
    //Getting Inbound Email
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
    system.debug('inside ReplyEmailHandlerMassOpportunity ');
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    Email_Tracking__c feedback= new Email_Tracking__c ();
    feedback.Opportunity__c =[SELECT Id FROM Opportunity WHERE Work_Email__c= :email.fromAddress OR Personal_Email__c= :email.fromAddress LIMIT 1].id;
    feedback.Email_Body__c =   email.plainTextBody;
    feedback.Email_Message_Type__c='Mass Email';
    feedback.Email_Status__c='Replied Email';
    feedback.Email_Subject__c=email.subject;
    system.debug('feedback.Opportunity__c'+feedback.Opportunity__c);
    try{
    blob b = blob.toPDF(email.plainTextBody);
     Attachment attachment = new Attachment();
              attachment.Name =''+system.now()+'.pdf';
              attachment.Body = b;
              attachment.ParentId = feedback.Opportunity__c;
              insert attachment;
    feedback.ReplyEmailContenetPdf__c = attachment.id;
    }catch(Exception ex){}
    
    if(email.textAttachments != null){
        
            // Save attachments, if any
            for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
              Attachment attachment = new Attachment();
             
              attachment.Name = tAttachment.fileName;
              attachment.Body = Blob.valueOf(tAttachment.body);
              attachment.ParentId = feedback.Opportunity__c;
              insert attachment;
              feedback.Attachment__c=attachment.id;
            }
        }
        
          if(email.binaryAttachments != null){
        
            for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
              Attachment attachment = new Attachment();
             
              attachment.Name = bAttachment.fileName;
              attachment.Body = bAttachment.body;
              attachment.ParentId = feedback.Opportunity__c;
              insert attachment;
              feedback.Attachment__c=attachment.id;
            }
        }
    
    insert feedback;
    system.debug('feedback.Attachment__c'+feedback.Attachment__c);
    return result;
    
}
}