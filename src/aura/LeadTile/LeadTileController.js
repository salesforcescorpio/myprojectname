({
	ledSelected : function(component, event, helper) {
		//alert(component.get("v.acc_id"));
      // alert('lead tile');
        component.set("v.led.selectable",!component.get("v.led.selectable"));
        var ids = component.get("v.selected_records");
            
        if(component.get("v.led.selectable")){
            ids.push(component.get("v.led_id"));
            component.set("v.selected_records",ids);
        }else{
            ids.pop(component.get("v.led_id"));
        }
	},
    doinit:function(component){
      ///  alert(window.location.href);
      var urlIs =''+ window.location.href;
        console.log('urlIs ',urlIs);
        if(urlIs.indexOf('/fa/')!=-1){
            
            component.set("v.isCommunity",true);
        }else{
          //  alert('not community');
            component.set("v.isCommunity",false);
            
        }
    }
})