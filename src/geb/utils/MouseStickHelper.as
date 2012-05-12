package geb.utils
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class MouseStickHelper
	{
		private var target:Sprite;
		private var timer:Timer = new Timer(intervalMiniSeconds);
		private var active:Boolean = false;
		private var mouseEvent:MouseEvent;
		
		private var _intervalMiniSeconds:uint = 100;

		public function get intervalMiniSeconds():uint
		{
			return _intervalMiniSeconds;
		}

		public function set intervalMiniSeconds(value:uint):void
		{
			_intervalMiniSeconds = value;
			timer.delay = value;
		}
		
		public var callback:Function = null;
		
		public function bind(obj:Sprite):void
		{
			unbind();
			target = obj;
			if(target != null)
			{
				target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				target.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				target.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				target.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			}
		}
		
		public function unbind():void
		{
			if(target != null)
			{
				target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				target.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				target.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				target.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				target = null;
				reset();
			}
		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			active = true;
			timer.stop();
			if(timer.hasEventListener(TimerEvent.TIMER) == false)
			{
				timer.addEventListener(TimerEvent.TIMER, 
					function(e:*):void
					{
						fireEvent();
					}
				);
			}
			timer.start();
			fireEvent();
		}
		
		private function fireEvent():void
		{
			if(this.callback != null)
			{
				this.callback();
			}
		}
		
		private function onMouseMove(event:MouseEvent):void
		{
			if(active == false) return;
		}

		private function onMouseOut(event:MouseEvent):void
		{
			reset();
		}

		private function onMouseUp(event:MouseEvent):void
		{
			reset();
		}

		private function reset():void
		{
			active = false;
			timer.stop();
		}
	}
}