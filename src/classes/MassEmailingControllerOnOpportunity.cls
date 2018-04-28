public with sharing class MassEmailingControllerOnOpportunity{
    public String strSoql {get;set;}                  //SOQL query
    String fld='Type'; //Filtering filed 
    public String AccountType{ get; set; }
    public Integer intTotNoOfRecs {get; set;} //Total number of records displayed in table
    public ApexPages.StandardSetController con {get;set;}
    public Integer intRecsize {get;set;} //Number of records displayed per page
    public string allErrorMsg {get;set;} 
    public List<wrapperOpportunity> OpportnityListRecs{get;set;} //Complete list of Wrapper
    public transient List<Opportunity> lstTempCasFltr = new List<Opportunity>(); 
    public transient List<Opportunity> lstTempCas = new List<Opportunity>();
    List<Opportunity> selectedOpportunitys = new List<Opportunity>();
    public List<wrapperOpportunity>selectedOpportunitieswrap {get;set;} 
    public boolean ShowAccTable{get;set;}
    public boolean showacclist{get;set;}
    public String EmailSubject{get;set;}
    public String EmailBody{get;set;} 
    List<String> toAddresses;
    public Opportunity sample_acc{get;set;}
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
     
     public list<selectOption> LeadSource {get;set;}
     public list<selectOption> LeadSourceSelected {get;set;}
     public list<String> selectedLeadSource {get;set;}
     
     
     public String emailTypeis {get;set;}
 
     public Document attachment {
  get {
      if (attachment == null)
        attachment = new Document();
      return attachment;
    }
  set;
  }
  
    public String dataFetched {get;set;}
    public String dataExist {get;set;}
    
     public MassEmailingControllerOnOpportunity(){
     dataFetched = 'false';
     dataExist = 'false';
     EmailBody =  [ SELECT Id, Name,  HtmlValue FROM EmailTemplate where Name='Account_mass_email' limit 1].HtmlValue ;
     emailTypeis = 'Personal_Email__c;Work_Email__c';
     AccountTypeValuesSelected  = new list<selectOption>();
     AccountPlanTypeValuesSelected  = new list<selectOption>();
     BusinessTypeSelected = new list<selectOption>();
     SellingBusinessSelected  = new list<selectOption>();
     EmailTypeSelected = new list<selectOption>();
     StageNameSelected = new list<selectOption>();
     LeadSourceSelected = new list<selectOption>();
       selectedAccType = new list<String>();
       selectedAccPlan = new list<String>();
       selectedBusinessType = new list<String>();
       selectedSellingBusiness= new list<String>();
       selectedStageName= new list<String>();
       selectedLeadSource = new list<String>();
       selectedemails = new list<string>();
      
     
     showerror = false;
     show_email = false;
     typeOfEmail = '';
     sample_acc = new Opportunity();
     InitialList = new list<String>();
     InitialList.add(UserInfo.getUserId());
     CurrentList = new list<String>();
    //Account type List
        Schema.DescribeFieldResult fieldResult = Opportunity.Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        AccountTypeValues = new list<selectOption>();  
        for( Schema.PicklistEntry f : ple)
       {
         // AccountTypeValues.add(f.getValue());
          AccountTypeValues.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
       //Account Plan Type       
         Schema.DescribeFieldResult fieldResult1= Opportunity.Account_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple1 = fieldResult1.getPicklistValues();
        AccountPlanTypeValues = new list<selectOption>();  
        for( Schema.PicklistEntry f : ple1)
       {
         
          AccountPlanTypeValues.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
       //Business Type
       
         Schema.DescribeFieldResult fieldResult2= Opportunity.Business_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple2 = fieldResult2.getPicklistValues();
        BusinessType = new list<selectOption>();  
        for( Schema.PicklistEntry f : ple2)
       {
         
          BusinessType.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
       
       //Email type
          EmailType = new list<selectOption>();  
          EmailType.add(new SelectOption('Official Email', 'Official Email'));
          EmailType.add(new SelectOption('Personal Email', 'Personal Email'));
       
       //Selling Business
       
         Schema.DescribeFieldResult fieldResult3= Opportunity.Selling_Business__c.getDescribe();
        List<Schema.PicklistEntry> ple3 = fieldResult3.getPicklistValues();
        SellingBusiness = new list<selectOption>();  
        for( Schema.PicklistEntry f : ple3)
       {
          SellingBusiness.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
       //Stage 
         Schema.DescribeFieldResult fieldResult4= Opportunity.StageName.getDescribe();
        List<Schema.PicklistEntry> ple4 = fieldResult4.getPicklistValues();
        StageName= new list<selectOption>();  
        for( Schema.PicklistEntry f : ple4)
       {
          StageName.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
        //Leadsource
         Schema.DescribeFieldResult fieldResult5= Opportunity.LeadSource.getDescribe();
        List<Schema.PicklistEntry> ple5 = fieldResult5.getPicklistValues();
        LeadSource = new list<selectOption>();  
        for( Schema.PicklistEntry f : ple5)
       {
          LeadSource.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
    }


    public PageReference ChangeManager() {
         OpportnityListRecs.clear();
        system.debug('AccountType '+AccountType);
        lstTempCasFltr = new List<Opportunity>();
        string Query = createQuery();
        system.debug('>>>>>>'+Query );
        lstTempCas=database.query(Query);
        system.debug('>>>>>>'+lstTempCas.size());
        con = new ApexPages.StandardSetController(lstTempCas);
        con.setPageSize(10);
        intTotNoOfRecs = con.getResultSize();
        if(!con.getRecords().isEmpty()){
                for(Opportunity objOpportunity : (List<Opportunity>) con.getRecords()){
                OpportnityListRecs.add(new wrapperOpportunity(objOpportunity));
                }
            } 
        return null;
    }


    public class wrapperOpportunity{
        public Opportunity opportunity {get; set;}
        public Boolean selected {get; set;}
        
        
        public wrapperOpportunity(Opportunity opp) {
            opportunity = opp;
            selected = false;
        }

    }

    public PageReference getSelected()
    {
        selectedOpportunitys.clear();
        for(wrapperOpportunity oppwrapper : OpportnityListRecs)
        if(oppwrapper.selected == true)
        selectedOpportunitys.add(oppwrapper.opportunity);
        return null;
    }
    public boolean showerror {get ; set ;}
    public String seletec_ids {get;set;} 
    public String selected_All  {get;set;}
    
    public void ProcessSelected(){
        
        String selectedIds = ApexPages.currentPage().getParameters().get('sele_list');
        seletec_ids = selectedIds;
        String selectedAll = ApexPages.currentPage().getParameters().get('selectedAll');
        selected_All = selectedAll ;
        System.debug('selectedIds  are '+selectedIds );
        system.debug('in processing the queries');
        selectedOpportunitieswrap=new list<wrapperOpportunity>();
      if(OpportnityListRecs!=null && OpportnityListRecs.size()>0)
     for(wrapperOpportunity wrapobj : OpportnityListRecs){
           if((wrapobj.Selected==true && wrapobj.opportunity.Personal_Email__c!=null) || (selectedIds.contains(wrapobj.opportunity.id) && wrapobj.opportunity.Personal_Email__c!=null ) || (selectedAll=='true' && wrapobj.opportunity.Personal_Email__c!=null ) ){
             selectedOpportunitieswrap.add(wrapobj);
           }
            
         }
         if(selectedOpportunitieswrap.size() >0){
         show_email = true;
         showacclist=true;
         system.debug('>>>>>'+selectedOpportunitieswrap.size());
         }else{
         showerror =true;
         }
      }   
     
      public string createQuery(){
      system.debug('inside create query');
       string base_strQuery='select id,name,Type__c,First_Name__c,Account_Type__c,Personal_Email__c,Work_Email__c,Business_Type__c,Selling_Business__c,StageName,LeadSource from Opportunity ';
       string strQuery  ='';
       
     System.debug('+++++++++++ '+selectedAccType);
      System.debug('+++++++++++ '+selectedAccPlan);
    
     System.debug('+++++++++++ '+selectedBusinessType);
     System.debug('+++++++++++ '+EmailTypeSelected);
    
      
        if((selectedemails.size() == 0)){
         emailTypeis = 'Personal_Email__c;Work_Email__c';
          //typeOfEmail = 'Personal_Email__c;Work_Email__c';
          System.debug ('>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<< '+strQuery);

        }
    
       if((selectedAccType.size()!=0 ) || (selectedAccPlan.size()!=0) || (selectedBusinessType.size()!=0) || (selectedSellingBusiness.size()!=0) ||(selectedStageName.size()!=0) || (selectedLeadSource.size()!=0) || (selectedemails.size() !=0)){
      
       String subQuery = 'Where';
       
       if(selectedAccType.size()!=0){
           
          
           subQuery += ' Type__c in : selectedAccType ';
       }
       
       if(selectedAccPlan.size()!=0){
           
          if(subQuery != 'Where')
           subQuery += ' and Account_Type__c in : selectedAccPlan ';
        else
            subQuery += ' Account_Type__c in : selectedAccPlan ';   
       }
       
       if(selectedBusinessType.size()!=0){
           
          if(subQuery != 'Where')
           subQuery += ' and Business_Type__c in : selectedBusinessType ';
        else
            subQuery += ' Business_Type__c in : selectedBusinessType '; 
       }
        
        if(selectedSellingBusiness.size()!=0){
           
          if(subQuery != 'Where')
           subQuery += ' and Selling_Business__c in : selectedSellingBusiness ';
        else
            subQuery += ' Selling_Business__c in : selectedSellingBusiness ';   
       }
       
       
       if(selectedStageName.size()!=0){
           
          if(subQuery != 'Where')
           subQuery += ' and StageName in : selectedStageName ';
        else
            subQuery += ' StageName in : selectedStageName ';   
       }
       
       
       if(selectedLeadSource.size()!=0){
           
          if(subQuery != 'Where')
           subQuery += ' and LeadSource in : selectedLeadSource ';
        else
            subQuery += ' LeadSource in : selectedLeadSource '; 
       }
      
       if(subQuery != 'Where'){
       
       base_strQuery = base_strQuery+subQuery ;
       }
        
         if(EmailTypeSelected.size() != 0 && EmailTypeSelected != null   ){
        emailTypeis = '';
        for(selectoption each:EmailTypeSelected){
          //emailTypeis = 'Personal_Email__c;Work_Email__c';
     
   
            if( subQuery  == 'Where' ){
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
        dataFetched = 'true';
    
        OpportnityListRecs  = new List<wrapperOpportunity>();
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
        
         for(selectOption  each:BusinessTypeSelected){
                selectedBusinessType.add(each.getvalue());
        }
        for(selectOption each: SellingBusinessSelected ){
            selectedSellingBusiness.add(each.getValue());
        }
        
        for(selectOption each: StageNameSelected  ){
            selectedStageName.add(each.getValue());
        }
        
        for(selectOption each: LeadSourceSelected  ){
            selectedLeadSource.add(each.getValue());
        }
        
        
        for(selectOption  each:EmailTypeSelected){
                selectedemails.add(each.getvalue());
        }
        
        if(EmailTypeSelected.size() == 0){
        
           emailTypeis = 'Personal_Email__c;Work_Email__c';
  
        }
       system.debug('>>>>>>>>>>>>>>>>'+selectedemails);
        strSoql = createQuery();
        
        System.debug('strSoql-->'+strSoql);
        List<Opportunity> lstCas;
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
               
               
               for(Opportunity objOpportunity: lstCas ){
                   OpportnityListRecs.add(new wrapperOpportunity(objOpportunity));
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
      system.debug('>>>>>>>>>'+selectedOpportunitieswrap.size());
       if(EmailSubject!=null && EmailBody!=null){
           for(wrapperOpportunity oppwrapper : selectedOpportunitieswrap){
            List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
           //System.debug('>>>>>>>>>>>>>>>> '+oppwrapper.Opportunity.get(typeOfEmail));
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
            if(oppwrapper.Opportunity.Personal_Email__c!=null || oppwrapper.Opportunity.Personal_Email__c==''){
            Emails.add(oppwrapper.Opportunity.Personal_Email__c);}
            
            if(oppwrapper.Opportunity.Work_Email__c!=null || oppwrapper.Opportunity.Work_Email__c==''){
            Emails.add(oppwrapper.Opportunity.Work_Email__c);}
        }        
        else if(typeOfEmail == 'Work_Email__c'){
        Emails.add(oppwrapper.Opportunity.Work_Email__c);
        }else{
            Emails.add(oppwrapper.Opportunity.Personal_Email__c);
        }
        
        system.debug('Emails'+Emails);
        system.debug('Emails'+Emails.size());
        if(Emails==null  ){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please select the records'));}
        mail.setToAddresses(Emails);
      //  mail.setTargetObjectId( UserInfo.getUserId() );
        mail.setBccAddresses(toAddresses);
        mail.setSubject(EmailSubject);
        mail.setSaveAsActivity(false); 
        
        String s1=EmailBody.replace('{#user}',oppwrapper.Opportunity.First_Name__c);
        String linebreak=s1.replaceAll('\n', '<br/>');
               
        mail.setHtmlBody(linebreak);
        //mail.setHtmlBody(EmailBody);
        //mail.setReplyTo('replyemailhandlermassopportunity@c-m62j0hlvzrer1ns8534ym2ge55x6ksl998cp40y4745tcrnnj.c-3vvireai.cs14.apex.sandbox.salesforce.com');
        String currentUserEmail = UserInfo.getUserEmail();
        String[] ccAddresses = new String[] {currentUserEmail};
        mail.setCcAddresses(ccAddresses);
        mail.setReplyTo(label.ReplyEmailHandlerMassOpportunityEmail);
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
            
            save_emails(selectedOpportunitieswrap,EmailSubject,EmailBody,attachment.Name,attachment.Body);
            
       }
    //    else {
    
  //  }
    
     return null;
    } 
    /***************end of send email*************************/
    
    
    /************************save email records******************/
    
    public void save_emails(list<wrapperOpportunity> selected_Accs,string EmailSubject,String EmailBody,String AttachmentName,Blob AttachmentBody){
    
    list<Email_Tracking__c> emailRecs = new list<Email_Tracking__c>();
    Document doc = new Document();
    doc.isPublic=true;
    doc.Body = AttachmentBody;
    doc.Name = AttachmentName;
    doc.folderId=UserInfo.getUserId(); 
    DataBase.saveResult docSaveResult = DataBase.insert(doc, false);
    system.debug(':::::::::::::::::::::::;'+doc);
    
        for(wrapperOpportunity each :selected_Accs){
        
            Email_Tracking__c individual = new Email_Tracking__c();
            individual.Opportunity__c= each.opportunity.Id;
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
    return;
    System.debug('>>>>>>>>>>>>> '+AccountTypeValuesSelected [0].getLabel());
    }
       }