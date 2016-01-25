package com.sandraproject.components{
	
	import flash.display.MovieClip;
	import caurina.transitions.*;
	import com.sandraproject.interfaces.IModel;
	import com.sandraproject.advicer.SPAdvicer;
	import flash.events.Event;
	
	public class LoadingComponent extends MovieClip implements IModel{
		
		public var a_sp_advicer:SPAdvicer=SPAdvicer.getInstance();
		
		public function LoadingComponent() {
			this.visible=false;
			this.alpha=0;
			addListeners();
		}
		public function addListeners(){
			a_sp_advicer.addEventListener(a_sp_advicer.SHOW_LOADING_ADVICE, showLoading);
			a_sp_advicer.addEventListener(a_sp_advicer.HIDE_LOADING_ADVICE, hideLoading);
		}
		private function showLoading(e:Event):void{
			this.visible=true;
			Tweener.addTween(this,{alpha:1,time:0.5,transition:"cubic"});
		}
		private function hideLoading(e:Event):void{
			Tweener.addTween(this,{alpha:0,time:0.5,transition:"cubic",visible:false});
		}
	}
	
}
