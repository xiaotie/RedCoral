package geb.controls
{
	import flash.display.AVM1Movie;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import geb.common.BaseComponent;
	import geb.common.ScaleBitmap;
	
	[Event(name="complete",type="flash.events.Event")]
	public class Image extends BaseComponent
	{
		public static const MODE_9GRID:String = "9grid";
		
		private var _horizontalAlign:String = "center";
		
		public var smoothing:Boolean = true;

		[Inspectable(defaultValue = "center", enumeration = "left,center,right,none", category = "String")]
		public function get horizontalAlign():String
		{
			return _horizontalAlign;
		}

		public function set horizontalAlign(value:String):void
		{
			_horizontalAlign = value;
		}

		private var _verticalAlign:String = "middle";

		[Inspectable(defaultValue = "middle", enumeration = "top,middle,bottom,none", category = "String")]
		public function get verticalAlign():String
		{
			return _verticalAlign;
		}

		public function set verticalAlign(value:String):void
		{
			_verticalAlign = value;
		}

		
		private var _source:*;

		public function get source():*
		{
			return _source;
		}

		[Bindable]
		public function set source(value:*):void
		{
			_source = value;
			this.onInvalidate(null);
		}
		
		[Bindable]
		public var sourceScale9Grid:Rectangle;
		
		public var maintainAspectRatio:Boolean = false;
		
		public var mode:String = MODE_9GRID;
		
		public function Image():void
		{
			super();
		}
		
		public override function draw():void
		{
			super.draw();
			if(source)
			{
				if(source is BitmapData)
				{
					drawBitmapData(source);
				}
				else if(source is Bitmap)
				{
					drawBitmapData(Bitmap(source).bitmapData);
				}
				else if(source is Class)
				{
					var item:Object = new source();
					if(item is Bitmap)
					{
						var bmp:Bitmap = new source() as Bitmap;
						if(bmp != null)
						{
							drawBitmapData(bmp.bitmapData);
						}
					}
					else if(item is DisplayObject)
					{
						var obj:DisplayObject = item as DisplayObject;
						if(obj != null)
						{
							drawDisplayObject(obj);
						}
					}
				}
				else if(source is String)
				{
					if(_loader != null)
					{
						_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadCompleted);
					}
					
					_loader = new Loader();
					_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadCompleted);
					_loader.load(new URLRequest(source));
				}
			}
			else
			{
				clear();
			}
		}
		
		private function loadCompleted(e:Event):void
		{
			clear();
			
			var d:DisplayObject = _loader.content;
			loadContent(d);
		}
		
		private function loadContent(d:DisplayObject):void
		{
			var child:DisplayObject = d;
			if(d is AVM1Movie)
			{
				var bmpData:BitmapData = new BitmapData(d.width,d.height,true,0);
				bmpData.draw(d);
				child = new Bitmap(bmpData,"auto",true);
			}
			else if(d is Bitmap)
			{
				Bitmap(d).smoothing = true;
			}
			
			if(this.width >= 0 && this.height >= 0)
			{
				var xx:Number = this.width / child.width;
				var yy:Number = this.height / child.height;
				var scale:Number = Math.min(xx,yy);
				switch(horizontalAlign)
				{
					case "none":
						child.x = 0;
						if(scale9Grid != null)
						{
							child.scaleX = xx;
						}
						else
						{
							child.width = width;
						}
						break;
					case "left":
						child.x = 0;
						child.scaleX = scale;
						break;
					case "right":
						child.x = (width - child.width * scale);
						child.scaleX = scale;
						break;
					case "center":
					default:
						child.x = 0.5*(width - child.width * scale);
						child.scaleX = scale;
						break;
				}
				
				switch(verticalAlign)
				{
					case "none":
						child.y = yy;
						if(scale9Grid != null)
						{
							child.scaleY = scale;
						}
						else
						{
							child.width = width;
						}
						break;
					case "top":
						child.y = 0;
						child.scaleY = scale;
						break;
					case "bottom":
						child.y = height - child.height * scale;
						child.scaleY = scale;
						break;
					case "middle":
					default:
						child.y = 0.5*(height - child.height * scale);
						child.scaleY = scale;
						break;
				}					
			}
			else
			{
				this._width = child.width;
				this._height = child.height;
				this.dispatchEvent(new Event(Event.RESIZE));
			}
			this._bgBitmap = child;
			child.scale9Grid = this.scale9Grid;
			addChild(child);
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private var _loader:Loader;
		
		private var _bgBitmap:DisplayObject = null;
		
		private function clear():void
		{
			if(_bgBitmap != null)
			{
				this.removeChild(_bgBitmap);
				_bgBitmap = null;
			}
		}
		
		protected function drawBitmapData(bmpData:BitmapData):void
		{
			clear();
			
			if(bmpData == null) return;
			var bmp:Bitmap = new Bitmap(bmpData,"auto", smoothing);
			this.loadContent(bmp);

//			
//			if(isNaN(this.width) || isNaN(this.height))
//			{
//				this._width = bmpData.width;
//				this._height = bmpData.height;
//				this.dispatchEvent(new Event(Event.RESIZE));
//			}
//						
//			if(sourceScale9Grid != null)
//			{
//				var sb:ScaleBitmap = new ScaleBitmap(bmpData,"auto",smoothing);
//				sb.scale9Grid = this.sourceScale9Grid;
//				sb.setSize(this.width,this.height);
//				_bgBitmap = sb;
//				this.addChild(sb);
//			}
//			else
//			{
//				if(this.width == 0) this.width = bmpData.width;
//				if(this.height == 0) this.height = bmpData.height;
//				
//				
//				bmp.width = width;
//				bmp.height = height;
//				_bgBitmap = bmp;
//				this.addChild(bmp);
//			}
//			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function drawDisplayObject(obj:DisplayObject):void
		{
			clear();
			
			if(obj == null) return;
			
			if(this.width == 0 || this.height == 0)
			{
				this._width = obj.width;
				this._height = obj.height;
				this.dispatchEvent(new Event(Event.RESIZE));
			}
			else
			{
				obj.width = this.width;
				obj.height = this.height;
				obj.scale9Grid = this.sourceScale9Grid;
			}
			
			_bgBitmap = obj;
			this.addChild(obj);
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function getBitmap():Bitmap
		{
			if(this._bgBitmap == null) return null;
			var bmpData:BitmapData = new BitmapData(this._bgBitmap.width,this._bgBitmap.height, true, 0);
			bmpData.draw(this._bgBitmap, new Matrix(this._bgBitmap.scaleX,0,0,this._bgBitmap.scaleY));
			var bmp:Bitmap = new Bitmap(bmpData);
			return bmp;
		}
	}
}