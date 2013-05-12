package geb.events
{
	import flash.events.Event;
	
	public class MomentoEvent extends Event
	{
		public static const typeName : String = "momentoEvent";
		
		public var momento : Object;
		
		public function MomentoEvent(momento:Object, type:String=typeName)
		{
			super(type);
			this.momento = momento;
		}
		
		public override function clone():Event
		{
			return new MomentoEvent(momento, this.type);
		} 
	}
}