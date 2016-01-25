package com.sandraproject.business
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.*;
	import flash.system.System;
	import com.sandraproject.advicer.SPAdvicer;
	
	public class MailSender extends EventDispatcher
	{
		
		public var a_sp_advicer:SPAdvicer=SPAdvicer.getInstance();
		
		public function MailSender()
		{
		}
		public function onEnviarMail(_message:Object):void {
			System.useCodePage=true;
			var urlVars:URLVariables = new URLVariables();
			urlVars.from=_message.from;
			urlVars.email=_message.email;
			urlVars.etiqueta=_message.etiqueta;
			urlVars.head_text=_message.head_text;
			urlVars.picmail=_message.picmail;
			urlVars.bottom_text=_message.bottom_text;
			urlVars.ecard_link=_message.ecard_link;
			urlVars.link=_message._link;
			urlVars.logo=_message.logo;
			var urlRequ:URLRequest = new URLRequest(a_sp_advicer.a_mail_path);
			urlRequ.method = URLRequestMethod.POST;
			urlRequ.data = urlVars;
			var urlLoad:URLLoader = new URLLoader();
			urlLoad.load(urlRequ);
			urlLoad.addEventListener(Event.COMPLETE, onSendComplete);
			urlLoad.addEventListener(IOErrorEvent.IO_ERROR, onSendError);
		}
		private function onSendComplete(e:Event):void{
			a_sp_advicer.dispatchAdvice(a_sp_advicer.MAIL_SUCCESS_ADVICE);
		}
		private function onSendError(e:IOErrorEvent):void{
			a_sp_advicer.dispatchAdvice(a_sp_advicer.MAIL_FAULT_ADVICE);
		}
	}
}