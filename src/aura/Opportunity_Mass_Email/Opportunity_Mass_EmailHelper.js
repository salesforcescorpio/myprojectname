({
	getOptys : function(component,page) {
        var action = component.get("c.getAllOpportunitys");
        action.setStorable();
		var pageSize = component.get("v.pageSize");
		action.setParams({
            "pageSize": pageSize,
            "pageNumber": page || 1
    	});
    	action.setCallback(this, function(response) {
          //  console.log('# getAllAccounts callback %f', (performance.now() - startTime));
			var result = response.getReturnValue();
            var allOptys = result.Opportunitys;
            var ModOptys = [];
            for(var i=0;i<allOptys.length;i++){
               	allOptys[i].selectable = false;
                ModOptys.push(allOptys[i]);
            }
           
         //   alert();
           // component.set("v.funds", result.funds);
          console.log('result ',result);
           component.set("v.Opportunities",ModOptys);
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
        var action = component.get("c.getOppType");
     
        action.setCallback(this, function(response) {
            console.log(response.getReturnValue());
            if (response.getState() == "SUCCESS") {
                var OppVal = response.getReturnValue();
                console.log('OppVal ',OppVal);
                component.set("v.AccountOptsList", OppVal.OpportunityAccountType);
                component.set("v.EmailTypeOptsList", OppVal.EmailType);
                component.set("v.BusinessTypeOptsList", OppVal.OpportunityBusinessType);
                component.set("v.LeadTypeOptsList", OppVal.OpportunityLeadSource);
                component.set("v.SellingBusinessOptsList", OppVal.OpportunitySellingBusiness);
                component.set("v.StageOptsList", OppVal.OpportunityStage);
                component.set("v.TypeOptsList", OppVal.OpportunityType);
                
            }
        });
        $A.enqueueAction(action);
    },
})