package com.sandraproject.components{
	
	import flash.display.MovieClip;
	import caurina.transitions.*;
	import com.sandraproject.advicer.SPAdvicer;
	import com.sandraproject.interfaces.IModel;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.siete.pipasa.model.ModelLocator;
	
	public class AlertComponent extends MovieClip implements IModel{
		
		public var a_sp_advicer:SPAdvicer=SPAdvicer.getInstance();
		public var a_model:ModelLocator=ModelLocator.getInstance();
		
		public function AlertComponent() {
			this.alpha=0;
			this.visible=false;
			addListeners();
		}
		public function addListeners(){
			ok_sa.addEventListener(MouseEvent.CLICK, closeComponent);
			a_sp_advicer.addEventListener(a_sp_advicer.HIDE_ALERT_ADVICE, hideAlert);
			a_sp_advicer.addEventListener(a_sp_advicer.SHOW_ALERT_ADVICE, showAlert);
		}
		private function showAlert(e:Event):void{
			label_txt.text=a_sp_advicer.a_message.toUpperCase();
			this.visible=true;
			Tweener.addTween(this,{alpha:1,time:0.5,transition:"cubic"});
		}
		private function hideAlert(e:Event=null):void{
			Tweener.addTween(this,{alpha:0,time:0.5,transition:"cubic",visible:false});
		}
		private function closeComponent(e:MouseEvent):void{
			a_model.a_sound.initSound("sounds/click.mp3");
			a_model.a_sound.playSound(1);
			a_sp_advicer.dispatchAdvice(a_sp_advicer.HIDE_ALERT_ADVICE);
		}
	}
}
