/**
 * @author xiaotie@geblab.com 
 */

package geb.utils
{
	import flash.text.Font;

	public class FlashFont
	{
		public var name:String;
		public var flashName:String;
		public var isBuildIn:Boolean;
		
		public function FlashFont(name:String, fname:String, buildIn:Boolean = false):void
		{
			this.name = name;
			this.flashName = fname;
			this.isBuildIn = buildIn;
		}
		
		public static function GetSystemFonts(lang:String = "CN"):Vector.<FlashFont>
		{
			var sysFonts:Array = Font.enumerateFonts(true); 
			var list:Vector.<FlashFont> = new Vector.<FlashFont>();
			var cns:Vector.<FlashFont> = GetCNFonts();
			for each(var item:FlashFont in cns)
			{
				var needAdd:Boolean = item.isBuildIn;
				if(needAdd == false)
				{
					for each(var font:Font in sysFonts)
					{
						if(item.flashName == font.fontName || item.name == font.fontName)
						{
							needAdd = true;
							break;
						}
					}
				}
				
				if(needAdd == true)
				{
					var flashFont:FlashFont = new FlashFont(item.name,item.flashName,item.isBuildIn);
					list.push(flashFont);
				}
			}
			return list;
		}
		
		private static function GetCNFonts():Vector.<FlashFont>
		{
			var cache:Vector.<FlashFont> = new Vector.<FlashFont>();
			cache.push(new FlashFont("宋体", "SimSun", true));
			cache.push(new FlashFont("黑体", "SimHei", true));
//			cache.push(new FlashFont("微软正黑体", "Microsoft JhengHei"));
			cache.push(new FlashFont("微软雅黑", "Microsoft YaHei", true));
			cache.push(new FlashFont("新宋体", "NSimSun"));
//			cache.push(new FlashFont("新细明体", "PMingLiU"));
			cache.push(new FlashFont("细明体", "MingLiU"));
//			cache.push(new FlashFont("标楷体", "DFKai-SB"));
			cache.push(new FlashFont("仿宋", "FangSong"));
			cache.push(new FlashFont("楷体", "KaiTi"));
			cache.push(new FlashFont("仿宋_GB2312", "FangSong_GB2312"));
			cache.push(new FlashFont("楷体_GB2312", "KaiTi_GB2312"));
			return cache;
		}
	}
}