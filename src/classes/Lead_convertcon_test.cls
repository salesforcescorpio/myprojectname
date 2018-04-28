@isTest(seeAlldata = true)
private class Lead_convertcon_test{

private static testMethod void testPositive() {
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

Apexpages.currentpage().getparameters().put('id',a.id);
    Lead_convertcon ll = new Lead_convertcon(null);
    
    ll.onloadpage();
    
    ll.myCheckbox1 = true;
    ll.convertlead();
    
    ll.doNoting();
    
    ll.dosubmit();
    
    ll.selectaccount = '';
    
}



}