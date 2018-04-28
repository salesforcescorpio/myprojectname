({
		doinit : function(component, event, helper) {
  //    alert('1 qw');
        var action= component.get("c.getLeadType");
        action.setCallback(this,function(data){
            var schema = data.getReturnValue();
            
            console.log(schema);
            console.log(schema.LeadType);
            component.set("v.LeadTypesOptsList",schema.LeadType);
     //       component.set("v.AccTypeRendered",true);
             component.set("v.LeadAccountPlanTypesOptsList",schema.LeadAccountPlanType);
       //     component.set("v.AccPlanTypeRendered",true);			
            component.set("v.LeadStatusOptsList",schema.LeadStatus);
     //       component.set("v.AccClassRendered",true);
             component.set("v.LeadSourceOptsList",schema.LeadSource);
    //        component.set("v.ClientTypeRendered",true);
               component.set("v.LeadRatingOptsList",schema.LeadRating);
             component.set("v.LeadSubSourceOptsList",schema.LeadSubSource);
             component.set("v.EmailTypeOptsList",schema.EmailType);
          

    //        alert('2');
        });
          $A.enqueueAction(action);
        
       helper.getLeads(component);

		
	},
        scriptsLoaded : function(component, event, helper) {
	//	alert('load successfully');
       
       // active/call select2 plugin function after load jQuery and select2 plugin successfully    
       $(".select2Class").select2({
           placeholder: "Select Multiple values",
           closeOnSelect:false
       });
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
    },
       Search_records :function(component, event, helper){
        var emptylist = [];
        component.set("v.selected_records",emptylist);
        component.set("v.show_loader",true);
       
        
        var selType =[];
        	selType = $('[id$=LeadType]').select2("val");
        var selectedAccPlanType = [];
        	selectedAccPlanType = $('[id$=AccPlan]').select2("val");
        var selectedStatus = [];
        	selectedStatus = $('[id$=status]').select2("val");
        var selectedSource = [];
        	selectedSource = $('[id$=source]').select2("val");
           
            var selectedRating = [];
        	selectedRating = $('[id$=Rating]').select2("val");
        var selectedSubSource = [];
        	selectedSubSource = $('[id$=sub_source]').select2("val");
            var selectedEmailTypes = [];
        	selectedEmailTypes = $('[id$=EmailType]').select2("val");
   component.set("v.selectedEmailTypes",selectedEmailTypes);
        
        var action = component.get("c.get_searchData");
        	var pageSize = component.get("v.pageSize");
	
        action.setParams({
            "pageSize": pageSize,
            "pageNumber":  1,
            selType:selType,
            selectedAccPlanType:selectedAccPlanType,
            selectedStatus:selectedStatus,
            selectedSource:selectedSource,
            selectedRating:selectedRating,
            selectedSubSource:selectedSubSource,
            selectedEmailTypes:selectedEmailTypes
        });
        
        action.setCallback(this,function(response){
            	
            var result = response.getReturnValue();
      
				console.log('response ',response); 
         //   console.log(data.status)
            console.log(response.getReturnValue());
            var ModAccs = [];
                 var allAccounts = result.Leads;
       
            for(var i=0;i<allAccounts.length;i++){
               	allAccounts[i].selectable = false;
                ModAccs.push(allAccounts[i]);
            }
           // component.set("v.funds", result.funds);
          console.log('result ',result);
             component.set("v.Leads", ModAccs);
           
           component.set("v.page", result.page);
           component.set("v.total", result.total);
           component.set("v.pages", Math.ceil(result.total/pageSize)  || 0);
           component.set("v.show_loader",false);
    
     
        });  
        
              $A.enqueueAction(action);
    
    },
    
	onMouseMove: function(component, event, helper) {
        if (event.target === event.currentTarget) return;
        var el = event.target;
        while (el && (!el.dataset || !el.dataset.id)) {
            el = el.parentElement;
        }
        if (el) {
			var acc = component.get("v.Leads");
            component.find("popup").showPopup(acc[el.dataset.id], event.clientX + 20, el.offsetTop - 46);
        }
    },

    onMouseLeave: function(component, event, helper) {
        if (event.target === component.find("list").getElement()) {
	        component.find("popup").hidePopup();    
        }
    },
})