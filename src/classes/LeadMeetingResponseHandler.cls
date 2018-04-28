global class LeadMeetingResponseHandler implements Messaging.InboundEmailHandler {


    //Getting Inbound Email
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
    system.debug('>>>>> '+email.fromAddress);
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    Meeting_Tracking__c feedback= new Meeting_Tracking__c();
    feedback.Lead__c =[SELECT Id FROM Lead WHERE Official_Email__c= :email.fromAddress OR Email= :email.fromAddress    LIMIT 1].id;
    feedback.Description__c =   email.plainTextBody;
    //feedback.Email_Message_Type__c='Mass Email';
    String emailBody = email.plainTextBody.toLowercase();
    String status;
    if(emailBody.contains('yes')){
        status = 'Accepted';
    }else{
            status = 'Rejected';
    
    }
    feedback.Start_Date_Time__c = system.today();
    feedback.End_Date_Time__c = system.today();
    feedback.Email_Type__c = 'Personal Email';
    feedback.Meeting_Invite_Status__c= status;
    feedback.Subject__c=email.subject;
    
    
    insert feedback;
    return result;
    
}




}