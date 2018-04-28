global class ReplyEmailHandler implements Messaging.InboundEmailHandler {
    public String strImageBlob;
    public blob b;
    //Getting Inbound Email
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
    Email_Object__c feedback= new Email_Object__c ();
    system.debug('inside reply handler method');
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    try{
 	 feedback.Account__c =[SELECT Id FROM Account WHERE Account_Official_Email__c= :email.fromAddress OR Account_Personal_Email__c= :email.fromAddress LIMIT 1].id;
    system.debug('>>>>>>>>>'+feedback.Account__c);
    feedback.Email_Body__c =   email.plainTextBody;
    feedback.Email_Status__c='Replied Email';
    feedback.Email_Message_Type__c='Mass Email';
    feedback.Email_Subject__c=email.subject;
    try{
    blob b = blob.toPDF(email.plainTextBody);
     Attachment attachment = new Attachment();
              attachment.Name =''+system.now()+'.pdf';
              attachment.Body = b;
              attachment.ParentId = feedback.Account__c;
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
              attachment.ParentId = feedback.Account__c;
              insert attachment;
              feedback.Attachment__c=attachment.id;
            }
        }
        
          if(email.binaryAttachments != null)
        {
            for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
              Attachment attachment = new Attachment();
             
              attachment.Name = bAttachment.fileName;
              attachment.Body = bAttachment.body;
              attachment.ParentId = feedback.Account__c;
              insert attachment;
              feedback.Attachment__c=attachment.id;
            }
        }
     insert feedback;
    result.success=true;
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
              replyContent.ParentId = feedback.Account__c;
              replyContent.ContentType='application/pdf';
              insert replyContent;
             // feedback.Email_Attachment_Content__c=replyContent.id; ReplyEmailContenetPdf__c
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