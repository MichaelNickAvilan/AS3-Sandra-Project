/**
 * @author Michael Nick Avilan Mora
 * @since 1.0
 */
package com.sandraproject.components{
	
	import flash.display.MovieClip;
	import caurina.transitions.*;
	import com.sandraproject.interfaces.IModel;
	import com.sandraproject.advicer.SPAdvicer;
	import flash.events.Event;
	
	public class LoadingComponent extends MovieClip implements IModel{
		
		public var a_sp_advicer:SPAdvicer=SPAdvicer.getInstance();
		
		/**
		 * Constructor method
		 * */
		public function LoadingComponent() {
			this.visible=false;
			this.alpha=0;
			addListeners();
		}
		/**
		 * Attach the events to its listeners
		 * */
		public function addListeners():void{
			a_sp_advicer.addEventListener(a_sp_advicer.SHOW_LOADING_ADVICE, showLoading);
			a_sp_advicer.addEventListener(a_sp_advicer.HIDE_LOADING_ADVICE, hideLoading);
		}
		/**
		 * Shows the loading MovieClip
		 * */
		private function showLoading(e:Event):void{
			this.visible=true;
			Tweener.addTween(this,{alpha:1,time:0.5,transition:"cubic"});
		}
		/**
		 * Hides the loading MovieClip
		 * */
		private function hideLoading(e:Event):void{
			Tweener.addTween(this,{alpha:0,time:0.5,transition:"cubic",visible:false});
		}
	}
	
}
