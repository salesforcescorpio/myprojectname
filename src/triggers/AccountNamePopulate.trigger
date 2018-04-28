trigger AccountNamePopulate on Account (before insert) {

try{
        if(!skipTriggers.getSkipAccountTrigger()){
            for(Account acc:trigger.New){
                
               list<String> Accname = new list<String>();
               Accname = acc.Name.split(' ');
                if(Accname.size()>0){
                    
                    acc.First_Name__c = Accname[0];
                    acc.Last_Name__c = Accname[1];
                }else{
                acc.First_Name__c = Accname[0];
                    acc.Last_Name__c = Accname[0];
                    
                    
                } 
                
            }
            }
    
  } 
    catch (Exception e){
    }
}