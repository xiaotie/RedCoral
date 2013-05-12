package geb.containers
{
	import flash.display.DisplayObject;
	import mx.core.UIComponent;

	[DefaultProperty( "children" )]
	public class FlexUI extends UIComponent
	{
		public function FlexUI()
		{
			super();
		}
		
		private var _children:Vector.<DisplayObject>;
		
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
						this.addChild(item);
					}
				}
				else
				{
					_children = value;
					if(_children != null)
					{
						for each(var item:DisplayObject in value)
						{
							this.addChild(item);
						}
					}
				}					
			}
		}
	}
}