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
	
	public class AsyncWebRequest
	{
		private var _args:Object;
		private var _url:String;
		private var _isPost:Boolean = true;
		private var _data:Object = null;
		private var _success:Function = null;
		private var _fail:Function = null;
		private var loader:URLLoader;
		
		public function AsyncWebRequest(url:String):void
		{
			this._url = url;
		}
		
		public function data(obj:Object, isPost:Boolean = true):AsyncWebRequest
		{
			_data = obj;
			_isPost = isPost;
			return this;
		}
		
		public function success(func:Function):AsyncWebRequest
		{
			_success = func;
			return this;
		}
		
		public function fail(func:Function):AsyncWebRequest
		{
			_fail = func;
			return this;
		}
		
		public function run():void
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,
				function(event:Event): void
				{
					if(_success != null)
					{
						_success(event.target.data);
					}
				}
			);
			
			loader.addEventListener(IOErrorEvent.IO_ERROR, 
				function(event:Event): void
				{
					if(_fail != null)
					{
						_fail(event.target.data);
					}
				}
			);
			
			var pds:URLVariables = new URLVariables();
			if(_data != null)
			{
				for(var name:String in _data)
				{
					pds[name] = _data[name];
				}
			}
			
			var req:URLRequest = new URLRequest(_url);
			req.method = _isPost? URLRequestMethod.POST :URLRequestMethod.GET; 
			req.data = pds;
			loader.load(req);
		}
	}
}