package com.sandraproject.containers {
	
	import flash.events.Event;
	import fl.events.ScrollEvent;
	import flash.display.MovieClip;
	
	public class ScrollableContainer {
		
		private var a_container:MovieClip;
		private var a_mask:MovieClip;
		private var a_sb:Object;

		public function ScrollableContainer(_container:MovieClip,_mask:MovieClip,_sb:Object) {
			a_container=_container;
			a_sb=_sb;
			a_mask=_mask;
			a_container.mask=a_mask;
			addListeners();
			setScroll();
		}
		public function setScroll():void{
			if(a_container.height>a_mask.height){
				a_sb.visible=true;
				a_sb.height = a_mask.height;
				a_sb.enabled = true;
				a_sb.setScrollProperties(a_mask.height, 0, 90);
			}else{
				a_sb.visible=false;
			}
		}
		private function addListeners():void{
			a_sb.addEventListener(ScrollEvent.SCROLL, scrollMC);
		}
		private function scrollMC(event:ScrollEvent):void{
			a_container.y = -a_container.height*(event.position/100)-150;
		}
	}
	
}
