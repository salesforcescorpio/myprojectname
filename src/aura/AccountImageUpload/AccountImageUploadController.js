({
    handleUploadFinished: function (cmp, event) {
        // Get the list of uploaded files
        var uploadedFiles = event.getParam("files");
        alert("Files uploaded : " + uploadedFiles.length);
        var action=cmp.get("c.update_account_image");
        action.setParams({
            "AccID":cmp.get("v.recordId")
        });
        action.setCallback(this,function(resp){
            
        });
        $A.enqueueAction(action);
    },
     upload_attachment:function(component,event,helper){
        
        var fileInput = component.find("myFile").getElement();
    	var file = fileInput.files[0];
        console.log('file ',file);
   		var helperis = helper;
   var fileName = file.name;
        var fr = new FileReader();
      //  fr.readAsText(file);  
       fr.readAsDataURL(file);  
       	fr.onload = function() {
       //     alert();
            var fileContents = fr.result;
    	    var base64Mark = 'base64,';
            var dataStart = fileContents.indexOf(base64Mark) + base64Mark.length;
		//	var dataStart = fileContents.indexOf(base64Mark) + base64Mark.length;

            fileContents = fileContents.substring(dataStart);
          
            component.set('v.fileString',fileContents);
            component.set('v.fileName',fileName);
           var allAtt =  component.get('v.All_attachments');
           // alert(allAtt.length);
            var newAtt = {
                fileOrder: allAtt.length+1,
                FileName :fileName,
                FileBody :fileContents
            };
           allAtt.push(newAtt);
            component.set('v.All_attachments',allAtt);
            
         

        };
    },
})