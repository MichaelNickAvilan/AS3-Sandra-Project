/**
 * @author Michael Nick Avilan Mora
 * @since 1.0
 */
package com.sandraproject.containers{
	
	import com.sandraproject.interfaces.IModel;
	import flash.events.MouseEvent;
	
	public class RadioButtonsContainer implements IModel{
		
		private var a_radios:Array=new Array
			
		/**
		 * Constructor method
		 * @param {array} $radios - Array of radio buttons
		 * */
		public function RadioButtonsContainer($radios:Array) {
			a_radios=$radios;
			addListeners();
		}
		/**
		 * Attach the events to its listeners
		 * */
		public function addListeners():void{
			for(var i:int=0;i<a_radios.length;i++){
				a_radios[i].addEventListener("click", radioSelected);
			}
		}
		/**
		 * Returns the selected radio index
		 * */
		public function getSelectedRadio():int{
			var _value:int=0;
			for(var i:int=0;i<a_radios.length;i++){
				if(a_radios[i].getState()!=false){
					_value= i+1;
				}
			}
			return _value;
		}
		/**
		 * Activates the current radio and deactivate the others
		 * */
		private function radioSelected(e:MouseEvent):void{
			for(var i:int=0;i<a_radios.length;i++){
				if(a_radios[i]!=e.currentTarget){
					a_radios[i].setState(false);
				}
			}
		}

	}
	
}
