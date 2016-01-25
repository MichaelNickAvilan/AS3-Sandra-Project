package com.sandraproject.containers{
	
	import com.sandraproject.interfaces.IModel;
	import flash.events.MouseEvent;
	
	public class RadioButtonsContainer implements IModel{
		
		private var a_radios:Array=new Array

		public function RadioButtonsContainer(_radios:Array) {
			a_radios=_radios;
			addListeners();
		}
		public function addListeners(){
			for(var i:int=0;i<a_radios.length;i++){
				a_radios[i].addEventListener("click", radioSelected);
			}
		}
		public function getSelectedRadio():int{
			var _value:int=0;
			for(var i:int=0;i<a_radios.length;i++){
				if(a_radios[i].getState()!=false){
					_value= i+1;
				}
			}
			return _value;
		}
		private function radioSelected(e:MouseEvent):void{
			for(var i:int=0;i<a_radios.length;i++){
				if(a_radios[i]!=e.currentTarget){
					a_radios[i].setState(false);
				}
			}
		}

	}
	
}
