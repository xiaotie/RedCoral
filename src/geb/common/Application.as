/**
 * @author xiaotie@geblab.com 
 */

package geb.common
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.core.Application;
	import mx.events.PropertyChangeEvent;
	
	[DefaultProperty( "children" )]
	[Bindable]
	[Event(name="inited", type="flash.events.Event")] 
	public class Application extends Sprite
	{
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		
		public var fillMode:Boolean = true;
		private var inited:Boolean = false;
		
		public static var instance : Application = null;
		
		public function Application()
		{
			super();
			x = 0;
			y = 0;
			instance = this;
			if(stage != null)
			{
				stage.showDefaultContextMenu = false;
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
			}
			addEventListener(Event.ENTER_FRAME, onInvalidate);
		}
		
		private var _children:Vector.<DisplayObject>;
		private var childrenChanged:Boolean = false;
		
		public function get children():Vector.<DisplayObject>
		{
			return _children;
		}
		
		public function set children( value:Vector.<DisplayObject> ):void
		{
			if ( _children != value )
			{
				_children = value;
				childrenChanged = true;
				invalidate();
			}
		}
		
		protected function invalidate():void
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			addEventListener(Event.ENTER_FRAME, onInvalidate);
		}
		
		protected function onStageResize(event:Event):void
		{
			if(fillMode == true)
			{
				if(this.width != stage.stageWidth) this.width = stage.stageWidth;
				if(this.height != stage.stageHeight) this.height = stage.stageHeight;
			}
		}
		
		protected function onInvalidate(event:Event) : void
		{
			if(stage == null) return;
			
			if(fillMode == true && stage.stageWidth > 0)
			{
				if(this.width != stage.stageWidth) this.width = stage.stageWidth;
				if(this.height != stage.stageHeight) this.height = stage.stageHeight;
			}
			
			if(stage.hasEventListener(Event.RESIZE) == true)
			{
				stage.removeEventListener(Event.RESIZE, onStageResize);
			}
			
			stage.addEventListener(Event.RESIZE, onStageResize);
			
			if ( childrenChanged )
			{
				while ( numChildren > 0 )
				{
					removeChildAt( 0 );
				}
				
				for each ( var child:DisplayObject in children )
				{
					addChild( child );
				}
				
				childrenChanged = false;
			}
			
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			
			if(inited == false)
			{
				inited = true;
				this.dispatchEvent(new Event("inited"));
			}
		}
		
		override public function set width(w:Number):void
		{
			if(_width == w) return;
			
			_width = w;
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}

		override public function get width():Number
		{
			return _width;
		}
		
		override public function set height(h:Number):void
		{
			if(_height == h) return;
			
			_height = h;
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}

		override public function get height():Number
		{
			return _height;
		}
		
		override public function set x(value:Number):void
		{
			super.x = Math.round(value);
		}
		
		override public function set y(value:Number):void
		{
			super.y = Math.round(value);
		}
		
		public function removeAllChildren():void
		{
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
			
			if(this._children != null)
			{
				this._children = null;
				childrenChanged = true;
			}
		}
	}
}