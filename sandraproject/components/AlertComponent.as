/**
* @author Michael Nick Avilan Mora
* @since 1.0
*/
package com.sandraproject.components{
	
	import flash.display.MovieClip;
	import caurina.transitions.*;
	import com.sandraproject.advicer.SPAdvicer;
	import com.sandraproject.interfaces.IModel;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class AlertComponent extends MovieClip implements IModel{
		
		private var a_ui_els:Array=new Array();
		public var a_sp_advicer:SPAdvicer=SPAdvicer.getInstance();
		
		/**
		 * Constructor method
		 * $okButton {Button} - The ok button element
		 * $labelText {DynamicText} - the label text element
		*/
		public function AlertComponent($okButton, $labelText) {
			this.alpha=0;
			this.visible=false;
			a_ui_els.push($okButton);
			a_ui_els.push($labelText);
			addListeners();
		}
		/**
		 * Attach the events to its listeners
		*/
		public function addListeners():void{
			a_ui_els[0].addEventListener(MouseEvent.CLICK, closeComponent);
			a_sp_advicer.addEventListener(a_sp_advicer.HIDE_ALERT_ADVICE, hideAlert);
			a_sp_advicer.addEventListener(a_sp_advicer.SHOW_ALERT_ADVICE, showAlert);
		}
		/**
		 * Makes visible the Alert dialog 
		*/
		private function showAlert(e:Event):void{
			a_ui_els[1].text=a_sp_advicer.a_message.toUpperCase();
			this.visible=true;
			Tweener.addTween(this,{alpha:1,time:0.5,transition:"cubic"});
		}
		/**
		 * Hides the Alert dialog 
		*/
		private function hideAlert(e:Event=null):void{
			Tweener.addTween(this,{alpha:0,time:0.5,transition:"cubic",visible:false});
		}
		/**
		 * Closes the Alert dialog
		*/
		private function closeComponent(e:MouseEvent):void{
			a_sp_advicer.dispatchAdvice(a_sp_advicer.HIDE_ALERT_ADVICE);
		}
	}
}