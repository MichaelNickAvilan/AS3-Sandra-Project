package  com.sandraproject.business{
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import com.sandraproject.interfaces.IModel;
	import flash.events.Event;
	import com.sandraproject.advicer.SPAdvicer;
	
	public class CSVReader implements IModel{
		
		public var sp_advicer:SPAdvicer=SPAdvicer.getInstance();
		
		private var a_loader:URLLoader=new URLLoader();
		private var a_request:URLRequest=new URLRequest();
		private var a_data:Array=new Array();

		public function CSVReader(_path:String) {
			a_request.url=_path;
			addListeners();
			a_loader.load(a_request);
		}
		public function getData():Array{
			return a_data;
		}
		public function addListeners(){
			a_loader.addEventListener(Event.COMPLETE, loadDataComplete);
		}
		private function loadDataComplete(e:Event):void{
			a_data=e.currentTarget.data.split(/\r\n|\n|\r/);
			for(var i:int=0;i<a_data.length;i++){
				a_data[i] = a_data[i].split(",");
			}
			sp_advicer.dispatchAdvice(sp_advicer.CSV_LOADED_SUCCESS);
		}

	}
	
}
