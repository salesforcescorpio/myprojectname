public with sharing class AttachmentUploadController {

    public String EmailBodylinebreaks{get;set;}
    public string selectedEmail {get;set;}               //selected value from selected list
    public Account acc;
    public Id AttachmentId;
    public String emailSubject{get;set;}
    public String emailBody{get;set;}
    public String strImageBlob;
    List<String> toAddresses;
    public boolean renderPeronsal{get;set;}
    public boolean renderwork{get;set;}
    public boolean rendersection{get;set;}
    public blob b;
    public String contentType {get; set;} //to get the attached extension
    
    Public Email_Object__c emailObj{
    get {
      if (emailObj == null)
        emailObj = new Email_Object__c();
      return emailObj;
    }
    set;
    }
       
  public Attachment attachment {
  get {
      if (attachment == null)
        attachment = new Attachment();
      return attachment;
    }
  set;
  }
  
  private ApexPages.StandardController controller;
  public AttachmentUploadController (ApexPages.StandardController controller) {
        this.acc=(Account)controller.getRecord();
        system.debug('>>>>>'+acc);
        emailObj = new Email_Object__c();
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+acc.id);
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+ApexPages.currentPage().getParameters().get('id'));
       emailObj.Account__c=acc.id;
       //emailObj.Account__c=ApexPages.currentPage().getParameters().get('id');
        emailObj.Email_Status__c='Sent Email';
        emailObj.Email_Message_Type__c='Single Email';
        rendersection=false;
    }

    public AttachmentUploadController() {
        renderPeronsal=false;
        renderwork=false;
        List<SelectOption> emailType =getItems();
        
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
  system.debug('selectedEmail Type >>>'+emailObj.Email_Type__c);
  if(emailObj.Email_Type__c.equals('--None--')){
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select Email Type'));
  }
  
      else{
                 if(emailObj.Email_Type__c.equals('Personal Email')){
                 system.debug('inside personal');
                     renderPeronsal=true;
                     if(acc.Account_Personal_Email__c==Null) ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'No Data for Personal Email')); else toAddresses.add(acc.Account_Personal_Email__c);
                 } 
            
            
            
            else{
                if(emailObj.Email_Type__c.equals('Work Email')){
                system.debug('inside work');
                renderwork=true;
                if(acc.Account_Official_Email__c==Null) ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'No Data for Work Email')); else toAddresses.add(acc.Account_Official_Email__c);
            }}
        
        }
        
     
     
  
  
      return null;
  }
  public void upload() {
   

    try {
       //attachment.FolderId='00l28000001FFctAAG';
      // attachment.FolderId='0056A000000zJrSQAU';
     attachment.ParentId=acc.id;
       insert attachment;
      system.debug('>>>'+attachment.id);
      AttachmentId=attachment.id;
      
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
     // return null;
    } finally {
      attachment = new Attachment(); 
    }

    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
   // return null;
  }
  
  
  public PageReference dosubmit(){

    // create case, etc.

    PageReference pr = new PageReference(label.OrgURL+acc.id);
    pr.setRedirect(true);
    return pr;
}
  
  
  public void sendEmail()
    {
        
        if(emailObj.Email_Type__c.equals('--None--')){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select Email Type')); return;
        //insert emailObj;
  }
  
  
          System.debug('>>>>>'+emailObj.Email_Subject__c);System.debug('>>>>>'+emailObj.Email_Body__c);System.debug('>>>>>'+emailObj.Email_Status__c);
        
        if(emailObj.Email_Subject__c==null || emailObj.Email_Subject__c=='') { ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Email Subject')); return; }
        if(emailObj.Email_Body__c==null || emailObj.Email_Body__c=='')       { ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Email Body')); return;    }
        
              
        if(contentType!=null){
        upload();
        try{    
                system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>attachment.id'+attachment.id);
                if(AttachmentId!=null){
                emailObj.Attachment__c=AttachmentId;
                //insert emailObj;
                system.debug('>>>>>>>>>emailObj.Attachment__c'+emailObj.Attachment__c);system.debug('>>>>>>>>>emailObj.Account__c'+emailObj.Account__c);}
            }
            catch(Exception e){
            system.debug('in here');
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,''));
            return;
            }
        }
        
        
        
        
        
        
        
        if(AttachmentId !=null){
            b = [select body from Attachment where id =: AttachmentId ].body;
            strImageBlob=EncodingUtil.base64Encode(b);
        }
        Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
        //List<String> lstString = new List<String>();
        if(toAddresses==null || toAddresses.size()==0) { ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select Email Type')); return; }
        mail.setToAddresses(toAddresses);
        mail.setSubject(emailObj.Email_Subject__c);
        if(AttachmentId !=null){
            Messaging.EmailFileAttachment attachment= new Messaging.EmailFileAttachment();
            attachment.setContentType(contentType);
            attachment.setFileName('test');
            attachment.setInline(false);
            attachment.Body = EncodingUtil.base64Decode(strImageBlob.replaceFirst('data:image/png;base64,',''));
            system.debug('>>>>>'+attachment.Body);
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment});
        }
        String currentUserEmail = UserInfo.getUserEmail();
        String[] ccAddresses = new String[] {currentUserEmail};
        system.debug(ccAddresses);
        mail.setCcAddresses(ccAddresses);
        //mail.setReplyTo('replyemailservice@1oaf6vfn3n9bdg3oyswe67maagt2j7bo7zeaxsiec2o8o0dqso.c-3vvireai.cs14.apex.sandbox.salesforce.com'); 
        mail.setReplyTo(Label.ReplyEmailServiceEmail);
        mail.setSaveAsActivity(false); 
        String s= 'Hi '+ acc.Name+',';
        String s1=emailObj.Email_Body__c;
        String linebreak=s1.replaceAll('\n', '<br/>'); system.debug('>>>>>>>>>>'+linebreak);
        mail.setHtmlBody(linebreak);
       // mail.setHtmlBody(s + '<br/>' +emailObj.Email_Body__c);
        Messaging.SendEmailResult[] result =Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        if(result[0].success){
            System.debug('The email was sent successfully.'); insert emailObj;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Email sent successfully to '+toAddresses[0]+''));
            if(emailObj.id!=null)update emailObj;
            //emailObj.Email_Subject__c=null;
            //emailObj.Email_Body__c=null;
            
            
        }
        else {
    System.debug('The email failed to send: '
          + result[0].errors[0].message); delete emailObj;
}
        
        
       
      
        
    }
  
  

}