({
	doInit : function(component, event, helper) {
		var Accid=component.get("v.recordId");
       // alert(Accid);
        var action= component.get("c.update_AccountforDelete");
        
        action.setParams({
            AccountId : Accid
        });
        
        action.setCallback(this,function(data){
            
           // alert(data.getReturnValue());
            
             var navEvent = $A.get("e.force:navigateToList");
            navEvent.setParams({
                "listViewId": component.get("v.redirectTo"),
                "listViewName": null,
                "scope": "Account"
            });
            navEvent.fire();
        });
        
        $A.enqueueAction(action);
	}
})