package geb.image
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.events.FlexEvent;

	public class Morpher extends BaseMorpher
	{
		public static const EVENT_MORPHCOMPLETED:String="MorphCompleted";

		public function Morpher()
		{
			super();
		}
		
		/**
		 * 是否使用双线性插值。true为使用，false为不使用。不使用双线性插值，则使用最近邻插值。
		 */
		public var UseBilinearInterpolation : Boolean = true;

		private var m_data:BitmapData;
		private var m_image:ArgbImage2;
		private var m_src:DisplayObject;
		
		/**
		 *  初始化Morpher。
		 *  @param mask 显示操作圆圈的canvas
		 *  @param img 待Morpher的图像
		 */
		public function Init(mask:Canvas, img:Image):void
		{
			this.AttachMask(mask);
			this.Load(img);
			img.addEventListener(FlexEvent.UPDATE_COMPLETE, OnSrcDataChanged);
		}
		
		public function Reload():void
		{
			this.Load(this.m_src);
		}
		
		/**
		 *  设置Morpher的状态。
		 *  @param value Morpher的新状态。true则打开Morpher,false则关闭Morpher
		 */
		public override function Enable(value:Boolean):void
		{
			if (this.m_enable != value)
			{
				if (this.m_src != null)
					this.Load(this.m_src);
			}

			EnableCore(value);
		}
				
		private function OnSrcDataChanged(event:Event):void
		{
			if (this.m_src != null)
			{
				this.Load(this.m_src);
			}
		}

		private function GetBitmapData():BitmapData
		{
			return this.m_image.ToBitmapData();
		}

		private function LoadBitmapData(data:BitmapData):void
		{
			this.m_data=data;
			this.m_image=ArgbImage2.CreateFromBitmapData(data);
		}

		private function Load(obj:DisplayObject):void
		{
			var m_cache:ArgbImage2=ArgbImage2.CreateFromBitmapData(Util.createBitmapData(obj));
			this.LoadBitmapData(m_cache.ToBitmapData());
			this.m_src=obj;
		}

		protected override function LocalMorth():void
		{
			if (this.m_image == null)
				return;

			this.m_image.LocalMorph(this.m_rootX, this.m_rootY, this.m_toX, this.m_toY, this.Radius, Strength, RadialBasisExponent, UseBilinearInterpolation);
			var e:BitmapDataEvent=new BitmapDataEvent(this.GetBitmapData(), EVENT_MORPHCOMPLETED);
			this.dispatchEvent(e);
		}
	}
}