/**
 * @author Michael Nick Avilan Mora
 * @since 1.0
 */
package com.sandraproject.containers {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import fl.events.ScrollEvent;
	
	public class ScrollableContainer {
		
		private var a_container:MovieClip;
		private var a_mask:MovieClip;
		private var a_sb:Object;
		
		/**
		 * Constructor method
		 * */
		public function ScrollableContainer($container:MovieClip,$mask:MovieClip,$sb:Object) {
			a_container=$container;
			a_sb=$sb;
			a_mask=$mask;
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
			a_sb.addEventListener('SCROLL', scrollMC);
		}
		private function scrollMC(event):void{
			a_container.y = -a_container.height*(event.position/100)-150;
		}
	}
}