public class SendMeetingInviteOpportunity {

    public boolean renderPeronsal{get;set;}
    public boolean renderwork{get;set;}
    public boolean rendersection{get;set;}
    public String Email_typeis{get;set;}    
    public String getEvent() {
        return null;
    }
    public SendMeetingInviteOpportunity(){}
    public String sendTo { get; set; }
    public String Subject { get; set;}
    public Opportunity opp{ get; set;}
    public boolean isLightning{get;set;}
    public Event objEvent{get;set;}
    public DateTime startDateTime{get;set;}
    public DateTime endDateTime{get;set;}
    public Date eventDate{get;set;}
    public String Description{get; set;}
    Public String Location{get;set;}
     public  List<String> toAddresses{get;set;}
    Public Meeting_Tracking__c meetingObj{
    get {
      if (meetingObj == null)
        meetingObj = new Meeting_Tracking__c();
      return meetingObj;
    }
    set;
    }
  
  private ApexPages.StandardController controller;
  public SendMeetingInviteOpportunity  (ApexPages.StandardController controller) {
  isLightning = false;
      this.opp =(Opportunity)controller.getRecord();
      system.debug('>>>>>'+opp);
        meetingObj = new Meeting_Tracking__c();
        system.debug('>>>>>>>>>'+opp.id);
        meetingObj.Opportunity__c=opp.id;
        Id OwenerId= [ Select id, Owner.Id from Opportunity where id =:opp.id].Owner.id;
        rendersection=false;
  }
  
   
  
