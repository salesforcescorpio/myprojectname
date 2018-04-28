trigger OpportunityNamePopulate on Opportunity(before insert) {

try{
        if(!skipTriggers.getSkipOpportunityTrigger()){
            for(Opportunity opp:trigger.New){
                
               list<String> Oppname = new list<String>();
               Oppname = opp.Name.split(' ');
                if(Oppname.size()>0){
                    
                    opp.First_Name__c = Oppname[0];
                    opp.Last_Name__c = Oppname[1];
                }
                else{
                        opp.First_Name__c = Oppname[0];
                        opp.Last_Name__c = Oppname[0];
                 } 
                
            }
       }
    
  } 
    catch (Exception e){
    }
    
  }