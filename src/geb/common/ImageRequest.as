/**
 * @author xiaotie@geblab.com 
 */

package geb.common
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.*;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.ByteArray;
	
	public class ImageRequest
	{
		private var args:Object;
		
		public var loader:Loader;
		
		public function ImageRequest(url:String, callback:Function = null, fail:Function = null, isPost:Boolean = true, postData:Object = null )
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,
				function(event:Event): void
				{
					var bmp:Bitmap = Bitmap(loader.content);
					if(callback != null) callback(bmp);
				}
			);
			
			loader.addEventListener(IOErrorEvent.IO_ERROR, 
				function(event:Event): void
				{
					trace("Loaded Failed:" + req.url);
					if(fail != null)
					{
						fail(event.target.data);
					}
				}
			);
			
			var pds:URLVariables = new URLVariables();
			if(postData != null)
			{
				for(var name:String in postData)
				{
					pds[name] = postData[name];
				}
			}
			
			var req:URLRequest = new URLRequest(url);
			req.method = isPost? URLRequestMethod.POST :URLRequestMethod.GET; 
			req.data = pds;
			loader.load(req);
		}
	}
}