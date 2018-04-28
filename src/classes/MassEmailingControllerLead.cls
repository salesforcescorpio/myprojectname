public with sharing class MassEmailingControllerLead {
   public String strSoql {get;set;}                   //SOQL query
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
    public List<wrapperLead>selectedLeadwrap {get;set;}
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
     public list<String> selectedSubsource {get;set;}
     
     public list<selectOption> Rating{get;set;}
     public list<selectOption> RatingSelected {get;set;}
     public list<String> selectedRating {get;set;}
     
     public list<selectOption> EmailType {get;set;}
     public list<selectOption> EmailTypeSelected {get;set;}
     public list<string> selectedemails {get ; set ;}
     
     
     
     public String emailTypeis {get;set;}
     
    // String Email_template_body {get;set;}
    
    public String dataFetched {get;set;}
    public String dataExist {get;set;}
     public Document attachment {
  get {
      if (attachment == null)
        attachment = new Document();
      return attachment;
    }
  set;
  }
    
     public MassEmailingControllerLead (){
     dataFetched = 'false';
     dataExist = 'false';
    EmailBody =  [ SELECT Id, Name,  HtmlValue FROM EmailTemplate where Name='Account_mass_email' limit 1].HtmlValue ;
     email_valiation = false;
     sendEmailis = 'no';
     emailTypeis = 'Personal Email;Official_Email__c';
     AccountTypeValuesSelected  = new list<selectOption>();
     AccountPlanTypeValuesSelected  = new list<selectOption>();
     StatusSelected  = new list<selectOption>();
    LeadSourceSelected  = new list<selectOption>();
    RatingSelected  = new list<selectOption>();
    LeadSubSourceSelected  = new list<selectOption>();
     EmailTypeSelected = new list<selectOption>();
        selectedAccType = new list<String>();//A
       selectedAccPlan = new list<String>();//B
       selectedStatus = new list<String>();//C
       selectedLeadSource = new list<String>();//D
       selectedRating = new list<String>();//E
       selectedSubsource = new list<String>();//F
       selectedemails = new list<string>();
     
     
     showerror = false;
     show_email = false;
     typeOfEmail = '';
     sample_lead = new Lead();
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
       
       
       //Rating
         Schema.DescribeFieldResult fieldResult7= Lead.Rating.getDescribe();
        List<Schema.PicklistEntry> ple7 = fieldResult7.getPicklistValues();
        Rating= new list<selectOption>();  
        for( Schema.PicklistEntry f : ple7)
       {
          Rating.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
       
       //Leadsource
         Schema.DescribeFieldResult fieldResult5= Lead.LeadSource.getDescribe();
        List<Schema.PicklistEntry> ple5 = fieldResult5.getPicklistValues();
        LeadSource = new list<selectOption>();  
        for( Schema.PicklistEntry f : ple5)
       {
          LeadSource.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
       
       //Lead Status 
         Schema.DescribeFieldResult fieldResult4= Lead.Status.getDescribe();
        List<Schema.PicklistEntry> ple4 = fieldResult4.getPicklistValues();
        Status= new list<selectOption>();  
        for( Schema.PicklistEntry f : ple4)
       {
          Status.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
       
       //LeadSubsource
         Schema.DescribeFieldResult fieldResult6= Lead.Lead_sub_source__c.getDescribe();
        List<Schema.PicklistEntry> ple6 = fieldResult6.getPicklistValues();
        LeadSubSource = new list<selectOption>();  
        for( Schema.PicklistEntry f : ple6)
       {
          LeadSubSource.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       
        //Email type
          EmailType = new list<selectOption>();  
          EmailType.add(new SelectOption('Official Email', 'Official Email'));
          EmailType.add(new SelectOption('Personal Email', 'Personal Email'));
       
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
                for(Lead  objLead  : (List<Lead>) con.getRecords()){
                LeadListRecs.add(new wrapperLead(objLead ));
                }
            } 
        return null;
    }


    public class wrapperLead{
        public Lead  Lead{get; set;}
        public Boolean selected {get; set;}
        
        
        public wrapperLead(Lead objlead) {
            Lead = objlead;
            selected = false;
        }

    }

    public PageReference getSelected()
    {
        selectedLeads.clear();
        for(wrapperLead wrapobj  : LeadListRecs)
        if(wrapobj.selected == true)
        selectedLeads.add(wrapobj.lead);
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
     selectedLeadwrap =new list<wrapperLead>();
     if(LeadListRecs!=null && LeadListRecs.size()>0)
     for(wrapperLead wrapobj : LeadListRecs){
           if( (wrapobj.Selected==true && wrapobj.Lead.Email!=null) || (selectedIds.contains(wrapobj.Lead.id) && wrapobj.Lead.Email!=null ) || (selectedAll=='true' && wrapobj.Lead.Email!=null ) ){
            selectedLeadwrap.add(wrapobj);
           }
            
         }
         if(selectedLeadwrap.size() >0){
         show_email = true;
         showacclist=true;
         system.debug('>>>>>'+selectedLeadwrap.size());
         }else{
         showerror =true;
         }
      }   


     
      public string createQuery(){
      system.debug('inside create query');
       string base_strQuery='select id,name,First_Name__c,Type__c,Account_Plant_Type__c,Email,LeadSource,Lead_sub_source__c,Status,Rating,Official_Email__c  from Lead ';
       string strQuery  ='';
       
        System.debug('+++++++++++ '+selectedAccType);
        System.debug('+++++++++++ '+selectedAccPlan);
        System.debug('+++++++++++ '+EmailTypeSelected);
    
      
        if((selectedemails.size() == 0)){
         emailTypeis = 'Personal Email;Official_Email__c';
          //typeOfEmail = 'Personal Email;Official_Email__c';
          System.debug ('>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<< '+strQuery);

        }
      
    
       if((selectedAccType.size()!=0 ) || (selectedAccPlan.size()!=0) || (selectedStatus.size()!=0 ) || (selectedLeadSource.size()!=0) || (selectedRating.size()!=0 ) || (selectedSubsource.size()!=0)|| ((selectedemails.size() !=0))){
      
       //A
      if((selectedAccType.size()!=0)  && (selectedAccPlan.size()==0)  && (selectedStatus.size()==0)&& (selectedLeadSource.size()==0) && (selectedRating.size()==0) && (selectedSubsource.size()==0)){
          strQuery  = '';           strQuery += 'where Type__c in :selectedAccType';
      }
     
     
     //B
        if((selectedAccType.size()==0)     && (selectedAccPlan.size()!=0) && (selectedStatus.size()==0) && (selectedLeadSource.size()==0) && (selectedRating.size()==0) && (selectedSubsource.size()==0)){
    
           strQuery  = '';           strQuery += 'where Account_Plant_Type__c in :selectedAccPlan ';
      }
      
      //C
        if((selectedAccType.size()==0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()==0)   && (selectedSubsource.size()==0)){
    
           strQuery  = '';           strQuery += 'where Status in :selectedStatus ';
      }
       //D
        if((selectedAccType.size()==0)      && (selectedAccPlan.size()==0)      && (selectedStatus.size()==0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()==0)      && (selectedSubsource.size()==0)){
    
           strQuery  = '';           strQuery += 'where LeadSource in :selectedLeadSource ';
      }
       //E
        if((selectedAccType.size()==0)      && (selectedAccPlan.size()==0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()!=0)      && (selectedSubsource.size()==0)){
    
           strQuery  = '';           strQuery += 'where Rating in :selectedRating ';
      }
       //F
        if((selectedAccType.size()==0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()==0)      && (selectedSubsource.size()!=0)){
    
           strQuery  = '';           strQuery += 'where Lead_sub_source__c in :selectedSubsource ';
      }
         
      //AB
       if((selectedAccType.size()!=0)      && (selectedAccPlan.size()!=0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()==0)      && (selectedSubsource.size()==0)){
      
           strQuery = '';           strQuery += 'where Type__c in:selectedAccType AND Account_Plant_Type__c in :selectedAccPlan ';
      }
      
      
      //AC
      if((selectedAccType.size()!=0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()==0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType AND Status in :selectedStatus';
      }
      
      //AD
      if((selectedAccType.size()!=0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()==0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType AND LeadSource in :selectedLeadSource';
      }
      
      
      //AE
      if((selectedAccType.size()!=0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()!=0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType AND Rating in :selectedRating';
      }
      
      //AF
      if((selectedAccType.size()!=0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()==0)      && (selectedSubsource.size()!=0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType AND Lead_sub_source__c in :selectedSubsource';
      }
      
      //BC
        if((selectedAccType.size()==0)       && (selectedAccPlan.size()!=0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()==0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where Account_Plant_Type__c in:selectedAccPlan AND Status in :selectedStatus';
      }
      //BD
        if((selectedAccType.size()==0)       && (selectedAccPlan.size()!=0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()==0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where Account_Plant_Type__c in:selectedAccPlan AND LeadSource in :selectedLeadSource';
      }
      
      
      //BE
        if((selectedAccType.size()==0)      && (selectedAccPlan.size()!=0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()!=0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where Account_Plant_Type__c in:selectedAccPlan AND Rating in :selectedRating';
      }
      
      //BF
        if((selectedAccType.size()==0)       && (selectedAccPlan.size()!=0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()==0)      && (selectedSubsource.size()!=0)){
    
      strQuery = '';           strQuery += 'where Account_Plant_Type__c in:selectedAccPlan AND Lead_sub_source__c in :selectedSubsource';
      }
      
      
      //CD
        if((selectedAccType.size()==0)      && (selectedAccPlan.size()==0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()==0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where status in:selectedStatus AND LeadSource in :selectedLeadSource';
      }
      
      //CE
        if((selectedAccType.size()==0)      && (selectedAccPlan.size()==0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()!=0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where status in:selectedStatus AND Rating in :selectedRating';
      }
      
      //CF
        if((selectedAccType.size()==0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()==0)      && (selectedSubsource.size()!=0)){
    
      strQuery = '';           strQuery += 'where status in:selectedStatus AND Lead_sub_source__c in :selectedSubsource';
      }
      
      //DE
        if((selectedAccType.size()==0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()!=0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where LeadSource in:selectedLeadSource AND Rating in :selectedRating';
      }
      
      
      //DF
        if((selectedAccType.size()==0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()==0)      && (selectedSubsource.size()!=0)){
    
      strQuery = '';           strQuery += 'where LeadSource in:selectedLeadSource AND Lead_sub_source__c in :selectedSubsource';
      }
      
      
      //EF
        if((selectedAccType.size()==0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()!=0)      && (selectedSubsource.size()!=0)){
    
      strQuery = '';           strQuery += 'where Rating in:selectedRating AND Lead_sub_source__c in :selectedSubsource';
      }
      //ABC
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()!=0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()==0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType AND Account_Plant_Type__c in :selectedAccPlan AND Status in :selectedStatus  ';
      }
      
      //ABD
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()!=0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()==0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType AND Account_Plant_Type__c in :selectedAccPlan AND LeadSource in :selectedLeadSource  ';
      }
      
      //ABE
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()!=0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()!=0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType AND Account_Plant_Type__c in :selectedAccPlan AND Rating in :selectedRating  ';
      }
      //ABF
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()!=0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()==0)      && (selectedSubsource.size()!=0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType AND Account_Plant_Type__c in :selectedAccPlan AND Lead_sub_source__c in :selectedSubsource  ';
      }
      
      
      //ACD
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()==0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType AND Status  in :selectedStatus AND LeadSource in :selectedLeadSource  ';
      }
      
      //ACE
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()!=0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType AND Status  in :selectedStatus AND Rating in :selectedRating  ';
      }
      
      //ACF
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()!=0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType AND Status  in :selectedStatus AND Lead_sub_source__c in :selectedSubsource  ';
      }
      
      //ADE
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()!=0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType AND LeadSource  in :selectedLeadSource AND Rating in :selectedRating  ';
      }
      
      //ADF
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()==0)      && (selectedSubsource.size()!=0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType    AND LeadSource  in :selectedLeadSource AND Lead_sub_source__c in :selectedSubsource';
      }
      
      //ABCD
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()!=0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()==0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType  AND Account_Plant_Type__c in :selectedAccPlan  AND Status  in :selectedStatus AND LeadSource  in :selectedLeadSource ';
      }
      
      //ABCE
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()!=0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()!=0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType  AND Account_Plant_Type__c in :selectedAccPlan  AND Status  in :selectedStatus AND Rating  in :selectedRating ';
      }
      
      //ABCF
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()!=0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()==0)      && (selectedRating.size()==0)      && (selectedSubsource.size()!=0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType  AND Account_Plant_Type__c in :selectedAccPlan  AND Status  in :selectedStatus AND Lead_sub_source__c in :selectedSubsource ';
      }
      
      
      //ACDE
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()!=0)      && (selectedSubsource.size()==0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType    AND Status  in :selectedStatus AND LeadSource  in :selectedLeadSource AND Rating in :selectedRating ';
      }
      
       //ACDF
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()==0)      && (selectedSubsource.size()!=0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType    AND Status  in :selectedStatus AND LeadSource  in :selectedLeadSource AND Lead_sub_source__c in :selectedSubsource ';
      }
      
      //ADEF
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()==0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()!=0)      && (selectedSubsource.size()!=0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType   AND LeadSource  in :selectedLeadSource AND Rating in :selectedRating AND Lead_sub_source__c in :selectedSubsource ';
      }
      
      
      //BCDE
        if((selectedAccType.size()==0)       && (selectedAccPlan.size()!=0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()!=0)      && (selectedSubsource.size() ==0)){
    
      strQuery = '';           strQuery += 'where Account_Plant_Type__c in :selectedAccPlan  AND Status  in :selectedStatus  AND LeadSource  in :selectedLeadSource AND Rating in :selectedRating  ';
      }
      
      //BCDF
        if((selectedAccType.size()==0)       && (selectedAccPlan.size()!=0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()==0)      && (selectedSubsource.size() !=0)){
    
      strQuery = '';           strQuery += 'where Account_Plant_Type__c in :selectedAccPlan  AND Status  in :selectedStatus  AND LeadSource  in :selectedLeadSource AND Lead_sub_source__c in :selectedSubsource  ';
      }
      
      //CDEF
        if((selectedAccType.size()==0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()!=0)      && (selectedSubsource.size() !=0)){
    
      strQuery = '';           strQuery += 'where  Status  in :selectedStatus  AND LeadSource  in :selectedLeadSource AND Rating in :selectedRating AND Lead_sub_source__c in :selectedSubsource  ';
      }
      
      //5
      
      //ABCDE
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()!=0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()!=0)      && (selectedSubsource.size() ==0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType   AND Account_Plant_Type__c in :selectedAccPlan AND  Status  in :selectedStatus  AND LeadSource  in :selectedLeadSource AND Rating in :selectedRating  ';
      }
      
        //ABCDF
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()!=0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()==0)      && (selectedSubsource.size() !=0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType   AND Account_Plant_Type__c in :selectedAccPlan AND  Status  in :selectedStatus  AND LeadSource  in :selectedLeadSource AND Lead_sub_source__c in :selectedSubsource ';
      }
      
      //ACDEF
        if((selectedAccType.size()!=0)       && (selectedAccPlan.size()==0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()!=0)      && (selectedSubsource.size() !=0)){
    
      strQuery = '';           strQuery += 'where Type__c in:selectedAccType   AND   Status  in :selectedStatus  AND LeadSource  in :selectedLeadSource AND Rating in :selectedRating  AND Lead_sub_source__c in :selectedSubsource ';
      }
      
      
      //BCDEF
        if((selectedAccType.size()==0)       && (selectedAccPlan.size()!=0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()!=0)      && (selectedSubsource.size() !=0)){
    
      strQuery = '';           strQuery += 'where Account_Plant_Type__c in :selectedAccPlan AND  Status  in :selectedStatus  AND LeadSource  in :selectedLeadSource AND Rating in :selectedRating  AND Lead_sub_source__c in :selectedSubsource ';
      }
      
      //ALL
      
      if((selectedAccType.size()!=0)       && (selectedAccPlan.size()!=0)       && (selectedStatus.size()!=0)      && (selectedLeadSource.size()!=0)      && (selectedRating.size()!=0)      && (selectedSubsource.size() !=0)){
    
      strQuery = '';
           strQuery += 'where Type__c in:selectedAccType  AND  Account_Plant_Type__c in :selectedAccPlan AND  Status  in :selectedStatus  AND LeadSource  in :selectedLeadSource AND Rating in :selectedRating  AND Lead_sub_source__c in :selectedSubsource ';
      }
      
      
        
        else if(EmailTypeSelected.size() != 0 && EmailTypeSelected != null   ){
        emailTypeis = '';
        for(selectoption each:EmailTypeSelected){
          //emailTypeis = 'Personal Email;Official_Email__c';
     
   
            if(strQuery ==''){
             if(each.getvalue() == 'Official Email'){
                strQuery += ' where Official_Email__c!=\'\'';               emailTypeis += 'Official_Email__c;';               typeOfEmail = 'Official_Email__c';
              }else{
                    strQuery += ' where  Email !=\'\'';            emailTypeis += 'Personal Email;';            typeOfEmail = 'Personal Email';
     
              }  
                
            }else{
            
             if(each.getvalue() == 'Official Email'){
                strQuery += ' and  Official_Email__c!=\'\'';               emailTypeis += 'Official_Email__c;';         typeOfEmail = 'Official_Email__c';
     
              }else{
                    strQuery += ' and  Email !=\'\'';                  emailTypeis += 'Personal Email;';                   typeOfEmail = 'Personal Email';
     
              }  
           
            }
            }
        
        }
        if((EmailTypeSelected.size() > 1)){       typeOfEmail='';
        }
        if(strQuery !=''){    base_strQuery = base_strQuery+strQuery;
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
      
        LeadListRecs  = new List<wrapperLead>();
       system.debug('>>>>>>'+AccountType);
       selectedAccType = new list<String>();
       selectedAccPlan = new list<String>();
       selectedStatus = new list<String>();
       selectedLeadSource = new list<String>();
       selectedRating = new list<String>();
       selectedSubsource = new list<String>();
       
        for(selectOption  each:AccountTypeValuesSelected){    selectedAccType.add(each.getvalue());
        }
               
         for(selectOption  each:AccountPlanTypeValuesSelected){  selectedAccPlan.add(each.getvalue());
        }
        
         for(selectOption  each:StatusSelected){         selectedStatus.add(each.getvalue());
        }
        
         for(selectOption  each:LeadSourceSelected){    selectedLeadSource.add(each.getvalue());
        }
        
         for(selectOption  each:RatingSelected){     selectedRating.add(each.getvalue());
        }
        
         for(selectOption  each:LeadSubSourceSelected){       selectedSubsource.add(each.getvalue());
        }
        
        for(selectOption  each:EmailTypeSelected){            selectedemails.add(each.getvalue());
        }
        
        if(EmailTypeSelected.size() == 0){
        
           emailTypeis = 'Personal Email;Official_Email__c';
  
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
                 dataExist = 'true';
    
                con.setPageSize(intRecsize);
                con.setpageNumber(1);
               
               
               for(Lead objlead: lstCas ){
                   LeadListRecs.add(new wrapperLead(objlead));
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
       
       sendEmailis = 'No';
            email_valiation = false;
     List<Messaging.SingleEmailMessage>  myEmails = new List<Messaging.SingleEmailMessage>();
       if(EmailSubject!=null && EmailBody!=null){
           for(wrapperLead wrapobj  : selectedLeadwrap){
            List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
           //System.debug('>>>>>>>>>>>>>>>> '+wrapobj .Account.get(typeOfEmail));
                                  
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
            if(wrapobj.Lead.Email!=null || wrapobj.Lead.Email==''){
            Emails.add(wrapobj.Lead.Email);}
            if(wrapobj.Lead.Official_Email__c!=null || wrapobj.Lead.Official_Email__c==''){
            Emails.add(wrapobj.Lead.Official_Email__c);}
        }        
        else if(typeOfEmail == 'Official_Email__c'){
        Emails.add(wrapobj.Lead.Official_Email__c);
        }else{
            Emails.add(wrapobj.Lead.Email);
        
        }
        
        if(Emails==null  ){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please select the records'));}
        mail.setToAddresses(Emails);
      //  mail.setTargetObjectId( UserInfo.getUserId() );
        mail.setBccAddresses(toAddresses);
        mail.setSubject(EmailSubject);
        mail.setSaveAsActivity(false); 
        
        String s1=EmailBody.replace('{#user}',wrapobj.Lead.First_Name__c);
        String linebreak=s1.replaceAll('\n', '<br/>');
        
        //mail.setHtmlBody(EmailBody);
        mail.setHtmlBody(linebreak);
        //mail.setReplyTo('replyemailhandlermass@j-ol83nad8yzireb1bk897ub7e4qsmv896x02ic69nn4aww9k86.c-3vvireai.cs14.apex.sandbox.salesforce.com');
        mail.setReplyTo('replyemailhandlermasslead@10ycb198uceo5etmkarp6ldjcqvjcujsf6xrealv2o1jr0rbg6.c-3vvireai.cs14.apex.sandbox.salesforce.com');
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
            
            save_emails(selectedLeadwrap,EmailSubject,EmailBody,attachment.Name,attachment.Body);
            
       }
    //    else {
    
  //  }
    
    return null;
    } 
    /***************end of send email*************************/
    
    
    /************************save email records******************/
    
    public void save_emails(list<wrapperLead> selected_Accs,string EmailSubject,String EmailBody,String AttachmentName,Blob AttachmentBody){
    
    list<Email_Tracking__c> emailRecs = new list<Email_Tracking__c>();
   Document doc = new Document();
    doc.isPublic=true;
    doc.Body = AttachmentBody;
    doc.Name = AttachmentName;
    doc.folderId=UserInfo.getUserId(); 
    DataBase.saveResult docSaveResult = DataBase.insert(doc, false);
    system.debug(':::::::::::::::::::::::;'+doc);
        for(wrapperLead each :selected_Accs){
        
            Email_Tracking__c individual = new Email_Tracking__c();
            individual.lead__c= each.Lead.Id;
            individual.Email_Body__c = EmailBody;
            individual.Email_Subject__c = EmailSubject;
            individual.Email_Message_Type__c='Mass Email';
            individual.Email_Status__c='Sent Email';
            if(null !=AttachmentBody){
            individual.Attachment__c= doc.id;
            individual.Email_Attachment_Content__c = EncodingUtil.base64Encode(AttachmentBody);
           // if(EncodingUtil.base64Encode(AttachmentBody).length > 32760){
                individual.Email_Attachment_Content__c = individual.Email_Attachment_Content__c.left(32760);
           // }
            }
            emailRecs.add(individual);
        }
        
        insert emailRecs;
    
    
    }
    /***************end of sav emails***********************/
    public void test(){}
       }