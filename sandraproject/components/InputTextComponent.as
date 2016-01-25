package  com.sandraproject.components{
	
	/**
	 * InputTextComponent
	 *
	 * @author		Michael Avilán
	 * @version		1.0.0
	 * @private
	 */
	
	import flash.display.MovieClip;
	
	public class InputTextComponent extends MovieClip {
		
		public function InputTextComponent() {
			txt.text="";
		}
		/**
		 * Sets the text style as a Password
		 */
		public function setAsPassword():void{
			txt.displayAsPassword=true;
		}
		/**
		 * Sets the text content
		 *
		 * @param		_content			String
		 */
		public function setContent(_content:String):void{
			txt.text=_content;
		}
		/**
		 * Returns the content of the Input Text Field
		 */
		public function getContent():String{
			return txt.text;
		}
	}
}