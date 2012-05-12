package geb.utils
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import mx.managers.CursorManager;
	
	import geb.common.Application;
	import geb.controls.Image;
	
	public class CursorHelper
	{
		public static var bitmap:Bitmap;
		
		public static const NORMAL:String = "NORMAL";  
		public static const CUSTOM:String = "CUSTOM";
		
		public static function removeCustomCursor():void
		{
			bitmap = null;
			instance.Cursor = NORMAL;
		}
		
		public static function useCustomCursor(bmp:Bitmap=null, registAtCenter:Boolean = false):void
		{
			if(bmp != null)
			{
				bitmap = bmp;
				if(registAtCenter == false)
				{
					instance.xOffset = 0;
					instance.yOffset = 0;
				}
				else
				{
					instance.xOffset = -bmp.width * 0.5;
					instance.yOffset = -bmp.height * 0.5;
				}
			}
			instance.Cursor = CUSTOM;
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
		private var cursor:Bitmap;  
		private var xOffset:Number = 0;
		private var yOffset:Number = 0;
		
		public function CursorHelper()  
		{  
			this.Cursor = NORMAL;  
		}  
		
		public function set Cursor( val:String ):void  
		{  
			if(this.current == val && this.cursor == bitmap) return;
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
				this.cursor = bitmap;
//				this.cursor.mouseEnabled = false;  
//				this.cursor.mouseChildren = false;  
				this.cursor.cacheAsBitmap = true; 
				this.cursor.x = this.stage.mouseX + this.xOffset;  
				this.cursor.y = this.stage.mouseY + this.yOffset;  
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
			this.cursor.x = e.stageX + this.xOffset;  
			this.cursor.y = e.stageY + this.yOffset;  
			e.updateAfterEvent();  
		}  
		
		public function mouseLeft( e:Event ):void  
		{  
			this.cursor.visible = false;  
		}  
	}
}