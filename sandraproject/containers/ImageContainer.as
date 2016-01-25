package com.sandraproject.containers
{
	
	import caurina.transitions.Tweener;
	import fl.containers.UILoader;
	import flash.events.*;
	import flash.display.*;

	public class ImageContainer
	{

		public function ImageContainer(_loader:UILoader)
		{
			_loader.alpha = 0;
			_loader.addEventListener(Event.COMPLETE, loadImageComplete);
			_loader.addEventListener(Event.CHANGE, sourceChanged);
		}
		private function loadImageComplete(e:Event):void
		{
			Tweener.addTween(e.currentTarget,{alpha:1,time:2,transition:"cubic"});
			var bmp:Bitmap=new Bitmap();
			bmp = e.currentTarget.content as Bitmap;
			bmp.smoothing = true;
		}
		private function sourceChanged(e:Event):void
		{
			e.currentTarget.alpha = 0;
		}
	}

}