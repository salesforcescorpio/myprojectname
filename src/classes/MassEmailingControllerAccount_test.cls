@isTest(SeeAllData=true) 
public class MassEmailingControllerAccount_test{

 public static testMethod void testPositive() {
    Test.StartTest();
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
a.Account_Personal_Email__c = 'test@adas.com';
insert a;

    MassEmailingController  Me = new MassEmailingController ();
     Me.EmailSubject = 'sample';
    Me.EmailBody= 'sample';
    Me.selectedAccType .add('test');
    Me.createQuery();
    Me.fetchRecords();
   
    Me.ChangeManager();
    Me.getSelected();
    try{
    Me.ProcessSelected();
    }catch(Exception ex){}
    
    Me.GoBack();
    Me.sendemail_validation();
   
     Me.selectedAccPlan.add('test');
     Me.EmailTypeSelected.add(new selectOption('Official Email','Official Email'));
       Me.EmailTypeSelected.add(new selectOption('Of','Of'));
       Me.createQuery();
       
       // Me.selectedStatus.add('test');
       Me.createQuery();
       
  
    
       Me.selectedAccountswrap  = new list< MassEmailingController.wrapperAccount>();
    for(Account each :[select First_Name__c,id,name,Type__c,Account_Plan_Type__c,Class__c,Account_Personal_Email__c,Account_Other_Email__c,Account_Official_Email__c from Account where Account_Personal_Email__c!='' limit 1] ){
       
       MassEmailingController.wrapperAccount wl = new MassEmailingController.wrapperAccount(each);
       Me.selectedAccountswrap.add(wl);
       }
        
    try{
   
    Me.sendEmail();
     }catch(Exception ex){}
     
     Me.save_emails(Me.selectedAccountswrap ,'test','test','test',null);
    }
}