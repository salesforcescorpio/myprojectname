({
	accSelected : function(component, event, helper) {
		//alert(component.get("v.acc_id"));
       console.log('event ',event);
         var target = event.target; 
        var dataEle = target.getAttribute("data-selected-Index");
        console.log('dataEle ',dataEle );
        var AccountsAre = component.get('v.Accounts');
        var selected_index;
        for(var i=0;i<AccountsAre.length;i++){
            if(i == dataEle){
                selected_index = i;
                console.log('AccountsAre[i] ',AccountsAre[i]);
               AccountsAre[i].selectable = !AccountsAre[i].selectable;
                break;
            }
        }
    //    component.set("v.acc.selectable",!component.get("v.acc.selectable"));
       var ids = component.get("v.selected_records");
            
        if(AccountsAre[selected_index].selectable){
          ids.push(AccountsAre[selected_index].Id);
        component.set("v.selected_records",ids);
     }else{
       ids.pop(AccountsAre[selected_index].Id);
     }
	},
})