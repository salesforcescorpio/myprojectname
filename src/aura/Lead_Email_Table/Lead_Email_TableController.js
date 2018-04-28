({
	leadSelected : function(component, event, helper) {
		//alert(component.get("v.acc_id"));
       console.log('event ',event);
         var target = event.target; 
        var dataEle = target.getAttribute("data-selected-Index");
        console.log('dataEle ',dataEle );
        var LeadsAre = component.get('v.Leads');
        var selected_index;
        for(var i=0;i<LeadsAre.length;i++){
            if(i == dataEle){
                selected_index = i;
                console.log('LeadsAre[i] ',LeadsAre[i]);
               LeadsAre[i].selectable = !LeadsAre[i].selectable;
                break;
            }
        }
    //    component.set("v.acc.selectable",!component.get("v.acc.selectable"));
       var ids = component.get("v.selected_records");
            
        if(LeadsAre[selected_index].selectable){
          ids.push(LeadsAre[selected_index].Id);
        component.set("v.selected_records",ids);
     }else{
       ids.pop(LeadsAre[selected_index].Id);
     }
	},
})