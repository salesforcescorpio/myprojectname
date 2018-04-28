public with sharing class Opportunityconvertcon{
    
    public opportunity opp {get ; set ;}
    public Account acc {get;set;}
    string  oppid;
    public Opportunityconvertcon(ApexPages.StandardController controller) {
    
      acc = new Account();
          
        oppid = Apexpages.Currentpage().getparameters().get('id');
        opp = new opportunity();
        opp = [select converted_To_Account__c,Class_Type__c,First_Name__c,Last_Name__c,id,name,Account_Type__c,Personal_Email__c,Personal_Phone__c,Type__c,Work_Email__c,Accountid,Account.id from opportunity where id =: oppid];
        system.debug('>>>'+opp);
  
  if(opp.converted_To_Account__c){
  
      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'This Opportunity Already Converted'));
        
  }      
          if(opp.Account.id == null){
            acc.name = opp.name;
            acc.Account_Plan_Type__c = opp.Account_Type__c;
            acc.Account_Personal_Email__c =opp.Personal_Email__c;
            acc.Personal_Number__c = opp.Personal_Phone__c;
            acc.Type__c     =opp.Type__c;
            acc.Account_Official_Email__c  =opp.Work_Email__c;
            acc.First_Name__c = opp.First_Name__c;
            acc.Last_Name__c = opp.Last_Name__c;
            acc.Name=opp.name;
            acc.Source__c = 'Created From Opportunity';
            acc.Class__c   = opp.Class_Type__c;
            
         
        }else{
          acc.name = opp.name;
            acc.Account_Plan_Type__c = opp.Account_Type__c;
            acc.Account_Personal_Email__c =opp.Personal_Email__c;
            acc.Personal_Number__c = opp.Personal_Phone__c;
            acc.Type__c     =opp.Type__c;
            acc.Account_Official_Email__c  =opp.Work_Email__c;
            acc.First_Name__c = opp.First_Name__c;
            acc.Last_Name__c = opp.Last_Name__c;
            
            acc.Name=opp.name;
            acc.Source__c = 'Created From Opportunity';
            acc.ParentId = opp.Account.Id;
            acc.Class__c   = opp.Class_Type__c;
         
        
        }
        
    }
    
    public PageReference dosubmit(){
    PageReference pr = new PageReference('https://markwisneski11111111111--developer1.cs14.my.salesforce.com/'+oppid);
    pr.setRedirect(true);
    return pr;
}
    
    
    
    public pagereference onloadpage(){
    
    
    
   update  opp;
     system.debug('>>>'+opp);
 
    
    
    if (opp.First_Name__c==null || opp.First_Name__c==''){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Opportunity First Name')); return null;}
    if (opp.Last_Name__c==null || opp.Last_Name__c=='') {  ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Opportunity Last Name')); return null; }
    
    //acc = new Account();
    /*         if(opp.Account.id == null){
            acc.name = opp.name;
            acc.Account_Plan_Type__c = opp.Account_Type__c;
            acc.Account_Personal_Email__c =opp.Personal_Email__c;
            acc.Personal_Number__c = opp.Personal_Phone__c;
            acc.Type__c     =opp.Type__c;
            acc.Account_Official_Email__c  =opp.Work_Email__c;
            acc.First_Name__c = opp.First_Name__c;
            acc.Last_Name__c = opp.Last_Name__c;
            acc.Name=opp.name;
            acc.Source__c = 'Created From Opportunity';
            acc.Class__c   = opp.Class_Type__c;
            
         
        }else{
          acc.name = opp.name;
            acc.Account_Plan_Type__c = opp.Account_Type__c;
            acc.Account_Personal_Email__c =opp.Personal_Email__c;
            acc.Personal_Number__c = opp.Personal_Phone__c;
            acc.Type__c     =opp.Type__c;
            acc.Account_Official_Email__c  =opp.Work_Email__c;
            acc.First_Name__c = opp.First_Name__c;
            acc.Last_Name__c = opp.Last_Name__c;
            
            acc.Name=opp.name;
            acc.Source__c = 'Created From Opportunity';
            acc.ParentId = opp.Account.Id;
            acc.Class__c   = opp.Class_Type__c;
         
        
        }*/
 
          acc.Source__c = 'Created From Opportunity';
      
    pagereference pg;
    
        if(opp.Account.id == null){
            
            insert acc;
            
            opp.Accountid = acc.id;
            opp.converted_To_Account__c = true;
            Update opp;
             pg = new pagereference('/'+acc.id);
            //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'Account Has been created Successfully'));
        
        }else{
                opp.converted_To_Account__c = true;
                    Update opp;
            
            insert acc;
            pg = new pagereference('/'+acc.id);
        
        
        }
        return pg;
    }
   

}