public class OpportunityFieldSchema {
    @Auraenabled
    public static void send_invite(String des,
                                  DateTime st,
                                  DateTime et,
                                  String Loca,
                                  String to,
                                  Opportunity ac,
                                  String Email_typeis){
        
        
SendMeetingInviteOpportunity  SIA = new SendMeetingInviteOpportunity ();
SIA.isLightning = true;
SIA.subject = des;
SIA.startDateTime = st ;
SIA.endDateTime = et;
SIA.Description = des;
SIA.Location = Loca;
SIA.sendTo = to;
SIA.opp = ac;
SIA.toAddresses = new list<String>();
SIA.toAddresses.add(to);
SIA.Email_typeis = Email_typeis;
     System.debug('>>>>>>>>>>>>>>>>>> ');                                 
SIA.sendInvite();
    }
   

        @AuraEnabled
    public static  Opportunity get_currentOpp(String recid){
        
        
        return [select id,Personal_Email__c,Work_Email__c from Opportunity where id=:recid limit 1];
    }
        
  @AuraEnabled
    public static  map<String,list<String>> getOppType(){
        map<String,list<String>> FieldAndSchema = new map<String,list<String>>();
        list<String> OppTypes =  new list<String>();
        Schema.DescribeFieldResult fieldResult = Opportunity.Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
       {
         // OpportunityTypeValues.add(f.getValue());
          OppTypes.add(f.getValue());
       }
        FieldAndSchema.put('OpportunityType',OppTypes);
        
        
           //Opportunity Account Type       
          list<String> OpportunityPlanTypes =  new list<String>();
       
         Schema.DescribeFieldResult fieldResult1= Opportunity.Account_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple1 = fieldResult1.getPicklistValues();
        for( Schema.PicklistEntry f : ple1)
       {
        
          OpportunityPlanTypes.add(f.getValue());
       }
         FieldAndSchema.put('OpportunityAccountType',OpportunityPlanTypes);
      
       //Opportunity Business Type
         list<String> OpportunityClass =  new list<String>();
       
        Schema.DescribeFieldResult fieldResult2= Opportunity.Business_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple2 = fieldResult2.getPicklistValues();
        for( Schema.PicklistEntry f : ple2)
       {
         // OpportunityTypeValues.add(f.getValue());
          OpportunityClass.add(f.getValue());
       }
           FieldAndSchema.put('OpportunityBusinessType',OpportunityClass);
     
       
       //Opportunity selling business
          list<String> OpportunityClient =  new list<String>();
      
         Schema.DescribeFieldResult fieldResult3= Opportunity.Selling_Business__c.getDescribe();
        List<Schema.PicklistEntry> ple3 = fieldResult3.getPicklistValues();
        for( Schema.PicklistEntry f : ple3)
       {
         // OpportunityTypeValues.add(f.getValue());
          OpportunityClient.add(f.getValue());
       }
        
            FieldAndSchema.put('OpportunitySellingBusiness',OpportunityClient);
            
          list<String> EmailType = new list<String>();
            EmailType.add('Official Email');
            EmailType.add('Personal Email');
          FieldAndSchema.put('EmailType',EmailType );
          
          
                //Opportunity Stage
          list<String> OpportunityStageName =  new list<String>();
      
         Schema.DescribeFieldResult fieldResult4= Opportunity.stageName.getDescribe();
        List<Schema.PicklistEntry> ple4 = fieldResult4.getPicklistValues();
        for( Schema.PicklistEntry f : ple4)
       {
         // OpportunityTypeValues.add(f.getValue());
          OpportunityStageName.add(f.getValue());
       }
        
            FieldAndSchema.put('OpportunityStage',OpportunityStageName);
            
            
            
                   //Opportunity LeadSource
          list<String> OpportunityLeadSource =  new list<String>();
      
         Schema.DescribeFieldResult fieldResult5= Opportunity.LeadSource.getDescribe();
        List<Schema.PicklistEntry> ple5 = fieldResult5.getPicklistValues();
        for( Schema.PicklistEntry f : ple5)
       {
         // OpportunityTypeValues.add(f.getValue());
          OpportunityLeadSource.add(f.getValue());
       }
        
            FieldAndSchema.put('OpportunityLeadSource',OpportunityLeadSource);
           
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
        public List<Opportunity> Opportunitys { get;set; }
        
    }


