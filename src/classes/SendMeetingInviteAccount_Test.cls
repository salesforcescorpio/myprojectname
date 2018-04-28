@isTest(seeAllData=true)
    public Class SendMeetingInviteAccount_Test
   {
     //Test Method for main class
     static testMethod void method1()
    {
    
   Account a = new Account();
a.name = 'test';
a.Account_Plan_Type__c = '401(k)';
a.Class__c = 'Tier - 1';
a.Client_Type__c = 'client';
a.Email__c = 'test@test.com';
a.First_Name__c = 'first';
a.Last_Name__c = 'last';
a.Source__c = 'Created From Lead';
a.Type__c = 'Retirement Plan';
a.Account_Official_Email__c = 'test@est.com';

insert a;

    
      ApexPages.StandardController sc = new ApexPages.StandardController(a);
    SendMeetingInviteAccount sa = new SendMeetingInviteAccount(sc);
    sa.subject = 'sample';
    sa.startDateTime = system.now().addDays(1);
    sa.endDateTime  = system.now().addDays(2);
    
    sa.getItems();
    sa.dosubmit();
   // 
   sa.sendInvite();
    try{
        sa.showEmail();
    }catch(Exception ex){}
    
    }
    
    
    
    }