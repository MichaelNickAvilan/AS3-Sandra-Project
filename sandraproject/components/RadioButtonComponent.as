package com.sandraproject.components{
	
	import flash.display.MovieClip;
	import com.sandraproject.interfaces.IModel;
	import flash.events.MouseEvent;
	
	public class RadioButtonComponent extends MovieClip implements IModel{
		
		private var a_state:Boolean=false;
		
		public function RadioButtonComponent() {
			this.buttonMode=true;
			setState(a_state);
			addListeners();
		}
		public function addListeners(){
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		public function removeListeners():void{
			this.removeEventListener(MouseEvent.CLICK, onClick);
		}
		private function onClick(e:MouseEvent):void{
			setState(true);
		}
		public function setState(_state:Boolean):void{
			a_state=_state;
			if(_state==true){
				over_mc.visible=true;
			}else{
				over_mc.visible=false;
			}
		}
		public function getState():Boolean{
			return a_state;
		}
	}
	
}
