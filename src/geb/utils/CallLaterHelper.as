package geb.utils
{
	import flash.display.Stage;
	import flash.events.Event;

	public class CallLaterHelper
	{
		public function CallLaterHelper(stage:Stage, callback:Function)
		{
			this.callback = callback;
			this.stage = stage;

			stage.addEventListener(Event.ENTER_FRAME, onStageEnterFrame);
		}
		
		private var stage:Stage;
		
		private var callback:Function;
		
		private function onStageEnterFrame(event:Event):void
		{
			stage.removeEventListener(Event.ENTER_FRAME, onStageEnterFrame);
			
			if(callback != null)
			{
				callback();
			}
		}
	}
}