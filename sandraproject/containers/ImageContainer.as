/**
 * @author Michael Nick Avilan Mora
 * @since 1.0
 */
package com.sandraproject.containers
{
	import com.sandraproject.interfaces.IModel;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import caurina.transitions.Tweener;

	public class ImageContainer implements IModel
	{
		private var a_ui_els:Array=new Array();
		
		/**
		 * Constructor method
		 * @param {Loader} $loader 
		 * */
		public function ImageContainer($loader:Loader)
		{
			a_ui_els.push($loader);
			a_ui_els[0].alpha = 0;
			addListeners();
		}
		/**
		 * Attach the events to its listeners
		 * */
		public function addListeners():void{
			a_ui_els[0].addEventListener(Event.COMPLETE, loadImageComplete);
			a_ui_els[0].addEventListener(Event.CHANGE, sourceChanged);
		}
		/**
		 * Creates a transition when the image is loaded and smooth it
		 * */
		private function loadImageComplete(e:Event):void
		{
			Tweener.addTween(e.currentTarget,{alpha:1,time:2,transition:"cubic"});
			var bmp:Bitmap=new Bitmap();
			bmp = e.currentTarget.content as Bitmap;
			bmp.smoothing = true;
		}
		/**
		 * Hides the loader when the source changes
		 * */
		private function sourceChanged(e:Event):void
		{
			e.currentTarget.alpha = 0;
		}
	}

}