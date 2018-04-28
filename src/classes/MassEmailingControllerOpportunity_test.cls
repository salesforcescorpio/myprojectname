@isTest(SeeAllData=true) 
public class MassEmailingControllerOpportunity_test{

 public static testMethod void testPositive() {
    Test.StartTest();
    
    MassEmailingControllerOnOpportunity  Me = new MassEmailingControllerOnOpportunity ();
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
       
        Me.selectedLeadSource.add('test');
       Me.createQuery();
       
          Me.selectedOpportunitieswrap  = new list< MassEmailingControllerOnOpportunity.wrapperOpportunity>();
    for(Opportunity each :[select id,name,Type__c,First_Name__c,Account_Type__c,Personal_Email__c,Work_Email__c,Business_Type__c,Selling_Business__c,StageName,LeadSource  from Opportunity where Personal_Email__c!='' limit 1] ){
       
       MassEmailingControllerOnOpportunity.wrapperOpportunity wl = new MassEmailingControllerOnOpportunity.wrapperOpportunity(each);
       Me.selectedOpportunitieswrap.add(wl);
       }
        
    try{
   
    Me.sendEmail();
     }catch(Exception ex){}
     
     Me.save_emails(Me.selectedOpportunitieswrap ,'test','test','test',null);
    }
}