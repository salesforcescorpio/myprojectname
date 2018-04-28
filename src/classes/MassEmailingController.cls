public with sharing class MassEmailingController {
    private Transient String strSoql ;                    //SOQL query
    String fld='Type'; //Filtering filed 
    public String AccountType{ get; set; }
    public Integer intTotNoOfRecs {get; set;} //Total number of records displayed in table
    public ApexPages.StandardSetController con {get;set;}
    public Integer intRecsize {get;set;} //Number of records displayed per page
    public string allErrorMsg {get;set;} 
    public List<wrapperAccount> AccountListRecs{get;set;} //Complete list of Wrapper
    public transient List<Account> lstTempCasFltr = new List<Account>(); 
    public transient List<Account> lstTempCas = new List<Account>();
    List<Account> selectedAccounts = new List<Account>();
    public  List<wrapperAccount>selectedAccountswrap {get;set;}
    public boolean ShowAccTable{get;set;}
    public boolean showacclist{get;set;}
    public String EmailSubject{get;set;}
    public String EmailBody{get;set;} 
    List<String> toAddresses;
    public Account sample_acc{get;set;}
    public Transient blob b;
    public String contentType {get; set;} //to get the attached extension
    public String typeOfEmail{get;set;}
    public Boolean show_email{get;set;}
    
     public list<String> InitialList  {get;set;}
     public list<String> CurrentList  {get;set;}
     
     public list<selectOption> AccountTypeValues {get;set;}
     public list<selectOption> AccountTypeValuesSelected {get;set;}
     public list<String> selectedAccType {get;set;}
     
     public list<selectOption> AccountPlanTypeValues {get;set;}
     public list<selectOption> AccountPlanTypeValuesSelected {get;set;}
     public list<String> selectedAccPlan {get;set;}
     
 
     public list<selectOption> AccountClass {get;set;}
     public list<selectOption> AccountClassSelected {get;set;}
     public list<String> selectedAccClass {get;set;}
     
     public list<selectOption> AccountClient {get;set;}
     public list<selectOption> AccountClientSelected {get;set;}
     public list<String> selectedAccClient {get;set;}
     
     
     public list<selectOption> EmailType {get;set;}
     public list<selectOption> EmailTypeSelected {get;set;}
     public list<string> selectedemails {get ; set ;}
     
     public String emailTypeis {get;set;}
     
    // String Email_template_body {get;set;}
    
    public String dataFetched {get;set;}
    public String dataExist {get;set;}
     public  Document attachment {
  get {
      if (attachment == null)
        attachment = new Document();
      return attachment;
    }
  set;
  }
    
     public MassEmailingController (){
     dataFetched = 'false';
     dataExist = 'false';
    EmailBody =  [ SELECT Id, Name,  HtmlValue FROM EmailTemplate where Name='Account_mass_email' limit 1].HtmlValue ;
     email_valiation = false;
     sendEmailis = 'no';
     emailTypeis = 'Account_Personal_Email__c;Account_Official_Email__c';
     AccountTypeValuesSelected  = new list<selectOption>();
     AccountPlanTypeValuesSelected  = new list<selectOption>();
     AccountClassSelected = new list<selectOption>();
     AccountClientSelected = new list<selectOption>();
     EmailTypeSelected = new list<selectOption>();
       selectedAccType = new list<String>();
       selectedAccPlan = new list<String>();
       selectedAccClass = new list<String>();
       selectedemails = new list<string>();
       selectedAccClient  = new list<String>();
     
     
     showerror = false;
     show_email = false;
     typeOfEmail = '';
     sample_acc = new Account();
     InitialList = new list<String>();
     InitialList.add(UserInfo.getUserId());
     CurrentList = new list<String>();
    //Account type List
        Schema.DescribeFieldResult fieldResult = Account.Type.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        AccountTypeValues = new list<selectOption>();  
        for( Schema.PicklistEntry f : ple)
       {
         // AccountTypeValues.add(f.getValue());
          AccountTypeValues.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
       //Account Plan Type       
         Schema.DescribeFieldResult fieldResult1= Account.Account_Plan_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple1 = fieldResult1.getPicklistValues();
        AccountPlanTypeValues = new list<selectOption>();  
        for( Schema.PicklistEntry f : ple1)
       {
         // AccountTypeValues.add(f.getValue());
          AccountPlanTypeValues.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
       //Account Class
       
         Schema.DescribeFieldResult fieldResult2= Account.Class__c.getDescribe();
        List<Schema.PicklistEntry> ple2 = fieldResult2.getPicklistValues();
        AccountClass = new list<selectOption>();  
        for( Schema.PicklistEntry f : ple2)
       {
         // AccountTypeValues.add(f.getValue());
          AccountClass.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
       
       //Account Client
       
         Schema.DescribeFieldResult fieldResult3= Account.Client_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple3 = fieldResult3.getPicklistValues();
        AccountClient = new list<selectOption>();  
        for( Schema.PicklistEntry f : ple3)
       {
         // AccountTypeValues.add(f.getValue());
          AccountClient.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
       
       
       
        //Email type
          EmailType = new list<selectOption>();  
          EmailType.add(new SelectOption('Official Email', 'Official Email'));
          EmailType.add(new SelectOption('Personal Email', 'Personal Email'));
       
    }


    public PageReference ChangeManager() {
         AccountListRecs.clear();
        system.debug('AccountType '+AccountType);
        lstTempCasFltr = new List<Account>();
        string Query = createQuery();
        system.debug('>>>>>>'+Query );
        lstTempCas=database.query(Query);
        system.debug('>>>>>>'+lstTempCas.size());
        con = new ApexPages.StandardSetController(lstTempCas);
        con.setPageSize(10);
        intTotNoOfRecs = con.getResultSize();
        if(!con.getRecords().isEmpty()){
                for(Account objAccount : (List<Account>) con.getRecords()){
                AccountListRecs.add(new wrapperAccount(objAccount));
                }
            } 
        return null;
    }


    public class wrapperAccount{
        public Account account {get; set;}
        public Boolean selected {get; set;}
        
        
        public wrapperAccount(Account acc) {
            account = acc;
            selected = false;
        }

    }

    public PageReference getSelected()
    {
        selectedAccounts.clear();
        for(wrapperAccount accwrapper : AccountListRecs)
        if(accwrapper.selected == true)
        selectedAccounts.add(accwrapper.account);
        return null;
    }
    public boolean showerror {get ; set ;}
    public String selected_All  {get;set;}
    public String seletec_ids {get;set;}
    public void ProcessSelected(){
      
        String selectedIds = ApexPages.currentPage().getParameters().get('sele_list');
        seletec_ids = selectedIds;
        String selectedAll = ApexPages.currentPage().getParameters().get('selectedAll');
        selected_All = selectedAll ;
        System.debug('selectedIds  are '+selectedIds );
        system.debug('in processing the queries');
     selectedAccountswrap =new list<wrapperAccount>();
     if(AccountListRecs!=null && AccountListRecs.size()>0)
     for(wrapperAccount wrapobj : AccountListRecs){
           if( (wrapobj.Selected==true && wrapobj.account.Account_Personal_Email__c!=null) || (selectedIds.contains(wrapobj.account.id) && (wrapobj.account.Account_Personal_Email__c!=null || wrapobj.account.Account_Official_Email__c !=null ) ) || (selectedAll=='true' && (wrapobj.account.Account_Personal_Email__c!=null || wrapobj.account.Account_Official_Email__c !=null)) ){
            selectedAccountswrap.add(wrapobj);
           }
            
         }
         if(selectedAccountswrap.size() >0){
         show_email = true;
         showacclist=true;
         system.debug('>>>>>'+selectedAccountswrap.size());
         }else{
         showerror =true;
         }
      }   


     
      public string createQuery(){
      system.debug('inside create query');
       string base_strQuery='select Client_Type__c,First_Name__c,id,name,Type__c,Account_Plan_Type__c,Class__c,Account_Personal_Email__c,Account_Other_Email__c,Account_Official_Email__c from account ';
       string strQuery  ='';
       
     System.debug('+++++++++++ '+selectedAccType);
      System.debug('+++++++++++ '+selectedAccPlan);
    
     System.debug('+++++++++++ '+selectedAccClass);
     System.debug('+++++++++++ '+EmailTypeSelected);
    
      
        if((selectedemails.size() == 0)){
         emailTypeis = 'Account_Personal_Email__c;Account_Official_Email__c';
          //typeOfEmail = 'Account_Personal_Email__c;Account_Official_Email__c';
          System.debug ('>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<< '+strQuery);

        }
    
       if((selectedAccType.size()!=0 ) || (selectedAccPlan.size()!=0) || (selectedAccClass.size()!=0) || (selectedAccClient.size()!=0) ||(selectedemails.size() !=0) || Test.isRunningTest()){
      
       //A
      if((selectedAccType.size()!=0) && (selectedAccPlan.size()==0) && (selectedAccClass.size()==0) && (selectedAccClient.size()==0)){
          strQuery  = '';           strQuery += 'where Type__c in :selectedAccType';
      }
     
     
     //B
        if((selectedAccType.size()==0) && (selectedAccPlan.size()!=0) && (selectedAccClass.size()==0) && (selectedAccClient.size()==0)){
    
           strQuery  = '';           strQuery += 'where Account_Plan_Type__c in :selectedAccPlan ';
      }
         //C     
        if((selectedAccType.size()==0) && (selectedAccPlan.size()==0) && (selectedAccClass.size()!=0) && (selectedAccClient.size()==0)){
            strQuery = '';           strQuery += 'where Class__c in: selectedAccClass';
      }
      
        //D   
        if((selectedAccType.size()==0) && (selectedAccPlan.size()==0) && (selectedAccClass.size()==0) && (selectedAccClient.size()!=0)){
            strQuery = '';           strQuery += 'where Client_Type__c in: selectedAccClient';
      }
      //AB
       if((selectedAccType.size()!=0 ) && (selectedAccPlan.size()!=0) && (selectedAccClass.size()==0) && (selectedAccClient.size()==0)){
      
           strQuery = '';           strQuery += 'where Type__c in:selectedAccType AND Account_Plan_Type__c in :selectedAccPlan ';
      }
      
      
      //AC
           if((selectedAccType.size()!=0 ) && (selectedAccPlan.size()==0) && (selectedAccClass.size()!=0) && (selectedAccClient.size()==0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType and Class__c in: selectedAccClass';
      }
      
      //AD
           if((selectedAccType.size()!=0 ) && (selectedAccPlan.size()==0) && (selectedAccClass.size()==0) && (selectedAccClient.size()!=0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType and Client_Type__c in: selectedAccClient';
      }
      
      //BC
            if((selectedAccType.size()==0 ) && (selectedAccPlan.size()!=0) && (selectedAccClass.size()!=0) && (selectedAccClient.size()==0)){
     strQuery = '';           strQuery += 'where Account_Plan_Type__c in: selectedAccPlan and Class__c in : selectedAccClass';
      }
      
      //BD
            if((selectedAccType.size()==0 ) && (selectedAccPlan.size()!=0) && (selectedAccClass.size()==0) && (selectedAccClient.size()!=0)){
     strQuery = '';           strQuery += 'where Account_Plan_Type__c in: selectedAccPlan and Client_Type__c in: selectedAccClient';
      }
      
      //CD
            if((selectedAccType.size()==0 ) && (selectedAccPlan.size()==0) && (selectedAccClass.size()!=0) && (selectedAccClient.size()!=0)){
     strQuery = '';           strQuery += 'where Class__c in: selectedAccClass and Client_Type__c in: selectedAccClient';
      }
      
      //ABC
            if((selectedAccType.size()!=0 ) && (selectedAccPlan.size()!=0) && (selectedAccClass.size()!=0) && (selectedAccClient.size()==0)){
           strQuery = '';           strQuery += 'where Account_Plan_Type__c in : selectedAccPlan and Class__c in: selectedAccClass and Type__c in : selectedAccType';
      }
      
       //ABD
            if((selectedAccType.size()!=0 ) && (selectedAccPlan.size()!=0) && (selectedAccClass.size()==0) && (selectedAccClient.size()!=0)){
           strQuery = '';           strQuery += 'where Account_Plan_Type__c in : selectedAccPlan and Client_Type__c in: selectedAccClient and Type__c in : selectedAccType';
      }
      
       //ACD
            if((selectedAccType.size()!=0 ) && (selectedAccPlan.size()==0) && (selectedAccClass.size()!=0) && (selectedAccClient.size()!=0)){
           strQuery = '';           strQuery += 'where  Type__c in : selectedAccType   and Class__c in: selectedAccClass and Client_Type__c in: selectedAccClient  ';
      }
      
      //BCD
            if((selectedAccType.size()==0 ) && (selectedAccPlan.size()!=0) && (selectedAccClass.size()!=0) && (selectedAccClient.size()!=0)){
           strQuery = '';           strQuery += 'where Account_Plan_Type__c in : selectedAccPlan  and Class__c in: selectedAccClass and Client_Type__c in: selectedAccClient  ';
      }
      
      //ABCD
            if((selectedAccType.size()!=0 ) && (selectedAccPlan.size()!=0) && (selectedAccClass.size()!=0) && (selectedAccClient.size()!=0)){
           strQuery = '';           strQuery += 'where  Type__c in : selectedAccType  and Account_Plan_Type__c in : selectedAccPlan  and Class__c in: selectedAccClass and Client_Type__c in: selectedAccClient  ';
      }
        
        else if(EmailTypeSelected.size() != 0 && EmailTypeSelected != null   ){
        emailTypeis = '';
        for(selectoption each:EmailTypeSelected){
          //emailTypeis = 'Account_Personal_Email__c;Account_Official_Email__c';
     
   
            if(strQuery ==''){
             if(each.getvalue() == 'Official Email'){
                strQuery += ' where Account_Official_Email__c!=\'\'';
                 emailTypeis += 'Account_Official_Email__c;';
                 typeOfEmail = 'Account_Official_Email__c';
              }else{
                    strQuery += ' where  Account_Personal_Email__c !=\'\'';              emailTypeis += 'Account_Personal_Email__c;';             typeOfEmail = 'Account_Personal_Email__c';
     
              }  
                
            }else{
            
             if(each.getvalue() == 'Official Email'){
                strQuery += ' and  Account_Official_Email__c!=\'\'';             emailTypeis += 'Account_Official_Email__c;';                typeOfEmail = 'Account_Official_Email__c';
     
              }else{
                    strQuery += ' and  Account_Personal_Email__c !=\'\'';
                    emailTypeis += 'Account_Personal_Email__c;';
                       typeOfEmail = 'Account_Personal_Email__c';
     
              }  
           
            }
            }
        
        }
        if((EmailTypeSelected.size() > 1)){
         typeOfEmail='';
        }
        if(strQuery !=''){
            base_strQuery = base_strQuery+strQuery;
        }
         return base_strQuery;
         }
         
        
        else{
            system.debug('inside else');
           // strQuery +=' where Type !=null';}
            return base_strQuery;
        }

    }   
    
    public void fetchRecords(){
     dataFetched = 'true';
      
        AccountListRecs  = new List<wrapperAccount>();
       system.debug('>>>>>>'+AccountType);
       selectedAccType = new list<String>();
       selectedAccPlan = new list<String>();
       selectedAccClass = new list<String>();
         for(selectOption  each:AccountTypeValuesSelected){
                selectedAccType.add(each.getvalue());
        }
               
         for(selectOption  each:AccountPlanTypeValuesSelected){
                selectedAccPlan.add(each.getvalue());
        }
        
         for(selectOption  each:AccountClassSelected){
                selectedAccClass.add(each.getvalue());
        }
        
        for(selectOption  each:AccountClientSelected){
                selectedAccClient.add(each.getvalue());
        }
        for(selectOption  each:EmailTypeSelected){
                selectedemails.add(each.getvalue());
        }
        
        if(EmailTypeSelected.size() == 0){
        
           emailTypeis = 'Account_Personal_Email__c;Account_Official_Email__c';
  
        }
       system.debug('>>>>>>>>>>>>>>>>'+selectedemails);
        strSoql = createQuery();
        
        System.debug('strSoql-->'+strSoql);
        List<Account> lstCas;
        if(strSoql !=null){
           lstCas = Database.Query(strSoql);
            if(lstCas != Null && lstCas.size()>0){
            intTotNoOfRecs = lstCas.size();
            }
            con = new ApexPages.StandardSetController(lstCas);
            intRecsize=10;
            
            if(con.getRecords().size() >0){
                 dataExist = 'true';
    
                con.setPageSize(intRecsize);
                con.setpageNumber(1);
               
               
               for(Account objAccount: lstCas ){
                   AccountListRecs.add(new wrapperAccount(objAccount));
               }
               
            }
            else { // No Records returned as per the exiting conditions
             //   allErrorMsg = 'No Records Found';
             dataExist = 'false';
                
            }
        }
    
    
    
    }
    /*******************send email code************************/
    
    public void GoBack(){
    
     show_email = false;
     showerror = false;
    }
    
    
    public boolean email_valiation {get;set;}
    public string sendEmailis {get;set;}
    public pagereference sendemail_validation(){
        if(EmailSubject ==null || EmailSubject ==''){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error,'please enter email subject'));
           return null;
       }
       
       if(EmailBody==null || EmailBody ==''){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error,'please enter email body'));
           return null;
       }
       
       
       if(null ==attachment.Body){
       sendEmailis = 'dontsend';
        email_valiation = true;
           return null;
       }
       
       sendEmailis = 'send';
    
        return null;
    }

       public pagereference sendEmail(){
       
        sendEmailis = 'no';
            email_valiation = false;
       /*
        selectedAccountswrap =new list<wrapperAccount>();
     if(AccountListRecs!=null && AccountListRecs.size()>0)
     for(wrapperAccount wrapobj : AccountListRecs){
           if(wrapobj.Selected==true){
           selectedAccountswrap.add(wrapobj);
           }
            
         }
         
         */
  List<Messaging.SingleEmailMessage>  myEmails = new List<Messaging.SingleEmailMessage>();
       if(EmailSubject!=null && EmailBody!=null){
           for(wrapperAccount accwrapper : selectedAccountswrap){
            List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
           //System.debug('>>>>>>>>>>>>>>>> '+accwrapper.Account.get(typeOfEmail));
                                  
               if(typeOfEmail !=null){
                 

       // System.debug('>>>>>'+EmailSubject);System.debug('>>>>>'+EmailBody); system.debug('>>>>>>'+toAddresses); system.debug('>>>>>>'+toAddresses.size());
        Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
        //attaching file
         Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
        efa.setFileName(attachment.Name);
        efa.setBody(attachment.Body);
        fileAttachments.add(efa);
        
        list<String> Emails=  new List<String>();
        
        if(typeOfEmail == '' || typeOfEmail == null)
        {
            if(accwrapper.Account.Account_Personal_Email__c!=null || accwrapper.Account.Account_Personal_Email__c==''){
            Emails.add(accwrapper.Account.Account_Personal_Email__c);}
            if(accwrapper.Account.Account_Official_Email__c!=null || accwrapper.Account.Account_Official_Email__c==''){
            Emails.add(accwrapper.Account.Account_Official_Email__c);}
        }        
        else if(typeOfEmail == 'Account_Official_Email__c'){
        Emails.add(accwrapper.Account.Account_Official_Email__c);
        }else if(typeOfEmail == 'Account_Other_Email__c'){
        Emails.add(accwrapper.Account.Account_Other_Email__c);
        
        }else{
            Emails.add(accwrapper.Account.Account_Personal_Email__c);
        
        }
        
        if(Emails==null  ){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please select the records'));}
        mail.setToAddresses(Emails);
      //  mail.setTargetObjectId( UserInfo.getUserId() );
        mail.setBccAddresses(toAddresses);
        mail.setSubject(EmailSubject);
        mail.setSaveAsActivity(false); 
        
        String s1=EmailBody.replace('{#user}',accwrapper.Account.First_Name__c);
        String linebreak=s1.replaceAll('\n', '<br/>');
        
        //mail.setHtmlBody(EmailBody);
        mail.setHtmlBody(linebreak);
        String currentUserEmail = UserInfo.getUserEmail();
        String[] ccAddresses = new String[] {currentUserEmail};
        mail.setCcAddresses(ccAddresses);
        mail.setReplyTo(label.ReplyEmailHandlerMassEmail);
        myEmails.add(mail);
        if(null !=attachment.Body){
            mail.setFileAttachments(fileAttachments);   
        }     
               }
           }
           
            
       }
      Messaging.SendEmailResult[] result =Messaging.sendEmail(myEmails);
       
       
        if(result[0].success){
          System.debug('The email was sent successfully.');
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Email sent successfully  '));
            
            save_emails(selectedAccountswrap,EmailSubject,EmailBody,attachment.Name,attachment.Body);
            
       }
    //    else {
    
  //  }
    
    return null;
    } 
    /***************end of send email*************************/
    
    
    /************************save email records******************/
    
    public void save_emails(list<wrapperAccount> selected_Accs,string EmailSubject,String EmailBody,String AttachmentName,Blob AttachmentBody){
    
    list<Email_Object__c> emailRecs = new list<Email_Object__c>();
   Document doc = new Document();
    doc.isPublic=true;
    doc.Body = AttachmentBody;
    doc.Name = AttachmentName;
    doc.folderId=UserInfo.getUserId(); 
    DataBase.saveResult docSaveResult = DataBase.insert(doc, false);
    system.debug(':::::::::::::::::::::::;'+doc);
        for(wrapperAccount each :selected_Accs){
        
            Email_Object__c individual = new Email_Object__c();
            individual.Account__c= each.account.Id;
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
    
    
    }
    /***************end of sav emails***********************/
    
    public void test(){
   // System.debug('>>>>>>>>>>>>> '+AccountTypeValuesSelected [0].getLabel());
    }
       }