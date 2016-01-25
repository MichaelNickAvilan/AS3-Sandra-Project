package com.sandraproject.containers
{
	import caurina.transitions.*;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import com.sandraproject.advicer.SPAdvicer;
	import flash.ui.MultitouchInputMode;
	import flash.ui.Multitouch;
	import com.sandraproject.interfaces.IModel;
	import flash.events.TransformGestureEvent;
	
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
		
		public function GridContainer()
		{
			Multitouch.inputMode=MultitouchInputMode.GESTURE;
		}
		public function initContainer(_contents:Array,_container:MovieClip,_rows:int,_separe:int,_tipo:String):void{
			a_contents = _contents;
			a_rows = _rows;
			a_counter=0;
			a_container = _container;
			
			if(a_init_centinela==false){
				a_init=a_container.x;
				a_inity=a_container.y;
				a_init_centinela=true;
			}
			a_tipo=_tipo;
			a_separe=_separe;
			removeContents();
			if(_tipo=="horizontal"){
				addHorizontalContents();
			}else{
				addVerticalContents();
			}
			a_centinela2=true;
			a_local_width=a_contents[0].a_width;
			a_local_height=a_contents[0].a_height;
		}
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
		public function addListeners(){
		}
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
		public function activateSwipe(_width:int,_discrim:int):void
		{
			a_discrim = _discrim;
			a_width = _width;
			a_container.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipe);
		}
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
		public function removeContents():void{
			trace("REMOVE");
			if(a_centinela2==true){
				while(a_container.numChildren) 
				{ 
					a_container.removeChildAt(0); 
				}  
			}
			
			resetValues();
		}
		public function addScroll(_prev:Object,_next:Object,_width:int,_discrim:int):void
		{
			a_discrim = _discrim;
			a_width = _width;
			_prev.addEventListener("click", prevSet);
			_next.addEventListener("click", nextSet);
			a_sc_centinela=true;
			activateSwipe(a_width,a_discrim);
		}
		public function removeVerticalScroll(_prev,_next):void
		{
			_prev.removeEventListener("click", prevSet);
			_next.removeEventListener("click", nextSet);
		}
		public function gotoImage(_index:int):void{
			a_counter=_index;
			if(a_tipo=="horizontal"){
				Tweener.addTween(a_container,{y:a_inity-((a_local_height+5)*a_counter),time:0.5,transition:"cubic"});
			}else{
				Tweener.addTween(a_container,{x:a_init-(a_local_width*a_counter),time:0.5,transition:"cubic"});
			}
		}		
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