package com.sandraproject.server{
	
	/**
	 * File Uploader
	 * @description Class to manage the upload file proccess to a server using a server side script
	 * @author		Michael Avilán
	 * @version		1.0.0
	 * @public
	 */
	
	import com.sandraproject.advicer.SPAdvicer;
	import flash.net.URLRequest;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import com.sandraproject.interfaces.IModel;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.events.EventDispatcher;
	
	public class FileUploader extends EventDispatcher implements IModel{
		
		public var a_advicer:SPAdvicer=SPAdvicer.getInstance();
		
		private var a_file_id:String;
		private var a_progress:Number;
		private var a_request:URLRequest=new URLRequest();
		private var a_file_filter:FileFilter;
		private var a_file_reference:FileReference=new FileReference();
		private var a_types:Array;
		private var a_upload_centinela:Boolean=false;
		/**
		 * Init the uploader Class
		 *
		 * @param		_uploaderFile		String		sets the server side script URL
		 * @param		_fyleType			String		Sets the fyle type (Images,Text)
		 */
		public function FileUploader(_uploaderFile:String,_fileType:String) {
			a_request.url=_uploaderFile;
			switch(_fileType){
				case "Images":
					a_file_filter=new FileFilter("Images (*.jpg, *.jpeg,*.png)","*.jpg; *.jpeg; *.png");
					a_types=new Array(a_file_filter);
					break;
				default:
					trace("Error: The fileType is not suported");
			}
			addListeners();
		}
		public function addListeners(){
			a_file_reference.addEventListener(Event.SELECT, fileSelected);
			a_file_reference.addEventListener(ProgressEvent.PROGRESS, uploadProgress);
			a_file_reference.addEventListener(Event.COMPLETE, uploadComplete);
		}
		/**
		 * Returns the progress percent of the loading file
		 */
		public function getProgress():Number{
			return a_progress;
		}
		public function getFileType():String{
			return String(a_file_reference.type);
		}
		/**
		 * Open a window to select the file
		 */
		public function browseFile():void{
			a_upload_centinela=true;
			a_file_reference.browse(a_types);
		}
		/**
		 * Sets the file name and upload the selected file 
		 *
		 * @param		_id		String		sets the name of the file
		 */
		public function setFileNameAndUpload(_id:String):void{
			if(a_upload_centinela==true){
				var url_vars:URLVariables=new URLVariables();
				a_file_id=_id;
				url_vars.fileId=a_file_id;
				a_request.method=URLRequestMethod.POST;
				a_request.data=url_vars;
				a_file_reference.upload(a_request);
				a_upload_centinela=false;
			}else{
				a_advicer.dispatchAdvice(a_advicer.UPLOAD_FAULT_ADVICE);
			}
		}
		/**
		 * Dispatch an Advice when the file is selected
		 */
		private function fileSelected(e:Event):void{
			a_advicer.dispatchAdvice(a_advicer.FILE_SELECTED_ADVICE);
			this.dispatchEvent(new Event(a_advicer.FILE_SELECTED_ADVICE));
		}
		/**
		 * Dispatch an Advice when the file is loading
		 */
		private function uploadProgress(e:ProgressEvent):void{
			a_progress=e.bytesLoaded/e.bytesTotal;
			a_advicer.dispatchAdvice(a_advicer.UPLOAD_PROGRESS_ADVICE);
		}
		/**
		 * Dispatch an Advice when the file upload is complete
		 */
		private function uploadComplete(e:Event):void{
			this.dispatchEvent(new Event(a_advicer.UPLOAD_COMPLETE_ADVICE));
		}

	}
	
}