  public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();       
        options.add(new SelectOption('--None--','--None--'));
        options.add(new selectoption('Personal Email','Personal Email'));
        options.add(new selectoption('Work Email','Work Email'));
       return options;
    }  
  
  public pageReference showEmail(){
    rendersection=true;
    renderPeronsal=false;
    renderwork=false;
    toAddresses= new List<String>();
    system.debug('selectedEmail Type >>>'+meetingObj.Email_Type__c);
    if(meetingObj.Email_Type__c.equals('--None--')){
    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select Email Type'));
    }
    else{
             if(meetingObj.Email_Type__c.equals('Personal Email')){
             system.debug('inside personal');
                 renderPeronsal=true;
                 if(opp.Personal_Email__c==Null) ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'No Data for Personal Email')); else toAddresses.add(opp.Personal_Email__c);
             } 
    else{
            if(meetingObj.Email_Type__c.equals('Work Email')){
            system.debug('inside work');
            renderwork=true;
            if(opp.Work_Email__c==Null) ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'No Data for Work Email')); else toAddresses.add(opp.Work_Email__c);
        }}

    }
    return null;
    }
    
    public PageReference dosubmit(){
    PageReference pr = new PageReference(label.OrgURL+opp.id);
    pr.setRedirect(true);
    return pr;
}
    
    
    
    public void sendInvite() {
      system.debug('in here');
       //if(sendTo==null){ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'Please Enter Email Time')); return;}
       if(subject==null){ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'Please Enter Description')); return;}
       if(startDateTime==null)  {ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'Please Enter Start Time')); return; }
       Long starttime=startDateTime.getTime();
       if(endDateTime==null){ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'Please Enter End Time'));return;}
      
       Event objEvent= new Event();
       objEvent.ActivityDate=eventDate;
       objEvent.Subject=Subject; 
       objEvent.Description=Description;
       objEvent.EndDateTime=endDateTime;
       objEvent.StartDateTime=startDateTime;
      
       Long endtime=endDateTime.getTime(); 
       Long duation= endtime- starttime;  
       integer endt=endtime.intvalue();
       integer start=starttime.intvalue();
       integer d =endt-start;
      
       system.debug('endt'+endt);system.debug('start'+start);system.debug('duration>>>'+d);
      
      // objEvent.DurationInMinutes= d;   system.debug('END'+endtime);system.debug('START'+starttime);system.debug('DURATION'+objEvent.DurationInMinutes);
       objEvent.OwnerID=userinfo.getUserID();
       //objEvent.whoID=opp.id;
       objEvent.WhatID=opp.id;

    system.debug('objEvent.StartDateTime'+objEvent.StartDateTime);system.debug('objEvent.EndDateTime'+objEvent.EndDateTime);system.debug('objEvent.Description'+objEvent.Description);system.debug('objEvent.ActivityDate'+objEvent.ActivityDate);  
    if(objEvent.EndDateTime<system.now()){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'End Date Time cannot be past')); return;
    }
    if(objEvent.StartDateTime<system.now()){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'Start Date Time cannot be past')); return;
    }
    //if(!Duration==objEvent.EndDateTime){ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'Minimum meeting time is 60 min')); return null;}
       try{
       insert objEvent;
       meetingObj.Start_Date_Time__c=objEvent.StartDateTime;
       meetingObj.End_Date_Time__c=objEvent.EndDateTime;
       meetingObj.Location__c=Location;
       meetingObj.Description__c=subject;
       meetingObj.Meeting_Invite_Status__c = 'sent';
       }
       catch(Exception e){
         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,''+e)); return;
       }
        
        system.debug('in>>>>>');
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        system.debug('toAddresses'+toAddresses);
        mail.setToAddresses(toAddresses);
        mail.setSubject(Subject);
        mail.setPlainTextBody('');
        mail.setReplyto(label.OpportunityMeetingResponseEmail);
        String currentUserEmail = UserInfo.getUserEmail();
        String[] ccAddresses = new String[] {currentUserEmail};
        system.debug(ccAddresses);
        mail.setCcAddresses(ccAddresses);
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.filename = 'meeting.ics';
        attach.ContentType = 'text/calendar;';
        attach.inline = true;
        Blob fileBody = generateEvent( sendTo , Subject, Description , startDateTime, endDateTime, 'testEvent1', 0,Location);
        attach.body=fileBody ;
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {attach});
        Messaging.SendEmailResult[] er = Messaging.sendEmail(new Messaging.Email[] {mail});
        //return null;
        
        
        if(er[0].success){ 
          if(!isLightning){
         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Meeting Invite sent successfully to '+toAddresses[0]+'')); insert meetingObj;}
       
        }
        if(isLightning){
       // meetingObj.Email_Type__c = Email_typeis;
           // meetingObj.Account__c=acc.id;
    
         }
        else {
         System.debug('The email failed to send: '+ er[0].errors[0].message); 
          if(!isLightning){
               ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Meeting Invite Sending Fail to '+toAddresses[0]+'')) ;
               ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,''+er[0].errors[0].message)) ;  
               }
        }
        
    }

    
    public static Blob generateEvent(String recepient, String summary, String description, Datetime startDate, Datetime endDate, String uniqueId, Integer seqNr,String Location) {
    // Build date strings
    String startDateString = '';
    startDateString += startDate.year();
    startDateString += ('0' + startDate.month()).right(2);
    startDateString += ('0' + startDate.day()).right(2);
    startDateString += 'T';
    startDateString += ('0' + startDate.hour()).right(2);
    startDateString += ('0' + startDate.minute()).right(2);
    startDateString += ('0' + startDate.second()).right(2);
    startDateString += 'Z';

    String endDateString = '';
    endDateString += endDate.year();
    endDateString += ('0' + endDate.month()).right(2);
    endDateString += ('0' + endDate.day()).right(2);
    endDateString += 'T';
    endDateString += ('0' + endDate.hour()).right(2);
    endDateString += ('0' + endDate.minute()).right(2);
    endDateString += ('0' + endDate.second()).right(2);
    endDateString += 'Z';

    String nowString = '';
    Datetime nowDT = Datetime.now();
    nowString += nowDT.year();
    nowString += ('0' + nowDT.month()).right(2);
    nowString += ('0' + nowDT.day()).right(2);
    nowString += 'T';
    nowString += ('0' + nowDT.hour()).right(2);
    nowString += ('0' + nowDT.minute()).right(2);
    nowString += ('0' + nowDT.second()).right(2);
    nowString += 'Z';

    // Generate actual body
    String txtInvite = '';
    txtInvite += 'BEGIN:VCALENDAR\n';
    txtInvite += 'PRODID:-//Google Inc//Google Calendar 70.9054//EN\n';
    txtInvite += 'VERSION:2.0\n';
    txtInvite += 'CALSCALE:GREGORIAN\n';
    txtInvite += 'METHOD:REQUEST\n';
    txtInvite += 'BEGIN:VEVENT\n';
    txtInvite += 'DTSTART:' + startDateString + '\n';
    txtInvite += 'DTEND:' + endDateString + '\n';
    txtInvite += 'DTSTAMP:' + startDateString + '\n';
    txtInvite += 'ORGANIZER;CN=' + UserInfo.getUserName() + ':MAILTO:' + UserInfo.getUserEmail() + '\n';
    txtInvite += 'UID:' + uniqueId + '\n';
    txtInvite += 'ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=\n';
    txtInvite += ' TRUE;X-NUM-GUESTS=0:mailto:' + recepient + '\n';
    txtInvite += 'CREATED:' + nowString + '\n';
    txtInvite += 'DESCRIPTION:' + description + '\n';
    txtInvite += 'LAST-MODIFIED:' + nowString + '\n';
    txtInvite += 'LOCATION:'+Location+'\n';
    if (seqNr != null) {
        txtInvite += 'SEQUENCE:' + seqNr + '\n';
    }
    txtInvite += 'STATUS:CONFIRMED\n';
    txtInvite += 'SUMMARY:' + summary+ '\n';
    txtInvite += 'TRANSP:OPAQUE\n';
    txtInvite += 'END:VEVENT\n';
    txtInvite += 'END:VCALENDAR\n';

    return Blob.valueOf(txtInvite);
}

    
    
    
}