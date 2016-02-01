package  com.sandraproject.utils{
	
	import caurina.transitions.*;
	import com.sandraproject.interfaces.IModel;
	import flash.events.MouseEvent;
	
	public class NavigationUtil implements IModel{
		
		private var a_sections:Array=new Array();
		private var a_buttons:Array=new Array();

		public function NavigationUtil(_sections:Array,_buttons:Array) {
			a_sections=_sections;
			a_buttons=_buttons;
			addListeners();
		}
		public function addListeners():void{
			for(var i:int=0;i<a_buttons.length;i++){
				a_buttons[i].addEventListener(MouseEvent.CLICK, gotoSelectedSection);
				if(i>0){
					a_sections[i].alpha=0;
					a_sections[i].visible=false;
				}
			}
		}
		private function gotoSelectedSection(e:MouseEvent):void{
			for(var i:int=0;i<a_buttons.length;i++){
				if(a_buttons[i]==e.currentTarget){
					a_sections[i].visible=true;
					Tweener.addTween(a_sections[i],{alpha:1,time:0.5,transition:"cubic"});
				}else{
					Tweener.addTween(a_sections[i],{alpha:0,time:0.2,transition:"cubic",visible:false});
				}
			}
		}

	}
	
}
