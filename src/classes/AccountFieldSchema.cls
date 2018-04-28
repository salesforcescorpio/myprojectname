public class AccountFieldSchema {
    @AuraEnabled
    public static Id saveTheFile(string parentId, String fileName, String base64Data, String contentType) { 
        if(parentId =='null'){
            parentId = [select id from Account where name='Base Account dont delete'].id;//userinfo.getUserId();
            System.debug('parentId '+parentId);
        }
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment a = new Attachment();
       
            System.debug('parentId '+parentId);
        a.parentId = parentId;

        a.Body = EncodingUtil.base64Decode(base64Data);
        a.Name = fileName;
        a.ContentType = contentType;
        
        insert a;
        
        return a.Id;
    }
    
     @AuraEnabled
    public static Id saveTheChunk(String parentId, String fileName, String base64Data, String contentType, String fileId) { 
        if (fileId == '') {
            fileId = saveTheFile(parentId, fileName, base64Data, contentType);
        } else {
            appendToFile(fileId, base64Data);
        }
        
        return Id.valueOf(fileId);
    }
    
    private static void appendToFile(Id fileId, String base64Data) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment a = [
            SELECT Id, Body
            FROM Attachment
            WHERE Id = :fileId
        ];
        
     	String existingBody = EncodingUtil.base64Encode(a.Body);
        a.Body = EncodingUtil.base64Decode(existingBody + base64Data); 
        
        update a;
    }
    @AuraEnabled
    public static void update_account_image(String AccID){
        Account acc = [select id,Image__c from Account where id=:AccID];
        Attachment atcc = [select id from Attachment where ParentId=:AccID limit 1];
        acc.Image__c = atcc.id;
        upsert acc;
    }
    @AuraEnabled
    public static Boolean update_AccountforDelete(String AccountId){
        Account acc = [select id,delete_account__c from Account where id=:AccountId];
        acc.delete_account__c = true; 
        update acc;
        return true;
    }
    @Auraenabled
    public static void send_invite(String des,
                                  DateTime st,
                                  DateTime et,
                                  String Loca,
                                  String to,
                                  Account ac,
                                  String Email_typeis){
        
        
SendMeetingInviteAccount  SIA = new SendMeetingInviteAccount ();
SIA.isLightning = true;
SIA.subject = des;
SIA.startDateTime = st ;
SIA.endDateTime = et;
SIA.Description = des;
SIA.Location = Loca;
SIA.sendTo = to;
SIA.acc = ac;
SIA.toAddresses = new list<String>();
SIA.toAddresses.add(to);
SIA.Email_typeis = Email_typeis;
     System.debug('>>>>>>>>>>>>>>>>>> ');                                 
SIA.sendInvite();
    }

        @AuraEnabled
    public static  Account get_currentAcc(String recid){
        
        
        return [select id,Account_Personal_Email__c,Account_Official_Email__c from Account where id=:recid limit 1];
    }
        
        @AuraEnabled
    public static  map<String,list<String>> getAccountType(){
        map<String,list<String>> FieldAndSchema = new map<String,list<String>>();
        list<String> AccountTypes =  new list<String>();
        Schema.DescribeFieldResult fieldResult = Account.Type.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
       {
         // AccountTypeValues.add(f.getValue());
          AccountTypes.add(f.getValue());
       }
        FieldAndSchema.put('AccountType',AccountTypes);
        
        
           //Account Plan Type       
          list<String> AccountPlanTypes =  new list<String>();
       
         Schema.DescribeFieldResult fieldResult1= Account.Account_Plan_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple1 = fieldResult1.getPicklistValues();
        for( Schema.PicklistEntry f : ple1)
       {
         // AccountTypeValues.add(f.getValue());
          AccountPlanTypes.add(f.getValue());
       }
         FieldAndSchema.put('AccountPlanType',AccountPlanTypes);
      
       //Account Class
         list<String> AccountClass =  new list<String>();
       
        Schema.DescribeFieldResult fieldResult2= Account.Class__c.getDescribe();
        List<Schema.PicklistEntry> ple2 = fieldResult2.getPicklistValues();
        for( Schema.PicklistEntry f : ple2)
       {
         // AccountTypeValues.add(f.getValue());
          AccountClass.add(f.getValue());
       }
           FieldAndSchema.put('AccountClass',AccountClass);
     
       
       //Account Client
          list<String> AccountClient =  new list<String>();
      
         Schema.DescribeFieldResult fieldResult3= Account.Client_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple3 = fieldResult3.getPicklistValues();
        for( Schema.PicklistEntry f : ple3)
       {
         // AccountTypeValues.add(f.getValue());
          AccountClient.add(f.getValue());
       }
        
            FieldAndSchema.put('AccountClient',AccountClient);
            
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
        public List<Account> Accounts { get;set; }
        
    }


    @AuraEnabled
    public static PagedResult getAllAccounts(Decimal pageSize, Decimal pageNumber) {
    //    Filter filter = (Filter) JSON.deserializeStrict(filters, FundController.Filter.class);
        Integer pSize = (Integer)pageSize;
      //  String key = '%' + filter.searchKey + '%';
        Integer offset = ((Integer)pageNumber - 1) * pSize;
        PagedResult r =  new PagedResult();
        r.pageSize = pSize;
        r.page = (Integer) pageNumber;
       r.Accounts = [select Image_Url__c,Last_Name__c, Client_Type__c,First_Name__c,id,name,Type__c,Account_Plan_Type__c,Class__c,Account_Personal_Email__c,Account_Other_Email__c,Account_Official_Email__c from account where createdById =: userinfo.getUserId() and RecordType.Name='Customer Account' and delete_account__c=false order by Last_Name__c asc];
                      /*abbreviation__c, asset_class__c, sector__r.Name, rating__c, YTD_Return__c, One_Year_Return__c, Two_Year_Return__c, Five_Year_Return__c FROM Fund__c 
                  WHERE name LIKE :key
                   AND Asset_Class__c like : (filter.assetClass == '' ? '%' : filter.assetClass)
                   AND Sector__r.Name like : (filter.sector == '' ? '%' : filter.sector)
                   AND YTD_Return__c >= :filter.minYtdReturn AND YTD_Return__c <= :filter.maxYtdReturn
                   AND One_Year_Return__c >= :filter.min1YearReturn AND One_Year_Return__c <= :filter.max1YearReturn
                   AND Five_Year_Return__c >= :filter.min5YearReturn AND Five_Year_Return__c <= :filter.max5YearReturn
                   LIMIT :pSize OFFSET :offset*///];
         r.total = r.Accounts.size();
        return r;
    }
    
    
    @AuraEnabled
    public static PagedResult get_searchData(Decimal pageSize, Decimal pageNumber,list<String> selAccplan,list<String> selectedAccClient,list<String> selectedAcc,list<String> selectedAccClas,list<String> selectedEmailTypes  ){
        system.debug('>>>>> '+selAccplan);
      String Query = 'select Image_Url__c,Last_Name__c, Client_Type__c,First_Name__c,id,name,Type__c,Account_Plan_Type__c,Class__c,Account_Personal_Email__c,Account_Other_Email__c,Account_Official_Email__c from account where createdById =\''+userinfo.getUserId()+'\' and RecordType.Name=\'Customer Account\' and delete_account__c=false';
        if(selAccplan!=null ){
            if(selAccplan.size()> 0){
                Query += ' and Account_Plan_Type__c in :selAccplan';
                
            }
        }
        
          if(selectedAccClient!=null ){
            if(selectedAccClient.size()> 0){
                Query += ' and Client_Type__c in :selectedAccClient';
                
            }
        }
        
        
          if(selectedAcc!=null ){
            if(selectedAcc.size()> 0){
                Query += ' and Type__c in :selectedAcc';
                
            }
        }
        
        
          if(selectedAccClas!=null ){
            if(selectedAccClas.size()> 0){
                Query += ' and Class__c in :selectedAccClas';
                
            }
        }
        
        if(selectedEmailTypes !=null){
            
            if(selectedEmailTypes.size()>0){
                
                
                if(selectedEmailTypes.size()==2){
                    
                        Query+= ' and Account_Personal_Email__c !=\'\'';
                        Query+= ' and Account_Official_Email__c !=\'\'';
                }
                else  if(selectedEmailTypes.size()==1){
                    if(selectedEmailTypes[0] !='Official Email'){
                               Query+= ' and Account_Personal_Email__c !=\'\'';
            
                    }else{
                                       Query+= ' and Account_Official_Email__c !=\'\'';
                        
                    }
                }
            }
            
        }
        
        
        Query+=' order by Last_Name__c asc';
        list<sObject> results = database.Query(Query);
            Integer pSize = (Integer)pageSize;
      //  String key = '%' + filter.searchKey + '%';
        Integer offset = ((Integer)pageNumber - 1) * pSize;
        PagedResult r =  new PagedResult();
        r.pageSize = pSize;
        r.page = (Integer) pageNumber;
        r.total = results.size();
        r.Accounts = results;
        return r;

      //  return database.Query(Query);
    }
   @AuraEnabled
      public static String get_email_body(){
        
        return [ SELECT Id, Name,  HtmlValue FROM EmailTemplate where Name='Account_mass_email' limit 1].HtmlValue;
    } 
    
    @AuraEnabled
   public static String sendEmail(String EmailSubject,String EmailBody,list<String> TypeOfEmail,list<String> sel_account,String listAtts){
 //    attachmentbody = EncodingUtil.urlDecode(attachmentbody, 'UTF-8');    
 list<multiple_attachments> AllAttsare = (list<multiple_attachments>)JSON.deserialize(listAtts, list<multiple_attachments>.class);
       
       String return_msg = '';
       System.debug('>>>><<<<<<<<<<<<< '+sel_account);  
       list<Attachment> atts = new list<Attachment>();
     
  List<Messaging.SingleEmailMessage>  myEmails = new List<Messaging.SingleEmailMessage>();
    list<String> Emails=  new List<String>();   
         List<Messaging.Emailfileattachment> fileAttachments  =new List<Messaging.Emailfileattachment>();
       list<Account> sel_accs =  [select id,First_Name__c,name,Account_Other_Email__c,Account_Personal_Email__c,Account_Official_Email__c from Account where id in : sel_account];
       for(Account acc :sel_accs){
            fileAttachments = new List<Messaging.Emailfileattachment>();
                                                  

    
        Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
        //attaching file
        for(multiple_attachments each_is:AllAttsare){
            Attachment a = [select Name, Body, BodyLength from Attachment where id = :each_is.FileBody];
         Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
        efa.setFileName(a.Name);
        efa.setBody(a.Body);
        fileAttachments.add(efa);
        }
       
        
        if(TypeOfEmail.size() == 0 ||  TypeOfEmail.size()==2)
        {
            if(acc.Account_Personal_Email__c!=null && acc.Account_Personal_Email__c!=''){
            Emails.add(acc.Account_Personal_Email__c);
            }
            if(acc.Account_Official_Email__c!=null && acc.Account_Official_Email__c!=''){
            Emails.add(acc.Account_Official_Email__c);
            
            }
        }  
            
        else if(TypeOfEmail[0] == 'Official Email'){
        Emails.add(acc.Account_Official_Email__c);
        }else if(TypeOfEmail[0] == 'Personal Email'){
        Emails.add(acc.Account_Personal_Email__c);
        
        /*}else{
            Emails.add(accwrapper.Account.Account_Personal_Email__c);
        
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
        //   if(null !=attachmentbody)
             mail.setFileAttachments(fileAttachments);   
      /*  if(null !=attachment.Body){
          
        }*/     
               
           }
    
   }     
       System.debug('myEmails '+myEmails);
     Messaging.SendEmailResult[] result =Messaging.sendEmail(myEmails);
       
     System.debug('result '+result);
       delete atts;
        if(result[0].success){
            return_msg = 'success';
            
            save_emails(sel_accs,EmailSubject,EmailBody,fileAttachments);
            
       }else{
            return_msg = 'failed';
       
       }
  //    System.debug('>>>> myEmails '+myEmails);
     //  System.debug('>>>>>>>>>>>>>>>> '+Messaging.sendEmail(myEmails));
   
            return return_msg;
    } 
    
    
    @AuraEnabled
    public static list<Account> get_AccountsforPopup (list<String> AccIds){
        
        return [select Image_Url__c,Last_Name__c, Client_Type__c,First_Name__c,id,name,Type__c,Account_Plan_Type__c,Class__c,Account_Personal_Email__c,Account_Other_Email__c,Account_Official_Email__c from Account where id in : AccIds];
    }

    
    
    /************************save email records******************/
    
    public static void  save_emails(list<Account> selected_Accs,string EmailSubject,String EmailBody,List<Messaging.Emailfileattachment> fileAttachments){
    
    list<Email_Object__c> emailRecs = new list<Email_Object__c>();
   //Document doc = new Document();
    //doc.isPublic=true;
  //  doc.Body = AttachmentBody;
  //  doc.Name = AttachmentName;
  //  doc.folderId=UserInfo.getUserId(); 
   // DataBase.saveResult docSaveResult = DataBase.insert(doc, false);
 //   system.debug(':::::::::::::::::::::::;'+doc);
        for(Account each :selected_Accs){
        
            Email_Object__c individual = new Email_Object__c();
            individual.Account__c= each.Id;
           // individual.Email_Body__c = EmailBody;
            individual.Email_Subject__c = EmailSubject;
            individual.Email_Message_Type__c='Mass Email';
            individual.Email_Status__c='Sent Email';
     //       if(null !=AttachmentBody){
          //  individual.Attachment__c= doc.id;
           // individual.Email_Attachment_Content__c = EncodingUtil.base64Encode(AttachmentBody);
            // individual.Email_Attachment_Content__c = individual.Email_Attachment_Content__c.left(32760);
       //     }
            emailRecs.add(individual );
        }
        
        insert emailRecs;
        list<Attachment> AllAttachments = new list<Attachment>();
    for(Email_Object__c eachEmail :emailRecs )  {
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
    @AuraEnabled
    public static void delete_att(String attId){
        
        Attachment att = [select id from Attachment where id=:attId];
        delete att;
    }
       }