@isTest(SeeAllData=true) 
public class MassEmailingControllerLead_test{

 public static testMethod void testPositive() {
    Test.StartTest();
        Lead a = new Lead();
a.Company = 'test1';
a.LeadSource = 'Web-to-lead';
a.Class_Type__c = 'Tier - 1';
a.Email = 'test@test1.com';
a.First_Name__c = 'first1';
a.Last_Name__c = 'last1';
a.FirstName = 'first1';
a.LastName = 'last1';
a.Type__c = 'Retirement Plan';
a.Official_Email__c = 'test@est1.com';
a.Account_Plant_Type__c = '401(k)';
a.IsDuplicate__c = false;

insert a;
    MassEmailingControllerLead  Me = new MassEmailingControllerLead ();
    Me.contentType='Test';
     Me.EmailSubject = 'sample';
    Me.EmailBody= 'sample';
    Me.BusinessType= new List<SelectOption>();
    
    
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
       
     Me.selectedStatus.add('test');
     Me.createQuery();
       
     Me.selectedLeadSource.add('test');
     Me.createQuery();
       
       
       
     Me.BusinessType.add(new selectOption('Official Email','Official Email'));
    // Me.BusinessTypeSelected.add(new selectOption('Official Email','Official Email'));
       
    Me.selectedLeadwrap = new list< MassEmailingControllerLead.wrapperLead>();
    for(Lead each :[select id,First_Name__c,Email,Official_Email__c from Lead  where Email !='' limit 1] ){
       
       MassEmailingControllerLead.wrapperLead  wl = new MassEmailingControllerLead.wrapperLead(each);
       Me.selectedLeadwrap.add(wl);
       }
        
    try{
   
    Me.sendEmail();
     }catch(Exception ex){}
     
     Me.save_emails(Me.selectedLeadwrap,'test','test','test',null);
    }
    
    
    
 public static testMethod void testPositive1() {
    Test.StartTest();
    
    
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