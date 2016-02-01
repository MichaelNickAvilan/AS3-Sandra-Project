/**
* @author Michael Nick Avilan Mora
* @since 1.0
* This allows load an XML file and convert its data to JSON
*/
package  com.sandraproject.business{
	
	import com.sandraproject.advicer.SPAdvicer;
	import com.sandraproject.interfaces.IModel;
	import com.sandraproject.utils.external.XML2JSON;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class XMLReader extends EventDispatcher implements IModel{
		
		public var sp_advicer:SPAdvicer=SPAdvicer.getInstance();
		
		private var a_loader:URLLoader=new URLLoader();
		private var a_request:URLRequest=new URLRequest();
		private var a_fileStream:FileStream = new FileStream(); 
		private var a_data:Object;
		
		/**
		 * Contructor method. This delegates the loading process
		 * @param {string} $path - The xml file location
		 * @param {boolean} $isAir - Specifies if the application will be executed with Adobe Air
		*/
		public function XMLReader($path:String, $isAir:Boolean) {
			addListeners();
			if($isAir===true){
				var file:File = File.applicationDirectory.resolvePath($path);
				a_fileStream.openAsync(file, FileMode.READ); 
			}else{
				a_request.url=$path;
				addListeners();
				a_loader.load(a_request);
			}
		}
		/**
		 * Returns the JSON object 
		*/
		public function getData():Object{
			return a_data;
		}
		/**
		 * Attach the events to its listeners 
		*/
		public function addListeners():void{
			a_fileStream.addEventListener(Event.COMPLETE, loadAirXMLComplete); 
			a_loader.addEventListener(Event.COMPLETE, loadDataComplete);
		}
		/**
		 * Converts the XMl into a JSON object and dipatch a success event 
		*/
		private function loadAirXMLComplete(e:Event):void{
			a_data = XML2JSON.parse(new XML(a_fileStream.readUTFBytes(a_fileStream.bytesAvailable)));
			this.dispatchEvent(new Event(sp_advicer.XML_COMPLETE_EVENT));
			a_fileStream.close(); 
		}
		/**
		 * Loads the XMl raw data 
		*/
		private function loadDataComplete(e:Event):void{
			a_data=XML(e.currentTarget.data);
			this.dispatchEvent(new Event(sp_advicer.XML_COMPLETE_EVENT));
		}

	}
	
}
