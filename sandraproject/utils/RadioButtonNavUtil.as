/**
 * @author Michael Nick Avilan Mora
 * @since 1.0
 */
package com.sandraproject.utils{
	
	import com.sandraproject.interfaces.IModel;
	import flash.events.MouseEvent;
	import com.sandraproject.components.RadioButtonComponent;
	
	public class RadioButtonNavUtil implements IModel{
		
		private var a_items:Array=new Array();

		public function RadioButtonNavUtil(_items:Array) {
			a_items=_items;
			addListeners();
		}
		public function addListeners():void{
			for(var i:int=0;i<a_items.length;i++){
				a_items[i].removeListeners();
				a_items[i].setState(false);
				a_items[i].addEventListener(MouseEvent.CLICK, onClick);
			}
		}
		public function getState():RadioButtonComponent{
			var _item:RadioButtonComponent;
			for(var i:int=0;i<a_items.length;i++){
				if(a_items[i].getState()==true){
					_item=a_items[i];
				}
			}
			return _item;
		}
		private function onClick(e:MouseEvent):void{
			for(var i:int=0;i<a_items.length;i++){
				if(a_items[i]==e.currentTarget){
					a_items[i].setState(true);
				}else{
					a_items[i].setState(false);
				}
			}
		}
	}
}
