@isTest(seeAllData=true)
    public Class SendMeetingInvite_Test
   {
    static testMethod void method1()
    {
     ApexPages.StandardController sc = new ApexPages.StandardController([select id from lead limit 1]);
    SendMeetingInvite ss = new SendMeetingInvite(sc);
    
    ss.Description = 'test';
    ss.sendTo = 'ttt@ttt.com';
    ss.Subject = 'yudfs';
    ss.startDateTime = System.now().addDays(2);
    ss.endDateTime = System.now().addDays(3);
    ss.eventDate = SYstem.Today().addDays(1);
    ss.meetingObj.Email_Type__c = 'test';
    ss.showEmail();
    ss.toAddresses = new list<String>();
    ss.toAddresses.add('sfsdf@sdad.com');
    try{
    ss.sendInvite();
    }catch(Exception ex){}
    ss.getItems();
    ss.dosubmit();
    
    
    renderFile rr = new renderFile();
    rr.fileBody  = Blob.valueOf('asdfasdas');
    rr.contentType  = 'text';
    rr.fileName  = 'adas';
   // rr.renderFile();
    rr.reRender();
    rr.save();
    
   
   }
   
   
       static testMethod void method2()
    {
     ApexPages.StandardController sc = new ApexPages.StandardController([select id from opportunity limit 1]);
    SendMeetingInviteOpportunity ss = new SendMeetingInviteOpportunity(sc);
    
    ss.Description = 'test';
    ss.sendTo = 'ttt@ttt.com';
    ss.Subject = 'yudfs';
    ss.startDateTime = System.now().addDays(2);
    ss.endDateTime = System.now().addDays(3);
    ss.eventDate = SYstem.Today().addDays(1);
    ss.meetingObj.Email_Type__c = 'test';
    ss.showEmail();
    SendMeetingInviteOpportunity.generateEvent('hello','hello','hello',System.now(),System.now(),'asda',10,'asdasd');
    //ss.toAddresses = new list<String>();
    //ss.toAddresses.add('sfsdf@sdad.com');
    try{
    ss.objEvent = new Event();
    ss.sendInvite();
    }catch(Exception ex){}
    ss.getItems();
    ss.dosubmit();
    
    
   
   }
   
   
   }