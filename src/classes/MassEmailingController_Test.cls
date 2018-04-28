@isTest(seeAllData=true)
    public Class MassEmailingController_Test
   {
     //Test Method for main class
     static testMethod void method1()
    {
    MassEmailingController mm = new MassEmailingController();
    mm.EmailTypeSelected.add(new selectOption('Official Email','Official Email'));
     mm.EmailTypeSelected.add(new selectOption('Official Email1','Official Email1'));
    mm.fetchRecords();

    Test.StartTest();
    
    MassEmailingController Me = new MassEmailingController();
    Me.contentType='Test';
     Me.EmailSubject = 'sample';
    Me.EmailBody= 'sample';
   
    
    //selectedBusinessType
    
    
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
       
   
     Me.createQuery();
       
    
     Me.createQuery();
       
       
       
    // Me.BusinessType.add(new selectOption('Official Email','Official Email'));
    // Me.BusinessTypeSelected.add(new selectOption('Official Email','Official Email'));
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

    
    Me.selectedAccountswrap  = new list< MassEmailingController.wrapperAccount>();
    for(Account each :[select Client_Type__c,First_Name__c,id,name,Type__c,Account_Plan_Type__c,Class__c,Account_Personal_Email__c,Account_Other_Email__c,Account_Official_Email__c from Account where Account_Official_Email__c  !='' limit 1] ){
       
      MassEmailingController.wrapperAccount wl = new MassEmailingController.wrapperAccount(each);
       Me.selectedAccountswrap .add(wl);
       }
        
    try{
   
    Me.sendEmail();
     }catch(Exception ex){}
     
     Me.save_emails(Me.selectedAccountswrap ,'test','test','test',null);
    }
    
    
    
 public static testMethod void testPositive1() {
    Test.StartTest();
    
    MassEmailingControllerOnLead Me = new MassEmailingControllerOnLead();
    Me.contentType='Test';
     Me.EmailSubject = 'sample';
    Me.EmailBody= 'sample';
    Me.BusinessType= new List<SelectOption>();
    
    
    //selectedBusinessType
    
    
    Me.selectedAccType .add('test');
    Me.createQuery();
    try{
    Me.fetchRecords();
    }catch(Exception ex){}
  
    Me.getSelected();
    try{
    Me.ProcessSelected();
    }catch(Exception ex){}
      try{
   
    Me.ChangeManager();
    }catch(Exception ex){}
    Me.GoBack();
    //Me.sendemail_validation();
   
     Me.selectedAccPlan.add('test');
     Me.EmailTypeSelected.add(new selectOption('Official Email','Official Email'));
     Me.EmailTypeSelected.add(new selectOption('Of','Of'));
     Me.createQuery();
       
     Me.selectedStatus.add('test');
     Me.createQuery();
       
     Me.selectedLeadSource.add('test');
     Me.createQuery();
       
       
       
     Me.BusinessType.add(new selectOption('Official Email','Official Email'));
     Me.BusinessTypeSelected.add(new selectOption('Official Email','Official Email'));
       
    Me.selectedLeadwrap = new list< MassEmailingControllerOnLead.wrapperLead>();
    for(Lead each :[select id,First_Name__c,Email,Official_Email__c from Lead  where Email !='' limit 1] ){
       
       MassEmailingControllerOnLead.wrapperLead  wl = new MassEmailingControllerOnLead.wrapperLead(each);
       Me.selectedLeadwrap.add(wl);
       }
        
    try{
   
    Me.sendEmail();
     }catch(Exception ex){}
     
     Me.save_emails(Me.selectedLeadwrap,'test','test','test',null);
    }
}