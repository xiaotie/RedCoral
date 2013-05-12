/**
 * @author xiaotie@geblab.com 
 */

package geb.common
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	[DefaultProperty( "children" )]
	[Bindable]
	[Event(name="inited", type="flash.events.Event")] 
	public class BaseContainer extends BaseComponent
	{
		private var _children:Vector.<DisplayObject>;
		private var childrenChanged:Boolean = false;
		
		protected function s(key:String,defaultValue:String = null):String
		{
			return l.i.getString(key,defaultValue);
		}
		
		/**
		 * Array of DisplayObject instances to be added as children
		 */
		public function get children():Vector.<DisplayObject>
		{
			return this._children;
		}
		
		public function set children( value:Vector.<DisplayObject> ):void
		{
			if ( _children != value )
			{
				if(_children != null)
				{
					for each(var item:DisplayObject in value)
					{
						_children.push(item);
					}
				}
				else
				{
					_children = value;
				}
				childrenChanged = true;
				invalidate();
			}
		}
		
		public function BaseContainer(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0)
		{
			super(parent, xpos, ypos);
		}
		
		override protected function onInvalidate(event:Event) : void
		{
			if ( childrenChanged )
			{
				while ( numChildren > 0 )
				{
					removeChildAt( 0 );
				}
				
				if(children != null)
				{
					for each ( var child:DisplayObject in children )
					{
						addChild( child );
					}
				}
				
				childrenChanged = false;
			}
			
			if(this.mask != null)
			{
				if(this.contains(this.mask))
				{
					this.removeChild(this.mask);
				}
			}
			
			super.onInvalidate(event);
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
		
		public function setCenter(obj:DisplayObject):void
		{
			obj.x = Math.round(0.5 * (this.width - obj.width));
			obj.y = Math.round(0.5 * (this.height - obj.height));
		}
	}
}