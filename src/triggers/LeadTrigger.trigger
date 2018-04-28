trigger LeadTrigger on Lead (after insert, after delete, after undelete, before insert, before update) {


      if(Trigger.isAfter){
      if(Trigger.isInsert){
           // Case_TriggerFunctions.SendEmailToLead(Trigger.new); 
        }
       } 
        
        if(Trigger.isBefore){ 
            system.debug('>>>>> in trigger before');
            if(Trigger.isInsert){
            if(Trigger.new[0].FirstName == '' || Trigger.new[0].FirstName == null){
                Trigger.new[0].addError('First Name is mandatory');
            }
            system.debug('>>> in before insert');
                Lead_TriggerFunctions.SendEmailToLead(Trigger.new);
                Lead_TriggerFunctions.SendEmailToLeadOnDuplicateDetection(Trigger.new);
              //  Lead_TriggerFunctions.SendEmailToDuplicateLead(Trigger.new); 
                

       
                
            }
           }
           
           if(Trigger.isAfter){
           
           if(Trigger.isInsert){
                List<ID> leadIDs = new List<ID>();
                    leadIDs.addAll(Trigger.newMap.keyset());
                      //Added as part of DEF-016310 
        if(System.isFuture() == false && System.isBatch() == false){
            Lead_TriggerFunctions.deleteDuplicateLead(leadIDs);
        }
       
            
            }
           
           
           }
           
           
          
}