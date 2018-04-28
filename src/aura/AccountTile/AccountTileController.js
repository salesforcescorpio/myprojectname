({
	accSelected : function(component, event, helper) {
		//alert(component.get("v.acc_id"));
       
        component.set("v.acc.selectable",!component.get("v.acc.selectable"));
        var ids = component.get("v.selected_records");
            
        if(component.get("v.acc.selectable")){
            ids.push(component.get("v.acc_id"));
            component.set("v.selected_records",ids);
        }else{
            ids.pop(component.get("v.acc_id"));
        }
	},
    doinit:function(component){
      ///  alert(window.location.href);
      var urlIs =''+ window.location.href;
        console.log('urlIs ',urlIs);
        if(urlIs.indexOf('/fa/')!=-1){
            component.set("v.isCommunity",true);
        }else{
            component.set("v.isCommunity",false);
            
        }
    }
})