({
	doinittest : function(component, event, helper) {
     //  alert('1');
        var action= component.get("c.getAccountType");
        action.setCallback(this,function(data){
            var schema = data.getReturnValue();
            component.set("v.AccType",schema.AccountType);
           // component.set("v.AccTypeRendered",true);
             component.set("v.AccPlanType",schema.AccountPlanType);
            //component.set("v.AccPlanTypeRendered",true);
			
            component.set("v.AccClass",schema.AccountClass);
          //  component.set("v.AccClassRendered",true);
            
             component.set("v.ClientType",schema.AccountClient);
          //  component.set("v.ClientTypeRendered",true);

            console.log(schema);
            
        });
          $A.enqueueAction(action);
        
        helper.getAccounts(component);

		
	},
    
    checkData :function(component, event, helper) {
        
        console.log('selectedAccType ',component.get("v.selectedAccType"));
        console.log('selectedAccPlanType ',component.get("v.selectedAccPlanType"));
         console.log('selectedAccClass ',component.get("v.selectedAccClass"));
    },
    onPreviousPage: function(component, event, helper) {
		var page = component.get("v.page") || 1;
        var direction = event.getParam("direction");
        page = page - 1;
        helper.loadFunds(component, page);
	},

	onNextPage: function(component, event, helper) {
		var page = component.get("v.page") || 1;
        var direction = event.getParam("direction");
        page = page + 1;
        helper.loadFunds(component, page);
	},
    
    fundFilterChangeHandler: function(component, event, helper) {
        var filterObject = component.get("v.filterObject");
        if (event.getParam("searchKey") !== undefined) {
	        filterObject.searchKey = event.getParam("searchKey");
        }
        if (event.getParam("assetClass") !== undefined) {
            filterObject.assetClass = event.getParam("assetClass");
        }
        if (event.getParam("sector") !== undefined) {
            var sector = event.getParam("sector");
	        filterObject.sector = event.getParam("sector");
        }
        console.log(filterObject);
        helper.loadFunds(component);
    },  
	onMouseMove: function(component, event, helper) {
        if (event.target === event.currentTarget) return;
        var el = event.target;
        while (el && (!el.dataset || !el.dataset.id)) {
            el = el.parentElement;
        }
        if (el) {
			var acc = component.get("v.Accounts");
            component.find("popup").showPopup(acc[el.dataset.id], event.clientX + 20, el.offsetTop - 46);
        }
    },

    onMouseLeave: function(component, event, helper) {
        if (event.target === component.find("list").getElement()) {
	        component.find("popup").hidePopup();    
        }
    },
    scriptsLoaded : function(component, event, helper) {
		console.log('load successfully');
       
       // active/call select2 plugin function after load jQuery and select2 plugin successfully    
       $(".select2Class").select2({
           placeholder: "Select Multiple values",
           closeOnSelect:false
       });
	},
    
    doInit: function(component, event, helper) {
       /*On the component load call the fetchPickListVal helper method
         pass the Picklist[multi-select] API name in parameter  
       */ 
        helper.fetchPickListVal(component);
        
              
        helper.getAccounts(component);

    },
    Search_records :function(component, event, helper){
        var emptylist = [];
        component.set("v.selected_records",emptylist);
        component.set("v.show_loader",true);
       
        
        var selectedAccPlan =[];
        	selectedAccPlan = $('[id$=AccPlan]').select2("val");
        var selectedAccClientType = [];
        	selectedAccClientType = $('[id$=ClientType]').select2("val");
        var selectedAccType = [];
        	selectedAccType = $('[id$=AccType]').select2("val");
        var selectedAccClass = [];
        	selectedAccClass = $('[id$=AccClass]').select2("val");
            var selectedEmailTypes = [];
        	selectedEmailTypes = $('[id$=EmailType]').select2("val");
   component.set("v.selectedEmailTypes",selectedEmailTypes);
        //component.set("v.objAcc.Active__c",selectedSkills);
        console.log(selectedAccPlan);
        console.log(selectedAccClientType);
        console.log(selectedAccType);
        console.log(selectedAccClass);
        console.log(selectedEmailTypes);
        
        var action = component.get("c.get_searchData");
        	var pageSize = component.get("v.pageSize");
	
        action.setParams({
            "pageSize": pageSize,
            "pageNumber":  1,
            selAccplan : selectedAccPlan,
            selectedAccClient : selectedAccClientType,
            selectedAcc : selectedAccType,
            selectedAccClas :selectedAccClass,
            selectedEmailTypes:selectedEmailTypes
        });
        
        action.setCallback(this,function(response){
            	
            var result = response.getReturnValue();
      
				console.log('response ',response); 
         //   console.log(data.status)
            console.log(response.getReturnValue());
            var ModAccs = [];
                 var allAccounts = result.Accounts;
       
            for(var i=0;i<allAccounts.length;i++){
               	allAccounts[i].selectable = false;
                ModAccs.push(allAccounts[i]);
            }
           // component.set("v.funds", result.funds);
          console.log('result ',result);
             component.set("v.Accounts", ModAccs);
           
           component.set("v.page", result.page);
           component.set("v.total", result.total);
           component.set("v.pages", Math.ceil(result.total/pageSize)  || 0);
           component.set("v.show_loader",false);
    
     
        });  
        
              $A.enqueueAction(action);
    
    },
    go_records :function(component){
        console.log('selected_records ',component.get("v.selected_records"));
        
        var total_rec =  component.get("v.selected_records");
        console.log(total_rec.length);
        if(total_rec.length>0){
  //  alert();        
            component.set("v.send_email",true);
        }else{
            component.set("v.send_email",false);
        }
    },
    doSwitchView :function(component){
          var sel = component.find('view_type').get("v.value");
     // alert(sel);
        if(sel){
            component.set("v.view_stype",'List');
        }else{
            component.set("v.view_stype",'Grid'); 
        }
    }

})