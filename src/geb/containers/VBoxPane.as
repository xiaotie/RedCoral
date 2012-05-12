package geb.containers
{
	import com.yahoo.astra.fl.containers.VBoxPane;
	import flash.display.DisplayObject;

	[DefaultProperty( "children" )]
	public class VBoxPane extends com.yahoo.astra.fl.containers.VBoxPane
	{
		private var _children:Vector.<DisplayObject>;
		
		public function get children():Vector.<DisplayObject> 
		{
			return _children; 
		}
		
		public function set children( value:Vector.<DisplayObject> ):void 
		{ 
			if ( _children != value ) 
			{ 
				_children = value; 
				if(_children != null) 
				{ 
					for each(var item:DisplayObject in _children) 
					{ 
						this.addChild(item); 
					} 
				} 
				invalidate(); 
			} 
		}
	}
}