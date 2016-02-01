/**
 * @author Michael Nick Avilan Mora
 * @since 1.0
 */
package  com.sandraproject.components{

	import flash.display.MovieClip;
	
	public class InputTextComponent extends MovieClip {
		
		private var a_ui_els:Array=new Array();
		
		public function InputTextComponent($label) {
			a_ui_els.push($label);
			a_ui_els[0].text="";
		}
		/**
		 * Sets the text style as a Password
		 */
		public function setAsPassword():void{
			a_ui_els[0].displayAsPassword=true;
		}
		/**
		 * Sets the text content
		 *
		 * @param {string} $content
		 */
		public function setContent($content:String):void{
			a_ui_els[0].text=$content;
		}
		/**
		 * Returns the content of the Input Text Field
		 */
		public function getContent():String{
			return a_ui_els[0].text;
		}
	}
}