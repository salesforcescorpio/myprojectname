public with sharing class Lead_convertcon {
    
    public string leadid {get ; set ;}
    public Lead leadrec {get ; set ;}
    public string selectaccount {get ; set ;}
    public string selectopportunity {get ; set ;}
    public boolean selected {get ; set ;}
    public boolean selectedopp {get ; set ;}
    public string nameacc {get ; set ;}
    public Account acc {get;set;}
    public opportunity opp{get;set;}
    public String searchCategory{get;set;}
    public Lead_convertcon(ApexPages.StandardController controller) {
    searchCategory = '';
        acc  = new Account();
        opp = new opportunity();
    }
    
    public PageReference dosubmit(){
    PageReference pr = new PageReference('https://markwisneski11111111111--developer1.cs14.my.salesforce.com/'+leadid);
    pr.setRedirect(true);
    return pr;
}
    
    
    Public boolean bothCreated {get;set;}
    public void onloadpage(){
        bothCreated = false;
        myCheckbox1 = false;
        leadid = Apexpages.currentpage().getparameters().get('id');
        leadrec = new Lead();
        leadrec = [select Account_Plant_Type__c,Parent_Account__c,id,name,FirstName,LastName,MiddleName,Company,phone,Email,MobilePhone,Type__c,Official_Email__c,Class_Type__c,
                        Street,City,State,Postalcode,country from lead Where id =: leadid ];
        loadData();       
    }
    public boolean myCheckbox1 {get ; set ;}
    public boolean mycheckbox2 {get ; set ;}
   



   public pagereference convertlead()
    {
    if(myCheckbox1 == false && myCheckbox2 == false){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please select atleast one Checkbox')); return null;
          }
      if(myCheckbox1 == true && myCheckbox2 == true){
      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Cannot create Account and Opportunity togeter. Please select only one checkbox'));return null;
      }    
          
      try{
        Database.LeadConvert lc = new Database.LeadConvert();
    //    update Leadrec;
        lc.setLeadId(Leadrec.id);        
        LeadStatus convertStatus = [SELECT Id, MasterLabel 
                                    FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);                       
      
        if(myCheckbox1){
        skipTriggers.setSkipAccountTrigger(true);
        insert acc;
        
        MoveEmailDataOnLeadConversion.moveLeadDataToAccount(Leadrec.id,acc.id,'Account');
        
        Address_Information__c addinfo = new Address_Information__c();
        addinfo.Primary_Address__c = string.valueof(leadrec.Street);
        addinfo.Primary_City__c =  string.valueof(leadrec.City);
        addinfo.Primary_State__c =  string.valueof(leadrec.State);
        if(null != leadrec.PostalCode){       addinfo.Primary_Zip__c =  integer.valueOf(leadrec.PostalCode);
        }
        addinfo.Primary_Country__c = leadrec.country;
        addinfo.Account_Address_Information__c = acc.id;
        insert addinfo;
        lc.setAccountId(acc.id);
        
       // Contact con = [select id,name from Contact where Accountid =: acc.id];
         //delete con;
        }
        lc.setDoNotCreateOpportunity(True);
         
         if(myCheckbox2 == false ){     lc.setDoNotCreateOpportunity(True);
         }else{    
         insert opp;
          MoveEmailDataOnLeadConversion.moveLeadDataToAccount(Leadrec.id,opp.id,'Opportunity');
       
         
         }
         
         Database.LeadConvertResult lcr = Database.convertLead(lc);
         //Mapping Custom Fields Lead to Account
         
         
         
         
         //Deleting Contacts as per requirement
         if(myCheckbox1 == true && myCheckbox2 == true){
            bothCreated = true;        return null;
          }else       
         if(myCheckbox1 == true){
             pagereference pf = new pagereference('/'+acc.id);  return pf;   
          }else if(myCheckbox1 == false && myCheckbox2 == true){
             pagereference pf = new pagereference('/'+opp.id);  return pf;
          
          }
          }catch(exception ex){
         
         ApexPages.addMessages(ex);
         }
              
            return null;
    }
    
    public pagereference doNoting(){
   //loadData();
   String searchCategory = ApexPages.currentPage().getParameters().get('selval');
   if(searchCategory == 'myCheckbox1'){
       myCheckbox1 = true;    myCheckbox2 = false;
   }else if(searchCategory == 'myCheckbox2'){
       myCheckbox1 = false;   myCheckbox2  =true;
   }
    return null;
    }
    
    
    public void loadData(){
    
    
            acc  = new Account();
            nameacc = leadrec.FirstName+' ' +leadrec.LastName;
        
         acc.Name = nameacc ;
        acc.First_Name__c = leadrec.FirstName;
        acc.Last_Name__c = leadrec.LastName;
        acc.Middle_Name__c  = leadrec.MiddleName;
        acc.Type__c = leadrec.Type__c;
        acc.Account_Personal_Email__c = leadrec.Email;
        acc.Work_Number__c = leadrec.Phone;
         acc.Source__c = 'Created From Lead';
         acc.Personal_Number__c = leadrec.MobilePhone;
         acc.Account_Official_Email__c= leadrec.Official_Email__c ;
         acc.Class__c = leadrec.Class_Type__c;
        acc.parentid = leadrec.Parent_Account__c;
        
         
        acc.BillingCity=  string.valueof(leadrec.City);
        acc.BillingState=  string.valueof(leadrec.State);
        if(null != leadrec.PostalCode){
        acc.BillingPostalCode=  leadrec.PostalCode;
        }
        acc.BillingCountry= leadrec.country;
    
        
        
        //create opportunity
        
        opp.Class_Type__c = leadrec.Class_Type__c;
        opp.First_Name__c= leadrec.FirstName;
        opp.Last_Name__c = leadrec.LastName;
        opp.Name= leadrec.name;
        opp.Personal_Phone__c =  leadrec.MobilePhone;
        opp.Personal_Email__c = leadrec.Email;
        opp.Type__c = leadrec.Type__c;
        opp.Account_Type__c =  leadrec.Account_Plant_Type__c;
        opp.AccountId = leadrec.Parent_Account__c;
           opp.StageName= 'Qualification';
        opp.CloseDate = system.today();
    

    
    
    }

}