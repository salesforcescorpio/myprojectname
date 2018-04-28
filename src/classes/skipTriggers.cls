public class skipTriggers{



    public static boolean SkipAccountTrigger = false;
    public static boolean SkipOpportunityTrigger = false;
    
    
    public static void  setSkipAccountTrigger(boolean skip){
    SkipAccountTrigger = skip;
    
    }
      public static boolean getSkipAccountTrigger(){
                return SkipAccountTrigger;
    
    }



public static void  setSkipOpportunityTrigger(boolean skip){
    SkipOpportunityTrigger = skip;
    
    }
      public static boolean getSkipOpportunityTrigger(){
                return SkipOpportunityTrigger;
    
    }
}