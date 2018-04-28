({
	getAccounts : function(component,page) {
        var action = component.get("c.getAllAccounts");
        action.setStorable();
		var pageSize = component.get("v.pageSize");
		action.setParams({
            "pageSize": pageSize,
            "pageNumber": page || 1
    	});
    	action.setCallback(this, function(response) {
            console.log('# getAllAccounts callback %f', (performance.now() - startTime));
			var result = response.getReturnValue();
            var allAccounts = result.Accounts;
            var ModAccs = [];
            for(var i=0;i<allAccounts.length;i++){
               	allAccounts[i].selectable = false;
                ModAccs.push(allAccounts[i]);
            }
           // component.set("v.funds", result.funds);
          console.log('result ',result);
             component.set("v.Accounts", ModAccs);
           component.set("v.page", result.page);
           component.set("v.total", result.total);
           component.set("v.pages", Math.ceil(result.total/pageSize));
               component.set("v.show_loader",false);

    	});
        var startTime = performance.now();
    	$A.enqueueAction(action);
		
	},
    fetchPickListVal: function(component) {
      /* call the apex getselectOptions method which is returns picklist values
         set the picklist values on "picklistOptsList" attribute [String list].
         which attribute used for iterate the select options in component.
       */  
        var action = component.get("c.getAccountType");
     /*   action.setParams({
             "objObject": {sobjectType : 'Account'},
             "fld": fieldName
        });*/
        action.setCallback(this, function(response) {
            console.log(response.getReturnValue());
            if (response.getState() == "SUCCESS") {
                var accPlan = response.getReturnValue();
                component.set("v.picklistOptsList", accPlan.AccountPlanType);
                component.set("v.ClientTypeOptsList",accPlan.AccountClient);
                component.set("v.AccountTypeOptsList",accPlan.AccountType);
                 component.set("v.AccountClassOptsList",accPlan.AccountClass);
                component.set("v.EmailTypeOptsList",accPlan.EmailType);
            }
        });
        $A.enqueueAction(action);
    },
})