    @AuraEnabled
    public static PagedResult getAllOpportunitys(Decimal pageSize, Decimal pageNumber) {
        Integer pSize = (Integer)pageSize;
        Integer offset = ((Integer)pageNumber - 1) * pSize;
        PagedResult r =  new PagedResult();
        r.pageSize = pSize;
        r.page = (Integer) pageNumber;
       r.Opportunitys = [select id,Image_Url__c,Other_Email__c,name,Type__c,First_Name__c,Account_Type__c,Personal_Email__c,Work_Email__c,Business_Type__c,Selling_Business__c,StageName,LeadSource from Opportunity
       where createdById =: userinfo.getUserId() and converted_To_Account__c = false];
                    
         r.total = r.Opportunitys.size();
        return r;
    }
    
    
    @AuraEnabled
    public static PagedResult get_searchData(Decimal pageSize, Decimal pageNumber,
                                             list<String> seloppType,
                                             list<String> selAccType,
                                             list<String> selBussType,
                                             list<String> selSellingBusiness,
                                             list<String> selStage,
                                             list<String> selLeadSource,
                                             list<String> selEmailTypes  ){
    //    system.debug('>>>>> '+selAccplan);
      String Query = 'select id,Image_Url__c,Other_Email__c,name,Type__c,First_Name__c,Account_Type__c,Personal_Email__c,Work_Email__c,Business_Type__c,Selling_Business__c,StageName,LeadSource from Opportunity where createdById =\''+userinfo.getUserId()+'\''+ ' and converted_To_Account__c = false';
        if(seloppType!=null ){
            if(seloppType.size()> 0){
                Query += ' and Type__c in :seloppType';
                
            }
        }
        
          if(selAccType!=null ){
            if(selAccType.size()> 0){
                Query += ' and Account_Type__c in :selAccType';
                
            }
        }
        
        
          if(selBussType!=null ){
            if(selBussType.size()> 0){
                Query += ' and Business_Type__c in :selBussType';
                
            }
        }
        
        
          if(selSellingBusiness!=null ){
            if(selSellingBusiness.size()> 0){
                Query += ' and Selling_Business__c in :selSellingBusiness';
                
            }
        }
                                                 
        
          if(selStage!=null ){
            if(selStage.size()> 0){
                Query += ' and StageName in :selStage';
                
            }
        }
                                                 
                                                 
          if(selLeadSource!=null ){
            if(selLeadSource.size()> 0){
                Query += ' and LeadSource in :selLeadSource';
                
            }
        }
                                                 
        
        if(selEmailTypes !=null){
            
            if(selEmailTypes.size()>0){
                
                
                if(selEmailTypes.size()==2){
                    
                        Query+= ' and Personal_Email__c !=\'\'';
                        Query+= ' and Work_Email__c !=\'\'';
                }
                else  if(selEmailTypes.size()==1){
                    if(selEmailTypes[0] !='Official Email'){
                               Query+= ' and Personal_Email__c !=\'\'';
            
                    }else{
                                       Query+= ' and Work_Email__c !=\'\'';
                        
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
        r.Opportunitys = results;
        return r;

      //  return database.Query(Query);
    }
   @AuraEnabled
      public static String get_email_body(){
        
        return [ SELECT Id, Name,  HtmlValue FROM EmailTemplate where Name='Account_mass_email' limit 1].HtmlValue;
    } 
    
    @AuraEnabled
   public static String sendEmail(String EmailSubject,String EmailBody,list<String> TypeOfEmail,list<String> sel_Opportunity,String attachmentbody,String attachmentName,String listAtts){
     attachmentbody = EncodingUtil.urlDecode(attachmentbody, 'UTF-8');    
 list<multiple_attachments> AllAttsare = (list<multiple_attachments>)JSON.deserialize(listAtts, list<multiple_attachments>.class);
       
       String return_msg = '';
       System.debug('>>>><<<<<<<<<<<<< '+sel_Opportunity);
  List<Messaging.SingleEmailMessage>  myEmails = new List<Messaging.SingleEmailMessage>();
    list<String> Emails=  new List<String>();   
         List<Messaging.Emailfileattachment> fileAttachments  =new List<Messaging.Emailfileattachment>();
       list<Opportunity> sel_accs =  [select id,name,Type__c,First_Name__c,Account_Type__c,Personal_Email__c,Work_Email__c,Business_Type__c,Selling_Business__c,StageName,LeadSource from Opportunity where id in : sel_Opportunity];
       for(Opportunity acc :sel_accs){
	   Emails=  new List<String>();   
            fileAttachments = new List<Messaging.Emailfileattachment>();
                                                  

    
        Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
        //attaching file
        for(multiple_attachments each_is:AllAttsare){
         Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
        efa.setFileName(each_is.FileName);
        efa.setBody(EncodingUtil.base64Decode(each_is.FileBody));
        fileAttachments.add(efa);
        }
       
        
        if(TypeOfEmail.size() == 0 ||  TypeOfEmail.size()==2)
        {
            if(acc.Personal_Email__c!=null && acc.Personal_Email__c!=''){
            Emails.add(acc.Personal_Email__c);
            }
            if(acc.Work_Email__c!=null && acc.Work_Email__c!=''){
            Emails.add(acc.Work_Email__c);
            
            }
        }  
            
        else if(TypeOfEmail[0] == 'Official Email'){
        Emails.add(acc.Work_Email__c);
        }else if(TypeOfEmail[0] == 'Personal Email'){
        Emails.add(acc.Personal_Email__c);
        
        /*}else{
            Emails.add(accwrapper.Opportunity.Personal_Email__c);
        
        }*/
        }
       if(Emails!=null  ){ 
   //     mail.setToAddresses(Emails);
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
      /*  if(null !=attachment.Body){
          
        }*/     
               
           }
    
   }     
       System.debug('myEmails '+myEmails);
     Messaging.SendEmailResult[] result =Messaging.sendEmail(myEmails);
       
     System.debug('result '+result);
        if(result[0].success){
            return_msg = 'success';
            
            save_emails(sel_accs,EmailSubject,EmailBody,attachmentName,blob.valueof(attachmentbody),fileAttachments);
            
       }else{
            return_msg = 'failed';
       
       }
  //    System.debug('>>>> myEmails '+myEmails);
     //  System.debug('>>>>>>>>>>>>>>>> '+Messaging.sendEmail(myEmails));
   
            return return_msg;
    } 
    
    
    @AuraEnabled
    public static list<Opportunity> get_OpportunitiesforPopup (list<String> OppIds){
        
        return [select id,name,Type__c,First_Name__c,Account_Type__c,Personal_Email__c,Work_Email__c,Business_Type__c,Selling_Business__c,StageName,LeadSource from Opportunity where id in : OppIds];
    }

    
    
  /************************save email records******************/
    
    public static void save_emails(list<opportunity> selected_Opps,string EmailSubject,String EmailBody,String AttachmentName,Blob AttachmentBody,List<Messaging.Emailfileattachment> fileAttachments){
    
    list<Email_Tracking__c> emailRecs = new list<Email_Tracking__c>();
    Document doc = new Document();
    doc.isPublic=true;
    doc.Body = AttachmentBody;
    doc.Name = AttachmentName;
    doc.folderId=UserInfo.getUserId(); 
    DataBase.saveResult docSaveResult = DataBase.insert(doc, false);
    system.debug(':::::::::::::::::::::::;'+doc);
    
        for(opportunity each :selected_Opps){
        
            Email_Tracking__c individual = new Email_Tracking__c();
            individual.Opportunity__c= each.Id;
            individual.Email_Body__c = EmailBody;
            individual.Email_Subject__c = EmailSubject;
            individual.Email_Message_Type__c='Mass Email';
            individual.Email_Status__c='Sent Email';
            if(null !=AttachmentBody){
            individual.Attachment__c= doc.id;
            individual.Email_Attachment_Content__c = EncodingUtil.base64Encode(AttachmentBody);
             individual.Email_Attachment_Content__c = individual.Email_Attachment_Content__c.left(32760);
            }
            emailRecs.add(individual );
        }
        
        insert emailRecs;
    
        list<Attachment> AllAttachments = new list<Attachment>();
    for(Email_Tracking__c eachEmail :emailRecs )  {
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
}