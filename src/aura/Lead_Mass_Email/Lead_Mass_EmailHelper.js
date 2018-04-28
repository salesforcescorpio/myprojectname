({
	
	getLeads : function(component,page) {
        var action = component.get("c.getAllLeads");
        action.setStorable();
		var pageSize = component.get("v.pageSize");
		action.setParams({
            "pageSize": pageSize,
            "pageNumber": page || 1
    	});
    	action.setCallback(this, function(response) {
           console.log('# getAllLeads callback %f', (performance.now() - startTime));
			var result = response.getReturnValue();
             var allLeads = result.Leads;
            var ModLeads = [];
            for(var i=0;i<allLeads.length;i++){
               	allLeads[i].selectable = false;
                ModLeads.push(allLeads[i]);
            }
          
             component.set("v.Leads",ModLeads);
           component.set("v.page", result.page);
           component.set("v.total", result.total);
           component.set("v.pages", Math.ceil(result.total/pageSize));
               component.set("v.show_loader",false);

    	});
        var startTime = performance.now();
    	$A.enqueueAction(action);
		
	},
})