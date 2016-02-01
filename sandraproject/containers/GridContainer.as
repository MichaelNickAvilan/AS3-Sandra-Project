/**
 * @author Michael Nick Avilan Mora
 * @since 1.0
 */
package com.sandraproject.containers
{
	import com.sandraproject.advicer.SPAdvicer;
	import com.sandraproject.interfaces.IModel;
	
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TransformGestureEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import caurina.transitions.Tweener;
	
	public class GridContainer implements IModel
	{
		public var a_sp_advicer:SPAdvicer=SPAdvicer.getInstance();
		private var a_init:int=new int(0);
		private var a_inity:int=new int(0);
		private var a_contents:Array=new Array();
		private var a_rows:int = new int(0);
		private var a_container:MovieClip;
		private var a_counter:int = new int(0);
		private var a_discrim:int = new int(0);
		private var a_width:int = new int(0);
		private var a_separe:int=new int(0);
		private var a_centinela:Boolean=false;
		private var a_centinela2:Boolean=false;
		private var a_vertical:Boolean=false;
		private var a_local_width:int=0;
		private var a_local_height:int=0;
		private var a_init_centinela:Boolean=false;
		private var a_sc_centinela:Boolean=false;
		private var a_tipo:String;
		private var a_device_centinela:Boolean=false;
		
		/**
		 * Constructor method
		 * @param {boolean} $isDevice - Defines if the app will ron on a mobile device 
		 * */
		public function GridContainer($isDevice:Boolean)
		{
			a_device_centinela=$isDevice;
			if(a_device_centinela === true){
				Multitouch.inputMode=MultitouchInputMode.GESTURE;
			}
		}
		/**
		 * Inits the container
		 * @param {array} $contents - Array of MovieClips
		 * @param {MovieClip} $container - Empty MovieClip to add the container elements
		 * @param {int} $rows - number of rows 
		 * @separe {int} $separe - separation in pixels between elements
		 * */
		public function initContainer($contents:Array,$container:MovieClip,$rows:int,$separe:int,$tipo:String):void{
			a_contents = $contents;
			a_rows = $rows;
			a_counter=0;
			a_container = $container;
			
			if(a_init_centinela==false){
				a_init=a_container.x;
				a_inity=a_container.y;
				a_init_centinela=true;
			}
			a_tipo=$tipo;
			a_separe=$separe;
			removeContents();
			if($tipo=="horizontal"){
				addHorizontalContents();
			}else{
				addVerticalContents();
			}
			a_centinela2=true;
			a_local_width=a_contents[0].a_width;
			a_local_height=a_contents[0].a_height;
		}
		/**
		 * Resets the initial values
		 * */
		private function resetValues():void{
			for (var i:int=0; i<a_contents.length; i++)
			{
				a_contents[i].x =0;
				a_contents[i].y =0;
			}
			a_container.y=a_inity;
			a_container.x=a_init;
			addListeners();
		}
		/**
		 * Attach the events to its listeners
		 * */
		public function addListeners():void{
		}
		/**
		 * Adds the contents with a horizontal distribution
		 * */
		public function addHorizontalContents():void
		{
			var x_pos:Number = 0;
			var y_pos:Number = 0; 
			var counter:int = 0;
			
			a_vertical=true;
			
			for (var i:int=0; i<a_contents.length; i++)
			{
				a_contents[i].x +=  x_pos;
				a_contents[i].y +=  y_pos;
				
				if (counter < a_rows - 1)
				{
					x_pos += a_contents[i].a_width + a_separe;
					counter++;
				}
				else
				{
					y_pos +=  a_contents[i].a_height+a_separe;
					counter = 0;
					x_pos = 0;
				}
				a_container.addChild(a_contents[i]);
			}
		}
		/**
		 * Activates the swipe behavior
		 * @param {int} $width - Is used to calculate the pixels to move the container
		 * @param {int} $discrim - number of elements to stop the swipe
		 * */
		public function activateSwipe($width:int,$discrim:int):void
		{
			a_discrim = $discrim;
			a_width = $width;
			a_container.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipe);
		}
		/**
		 * Adds the contents with a vertical distribution
		 * */
		public function addVerticalContents():void
		{
			var x_pos:Number = 0;
			var y_pos:Number = 0;
			var counter:int = 0;
			for (var i:int=0; i<a_contents.length; i++)
			{
				a_contents[i].x +=  x_pos;
				a_contents[i].y +=  y_pos;
				
				if (counter < a_rows - 1)
				{
					y_pos +=  a_contents[i].a_height+a_separe;
					counter++;
				}
				else
				{
					x_pos += a_contents[i].a_width + a_separe;
					counter = 0;
					y_pos = 0;
				}
				a_container.addChild(a_contents[i]);
			}
		}
		/**
		 * Removes the childs of the container
		 * */
		public function removeContents():void{
			if(a_centinela2==true){
				while(a_container.numChildren) 
				{ 
					a_container.removeChildAt(0); 
				}  
			}
			
			resetValues();
		}
		/**
		 * Adds a scroll behavior using UI buttons
		 * @param {MovieClip} $prev
		 * @param {MovieClip} $next
		 * @param {int} $width - Is used to calculate the pixels to move the container
		 * @param {int} $discrim - number of elements to stop the swipe
		 * */
		public function addScroll($prev:MovieClip,$next:MovieClip,$width:int,$discrim:int):void
		{
			a_discrim = $discrim;
			a_width = $width;
			$prev.addEventListener("click", prevSet);
			$next.addEventListener("click", nextSet);
			a_sc_centinela=true;
			activateSwipe(a_width,a_discrim);
		}
		/**
		 * Removes the listeners of a verticarl scroll
		 * @param {int} $width - Is used to calculate the pixels to move the container
		 * @param {int} $discrim - number of elements to stop the swipe
		 * */
		public function removeVerticalScroll($prev:MovieClip,$next:MovieClip):void
		{
			$prev.removeEventListener("click", prevSet);
			$next.removeEventListener("click", nextSet);
		}
		/**
		 * Loads the desired slide
		 * @param {int} $index - slide position in the array
		 * */
		public function gotoImage($index:int):void{
			a_counter=$index;
			if(a_tipo=="horizontal"){
				Tweener.addTween(a_container,{y:a_inity-((a_local_height+5)*a_counter),time:0.5,transition:"cubic"});
			}else{
				Tweener.addTween(a_container,{x:a_init-(a_local_width*a_counter),time:0.5,transition:"cubic"});
			}
		}		
		/**
		 * Executes when the device detects a swipe gesture 
		 * */
		private function onSwipe(e:TransformGestureEvent):void{
			if(a_tipo=="vertical"){
				if (e.offsetX==1){
					prevSet();
				}else{
					nextSet();
				}
			}else{
				if (e.offsetY==1){
					prevSet();
				}else{
					nextSet();
				}
			}
		}
		/**
		 * Moves the container to show the previous slide
		 * */
		private function prevSet(e:MouseEvent=null):void
		{
			var _move:Number;
			if(a_centinela==true){
				this.a_counter=0;
				a_centinela=false;
			}
			if (this.a_counter > 0)
			{
				this.a_counter--;
			}
			gotoImage(a_counter);
			a_sp_advicer.dispatchAdvice(a_sp_advicer.PREV_SCROLL_ADVICE);
		}
		/**
		 * Moves the container to show the next slide
		 * */
		private function nextSet(e:MouseEvent=null):void
		{
			var _move:Number;
			if(a_centinela==true){
				this.a_counter=0;
				a_centinela=false;
			}
			if (this.a_counter < a_contents.length - a_discrim)
			{
				this.a_counter++;
			}
			gotoImage(a_counter);
			a_sp_advicer.dispatchAdvice(a_sp_advicer.NEXT_SCROLL_ADVICE);
		}
	}
}