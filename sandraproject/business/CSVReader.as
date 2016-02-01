/*
* @author Michael Nick Avilan Mora
* @since 1.0
* This allows to load a CSV file
*/
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
		
		/*
		 * contstructor method, delegates the CSV loading process
		 * @param {string} _path - CSV location URL
		*/
		public function CSVReader($path:String) {
			a_request.url=$path;
			addListeners();
			a_loader.load(a_request);
		}
		/*
		 * Returns an array of arrays from the CSV converted data 
		*/
		public function getData():Array{
			return a_data;
		}
		/*
		 * Attach events to its listeners 
		*/
		public function addListeners():void{
			a_loader.addEventListener(Event.COMPLETE, loadDataComplete);
		}
		/*
		 * Process the received data from the CSV file
		 * Dispatch the CSV_LOADED_SUCCESS event
		 * @param {event}
		*/
		private function loadDataComplete(e:Event):void{
			a_data=e.currentTarget.data.split(/\r\n|\n|\r/);
			for(var i:int=0;i<a_data.length;i++){
				a_data[i] = a_data[i].split(",");
			}
			sp_advicer.dispatchAdvice(sp_advicer.CSV_LOADED_SUCCESS);
		}

	}
	
}
