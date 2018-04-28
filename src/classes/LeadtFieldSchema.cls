public class LeadtFieldSchema {
       @AuraEnabled
    public static  map<String,list<String>> getLeadType(){
        map<String,list<String>> FieldAndSchema = new map<String,list<String>>();
        list<String> LeadTypes =  new list<String>();
        Schema.DescribeFieldResult fieldResult = Lead.Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
       {
         // AccountTypeValues.add(f.getValue());
          LeadTypes.add(f.getValue());
       }
        FieldAndSchema.put('LeadType',LeadTypes);
        
        
           //Lead Account Plan Type       
          list<String> LeadAccountPlanTypes =  new list<String>();
       
         Schema.DescribeFieldResult fieldResult1= Lead.Account_Plant_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple1 = fieldResult1.getPicklistValues();
        for( Schema.PicklistEntry f : ple1)
       {
         // AccountTypeValues.add(f.getValue());
          LeadAccountPlanTypes.add(f.getValue());
       }
         FieldAndSchema.put('LeadAccountPlanType',LeadAccountPlanTypes);
      
       //Lead Staus
         list<String> LeadStatus =  new list<String>();
       
        Schema.DescribeFieldResult fieldResult2= Lead.Status.getDescribe();
        List<Schema.PicklistEntry> ple2 = fieldResult2.getPicklistValues();
        for( Schema.PicklistEntry f : ple2)
       {
         // AccountTypeValues.add(f.getValue());
          LeadStatus.add(f.getValue());
       }
           FieldAndSchema.put('LeadStatus',LeadStatus);
     
       
       //   LeadSource
          list<String>  LeadSource =  new list<String>();
      
         Schema.DescribeFieldResult fieldResult3= Lead.LeadSource.getDescribe();
        List<Schema.PicklistEntry> ple3 = fieldResult3.getPicklistValues();
        for( Schema.PicklistEntry f : ple3)
       {
         // AccountTypeValues.add(f.getValue());
            LeadSource.add(f.getValue());
       }
        
            FieldAndSchema.put('LeadSource',LeadSource);
        
        //  Lead Rating
          list<String>  LeadRating =  new list<String>();
      
         Schema.DescribeFieldResult fieldResult4= Lead.Rating.getDescribe();
        List<Schema.PicklistEntry> ple4 = fieldResult4.getPicklistValues();
        for( Schema.PicklistEntry f : ple4)
       {
         // AccountTypeValues.add(f.getValue());
            LeadRating.add(f.getValue());
       }
        
            FieldAndSchema.put('LeadRating',LeadRating);
        
        //  Lead subsource
          list<String>  LeadSubSource =  new list<String>();
      
         Schema.DescribeFieldResult fieldResult5= Lead.Lead_sub_source__c.getDescribe();
        List<Schema.PicklistEntry> ple5 = fieldResult5.getPicklistValues();
        for( Schema.PicklistEntry f : ple5)
       {
         // AccountTypeValues.add(f.getValue());
            LeadSubSource.add(f.getValue());
       }
        
            FieldAndSchema.put('LeadSubSource',LeadSubSource);
        
          list<String> EmailType = new list<String>();
            EmailType.add('Official Email');
            EmailType.add('Personal Email');
          FieldAndSchema.put('EmailType',EmailType );
           
        return FieldAndSchema;
    }

   
    
     public class PagedResult {
        
        @AuraEnabled
        public Integer pageSize { get;set; }
        
        @AuraEnabled
        public Integer page { get;set; }
        
        @AuraEnabled
        public Integer total { get;set; }
        
        @AuraEnabled
        public List<Lead> Leads { get;set; }
        
    }
    @AuraEnabled
    public static  Lead get_currentLead(String recid){
        
        
        return [select id,Image_Url__c,name,First_Name__c,Type__c,Account_Plant_Type__c,Email,LeadSource,Lead_sub_source__c,Status,Rating,Official_Email__c from Lead where id=:recid limit 1];
    }

    @AuraEnabled
    public static PagedResult getAllLeads(Decimal pageSize, Decimal pageNumber) {
    //    Filter filter = (Filter) JSON.deserializeStrict(filters, FundController.Filter.class);
        Integer pSize = (Integer)pageSize;
      //  String key = '%' + filter.searchKey + '%';
        Integer offset = ((Integer)pageNumber - 1) * pSize;
        PagedResult r =  new PagedResult();
        r.pageSize = pSize;
        r.page = (Integer) pageNumber;
       r.Leads = [select id,Image_Url__c,name,First_Name__c,Type__c,Account_Plant_Type__c,Email,LeadSource,Lead_sub_source__c,Status,Rating,Official_Email__c  from Lead  where createdById =: userinfo.getUserId()];
                       r.total = r.Leads.size();
        return r;
    }
    
    
    @AuraEnabled
    public static PagedResult get_searchData(Decimal pageSize, 
                                             Decimal pageNumber,
                                             list<String> selType,
                                             list<String> selectedAccPlanType,
                                             list<String> selectedStatus,
                                             list<String> selectedSource,
                                              list<String> selectedRating,
                                             list<String> selectedSubSource,
                                             list<String> selectedEmailTypes  ){
      String Query = 'select id,Image_Url__c,name,First_Name__c,Type__c,Account_Plant_Type__c,Email,LeadSource,Lead_sub_source__c,Status,Rating,Official_Email__c  from Lead where createdById =\''+userinfo.getUserId()+'\'';
        if(selType!=null ){
            if(selType.size()> 0){
                Query += ' and Type__c in :selType';
                
            }
        }
        
          if(selectedAccPlanType!=null ){
            if(selectedAccPlanType.size()> 0){
                Query += ' and Account_Plant_Type__c  in :selectedAccPlanType';
                
            }
        }
        
        //status
          if(selectedStatus!=null ){
            if(selectedStatus.size()> 0){
                Query += ' and Status  in :selectedStatus';
                
            }
        }
        
        //Source
          if(selectedSource!=null ){
            if(selectedSource.size()> 0){
                Query += ' and LeadSource in :selectedSource';
                
            }
        }
                                                 
          //Rating                                       
          if(selectedRating!=null ){
            if(selectedRating.size()> 0){
                Query += ' and Rating in :selectedRating';
                
            }
        }
                                                 
          //subsource                                       
          if(selectedSubSource!=null ){
            if(selectedSubSource.size()> 0){
                Query += ' and Lead_sub_source__c in :selectedSubSource';
                
            }
        }
        
        if(selectedEmailTypes !=null){
            
            if(selectedEmailTypes.size()>0){
                
                
                if(selectedEmailTypes.size()==2){
                    
                        Query+= ' and Email !=\'\'';
                        Query+= ' and Official_Email__c !=\'\'';
                }
                else  if(selectedEmailTypes.size()==1){
                    if(selectedEmailTypes[0] !='Official Email'){
                               Query+= ' and Official_Email__c !=\'\'';
            
                    }else{
                                       Query+= ' and Official_Email__c !=\'\'';
                        
                    }
                }
            }
            
        }
        
        
        
        list<sObject> results = database.Query(Query);
            Integer pSize = (Integer)pageSize;
      //  String key = '%' + filter.searchKey + '%';
        Integer offset = ((Integer)pageNumber - 1) * pSize;
        PagedResult r =  new PagedResult();
        r.pageSize = pSize;
        r.page = (Integer) pageNumber;
        r.total = results.size();
        r.Leads = results;
        return r;

      //  return database.Query(Query);
    }
   @AuraEnabled
      public static String get_email_body(){
        
        return [ SELECT Id, Name,  HtmlValue FROM EmailTemplate where Name='Account_mass_email' limit 1].HtmlValue;
    } 
    
    @AuraEnabled
   public static String sendEmail(String EmailSubject,String EmailBody,list<String> TypeOfEmail,list<String> sel_account,String attachmentbody,String attachmentName,String listAtts){
    
       system.debug('inside send email');
       attachmentbody = EncodingUtil.urlDecode(attachmentbody, 'UTF-8');    
 list<multiple_attachments> AllAttsare = (list<multiple_attachments>)JSON.deserialize(listAtts, list<multiple_attachments>.class);
       
       String return_msg = '';
       System.debug('>>>><<<<<<<<<<<<< 1111 '+sel_account);
  List<Messaging.SingleEmailMessage>  myEmails = new List<Messaging.SingleEmailMessage>();
    list<String> Emails=  new List<String>();   
         List<Messaging.Emailfileattachment> fileAttachments  =new List<Messaging.Emailfileattachment>();
       list<Lead> sel_accs =  [select id,name,First_Name__c,Type__c,Account_Plant_Type__c,Email,LeadSource,Lead_sub_source__c,Status,Rating,Official_Email__c from lead where id in : sel_account];
       for(Lead acc :sel_accs){
  Emails=  new List<String>();   
             
          fileAttachments = new List<Messaging.Emailfileattachment>();
                                                  

    
        Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
        //attaching file
        for(multiple_attachments each_is:AllAttsare){
         Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
        efa.setFileName(each_is.FileName);
        efa.setBody(EncodingUtil.base64Decode(each_is.FileBody));
        fileAttachments.add(efa);
       system.debug('file efa -->  '+EncodingUtil.base64Decode(each_is.FileBody).size());
       
        }
       system.debug('file attachment -->  '+fileAttachments.size());
        
        if(TypeOfEmail.size() == 0 ||  TypeOfEmail.size()==2)
        {
            if(acc.Email!=null && acc.Email!=''){
            Emails.add(acc.Email);
            }
            if(acc.Official_Email__c!=null && acc.Official_Email__c!=''){
            Emails.add(acc.Official_Email__c);
            
            }
        }  
            
        else if(TypeOfEmail[0] == 'Official Email'){
        Emails.add(acc.Official_Email__c);
        }else if(TypeOfEmail[0] == 'Personal Email'){
        Emails.add(acc.Email);
        
     
        }
        System.debug('Emails >> '+Emails);
       if(Emails!=null  ){ 
      //  mail.setToAddresses(Emails);
      mail.setBccAddresses(Emails);
        mail.setSubject(EmailSubject);
        mail.setSaveAsActivity(false); 
        
        String s1=EmailBody.replace('{#user}',acc.First_Name__c);
        String linebreak=s1.replaceAll('\n', '<br/>');
        
        mail.setHtmlBody(linebreak);
        String currentUserEmail = UserInfo.getUserEmail();
        String[] ccAddresses = new String[] {currentUserEmail};
        mail.setCcAddresses(ccAddresses);
        mail.setReplyTo(label.ReplyEmailHandlerMassEmail);
        myEmails.add(mail);
           if(null !=attachmentbody)
             mail.setFileAttachments(fileAttachments);   
          
               
           }
    
   }     
     System.debug('sending  ');
      
     Messaging.SendEmailResult[] result =Messaging.sendEmail(myEmails);
       
         if(result[0].success){
            return_msg = 'success';
            
            save_emails(sel_accs,EmailSubject,EmailBody,attachmentName,blob.valueof(attachmentbody),fileAttachments);
            
       }else{
            return_msg = 'failed';
       
       }
  
            return return_msg;
    } 
    
    
    @AuraEnabled
    public static list<Lead> get_LeadsforPopup (list<String> LeadIds){
        
        return [select id,name,First_Name__c,Type__c,Account_Plant_Type__c,Email,LeadSource,Lead_sub_source__c,Status,Rating,Official_Email__c from Lead where id in : LeadIds];
    }

    
    
    /************************save email records******************/
    
    public static void  save_emails(list<Lead> selected_Accs,string EmailSubject,String EmailBody,String AttachmentName,Blob AttachmentBody,List<Messaging.Emailfileattachment> fileAttachments){
    
    list<Email_Tracking__c> emailRecs = new list<Email_Tracking__c>();
   Document doc = new Document();
    doc.isPublic=true;
    doc.Body = AttachmentBody;
    doc.Name = AttachmentName;
    doc.folderId=UserInfo.getUserId(); 
   // DataBase.saveResult docSaveResult = DataBase.insert(doc, false);
    system.debug(':::::::::::::::::::::::;'+doc);
        for(Lead each :selected_Accs){
        
            Email_Tracking__c individual = new Email_Tracking__c();
            individual.lead__c= each.Id;
           // individual.Email_Body__c = EmailBody;
            individual.Email_Subject__c = EmailSubject;
            individual.Email_Message_Type__c='Mass Email';
            individual.Email_Status__c='Sent Email';
            if(null !=AttachmentBody){
          //  individual.Attachment__c= doc.id;
           // individual.Email_Attachment_Content__c = EncodingUtil.base64Encode(AttachmentBody);
            // individual.Email_Attachment_Content__c = individual.Email_Attachment_Content__c.left(32760);
            }
            emailRecs.add(individual );
        }
        
        insert emailRecs;
        list<Attachment> AllAttachments = new list<Attachment>();
    for(Email_Tracking__c  eachEmail :emailRecs )  {
        for( Messaging.Emailfileattachment    eachAttachmet:fileAttachments ){
        
        Attachment attach = new Attachment();
attach.ParentId=eachEmail.id;
attach.ownerId=UserInfo.getUserId();
//attach.IsPrivate=true;
//attach.Description='Test Description';
attach.name=eachAttachmet.getFileName();
attach.Body=eachAttachmet.getBody();
        AllAttachments.add(attach);
        
        
        }
    
        }

if (AllAttachments.size()>0){
    insert AllAttachments;
}       
    }
    /***************end of sav emails***********************/
     @Auraenabled
    public static void send_invite(String des,
                                  DateTime st,
                                  DateTime et,
                                  String Loca,
                                  String to,
                                  Lead ac,
                                  String Email_typeis){
        
        
SendMeetingInvite  SIA = new SendMeetingInvite ();
SIA.isLightning = true;
SIA.subject = des;
SIA.startDateTime = st ;
SIA.endDateTime = et;
SIA.Description = des;
SIA.Location = Loca;
SIA.sendTo = to;
SIA.lead = ac;
SIA.toAddresses = new list<String>();
SIA.toAddresses.add(to);
SIA.Email_typeis = Email_typeis;
     System.debug('>>>>>>>>>>>>>>>>>> ');                                 
SIA.sendInvite();
    }

}