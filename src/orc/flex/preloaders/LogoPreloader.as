package orc.flex.preloaders
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	
	import mx.events.FlexEvent;
	import mx.preloaders.DownloadProgressBar;
	
	public class LogoPreloader extends DownloadProgressBar
	{
		private var bmpData:BitmapData;
		private var bmpDataGray:BitmapData;
		
		public function LogoPreloader():void
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void
			{
				stage.addEventListener(Event.RESIZE, onResize);
				var params:Object = loaderInfo.parameters;
				if(params != null)
				{
					receiveParameters(params);
				}				
			});
		}
		
		protected function receiveParameters(params:Object):void
		{
			
		}
		
		protected function createLogo():Bitmap
		{
			return null;
		}
		
		protected function createBgFilter(alpha:Number = 0.3):ColorMatrixFilter
		{
			return createGrayFilter(alpha);
		}
		
		protected function createGrayFilter(a:Number = 1, r:Number = 0.212672, g:Number = 0.715160, b:Number = 0.072169):ColorMatrixFilter
		{
			return new ColorMatrixFilter(
				[r, g, b, 0, 0,
					r, g, b, 0, 0,
					r, g, b, 0, 0,
					0, 0, 0, a, 0]);
		}
		
		private var ratio:Number = 0;
		
		override public function set preloader(value:Sprite):void
		{
			var bmp:Bitmap = createLogo();
			if(bmp != null)
			{
				x = (stageWidth/2) - (bmp.width/2);
				y = (stageHeight/2) - (bmp.height/2);
				bmpData = bmp.bitmapData;
				bmpDataGray= bmpData.clone();
				bmpDataGray.applyFilter(bmpData,bmpData.rect, new Point(),createBgFilter());
			}
			
			if(x > 0 && y > 0)
			{
				drawLogo(0);
			}
			
			value.addEventListener(ProgressEvent.PROGRESS, function(e:ProgressEvent):void
			{
				ratio = e.bytesLoaded/e.bytesTotal;
				if(x > 0 && y > 0)
				{
					drawLogo(ratio);
				}
			});
			
			value.addEventListener(FlexEvent.INIT_COMPLETE, onInitComplete);
		}
		
		private function onResize(e:Event):void
		{
			if(bmpData == null) return;
			
			x = (stage.stageWidth/2) - (bmpData.width/2);
			y = (stage.stageHeight/2) - (bmpData.height/2);
		}
		
		protected function onInitComplete(e:FlexEvent):void
		{
			stage.removeEventListener(Event.RESIZE, onResize);
			dispatchCompleteEvent();
		}
		
		protected function dispatchCompleteEvent():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function drawLogo(ratio:Number):void
		{
			if(ratio > 1) ratio = 1;
			if(bmpData == null) return;
			
			graphics.clear();
			graphics.beginBitmapFill(bmpData,null,true,true);
			graphics.drawRect(0,0,bmpData.width*ratio,bmpData.height);
			graphics.beginBitmapFill(bmpDataGray,null,true,true);
			graphics.drawRect(bmpData.width*ratio,0,bmpData.width*(1-ratio),bmpData.height);
			graphics.endFill();
		}
	}
}