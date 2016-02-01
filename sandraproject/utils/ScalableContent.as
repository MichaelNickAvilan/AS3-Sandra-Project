/**
 * @author Michael Nick Avilan Mora
 * @since 1.0
 */
package com.sandraproject.utils{

	import caurina.transitions.*;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	public class ScalableContent extends MovieClip {

		public var newx:Number=0;
		public var newy:Number=0;
		private var mc:MovieClip=new MovieClip();
		private var back_image:MovieClip=new MovieClip();
		private var _stage:Stage;
		private var factor:Number;
		private var margin:Number;
		private var a_autoscale:Boolean;
		private var w:Number;
		private var h:Number;
		private var a_ancho:Number;
		private var a_alto:Number;

		public function ScalableContent(raiz:Stage, scale:Boolean, site:MovieClip, back:MovieClip):void {
			mc=site;
			back_image=back;
			_stage=raiz;
			a_autoscale=scale;
			margin=0;
			w=1280;
			h=800;
			a_ancho=_stage.stageWidth;
			a_alto=_stage.stageHeight;
			_stage.scaleMode=StageScaleMode.NO_SCALE;
			_stage.align=StageAlign.TOP_LEFT;
			_stage.addEventListener(Event.RESIZE, resize);
			resize();
		}
		public function resize(event:Event=null):void {
			a_ancho=_stage.stageWidth;
			a_alto=_stage.stageHeight;
			factor=1;
			if (a_autoscale==true) {
				scaleEcard();
			} else {
				moveEcard();
			}
		}
		public function scaleEcard():void {
			if (a_ancho/a_alto>=w/h) {
				factor=a_alto/h-margin;
			} else {
				factor=a_ancho/w-margin;
			}
			moveEcard();
		}
		public function moveEcard():void {
			newx=a_ancho/2;
			newy=a_alto/2;
			back_image.width=a_ancho;
			back_image.height=a_alto;
			back_image.x=a_ancho/2;
			back_image.y=a_alto/2;
			Tweener.addTween(mc,{x:newx, y:newy, scaleX:factor, scaleY:factor, time:1, transition:"cubic"});
			if (a_autoscale==false) {
				for (var i:int=0; i<mc.numChildren; i++) {
					if (mc.getChildAt(i) is MovieClip) {
						var child=mc.getChildAt(i);
						var xpadding=child.width/2+10;
						var ypadding=child.height/2+10;
						switch (child.align) {
							case "TOP_LEFT" :
								newx=- a_ancho/2+xpadding;
								newy=- a_alto/2+ypadding;
								Tweener.addTween(child,{x:newx, y:newy, time:1, transition:"cubic"});
								break;

							case "TOP_CENTER" :
								newx=0;
								newy=- a_alto/2+ypadding+100;
								Tweener.addTween(child,{x:newx, y:newy, time:1, transition:"cubic"});
								break;

							case "TOP_RIGHT" :
								newx=a_ancho/2;
								newy=- a_alto/2+ypadding;
								Tweener.addTween(child,{x:newx, y:newy, time:1, transition:"cubic"});
								break;
							
							case "MENU":
								newx=- a_ancho/2+xpadding-48;
								newy= - a_alto/2+ypadding+80
								Tweener.addTween(child,{x:newx, y:newy, time:1, transition:"cubic"});
								break;
							case "MENU_RIGHT":
								newx=a_ancho/2;
								newy= - a_alto/2+ypadding+80;
								Tweener.addTween(child,{x:newx, y:newy, time:1, transition:"cubic"});
								break;
							case "CONTENTS":
								newy= - a_alto/2+ypadding+74;
								Tweener.addTween(child,{y:newy, time:1, transition:"cubic"});
								break;
							case "THUMB_CONTENTS":
								newx=- a_ancho/2+xpadding-83;
								newy=- (a_alto/2+ypadding)+370;
								Tweener.addTween(child,{x:newx, y:newy, time:1, transition:"cubic"});
								break;
							case "NETS":
								newx=a_ancho/2;
								newy= - a_alto/2+ypadding+100;
								Tweener.addTween(child,{x:newx,y:newy, time:1, transition:"cubic"});
								break;
							case "BG_CENTER":
								newx=- a_ancho/2+xpadding;
								newy= - a_alto/2+ypadding+100;
								Tweener.addTween(child,{x:newx, y:newy, time:1, transition:"cubic"});
								break;

							case "MIDDLE_LEFT" :
								newx=- a_ancho/2+xpadding;
								newy= 0;
								Tweener.addTween(child,{x:newx, y:newy, time:1, transition:"cubic"});
								break;
							
							case "MIDDLE_DESC" :
								newx=- a_ancho/2+xpadding+180;
								newy= 40;
								Tweener.addTween(child,{x:newx, y:newy, time:1, transition:"cubic"});
								break;

							case "MIDDLE_CENTER" :
								newx=0;
								newy=0;
								Tweener.addTween(child,{x:newx, y:newy, time:1, transition:"cubic"});
								break;

							case "MIDDLE_RIGHT" :
								newx=a_ancho/2-xpadding;
								newy=0;
								Tweener.addTween(child,{x:newx, y:newy, time:1, transition:"cubic"});
								break;

							case "BOTTOM_LEFT" :
								newx=- a_ancho/2+xpadding;
								newy=a_alto/2-ypadding-8;
								Tweener.addTween(child,{x:newx, y:newy, time:1, transition:"cubic"});
								break;
							
							case "BOTTOM_LEFT2" :
								newx=- a_ancho/2+xpadding+135;
								newy=a_alto/2-ypadding+7;
								Tweener.addTween(child,{x:newx, y:newy, time:1, transition:"cubic"});
								break;

							case "BOTTOM_CENTER" :
								newx=0;
								newy=a_alto/2-ypadding;
								Tweener.addTween(child,{x:newx, y:newy, time:1, transition:"cubic"});
								break;

							case "BOTTOM_RIGHT" :
								newx=a_ancho/2-xpadding;
								newy=a_alto/2-ypadding-8;
								Tweener.addTween(child,{x:newx, y:newy, time:1, transition:"cubic"});
								break;
						}
					}
				}
			}
		}
	}
}