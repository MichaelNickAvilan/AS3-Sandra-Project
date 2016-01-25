package com.sandraproject.components{
	
	/**
	 * Button Component
	 *
	 * @author		Michael Avilán
	 * @version		1.0.0
	 * @private
	 */
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ButtonComponent extends MovieClip {
		
		private var a_over:uint=0x000000;
		private var a_out:uint=0x333333;
		
		public function ButtonComponent() {
			this.buttonMode=true;
			inv_mc.alpha=0;
			label_txt.textColor=a_out;
			addListeners();
		}
		/**
		 * Sets the textColor parameter for the over and out behaviors
		 *
		 * @param		_over				uint		Color number (ie, 0xffff00)
		 * @return		_out				uint		Color number (ie, 0xffff00)
		 */
		public function setColors(_over:uint,_out:uint):void{
			a_over=_over;
			a_over=_out;
		}
		private function addListeners():void{
			this.addEventListener(MouseEvent.MOUSE_OVER, over);
			this.addEventListener(MouseEvent.MOUSE_OUT, out);
		}
		private function over(e:MouseEvent):void{
			label_txt.textColor=a_over;
		}
		private function out(e:MouseEvent):void{
			label_txt.textColor=a_out;
		}
	}
	
}
