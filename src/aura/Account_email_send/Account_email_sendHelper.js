({
    MAX_FILE_SIZE: 4500000, /* 6 000 000 * 3/4 to account for base64 */
    CHUNK_SIZE: 950000, /* Use a multiple of 4 */

    save : function(component) {
    //    component.set("v.show_spinner",true);
        var fileInput = component.find("file").getElement();
    	var file = fileInput.files[0];
   
        if (file.size > this.MAX_FILE_SIZE) {
            alert('File size cannot exceed ' + this.MAX_FILE_SIZE + ' bytes.\n' +
    		  'Selected file size: ' + file.size);
    	    return;
        }
        
        var fr = new FileReader();

        var self = this;
        fr.onload = function() {
            var fileContents = fr.result;
    	    var base64Mark = 'base64,';
            var dataStart = fileContents.indexOf(base64Mark) + base64Mark.length;

            fileContents = fileContents.substring(dataStart);
        
    	    self.upload(component, file, fileContents);
        };

        fr.readAsDataURL(file);
    },
        
    upload: function(component, file, fileContents) {
   //     alert();
        var fromPos = 0;
        var toPos = Math.min(fileContents.length, fromPos + this.CHUNK_SIZE);
		
        // start with the initial chunk
        this.uploadChunk(component, file, fileContents, fromPos, toPos, '');   
    },
     
    uploadChunk : function(component, file, fileContents, fromPos, toPos, attachId) {
        var action = component.get("c.saveTheChunk"); 
        var chunk = fileContents.substring(fromPos, toPos);

        action.setParams({
            parentId: 'null',
            fileName: file.name,
            base64Data: encodeURIComponent(chunk), 
            contentType: file.type,
            fileId: attachId
        });
       
        var self = this;
        action.setCallback(this, function(a) {
            attachId = a.getReturnValue();
            
            fromPos = toPos;
            toPos = Math.min(fileContents.length, fromPos + self.CHUNK_SIZE);    
            if (fromPos < toPos) {
             
            	self.uploadChunk(component, file, fileContents, fromPos, toPos, attachId);  
            }else{
              //  alert(attachId);
              
        component.set("v.show_spinner",false);
                var allAtt =  component.get('v.All_attachments');
           // alert(allAtt.length);
            var newAtt = {
                fileOrder: allAtt.length+1,
                FileName :file.name,
                FileBody :attachId
            };
           allAtt.push(newAtt);
                console.log('allAtt ',allAtt);
            component.set('v.All_attachments',allAtt);
            
            allAtt.length == 5 ? component.set('v.Max_attachmentsAdded',true):component.set('v.Max_attachmentsAdded',false);
         

            }
        });
            
            $A.enqueueAction(action); 
      
    }
})