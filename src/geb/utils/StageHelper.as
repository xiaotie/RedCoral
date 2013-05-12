package geb.utils
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import geb.common.Application;
	import geb.events.MoveEvent;
	
	[Event(name="moving",type="geb.events.MoveEvent")]
	[Event(name="mouseUp",type="flash.events.MouseEvent")]
	public class StageHelper extends EventDispatcher
	{
		public static var _instance:StageHelper = null;
		
		public static function get instance():StageHelper
		{
			if(_instance == null)
			{
				_instance = new StageHelper();
				_instance.bind(geb.common.Application.instance.stage);
			}
			
			return _instance;
		}
		
		private var target:Stage; 
		
		private var movingTarget:Sprite;
		
		private var boundaryObject:Sprite;
		private var boundaryRect:Rectangle;
		
		private var moving:Boolean;
		
		public var start:Point;
		public var current:Point;
		
		private function checkInput(event:MouseEvent):Boolean
		{
			if(boundaryObject == null) return true;
			else
			{
				return boundaryObject.hitTestPoint(event.stageX,event.stageY);
			}
		}
		
		public function bind(obj:Stage, boundary:Sprite = null):void
		{
			unbind();
			boundaryObject = boundary;
			target = obj;
			target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			target.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			target.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		public function unbind():void
		{
			if(target != null)
			{
				target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				target.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				target.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				target = null;
			}
			boundaryObject = null;
		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			if(checkInput(event) == false) return;
			
			moving = true;
			start = new Point(event.stageX,event.stageY);
			movingTarget = event.target as Sprite;
			current = start.clone();
			if(movingTarget!=null)
			{
				this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			}
		}
		
		private function onMouseMove(event:MouseEvent):void
		{
			if(checkInput(event) == false)
			{
				moving = false;
				movingTarget = null;
			}
			
			if(moving == false || current == null) return;
			var old:Point = current.clone();
			current = new Point(event.stageX,event.stageY);
			if(movingTarget!=null)
			{
				var e:MoveEvent = new MoveEvent(current.x - old.x, current.y - old.y);
				e.movingTarget = movingTarget;
				this.dispatchEvent(e);
			}
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			moving = false;
			movingTarget = null;
			this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
		}
	}
}