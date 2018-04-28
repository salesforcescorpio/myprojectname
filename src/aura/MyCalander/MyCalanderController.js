({
	scriptsLoaded : function(component, event, helper) {
        
        
        
        var action = component.get("c.getAppointments");
      action.setCallback(this,function(retData){
            var data=retData.getReturnValue();
                helper.helperMethod(data);    
        });
        
         $A.enqueueAction(action);
       
	}
})