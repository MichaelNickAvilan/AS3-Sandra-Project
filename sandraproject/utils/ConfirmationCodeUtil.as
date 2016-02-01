/**
 * @author Michael Nick Avilan Mora
 * @since 1.0
 */
package com.sandraproject.utils
{

	public class ConfirmationCodeUtil
	{

		private var a_code_text:Object;
		private var a_chars:Array = new Array("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z");

		public function ConfirmationCodeUtil()
		{
			// constructor code
		}
		public function initConfirmationCode(_txt:Object):void
		{
			a_code_text = _txt;
			resetCode();
		}
		public function getCode(_text):Boolean{
			if(a_code_text.text==_text){
				resetCode()
				return true;
			}else{
				resetCode();
				return false;
			}
		}
		private function randomNumber(min : Number, max : Number, decimas : Number):int
		{
			var diffPlage = (max - min) * Math.pow (10, decimas) + 1;
			var valAleatoire = Math.random() * diffPlage;
			valAleatoire = Math.floor(valAleatoire);
			valAleatoire /=  Math.pow(10,decimas);
			valAleatoire +=  min;
			return int(valAleatoire);
		}
		private function resetCode():void
		{
			a_code_text.text=String(a_chars[randomNumber(0,25,0)]+a_chars[randomNumber(0,25,0)]+a_chars[randomNumber(0,25,0)]+
			   randomNumber(0,9,0)+randomNumber(0,9,0)+randomNumber(0,9,0));
		}

	}

}