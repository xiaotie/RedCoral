/**
 * @author xiaotie@geblab.com 
 */

package 
{
	import geb.common.RpcRequest;

	public dynamic class l extends Object
	{
		[Bindable]
		public static var i:l = new l();
		
		public function s(key:String, defaultString:String = null):String
		{
			return getString(key,defaultString);
		}
		
		public static function s(key:String, defaultString:String = null):String
		{
			return i.s(key,defaultString);
		}

		public function getString(key:String, defaultString:String = null):String
		{
			if(this.hasOwnProperty(key)==false) 
			{
				var lowKey:String = key.toLowerCase();
				if(this.hasOwnProperty(lowKey) == false)
				{
					return defaultString ? defaultString : key;	
				}
				else
				{
					return this[lowKey];
				}
			}
			else
			{
				return this[key];
			}
		}
		
		public static function loadRemote(url:String, callback:Function = null, failCallback:Function = null):void
		{
			new RpcRequest(url, null,
				function(obj:Object):void
				{
					loadXml(new XML(obj));
					if(callback != null) callback();
				},
				failCallback
			);
		}
		
		public static function loadXml(xml:XML):void
		{
			if(xml == null) return;
			
			var lang:l = new l();
			
			// 第一遍
			for each(var node: XML in xml.item)
			{
				lang[node.@key]=String(node.@value);
			}
			
			// 第二遍，存储小写的key
			for each(var node: XML in xml.item)
			{
				var lkey:String = String(node.@key).toLowerCase();
				if(lang.hasOwnProperty(lkey) == false)
				{
					lang[lkey] = String(node.@value); 
				}
			}
			
			i = lang;
		}
	}
}