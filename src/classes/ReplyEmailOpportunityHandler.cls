global class ReplyEmailOpportunityHandler implements Messaging.InboundEmailHandler {
    public String strImageBlob;
    public blob b;
    //Getting Inbound Email
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
    Email_Tracking__c feedback= new Email_Tracking__c();
    system.debug('inside reply handler of the opportunity method');
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    try{
        feedback.Opportunity__c=[SELECT Id FROM Opportunity  WHERE Personal_Email__c= :email.fromAddress OR Work_Email__c= :email.fromAddress LIMIT 1].id;
        system.debug('>>>>>>>>>'+feedback.Opportunity__c);
        feedback.Email_Body__c =   email.plainTextBody;
        feedback.Email_Status__c='Replied Email';
        feedback.Email_Message_Type__c='Single Email';
        feedback.Email_Subject__c=email.subject;
        
         try{
    blob b = blob.toPDF(email.plainTextBody);
     Attachment attachment = new Attachment();
             
              attachment.Name =''+system.now()+'.pdf';
              attachment.Body = b;
              attachment.ParentId = feedback.Opportunity__c;
              insert attachment;
    feedback.ReplyEmailContenetPdf__c = attachment.id;
    }catch(Exception ex){}
        
        
    
    if(email.textAttachments != null)
        {
            // Save attachments, if any
            for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
              Attachment attachment = new Attachment();
             
              attachment.Name = tAttachment.fileName;
              attachment.Body = Blob.valueOf(tAttachment.body);
              attachment.ParentId = feedback.Opportunity__c;
              insert attachment;
              system.debug('attachment>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+attachment.id);
              feedback.Attachment__c=attachment.id;
            }
        }
        
          if(email.binaryAttachments != null)
        {
            for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
              Attachment attachment = new Attachment();
             
              attachment.Name = bAttachment.fileName;
              attachment.Body = bAttachment.body;
              attachment.ParentId = feedback.Opportunity__c;
              insert attachment;
              system.debug('attachment>>>>>>>>>>>>>>>>>>>>>>>>>>'+attachment.id);
              feedback.Attachment__c=attachment.id;
            }
        }
     insert feedback;
     
    result.success=true;
    
    system.debug('feedback.id'+feedback.id);
    system.debug('feedback.Attachment__c'+feedback.Attachment__c);
    
    if(email.plainTextBody != null && email.plainTextBody != ''){
    strImageBlob=email.plainTextBody;
    b=EncodingUtil.base64Decode(strImageBlob.replaceFirst('data:image/png;base64,',''));
    //b=EncodingUtil.base64Decode(strImageBlob);
    system.debug('strImageBlob'+strImageBlob);
    }
    if(strImageBlob!=null && b!=null){
        Attachment replyContent= new Attachment();
             
              replyContent.Name = 'reply content';
              //replyContent.Body = Blob.valueOf(strImageBlob);
              replyContent.Body=b;
              replyContent.ParentId = feedback.Opportunity__c;
              replyContent.ContentType='application/pdf';
              insert replyContent;
              feedback.ReplyEmailContenetPdf__c=replyContent.id;
              system.debug('replyContent.Body'+replyContent.Body);
              system.debug('reply attachment id'+feedback.ReplyEmailContenetPdf__c);
              
    }
    }
    catch(Exception e){
        result.success=false;
    }
    return result;
    
}

}