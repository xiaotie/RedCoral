package geb.image
{
	import flash.display.Graphics;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	
	public class BaseMorpher extends EventDispatcher
	{
		public function BaseMorpher()
		{
			super();
			m_enable=false;
		}
		
		protected var m_enable:Boolean;
		protected var m_drawMode:Boolean;
		protected var m_enableMorph:Boolean;
		protected var m_mask:Canvas;
		protected var m_rootX:int;
		protected var m_rootY:int;
		protected var m_toX:int;
		protected var m_toY:int;

		protected static var MIN_STEP_SQUEAR:int=2;
		/**
		 * 选择区半径
		 */
		public var Radius:uint;

		/**
		 * 变形强度，取值范围为 1-1000
		 */
		public var Strength:uint;
		
		/**
		 * 变形使用的径向基函数的幂。RadialBasisExponent 越大，选区边缘的变形越小
		 */
		public var RadialBasisExponent:int = 2;
		

		protected function AttachMask(mask:Canvas):void
		{
			this.m_mask=mask;
			mask.useHandCursor=true;
			mask.addEventListener(MouseEvent.MOUSE_DOWN, OnMaskMouseDown);
			mask.addEventListener(MouseEvent.MOUSE_UP, OnMaskMouseUp);
			mask.addEventListener(MouseEvent.MOUSE_MOVE, OnMaskMouseMove);
			mask.addEventListener(MouseEvent.MOUSE_OUT, OnMaskMouseOut);
		}
		
		public virtual function Enable(value:Boolean):void
		{
			EnableCore(value);
		}
		
		protected function EnableCore(value:Boolean):void
		{
			this.m_enable=value;
			this.m_drawMode=value;
			this.m_enableMorph=value;
		}

		private function InDrawMode():Boolean
		{
			return this.m_enable && this.m_drawMode;
		}

		private function DrawCircle(radius:uint, x:int, y:int):void
		{
			if (this.m_mask == null)
				return;

			if (this.InDrawMode() == false)
				return;
			var r:uint=radius;

			var g:Graphics=this.m_mask.graphics;
			var lineColor:uint=0xFFFFCC00;
			if (x < -r || y < -r || x > this.m_mask.width + r || y > this.m_mask.height + r)
			{
				return;
			}
			g.lineStyle(1, lineColor);
			g.drawCircle(x, y, r);
			g.endFill();
		}

		private function OnMaskMouseDown(event:MouseEvent):void
		{
			this.Clear();
			this.m_enableMorph=true;
			this.ResetRootPosition(event);
			this.ResetToPosition(event);
		}

		private function ResetRootPosition(event:MouseEvent):void
		{
			this.m_rootX=event.localX;
			this.m_rootY=event.localY;
		}

		private function ResetToPosition(event:MouseEvent):void
		{
			this.m_toX=event.localX;
			this.m_toY=event.localY;
		}

		private function Clear():void
		{
			if (this.m_mask != null)
				this.m_mask.graphics.clear();
		}

		private function OnMaskMouseMove(event:MouseEvent):void
		{
			if (this.InDrawMode() == true)
			{
				this.Clear();

				DrawCircle(this.Radius, event.localX, event.localY);

//				if (this.m_enableMorph == true)
//				{
//					this.ResetToPosition(event);
//					var distanceSquear:int=Util.DistanceSquear(this.m_rootX, this.m_rootY, this.m_toX, this.m_toY);
//					if (distanceSquear > MIN_STEP_SQUEAR)
//					{
//						this.LocalMorth();
//						this.ResetRootPosition(event);
//					}
//				}
			}
		}

		private function OnMaskMouseUp(event:MouseEvent):void
		{
			if (this.m_enable == false)
				return;

			this.Clear();
			this.ResetToPosition(event);

			var distanceSquear:int=Util.distanceSquear(this.m_rootX, this.m_rootY, this.m_toX, this.m_toY);
			if (distanceSquear > MIN_STEP_SQUEAR)
			{
				this.LocalMorth();
			}

			this.ResetRootPosition(event);
			this.m_enableMorph=false;
		}

		private function OnMaskMouseOut(event:MouseEvent):void
		{
			this.Clear();
			this.m_enableMorph=false;
		}
		
		protected virtual function LocalMorth():void
		{
		}
	}
}