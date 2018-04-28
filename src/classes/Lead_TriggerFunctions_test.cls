@isTest(SeeAllData = true)
    Public class Lead_TriggerFunctions_test{
    public static testmethod void testmethod1(){
       Lead a = new Lead();
a.Company = 'test';
a.LeadSource = 'Web-to-lead';
a.Class_Type__c = 'Tier - 1';
a.Email = 'test@test.com';
a.First_Name__c = 'first';
a.Last_Name__c = 'last';
a.FirstName = 'first';
a.LastName = 'last';
a.Type__c = 'Retirement Plan';
a.Official_Email__c = 'test@est.com';
a.Account_Plant_Type__c = '401(k)';
a.IsDuplicate__c = false;

insert a;


    
     try{
    Lead_TriggerFunctions.SendEmailToLead([select id,LeadSource,Phone,email from lead limit 2]);
     }catch(Exception ex){}
    try{
    Lead_TriggerFunctions.SendEmailToLeadOnDuplicateDetection([select id,LeadSource,Phone,email,First_Name__c,Last_Name__c,FirstName,LastName from lead limit 2]);
     }catch(Exception ex){}
    
    
    
    }
    
    }