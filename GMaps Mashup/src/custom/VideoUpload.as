package custom
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.formatters.DateFormatter;
	
	
	
	public class VideoUpload extends UIComponent
	{
		private var imageURL:String="null";
		private var user_image_dir:String="";
		private var urlRequest:URLRequest;
		private var fileReferenceList:FileReferenceList;
		private var imageTypes:FileFilter = new FileFilter("Image:*.jpg;*.jpeg;*.gif;*.png","*.jpg;*.jpeg;*.gif;*.png");
		private var serverSideScript:String = "php/media/uploadFile.php";
		private var _numCurrentUpload:Number = 0;
		private var myVar:String;
		private var uploadedImageURL:String;
		private var dateFormatter:DateFormatter;
		
		public function VideoUpload()
		{
			
		}
		
		public function uploadFile2():void {
				
				fileReferenceList.browse([imageTypes]);
				
			}
			
			private function fileSelectedHandler(event:Event):void {
				Alert.show("File Uploading...");
				var fileReference:FileReference;
				var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
				var fileList:Array = fileReferenceList.fileList;

				// get the first file that the user chose
				fileReference = FileReference(fileList[0]);
				
				
				// upload the file to the server side script
				fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler);
				fileReference.addEventListener(ProgressEvent.PROGRESS, onUploadProgress);
				//fileReference.upload(urlRequest+"?myVar='Rosco'");
				dateFormatter.formatString = "DDMMMYYYY-HNNSS-";
				var currentDate:Date = new Date();
				myVar = dateFormatter.format(currentDate);
				fileReference.upload(new URLRequest("php/media/uploadFile.php?myVar="+myVar));
				
				// update the status text
				Application.application.mInfo.lblVideoStatus.text = "Uploading...";
				updateProgBar();
			}
			
			private function uploadCompleteHandler(event:Event):void {
				Application.application.mInfo.lblVideoStatus.text = "Image Uploaded: " + event.target.name;
				imageURL="media/"+myVar+event.target.name;
				uploadedImageURL = imageURL;
				setImage();
			}
			
			private function setImage():void{
			//image.source=imageURL;
			Alert.show(imageURL,"UPLOAD COMPLETE");
			}
			
			public function return_imageURL():String{
				return imageURL;
			}
			
			// Get upload progress
			private function onUploadProgress(event:ProgressEvent):void {
				var numPerc:Number = Math.round((event.bytesLoaded / event.bytesTotal) * 100);
				updateProgBar(numPerc);
				var evt:ProgressEvent = new ProgressEvent("uploadProgress", false, false, event.bytesLoaded, event.bytesTotal);
				Application.application.mInfo.dispatchEvent(evt);
			}
			
			// Update progBar
			private function updateProgBar(numPerc:Number = 0):void {
				var strLabel:String = (_numCurrentUpload + 1) + "/" + fileReferenceList.fileList.length;
				strLabel = (_numCurrentUpload + 1 <= fileReferenceList.fileList.length && numPerc > 0 && numPerc < 100) ? numPerc + "% - " + strLabel : strLabel;
				strLabel = (_numCurrentUpload + 1 == fileReferenceList.fileList.length && numPerc == 100) ? "Upload Complete - " + strLabel : strLabel;
				strLabel = (fileReferenceList.fileList.length == 0) ? "" : strLabel;
				Application.application.mInfo.progBarVideo.label = strLabel;
				Application.application.mInfo.progBarVideo.setProgress(numPerc, 100);
				Application.application.mInfo.progBarVideo.validateNow();
			}

	}
}