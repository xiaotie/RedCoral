package geb.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	public class FileHelper
	{
		private static var isOpenning:Boolean = false;
		
		public static function openImageFile(
			callback:Function = null, title:String = "图像文件", exts:String = '*.jpg; *.jpeg; *.gif; *.png',
			onCheckFile:Function = null
		):void
		{
			var f:FileFilter = new FileFilter(title +" ("+ exts +")", exts);
			var fr:FileReference = new FileReference();
			if(callback != null)
			{
				fr.addEventListener(Event.ACTIVATE,
					function(...args):void
					{
						isOpenning = false;
					}
				);
				
				fr.addEventListener(Event.SELECT,
					function(...args):void
					{
						if(onCheckFile != null)
						{
							if(onCheckFile(fr.name, fr.size) == true)
							{
								fr.load();
							}
						}
						else
						{
							fr.load();
						}
					}
				);
				fr.addEventListener(Event.COMPLETE, 
					function(event:Event):void
					{
						var bytes:ByteArray = (event.target as FileReference).data;
						BitmapHelper.loadByteArray2Bitmap(bytes, callback, true);
					}
				);
			}
			
			//if(isOpenning == false)
			{
				isOpenning = true;
				fr.browse([f]);
			}
		}
	}
}