@isTest(seeAllData=true)
    public Class MassEmailingControllerOnOpportunity_Test
   {
     //Test Method for main class
     static testMethod void method1()
    {
    MassEmailingControllerOnOpportunity mm = new MassEmailingControllerOnOpportunity();
    mm.EmailTypeSelected.add(new selectOption('Official Email','Official Email'));
     mm.EmailTypeSelected.add(new selectOption('Official Email1','Official Email1'));
   // mm.fetchRecords();

    Test.StartTest();
    
    MassEmailingControllerOnOpportunity  Me = new MassEmailingControllerOnOpportunity ();
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
    Me.selectedOpportunitieswrap = new list< MassEmailingControllerOnOpportunity.wrapperOpportunity>();
    for(opportunity each:[select id,name,Type__c,First_Name__c,Account_Type__c,Personal_Email__c,Work_Email__c,Business_Type__c,Selling_Business__c,StageName,LeadSource from Opportunity where Work_Email__c !='' limit 1] ){
       
      MassEmailingControllerOnOpportunity.wrapperOpportunity wl = new MassEmailingControllerOnOpportunity.wrapperOpportunity(each);
       Me.selectedOpportunitieswrap .add(wl);
       }
        
    try{
   
    Me.sendEmail();
     }catch(Exception ex){}
     
     Me.save_emails(Me.selectedOpportunitieswrap ,'test','test','test',null);
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