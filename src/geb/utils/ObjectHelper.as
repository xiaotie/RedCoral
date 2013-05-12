package geb.utils
{
	public class ObjectHelper
	{
		public static function clone(obj:Object):Object
		{
			if(obj == null) return null;
			
			var copy:Object = new Object();
			for(var key:String in obj)
			{
				copy[key] = obj[key];
			}
			
			return copy;
		}
		
		public static function copy(src:Object, dst:Object, checkExistance:Boolean = false):void
		{
			if(src == null || dst == null) return;
			
			if(checkExistance == false)
			{
				for(var key:String in src)
				{
					dst[key] = src[key];
				}
			}
			else
			{
				for(key in src)
				{
					if(dst.hasOwnProperty(key) == true)
					{
						dst[key] = src[key];
					}
				}
			}
		}
	}
}