/**
 * @author Michael Nick Avilan Mora
 * @since 1.0
*/
package  com.sandraproject.advicer{
	
	import flash.events.EventDispatcher;
	import com.sandraproject.interfaces.IController;
	import flash.events.Event;
	
	public class SPAdvicer extends EventDispatcher implements IController {
		
		private static var a_advicer:SPAdvicer;
		
		public var a_virtual_model:Object;
		public var a_contents:Array=new Array();
		
		public var INTRO_COMPLETE_EVENT:String="INTRO_COMPLETE_EVENT";
		public var XML_COMPLETE_EVENT:String="XML_COMPLETE_EVENT";
		
		public var UPLOAD_PROGRESS_ADVICE:String="UPLOAD_PROGRESS_ADVICE";
		public var UPLOAD_FAULT_ADVICE:String="UPLOAD_FAULT_ADVICE";
		public var UPLOAD_COMPLETE_ADVICE:String="UPLOAD_COMPLETE_ADVICE";
		
		public var FILE_SELECTED_ADVICE:String="FILE_SELECTED_ADVICE";		
		public var CSV_LOADED_SUCCESS:String="CSV_LOADED_SUCCESS";
		
		public var SHOW_LOADING_ADVICE:String="SHOW_LOADING_ADVICE";
		public var HIDE_LOADING_ADVICE:String="HIDE_LOADING_ADVICE";
		
		public var SHOW_ALERT_ADVICE:String="SHOW_ALERT_ADVICE";
		public var HIDE_ALERT_ADVICE:String="HIDE_ALERT_ADVICE";
		
		public var NEXT_SCROLL_ADVICE:String="NEXT_SCROLL_ADVICE";
		public var PREV_SCROLL_ADVICE:String="PREV_SCROLL_ADVICE";
		
		public var MAIL_SUCCESS_ADVICE:String="MAIL_SUCCESS_ADVICE";
		public var MAIL_FAULT_ADVICE:String="MAIL_FAULT_ADVICE";

		public var a_message:String;
		
		public function SPAdvicer() {
			// constructor code
		}
		/**
		 * This returns an instance of the SPadvicer Class 
		*/
		public static function getInstance():SPAdvicer{
			if(a_advicer == null){
				a_advicer=new SPAdvicer();
			}
			return a_advicer;
		}
		/**
		 * This dispatch an event
		 * @param {string} _advice - Event Name
		*/
		public function dispatchAdvice($advice:String):void{
			this.dispatchEvent(new Event($advice));
		}
	}
	
}
