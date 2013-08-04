/**
 * @author xiaotie@geblab.com 
 */

package geb.common
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.*;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.ByteArray;
	
	public class RpcRequest
	{
		private var args:Object;
		
		public var loader:URLLoader;
		
		public function RpcRequest(url:String, postData:Object = null, callback:Function = null, fail:Function = null, isPost:Boolean = true, args:Object = null, isBinary:Boolean = false )
		{
			this.args = args;
			
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,
				function(event:Event): void
				{
					trace("Loaded:" + req.url);
					if(callback != null)
					{
						if(!args)
						{
							callback(event.target.data);
						}
						else
						{
							callback(event.target.data, args);
						}
					}
				}
			);
			
			loader.addEventListener(IOErrorEvent.IO_ERROR, 
				function(event:Event): void
				{
					trace("Loaded Failed:" + req.url);
					if(fail != null)
					{
						if(!args)
						{
							fail(event.target.data);
						}
						else
						{
							fail(event.target.data, args);
						}
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
			
			if(isBinary == true)
			{
				loader.dataFormat = URLLoaderDataFormat.BINARY;
				req.contentType = "application/octet-stream";
				req.method = URLRequestMethod.POST;
				req.data = postData;
			}
			
			loader.load(req);
		}
	}
}