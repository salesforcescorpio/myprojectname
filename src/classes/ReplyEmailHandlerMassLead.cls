global class ReplyEmailHandlerMassLead implements Messaging.InboundEmailHandler {
    
    //Getting Inbound Email
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
    system.debug('inside ReplyEmailHandlerMassOpportunity ');
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    Email_Tracking__c feedback= new Email_Tracking__c ();
    feedback.lead__c=[SELECT Id FROM Lead WHERE Email= :email.fromAddress or Official_Email__c=:email.fromAddress LIMIT 1].id;
    feedback.Email_Body__c =   email.plainTextBody;
    feedback.Email_Message_Type__c='Mass Email';
    feedback.Email_Status__c='Replied Email';
    feedback.Email_Subject__c=email.subject;
    system.debug('feedback.lead__c'+feedback.lead__c);
    try{
    blob b = blob.toPDF(email.plainTextBody);
     Attachment attachment = new Attachment();
              attachment.Name =''+system.now()+'.pdf';
              attachment.Body = b;
              attachment.ParentId = feedback.lead__c;
              insert attachment;
    feedback.ReplyEmailContenetPdf__c = attachment.id;
    }catch(Exception ex){}
   system.debug('email.textAttachments'+email.textAttachments) ;
    if(email.textAttachments != null){
        
            // Save attachments, if any
            for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
              Attachment attachment = new Attachment();
             
              attachment.Name = tAttachment.fileName;
              attachment.Body = Blob.valueOf(tAttachment.body);
              attachment.ParentId = feedback.lead__c;
              insert attachment;
              feedback.Attachment__c=attachment.id;
              system.debug('feedback.Attachment__c'+feedback.Attachment__c);
            }
        }
        system.debug('email.binaryAttachments'+email.binaryAttachments) ;
          if(email.binaryAttachments != null){
        
            for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
              Attachment attachment = new Attachment();
             
              attachment.Name = bAttachment.fileName;
              attachment.Body = bAttachment.body;
              attachment.ParentId = feedback.lead__c;
              insert attachment;
              feedback.Attachment__c=attachment.id;
              system.debug('feedback.Attachment__c'+feedback.Attachment__c);
            }
        }
    
    insert feedback;
    system.debug('feedback.Attachment__c'+feedback.Attachment__c);
    return result;
    
}
}