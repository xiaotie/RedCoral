package geb.events
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class MoveEvent extends Event
	{
		public static const MOVING:String = "moving";
		
		public var xOffSet:Number = 0;
		public var yOffSet:Number = 0;
		public var movingTarget:Sprite;
		
		public function MoveEvent(xOff:Number = 0, yOff:Number = 0, type:String = MOVING)
		{
			super(type);
			xOffSet = xOff;
			yOffSet = yOff;
		}
		
		public override function clone():Event
		{
			var copy:MoveEvent = new MoveEvent(this.xOffSet,this.yOffSet,this.type);
			copy.movingTarget = this.movingTarget;
			return copy;
		}
	}
}