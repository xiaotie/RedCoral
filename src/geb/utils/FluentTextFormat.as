package geb.utils
{
	import flash.text.TextFormat;

	public class FluentTextFormat extends TextFormat
	{
		public function FluentTextFormat()
		{
			super();
			this.font = "宋体";
		}
		
		public function setBold(val:Boolean = true):FluentTextFormat
		{
			this.bold = true;
			return this;
		}
		
		public function setAlign(val:String = "left"):FluentTextFormat
		{
			this.align = val;
			return this;
		}
		
		public function setSize(val:int = 10):FluentTextFormat
		{
			this.size = val;
			return this;
		}
		
		public function setColor(color:uint = 0):FluentTextFormat
		{
			this.color = color;
			return this;
		}
	}
}