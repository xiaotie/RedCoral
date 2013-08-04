package geb.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import geb.common.Application;
	import geb.controls.Image;
	
	import mx.managers.CursorManager;
	
	public class CursorHelper
	{
		public static var bitmap:Bitmap;
		
		public static const NORMAL:String = "NORMAL";  
		public static const CUSTOM:String = "CUSTOM";
		
		public static function removeCustomCursor():void
		{
			bitmap = null;
			instance.Cursor = NORMAL;
			instance.rotation = 0;
		}
		
		public static function useCustomCursor(bmp:Bitmap=null, cursorName:String = "CUSTOM", registAtCenter:Boolean = false, xOffset:Number = 0, yOffset:Number = 0):void
		{
			if(bmp != null)
			{
				bitmap = bmp;
				if(registAtCenter == false)
				{
					instance.xOffset = xOffset;
					instance.yOffset = yOffset;
				}
				else
				{
					instance.xOffset = -bmp.width * 0.5;
					instance.yOffset = -bmp.height * 0.5;
				}
			}
			instance.Cursor = cursorName;
		}
		
		public static function get rotation():Number
		{
			return instance.rotation;
		}
		
		public static function set rotation(val:Number):void
		{
			instance.rotation = val;
			if(instance.cursor != null)
			{
				instance.cursor.rotation = val;
			}
		}
		
		public static function useNormalCursor():void
		{
			instance.Cursor = NORMAL;
		}
		
		private static var instance:CursorHelper = new CursorHelper();
		
		private function get stage():Stage
		{
			if(global.stage != null)
			{
				return global.stage;
			}
			else
			{
				return geb.common.Application.instance.stage;
			}
		}
		
		private var current:String;  
		private var cursor:Sprite;  
		private var xOffset:Number = 0;
		private var yOffset:Number = 0;
		private var rotation:Number = 0;
		
		public function CursorHelper()  
		{  
			this.Cursor = NORMAL;  
		}  
		
		public function set Cursor( val:String ):void  
		{  
			if(this.current == val && this.cursor != null) return;
			if(bitmap == null && val != NORMAL ) return;
			
			this.current = val;  
			if (this.cursor != null)  
			{  
				this.stage.removeChild( this.cursor );  
				this.stage.removeEventListener( MouseEvent.MOUSE_MOVE, mouseMoved );  
				this.stage.removeEventListener( Event.MOUSE_LEAVE, mouseLeft );  
			}  
			
			if (this.current == NORMAL)  
			{  
				Mouse.show();  
				this.cursor = null;
			}  
			else  
			{  
				// Hide the real mouse 
				Mouse.hide();
				
				var s:Sprite = new Sprite();
				bitmap.x = this.xOffset;
				bitmap.y = this.yOffset;
				bitmap.smoothing = true;
				s.addChild(bitmap);
				this.cursor = s;
				this.cursor.mouseEnabled = false;  
				this.cursor.mouseChildren = false;  
				this.cursor.cacheAsBitmap = true; 
				this.cursor.x = this.stage.mouseX;  
				this.cursor.y = this.stage.mouseY;  
				this.stage.addChild( this.cursor );  
				this.stage.addEventListener( MouseEvent.MOUSE_MOVE, mouseMoved );  
				this.stage.addEventListener( Event.MOUSE_LEAVE, mouseLeft );  
			}  
		}
		
		public function get Cursor():String  
		{  
			return this.current;  
		}  
		
		public function mouseMoved( e:MouseEvent ):void  
		{  
			this.cursor.visible = true;  
			this.cursor.x = e.stageX;  
			this.cursor.y = e.stageY;  
			e.updateAfterEvent();  
		}  
		
		public function mouseLeft( e:Event ):void  
		{  
			this.cursor.visible = false;  
		}  
	}
}