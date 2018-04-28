public with sharing class MassEmailingControllerOnLead {
    private Transient String strSoql ;                    //SOQL query
    String fld='Type'; //Filtering filed 
    public String AccountType{ get; set; }
    public Integer intTotNoOfRecs {get; set;} //Total number of records displayed in table
    public ApexPages.StandardSetController con {get;set;}
    public Integer intRecsize {get;set;} //Number of records displayed per page
    public string allErrorMsg {get;set;} 
    public List<wrapperLead> LeadListRecs{get;set;} //Complete list of Wrapper
    public transient List<Lead> lstTempCasFltr = new List<Lead>(); 
    public transient List<Lead> lstTempCas = new List<Lead>();
    List<Lead> selectedLeads = new List<Lead>();
   public List<wrapperLead>selectedLeadWrap {get;set;} 
    public boolean ShowAccTable{get;set;}
    public boolean showacclist{get;set;}
    public String EmailSubject{get;set;}
    public String EmailBody{get;set;} 
    List<String> toAddresses;
    public Lead sample_lead{get;set;}
    public blob b;
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
          
          
     public list<selectOption> EmailType {get;set;}
     public list<selectOption> EmailTypeSelected {get;set;}
     public list<string> selectedemails {get ; set ;}
     
     public list<selectOption> BusinessType {get;set;}
     public list<selectOption> BusinessTypeSelected {get;set;}
     public list<String> selectedBusinessType {get;set;}
     
     public list<selectOption> SellingBusiness {get;set;}
     public list<selectOption> SellingBusinessSelected {get;set;}
     public list<String> selectedSellingBusiness {get;set;}
     
     public list<selectOption> StageName {get;set;}
     public list<selectOption> StageNameSelected {get;set;}
     public list<String> selectedStageName {get;set;}
     
     public list<selectOption> Status{get;set;}
     public list<selectOption> StatusSelected {get;set;}
     public list<String> selectedStatus {get;set;}
         
     public list<selectOption> LeadSource {get;set;}
     public list<selectOption> LeadSourceSelected {get;set;}
     public list<String> selectedLeadSource {get;set;}
     
     public list<selectOption> LeadSubSource {get;set;}
     public list<selectOption> LeadSubSourceSelected {get;set;}
     public list<String> selectedLeadSubSource {get;set;}
     
     public list<selectOption> Rating{get;set;}
     public list<selectOption> RatingSelected {get;set;}
     public list<String> selectedRating {get;set;}
     
     
     public String emailTypeis {get;set;}
 
     public Document attachment {
  get {
      if (attachment == null)
        attachment = new Document();
      return attachment;
    }
  set;
  }
    
     public MassEmailingControllerOnLead (){
     
     emailTypeis = 'Email';
     AccountTypeValuesSelected  = new list<selectOption>();
     AccountPlanTypeValuesSelected  = new list<selectOption>();
     BusinessTypeSelected = new list<selectOption>();
     SellingBusinessSelected  = new list<selectOption>();
     EmailTypeSelected = new list<selectOption>();
     StatusSelected = new list<selectOption>();
     LeadSourceSelected = new list<selectOption>();
     LeadSubSourceSelected = new list<selectOption>();
     RatingSelected = new List<SelectOption>();
       
       selectedAccType = new list<String>();
       selectedAccPlan = new list<String>();
       selectedBusinessType = new list<String>();
       selectedSellingBusiness= new list<String>();
       selectedStatus= new list<String>();
       selectedLeadSource = new list<String>();
       selectedLeadSubSource = new list<String>();
       selectedemails = new list<string>();
       
     
     showerror = false;
     show_email = false;
     typeOfEmail = '';
     sample_lead = new Lead();
     InitialList = new list<String>();
     InitialList.add(UserInfo.getUserId());
     CurrentList = new list<String>();
    
    //Account type List
        Schema.DescribeFieldResult fieldResult = Lead.Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        AccountTypeValues = new list<selectOption>();  
        for( Schema.PicklistEntry f : ple)
       {
         // AccountTypeValues.add(f.getValue());
          AccountTypeValues.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
       //Account Plan Type       
         Schema.DescribeFieldResult fieldResult1= Lead.Account_Plant_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple1 = fieldResult1.getPicklistValues();
        AccountPlanTypeValues = new list<selectOption>();  
        for( Schema.PicklistEntry f : ple1)
       {
         AccountPlanTypeValues.add(new SelectOption(f.getLabel(), f.getValue()));
       }
             
       
       //Email type
          EmailType = new list<selectOption>();  
          EmailType.add(new SelectOption('Official Email', 'Official Email'));
          EmailType.add(new SelectOption('Personal Email', 'Personal Email'));
       
       //Lead Status 
         Schema.DescribeFieldResult fieldResult4= Lead.Status.getDescribe();
        List<Schema.PicklistEntry> ple4 = fieldResult4.getPicklistValues();
        Status= new list<selectOption>();  
        for( Schema.PicklistEntry f : ple4)
       {
          Status.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
     
       //Leadsource
         Schema.DescribeFieldResult fieldResult5= Lead.LeadSource.getDescribe();
        List<Schema.PicklistEntry> ple5 = fieldResult5.getPicklistValues();
        LeadSource = new list<selectOption>();  
        for( Schema.PicklistEntry f : ple5)
       {
          LeadSource.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
        //LeadSubsource
         Schema.DescribeFieldResult fieldResult6= Lead.Lead_sub_source__c.getDescribe();
        List<Schema.PicklistEntry> ple6 = fieldResult6.getPicklistValues();
        LeadSubSource = new list<selectOption>();  
        for( Schema.PicklistEntry f : ple6)
       {
          LeadSubSource.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
       
       //Rating
         Schema.DescribeFieldResult fieldResult7= Lead.Rating.getDescribe();
        List<Schema.PicklistEntry> ple7 = fieldResult7.getPicklistValues();
        Rating= new list<selectOption>();  
        for( Schema.PicklistEntry f : ple7)
       {
          Rating.add(new SelectOption(f.getLabel(), f.getValue()));
       }
    }


    public PageReference ChangeManager() {
         LeadListRecs.clear();
        system.debug('AccountType '+AccountType);
        lstTempCasFltr = new List<Lead>();
        string Query = createQuery();
        system.debug('>>>>>>'+Query );
        lstTempCas=database.query(Query);
        system.debug('>>>>>>'+lstTempCas.size());
        con = new ApexPages.StandardSetController(lstTempCas);
        con.setPageSize(10);
        intTotNoOfRecs = con.getResultSize();
        if(!con.getRecords().isEmpty()){
                for(Lead objLead : (List<Lead>) con.getRecords()){
                LeadListRecs.add(new wrapperLead(objLead));
                }
            } 
        return null;
    }


    public class wrapperLead{
        public Lead Lead {get; set;}
        public Boolean selected {get; set;}
        
        
        public wrapperLead(Lead objlead) {
            Lead = objlead;
            selected = false;
        }

    }

    public PageReference getSelected()
    {
        selectedLeads.clear();
        for(wrapperLead oppwrapper : LeadListRecs)
        if(oppwrapper.selected == true)
        selectedLeads.add(oppwrapper.Lead);
        return null;
    }
    public boolean showerror {get ; set ;}
    public void ProcessSelected(){
      
        
        system.debug('in processing the queries');
     selectedLeadWrap=new list<wrapperLead>();
     if(LeadListRecs!=null && LeadListRecs.size()>0)
     for(wrapperLead wrapobj : LeadListRecs){
           if(wrapobj.Selected==true && wrapobj.Lead.Email!=null ){
            selectedLeadWrap.add(wrapobj);
           }
            
         }
         if(selectedLeadWrap.size() >0){
         show_email = true;
         showacclist=true;
         system.debug('>>>>>'+selectedLeadWrap.size());
         }else{
         showerror =true;
         }
      }   
     
      public string createQuery(){
      system.debug('inside create query');
       string base_strQuery='select id,name,Type__c,Account_Plant_Type__c,Email,LeadSource,Lead_sub_source__c,Status,Rating from Lead';
       string strQuery  ='';
       
      System.debug('+++++++++++ '+selectedAccType);
      System.debug('+++++++++++ '+selectedAccPlan);
      System.debug('+++++++++++ '+selectedStatus);
      System.debug('+++++++++++ '+selectedLeadSource);
      System.debug('+++++++++++ '+selectedLeadSubSource);
      System.debug('+++++++++++ '+selectedRating);
      
      
      
        if((selectedemails.size() == 0)){
         emailTypeis = 'Email';
          System.debug ('>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<< '+strQuery);

        }
    
       //if((selectedAccType.size()!=0 ) || (selectedAccPlan.size()!=0) || (selectedStatus.size()!=0)){
      if((selectedAccType.size()!=0 ) || (selectedAccPlan.size()!=0) || (selectedStatus.size()!=0) || (selectedLeadSource.size() !=0) ||(selectedLeadSubSource.size()!=0) || (selectedRating.size()!=0) ){
       //A
      if((selectedAccType.size()!=0) && (selectedAccPlan.size()==0) && (selectedBusinessType.size()==0)){
          strQuery  = '';
           strQuery += ' where Type__c in :selectedAccType';
      }
     
     
     //B
        if((selectedAccType.size()==0) && (selectedAccPlan.size()!=0)){
    
           strQuery  = '';
           strQuery += ' where Account_Plant_Type__c in :selectedAccPlan ';
      }
        
      //C
      if((selectedAccType.size()==0) && (selectedAccPlan.size()==0) &&(selectedLeadSubSource.Size()==0)){
    
           strQuery  = '';
           strQuery += ' where Status in :selectedStatus';
      }
      //D
      //E
      //F
      
      
      //AB
       if((selectedAccType.size()!=0 ) && (selectedAccPlan.size()!=0) && (selectedBusinessType.size()==0)){
      
           strQuery = ' ';
           strQuery += 'where Type__c in:selectedAccType AND Account_Plant_Type__c in :selectedAccPlan ';
      }
      
      
      //AC
           if((selectedAccType.size()!=0 ) && (selectedAccPlan.size()==0) && (selectedBusinessType.size()!=0)){
    
      strQuery = ' ';
           strQuery += 'where Type__c in:selectedAccType';
      }
      
      //BC
            if((selectedAccType.size()==0 ) && (selectedAccPlan.size()!=0) && (selectedBusinessType.size()!=0)){
     strQuery = ' ';
           strQuery += 'where Account_Plant_Type__c in: selectedAccPlan';
      }
      
      //ABC
            if((selectedAccType.size()!=0 ) && (selectedAccPlan.size()!=0) && (selectedBusinessType.size()!=0)){
           strQuery = ' ';
           strQuery += 'where Account_Plant_Type__c in : selectedAccPlan';
      }
      
      
        
        else if(EmailTypeSelected.size() != 0 && EmailTypeSelected != null   ){
        emailTypeis = '';
        for(selectoption each:EmailTypeSelected){
          //emailTypeis = 'Personal_Email__c;Work_Email__c';
     
   
            if(strQuery ==''){
             if(each.getvalue() == 'Official Email'){
                strQuery += ' where Work_Email__c!=\'\'';
                 emailTypeis += 'Work_Email__c;';
                 typeOfEmail = 'Work_Email__c';
              }else{
                    strQuery += ' where  Personal_Email__c !=\'\'';
                   emailTypeis += 'Personal_Email__c;';
                    typeOfEmail = 'Personal_Email__c';
     
              }  
                
            }else{
            
             if(each.getvalue() == 'Official Email'){
                strQuery += ' and  Work_Email__c!=\'\'';
                emailTypeis += 'Work_Email__c;';
                typeOfEmail = 'Work_Email__c';
     
              }else{
                    strQuery += ' and  Personal_Email__c !=\'\'';
                    emailTypeis += 'Personal_Email__c;';
                       typeOfEmail = 'Personal_Email__c';
     
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
       
        LeadListRecs= new List<wrapperLead>();
       system.debug('>>>>>>'+AccountType);
       selectedAccType = new list<String>();
       selectedAccPlan = new list<String>();
       selectedBusinessType = new list<String>();
       selectedSellingBusiness =new list<String>();
         for(selectOption  each:AccountTypeValuesSelected){
                selectedAccType.add(each.getvalue());
        }
               
         for(selectOption  each:AccountPlanTypeValuesSelected){
                selectedAccPlan.add(each.getvalue());
        }
            for(selectOption  each:StatusSelected){
            selectedStatus.add(each.getvalue());
            }
         
        for(selectOption  each:EmailTypeSelected){
                selectedemails.add(each.getvalue());
        }
        
        if(EmailTypeSelected.size() == 0){
        
           emailTypeis = 'Email';
  
        }
       system.debug('>>>>>>>>>>>>>>>>'+selectedemails);
        strSoql = createQuery();
        
        System.debug('strSoql-->'+strSoql);
        List<Lead> lstCas;
        if(strSoql !=null){
           lstCas = Database.Query(strSoql);
            if(lstCas != Null && lstCas.size()>0){
            intTotNoOfRecs = lstCas.size();
            }
            con = new ApexPages.StandardSetController(lstCas);
            intRecsize=10;
            
            if(con.getRecords().size() >0){
                
                con.setPageSize(intRecsize);
                con.setpageNumber(1);
               
               
               for(Lead objOpportunity: lstCas ){
                   LeadListRecs.add(new wrapperLead(objOpportunity));
               }
               
            }
            else { // No Records returned as per the exiting conditions
             //   allErrorMsg = 'No Records Found';
                
            }
        }
    
    
    
    }
    /*******************send email code************************/
    
    public void GoBack(){
    
    show_email = false;
     showerror = false;
    }
    

       public pagereference sendEmail(){
       
       system.debug('inside send email method');
       if(EmailSubject ==null || EmailSubject ==''){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error,'please enter email subject'));
           return null;
       }
       
       if(EmailBody==null || EmailBody ==''){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error,'please enter email body'));
         
           return null;
       }
       
  List<Messaging.SingleEmailMessage>  myEmails = new List<Messaging.SingleEmailMessage>();
      system.debug('>>>>>>>>>'+selectedLeadWrap.size());
       if(EmailSubject!=null && EmailBody!=null){
           for(wrapperLead oppwrapper : selectedLeadWrap){
            List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
           //System.debug('>>>>>>>>>>>>>>>> '+oppwrapper.Lead.get(typeOfEmail));
               system.debug('typeOfEmail>>>>>>>'+ typeOfEmail );                   
               if(typeOfEmail !=null){
                 

        System.debug('>>>>>'+EmailSubject);
        System.debug('>>>>>'+EmailBody); 
        system.debug('>>>>>>'+toAddresses); 
        //system.debug('>>>>>>'+toAddresses.size());
        Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
        //attaching file
         Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
        efa.setFileName(attachment.Name);
        efa.setBody(attachment.Body);
        fileAttachments.add(efa);
        
        list<String> Emails=  new List<String>();
        
        if(typeOfEmail == '' || typeOfEmail == null)
        {
            if(oppwrapper.Lead.Email!=null || oppwrapper.Lead.Email==''){
            Emails.add(oppwrapper.Lead.Email);}
        }        
     
        system.debug('Emails'+Emails);
        system.debug('Emails'+Emails.size());
        if(Emails==null  ){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please select the records'));}
        mail.setToAddresses(Emails);
      //  mail.setTargetObjectId( UserInfo.getUserId() );
        mail.setBccAddresses(toAddresses);
        mail.setSubject(EmailSubject);
        mail.setSaveAsActivity(false); 
        String s1=EmailBody;
        String linebreak=s1.replaceAll('\n', '<br/>');
        //mail.setHtmlBody(EmailBody);
        mail.setHtmlBody(linebreak);
        mail.setReplyTo('replyemailhandlermass@j-ol83nad8yzireb1bk897ub7e4qsmv896x02ic69nn4aww9k86.c-3vvireai.cs14.apex.sandbox.salesforce.com');
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
            
            save_emails(selectedLeadWrap,EmailSubject,EmailBody,attachment.Name,attachment.Body);
            
       }
    //    else {
    
  //  }
    
     return null;
    } 
    /***************end of send email*************************/
    
    
    /************************save email records******************/
    
    public void save_emails(list<wrapperLead> selected_Accs,string EmailSubject,String EmailBody,String AttachmentName,Blob AttachmentBody){
    
    list<Email_Tracking__c> emailRecs = new list<Email_Tracking__c>();
    
        for(wrapperLead each :selected_Accs){
        
            Email_Tracking__c individual = new Email_Tracking__c();
            individual.lead__c= each.Lead.Id;
            individual.Email_Body__c = EmailBody;
            individual.Email_Subject__c = EmailSubject;
            individual.Email_Message_Type__c='Mass Email';
            individual.Email_Status__c='Sent Email';
            if(null !=AttachmentBody){
            individual.Attachment__c= AttachmentName;
            individual.Email_Attachment_Content__c = EncodingUtil.base64Encode(AttachmentBody);
            }
            emailRecs.add(individual );
        }
        
        insert emailRecs;
    
    
    }
    /***************end of sav emails***********************/
    
    public void test(){
    System.debug('>>>>>>>>>>>>> '+AccountTypeValuesSelected [0].getLabel());
    }
       }