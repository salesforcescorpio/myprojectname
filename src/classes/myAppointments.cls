public class myAppointments {
    
    
    @AuraEnabled
    public static list<Meeting_Tracking__c> getAppointments(){
        
        
        return [select id,Start_Date_Time__c,End_Date_Time__c,Subject__c  from Meeting_Tracking__c where createdById=:userinfo.getUserid()];
    }

}