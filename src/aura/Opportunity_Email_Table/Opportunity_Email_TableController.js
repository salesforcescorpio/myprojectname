({
	oppSelected : function(component, event, helper) {
		//alert(component.get("v.acc_id"));
       console.log('event ',event);
         var target = event.target; 
        var dataEle = target.getAttribute("data-selected-Index");
        console.log('dataEle ',dataEle );
        var OppAre = component.get('v.opportunities');
        var selected_index;
        for(var i=0;i<OppAre.length;i++){
            if(i == dataEle){
                selected_index = i;
                console.log('OppAre[i] ',OppAre[i]);
               OppAre[i].selectable = !OppAre[i].selectable;
                break;
            }
        }
    //    component.set("v.acc.selectable",!component.get("v.acc.selectable"));
       var ids = component.get("v.selected_records");
            
        if(OppAre[selected_index].selectable){
          ids.push(OppAre[selected_index].Id);
        component.set("v.selected_records",ids);
     }else{
       ids.pop(OppAre[selected_index].Id);
     }
	},
})