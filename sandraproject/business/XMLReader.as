package  com.sandraproject.business{
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import com.sandraproject.interfaces.IModel;
	import flash.events.Event;
	import com.sandraproject.advicer.SPAdvicer;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import flash.events.EventDispatcher;
	
	public class XMLReader extends EventDispatcher implements IModel{
		
		public var sp_advicer:SPAdvicer=SPAdvicer.getInstance();
		
		private var a_loader:URLLoader=new URLLoader();
		private var a_request:URLRequest=new URLRequest();
		private var a_fileStream:FileStream = new FileStream(); 
		private var a_data:Object;

		public function XMLReader(_path:String, isAir:Boolean) {
			addListeners();
			if(isAir===true){
				var file:File = File.applicationDirectory.resolvePath(_path);
				a_fileStream.openAsync(file, FileMode.READ); 
			}else{
				a_request.url=_path;
				addListeners();
				a_loader.load(a_request);
			}
		}
		public function getData(listLabel:String):Object{
			return a_data;
		}
		public function addListeners(){
			a_fileStream.addEventListener(Event.COMPLETE, loadAirXMLComplete); 
			a_loader.addEventListener(Event.COMPLETE, loadDataComplete);
		}
		private function loadAirXMLComplete(e:Event):void{
			a_data = XML2JSON.parse(new XML(a_fileStream.readUTFBytes(a_fileStream.bytesAvailable)));
			this.dispatchEvent(new Event(sp_advicer.XML_COMPLETE_EVENT));
			a_fileStream.close(); 
		}
		private function loadDataComplete(e:Event):void{
			a_data=XML(e.currentTarget.data);
			this.dispatchEvent(new Event(sp_advicer.XML_COMPLETE_EVENT));
		}

	}
	
}
