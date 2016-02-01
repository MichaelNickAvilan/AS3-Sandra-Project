/**
 * @author Michael Nick Avilan Mora
 * @since 1.0
 */
package com.sandraproject.components{
	
	import com.sandraproject.interfaces.IModel;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class RadioButtonComponent extends MovieClip implements IModel{
		
		private var a_state:Boolean=false;
		private var a_ui_els:Array=new Array();
		
		
		/**
		 * Constructor method
		 * @param {MovieClip} $over
		 * @param {MovieClip} $out 
		 * */
		public function RadioButtonComponent($over:MovieClip, $out:MovieClip) {
			a_ui_els.push($over);
			a_ui_els.push($out);
			this.buttonMode=true;
			setState(a_state);
			addListeners();
		}
		/**
		 * Attach the events to its listeners
		 * */
		public function addListeners():void{
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		/**
		 * Removes the previous attached events
		 * */
		public function removeListeners():void{
			this.removeEventListener(MouseEvent.CLICK, onClick);
		}
		/**
		 * Sets the state of the element to true
		 * */
		private function onClick(e:MouseEvent):void{
			setState(true);
		}
		public function setState(_state:Boolean):void{
			a_state=_state;
			if(_state==true){
				a_ui_els[0].visible=true;
			}else{
				a_ui_els[1].visible=false;
			}
		}
		public function getState():Boolean{
			return a_state;
		}
	}
	
}
