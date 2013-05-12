package geb.utils
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import geb.common.Application;
	import geb.events.MoveEvent;

	[Event(name="moving",type="geb.events.MoveEvent")]
	[Event(name=MouseEvent.MOUSE_UP,type="flash.events.MouseEvent")]
	public class DragHelper extends EventDispatcher
	{
		public var target:Sprite;
		
		private var _boundary:Sprite;
		
		private var stageHelper:StageHelper = new StageHelper();
		
		public function bind(obj:Sprite, boundary:Sprite = null):void
		{
			unbind();
			
			target = obj;
			_boundary = boundary;
			target.addEventListener(MouseEvent.MOUSE_DOWN, addEvents);
		}
		
		private function addEvents(e:Event):void
		{
			if(global.stage != null)
			{
				stageHelper.bind(global.stage, _boundary);
			}
			else
			{
				stageHelper.bind(geb.common.Application.instance.stage, _boundary);
			}
			
			stageHelper.addEventListener(MoveEvent.MOVING, onMoving);
			stageHelper.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);			
		}
		
		public function unbind():void
		{
			if(target != null)
			{
				target = null;
			}
			
			stageHelper.unbind();
		}
		
		private function onMoving(event:MoveEvent):void
		{
			if(target == null) return;
			if(event.movingTarget != null)
			{
				if(target.contains(event.movingTarget) == true)
				{
					this.dispatchEvent(event.clone());
				}
			}
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
			stageHelper.removeEventListener(MoveEvent.MOVING, onMoving);
			stageHelper.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);	
			stageHelper.unbind();
		}
	}
}