/**
* @author Michael Nick Avilan Mora
* @since 1.0
* This allows to send a basic HTML email
*/
package com.sandraproject.business
{
	import com.sandraproject.advicer.SPAdvicer;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.system.System;
	
	public class MailSender extends EventDispatcher
	{
		
		public var a_sp_advicer:SPAdvicer=SPAdvicer.getInstance();
		private var a_server_script:String='';
		
		/**
		 * Constructor method
		 * @param {String} $serverScriptURL - A server script wich will do the sending mail process
		*/
		public function MailSender($serverScriptURL:String)
		{
			a_server_script=$serverScriptURL;
		}
		/**
		 * This sends the data to the server script
		 * @param {string} $from - The remitant email
		 * @param {string} $to - The destination email
		 * @param {string} $subject - The email subject
		 * @param {string} $headerText - The text to siplay at the top of the email message
		 * @param {string} $footerText - The text to display at the bottom of the email message
		 * @param {string} $picmail - URL of the image to display in the email
		 * @param {string} $ecardLink - Destination image URL
		 * @param {string} $messageLink - Destination email body URL
		 * @param {stirng} $messageLogo - Enterprise logo URL
		*/
		public function onEnviarMail($from:String, $to:String, $subject:String, $headerText:String, $footerText:String, $picmail:String, $ecardLink:String,
		$messageLink:String, $messageLogo:String):void {
			System.useCodePage=true;
			var urlVars:URLVariables = new URLVariables();
			urlVars.from=$from;
			urlVars.to=$to;
			urlVars.etiqueta=$subject;
			urlVars.head_text=$headerText;
			urlVars.picmail=$picmail;
			urlVars.bottom_text=$footerText;
			urlVars.ecard_link=$ecardLink;
			urlVars.link=$messageLink;
			urlVars.logo=$messageLogo;
			var urlRequ:URLRequest = new URLRequest(a_server_script);
			urlRequ.method = URLRequestMethod.POST;
			urlRequ.data = urlVars;
			var urlLoad:URLLoader = new URLLoader();
			urlLoad.load(urlRequ);
			urlLoad.addEventListener(Event.COMPLETE, onSendComplete);
			urlLoad.addEventListener(IOErrorEvent.IO_ERROR, onSendError);
		}
		/**
		 * Dispatch a success event when the server side script responds
		*/
		private function onSendComplete(e:Event):void{
			a_sp_advicer.dispatchAdvice(a_sp_advicer.MAIL_SUCCESS_ADVICE);
		}
		/**
		* Dispatch a success event when the server side script don't responds
		*/
		private function onSendError(e:IOErrorEvent):void{
			a_sp_advicer.dispatchAdvice(a_sp_advicer.MAIL_FAULT_ADVICE);
		}
	}
}