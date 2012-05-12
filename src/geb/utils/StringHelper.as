package geb.utils
{
	public final class StringHelper
	{
		public static function extract(txt:String, ahead:String, behind:String = null):String
		{
			if (txt == null) return "";
			
			var indexStart:int = ahead == null ? 0 : txt.indexOf(ahead);
			if (indexStart < 0) return "";
			
			var startLength:int = ahead == null ? 0 : ahead.length;
			
			if(behind == null || behind == "") return txt.substring(indexStart);
			
			var indexEnd:int = behind == null ? txt.length : txt.indexOf(behind, Math.max(0, indexStart + startLength));
			
			if (indexEnd < indexStart) return "";
			else return txt.substr(indexStart + startLength, indexEnd - indexStart - startLength);
		}
	}
}