@isTest(SeeAllData = false)
    Public class Test_MassEmailingController{
    public static testmethod void MassEmailingControllerm1(){
    system.Test.startTest();
    
    //create Account
    Account acc = New Account();
    acc.Class__c='Tier - 1';
    acc.First_Name__c='test';
    acc.Last_Name__c='Account';
    acc.Personal_Number__c='9765342167';
    acc.Account_Personal_Email__c='Test@richtext.com';
    acc.Account_Official_Email__c='Test@gmail.com';
    acc.Work_Number__c='4356789087';
    acc.Name='test';
    acc.Type__c='Retirement Plan';
    acc.Account_Plan_Type__c='401(k)'; 
    acc.class__c='Tier - 1';
    insert acc;
   
   MassEmailingController con= new MassEmailingController();
   MassEmailingController.wrapperAccount AccountListRecs= new MassEmailingController.wrapperAccount(acc);
   MassEmailingController.wrapperAccount selectedAccountswrap= new MassEmailingController.wrapperAccount(acc);
   con.EmailSubject='test Subject';
   con.EmailBody='test Body';
   con.allErrorMsg='ttttt';
   con.ShowAccTable=true;
   con.showacclist=true;
   con.contentType='application/vnd.oasis.opendocument.text';
   con.attachment = new Document();
   con.selectedAccType=new string[]{'Retirement Plan'};
   con.selectedAccPlan= new string[]{''};
   con.selectedAccClass=new string[]{'Tier - 1'};
   con.selectedemails=new string[]{'Official Email','Personal Email'};
  // con.strSoql='';
  // con.selectedAccounts =new List<Account>();
   // con.test();
   con.goBack();
      
      con.fetchRecords();
      
       for( MassEmailingController.wrapperAccount cc : con.AccountListRecs){
          cc.selected=true;
         }
         for( MassEmailingController.wrapperAccount cc : con.AccountListRecs){
         // MassEmailingController.selectedAccountswrap.add(cc);
         }
         
         con.ChangeManager();
         con.getSelected();
         try{
         con.ProcessSelected();
         }catch(Exception ex){}
        try{
         con.sendEmail();
           }catch(Exception ex){}
       
       try{
         con.createQuery();
          }catch(Exception ex){}
        
         con.sendemail_validation();
         try{
         con.save_emails(null,null,null,null,null);
           }catch(Exception ex){}
       
         system.Test.StopTest();
    
    
    
    }
    }