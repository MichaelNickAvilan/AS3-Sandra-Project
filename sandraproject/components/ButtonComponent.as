/**
 * @author Michael Nick Avilan Mora
 * @since 1.0
 */

package com.sandraproject.components{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ButtonComponent extends MovieClip {
		
		private var a_over:uint=0x000000;
		private var a_out:uint=0x333333;
		private var a_ui_els:Array=new Array();
		
		/**
		 * Constructor method
		 * @param {MovieClip} $inv
		 * @param {DynamicText} $label
		*/
		public function ButtonComponent($inv, $label) {
			this.buttonMode=true;
			a_ui_els.push($inv);
			a_ui_els.push($label);
			a_ui_els[0].alpha=0;
			a_ui_els[1].textColor=a_out;
			addListeners();
		}
		/**
		 * Sets the textColor parameter for the over and out behaviors
		 * @param {uint} $over Color number (ie, 0xffff00)
		 * @param {uint} $out Color number (ie, 0xffff00)
		 */
		public function setColors(_over:uint,_out:uint):void{
			a_over=_over;
			a_over=_out;
		}
		/**
		 * Attach the events to its listeners
		 */
		private function addListeners():void{
			this.addEventListener(MouseEvent.MOUSE_OVER, over);
			this.addEventListener(MouseEvent.MOUSE_OUT, out);
		}
		/**
		 * Assigns the over color to the label field
		 * */
		private function over(e:MouseEvent):void{
			a_ui_els[1].textColor=a_over;
		}
		/**
		 * Assigns the out color to the label field
		 * */
		private function out(e:MouseEvent):void{
			a_ui_els[1].textColor=a_out;
		}
	}
	
}
