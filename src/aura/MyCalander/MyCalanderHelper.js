({
	helperMethod : function(data) {
		console.log('data ',data);
        var apps = data;
        var events = [];
        
        for(var i=0;i<apps.length;i++){
            var color = 'green';
            
          /*  if(apps[i].Type__c=='Booked'){
                color = 'red';
            }else if(apps[i].Type__c=='Free'){
                color = 'green';
            }else if(apps[i].Type__c=='Blocked'){
                color = 'red';
            }else if(apps[i].Type__c=='Available'){
                color = 'blue';
            }*/
            events.push({
            	title  : apps[i].Subject__c,
            	start  : apps[i].Start_Date_Time__c,
            	end    : apps[i].End_Date_Time__c,
                backgroundColor : color
                
            });
        }
         $('#calendar').fullCalendar({
        // put your options and callbacks here
        dayClick: function() {
        alert('a day has been clicked!');
    },
              header: { center: 'month,agendaWeek,agendaDay' }, // buttons for switching between views

        views: {
        basic: {
            // options apply to basicWeek and basicDay views
        },
        agenda: {
            // options apply to agendaWeek and agendaDay views
        },
        week: {
            // options apply to basicWeek and agendaWeek views
        },
        day: {
            // options apply to basicDay and agendaDay views
        }
    },
             events:events
    });
	}
})