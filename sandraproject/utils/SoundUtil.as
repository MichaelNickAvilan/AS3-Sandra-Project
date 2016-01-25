package  com.sandraproject.utils{
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	
	public class SoundUtil {
		
		private var a_sound:Sound;
		private var a_sound_channel:SoundChannel;

		public function SoundUtil() {
			// constructor code
		}
		public function initSound(_path:String):void{
			a_sound=new Sound(new URLRequest(_path));
		}
		public function playSound(_repeticiones:int=0):void{
			a_sound_channel=a_sound.play(0,_repeticiones);
		}
		public function stopSound():void{
			a_sound_channel.stop();
		}
		public function stopAll():void{
			SoundMixer.stopAll();
		}
		public function setVolume(vol:Number) {
         var transform:SoundTransform = a_sound_channel.soundTransform;
         transform.volume = vol ;
         a_sound_channel.soundTransform = transform;
      }

	}
	
}
