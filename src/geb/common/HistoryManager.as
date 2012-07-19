/**
 * @author xiaotie@geblab.com 
 */

package geb.common
{
	import geb.collections.Stack;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import geb.events.MomentoEvent;
	
	public class HistoryManager extends EventDispatcher
	{
		public static const EVENT_MOMENTO_REDO:String="redo";
		public static const EVENT_MOMENTO_UNDO:String="undo";
		public static const EVENT_MOMENTO_CHANGED:String="changed";
		
		private var m_undoStack : Stack = new Stack();
		private var m_redoStack : Stack = new Stack();
		private var m_maxHistoryCount : int;
		
		public function HistoryManager(maxHistoryCount:int = 20)
		{
			if(m_maxHistoryCount <0) m_maxHistoryCount = 0;
			m_maxHistoryCount = maxHistoryCount;
		}
		
		public function get maxHistoryCount():int
		{
			return this.m_maxHistoryCount;
		}
		
		public function pushMomento(obj:Object):void
		{
			if(this.maxHistoryCount <= 0) return;
			
			while(this.m_undoStack.size() > this.m_maxHistoryCount)
			{
				this.m_undoStack.dequeue();
			}
			
			this.m_undoStack.push(obj);

			if(this.m_redoStack.isEmpty()==false) this.m_redoStack.clear();
			
			this.dispatchMomentChangedEvent();
		}
		
		public function get canUndo():Boolean
		{
			return this.m_undoStack.size() > 1;
		}
		
		public function get canRedo():Boolean
		{
			return !this.m_redoStack.isEmpty();
		}
		
		public function undo(step:int = 1):void
		{
			if(step < 1) return;
			if(this.canUndo == false) return;
			
			if(step > (this.m_undoStack.size()-1)) step = this.m_undoStack.size()-1;
			
			var obj: Object = null;
			for(var i : int = 0; i < step; i++)
			{
				obj = this.m_undoStack.pop();
				if(obj!=null) this.m_redoStack.push(obj);
			}
			
			obj = this.m_undoStack.head;
			
			if(obj!=null)
			{
				this.dispatchMomentEvent(obj, EVENT_MOMENTO_UNDO);
			}
			
			this.dispatchMomentChangedEvent();
		}
		
		public function redo(step:int = 1):void
		{
			if(step < 1) return;
			if(this.canRedo == false) return;
			
			if(step > this.m_redoStack.size()) step = this.m_redoStack.size();
			
			var obj : Object = null;
			for(var i : int = 0; i < step; i++)
			{
				obj = this.m_redoStack.pop();
				if(obj != null) this.m_undoStack.push(obj);
			}
			
			if(obj!=null)
			{
				this.dispatchMomentEvent(obj, EVENT_MOMENTO_REDO);
			}
			
			this.dispatchMomentChangedEvent();
		}
		
		public function clearMomentos():void
		{
			this.m_redoStack.clear();
			this.m_undoStack.clear();
		}
		
		private function dispatchMomentEvent(momento: Object, eventType: String):void
		{
			var e:MomentoEvent=new MomentoEvent(momento, eventType);
			this.dispatchEvent(e);
		}
		
		private function dispatchMomentChangedEvent():void
		{
			var e : Event = new Event(EVENT_MOMENTO_CHANGED);
			this.dispatchEvent(e);
		}
	}
}