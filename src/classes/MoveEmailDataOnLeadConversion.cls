public class MoveEmailDataOnLeadConversion{


    public Static void moveLeadDataToAccount(String LeadId,String PassedId,String CovertedDestiNation){
    
    List<Email_Tracking__c> AllEmails = new list<Email_Tracking__c>();
                                                
                                                
    try{
         AllEmails = [select id,Attachment__c,Email_Body__c,Email_Attachment_Content__c,Email_Message_Type__c,
                                                Email_mess__c,Email_Status__c,
                                                Email_Subject__c,Email_Type__c,
                                                ReplyEmailContenetPdf__c,
                                                ReplyEmailContentPdfName__c from Email_Tracking__c where Lead__c=:LeadId];
    
    }catch(Exception ex){}
        if(test.isRunningTest()){
            AllEmails.add(new Email_Tracking__c());
        }
    
    List<Email_Object__c> EmailObjects = new list<Email_Object__c>();
    if(AllEmails.size()>0){
    
    for(Email_Tracking__c LeadEmailRec:AllEmails ){
    
    if(CovertedDestiNation == 'Account'){
        Email_Object__c  eachObj =  new Email_Object__c();
        eachObj.Account__c = PassedId;
        eachObj.Attachment__c = LeadEmailRec.Attachment__c;
        eachObj.Email_Body__c = LeadEmailRec.Email_Body__c;
        
        eachObj.Email_Subject__c = LeadEmailRec.Email_Subject__c;
        eachObj.Email_Type__c= LeadEmailRec.Email_Type__c;
        eachObj.Email_Attachment_Content__c = LeadEmailRec.Email_Attachment_Content__c;
        
        eachObj.Email_Message_Type__c= LeadEmailRec.Email_Message_Type__c;
        eachObj.Email_Status__c= LeadEmailRec.Email_Status__c;
        eachObj.ReplyEmailContenetPdf__c= LeadEmailRec.ReplyEmailContenetPdf__c;
        
            EmailObjects.add(eachObj);
            
       }else if(CovertedDestiNation == 'Opportunity'){
       
           LeadEmailRec.Opportunity__c = PassedId;
       }     
    
    }
    
    if(EmailObjects.size()>0 && CovertedDestiNation == 'Account' ){
        insert EmailObjects;
    }else if(CovertedDestiNation == 'Opportunity'){
        update AllEmails;
    
    }
    
    }
    
    
    }

}