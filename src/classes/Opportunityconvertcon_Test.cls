@isTest(seeAllData=true)
    public Class Opportunityconvertcon_Test
   {
     //Test Method for main class
     static testMethod void method1()
    {
    
    Opportunity opp = new opportunity();

opp.name='test';
opp.Type__c='test';
opp.First_Name__c='test';
opp.Account_Type__c='test';
opp.Personal_Email__c='test@ttt.com';
opp.Work_Email__c='sds@adasd.com';
opp.Business_Type__c='Existing Business';
opp.Selling_Business__c= 'Yes';
opp.StageName = 'Closed';
opp.Personal_Phone__c = '1234567';
opp.CloseDate= System.today().addDays(10);

insert opp;
             Apexpages.Currentpage().getparameters().put('id',[select id from opportunity where Personal_Email__c!=null and Personal_Phone__c != null  limit 1].id);
  
    Opportunityconvertcon sa = new Opportunityconvertcon(null);
    
    sa.onloadpage();
    sa.dosubmit();
    
    
    }
    
    
    //Test Method for main class
     static testMethod void method2()
    {
    Opportunity opp = new opportunity();
    opp.name='test';
opp.Type__c='test';
opp.First_Name__c='test';
opp.Account_Type__c='test';
opp.Personal_Email__c='test@ttt.com';
opp.Work_Email__c='sds@adasd.com';
opp.Business_Type__c='Existing Business';
opp.Selling_Business__c= 'Yes';
opp.StageName = 'Closed';
opp.Personal_Phone__c = '1234567';
opp.CloseDate= System.today().addDays(10);

insert opp;
             Apexpages.Currentpage().getparameters().put('id',[select id from opportunity where Personal_Email__c!=null and Personal_Phone__c != null and AccountId = null   limit 1].id);
  
    Opportunityconvertcon sa = new Opportunityconvertcon(null);
    
    sa.onloadpage();
    sa.dosubmit();
    
    
    }
    
    }