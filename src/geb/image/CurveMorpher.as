package geb.image
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.containers.Canvas;
	import mx.controls.Image;

	/**
	 * 曲线变形工具
	 */
	public class CurveMorpher extends BaseMorpher
	{
		public static const EVENT_MORPH_COMPLETED:String="MorphCompleted";

		public var Points:Array=new Array();

		public function CurveMorpher()
		{
			super();
			this.m_enable = false;
		}
		
		/**
		 * 启用或关闭变形功能
		 */
		public override function Enable(value:Boolean):void
		{
			EnableCore(value);
		}

		/**
		 * 划出曲线
		 */
		public function Draw(img:Image, lineWidth:Number, color:uint, clearBeforeDraw:Boolean=true):void
		{
			if (clearBeforeDraw == true)
				Util.clear(img);

			if (this.Points.length < 2)
				return;
				
			var start:Point=this.Points[0];
			img.graphics.clear();
			img.graphics.lineStyle(lineWidth, color);
			img.graphics.moveTo(start.x, start.y);
			for (var i:int=1; i < this.Points.length; i++)
			{
				var p:Point=this.Points[i];
				img.graphics.lineTo(p.x, p.y);
			}
		}
		
		/**
		 *  初始化Morpher于Canvas上。
		 */
		public function Init(mask:Canvas):void
		{
			this.AttachMask(mask);
		}
		
		public function Clone():CurveMorpher
		{
			var cm : CurveMorpher = new CurveMorpher();
			cm.RadialBasisExponent =this.RadialBasisExponent;
			cm.Radius = this.Radius;
			cm.Strength = this.Strength;
			cm.Points = new Array();
			for(var i : int = 0; i < this.Points.length; i++)
			{
				var p : Point = this.Points[i] as Point;
				cm.Points.push(new Point( p.x, p.y));
			}
			return cm;
		}

		protected override function LocalMorth():void
		{
			this.LocalMorphCore(this.m_rootX, this.m_rootY, this.m_toX, this.m_toY);
			var e:Event=new Event(EVENT_MORPH_COMPLETED);
			this.dispatchEvent(e);
		}

		private function LocalMorphCore(rootX:int, rootY:int, toX:int, toY:int):void
		{
			var rSquare:int=Radius * Radius;

			var transX:int=toX - rootX;
			var transY:int=toY - rootY;
			var transDistanceSquare:int=transX * transX + transY * transY; // dest 和 root 两点间距离的平方，也就是 |m-c|^2

			// 计算需要变形的框
			var fromX:int=Math.max(0, rootX - Radius);
			var toX:int=rootX + Radius;
			var fromY:int=Math.max(0, rootY - Radius);
			var toY:int=rootY + Radius;

			for (var i:int=0; i < this.Points.length; i++)
			{
				var p:Point=this.Points[i];
				var x:int=p.x;
				var y:int=p.y;
				var distanceSquare:int=(x - rootX) * (x - rootX) + (y - rootY) * (y - rootY); // |x-c|^2

				if (distanceSquare < rSquare)
				{
					var factor:Number=1 - ((Number)(distanceSquare)) / rSquare;
					if (RadialBasisExponent == 2)
					{
						factor=factor * factor;
					}
					else if (RadialBasisExponent == 3)
					{
						factor=factor * factor * factor;
					}
					else if (RadialBasisExponent > 3)
					{
						factor=Math.pow(factor, RadialBasisExponent);
					}

					factor=(factor * Strength) / 1000;

					p.x=x + (factor * transX); // 反向变换点的x坐标
					p.y=y + (factor * transY); // 反向变换点的y坐标
				}
			}
		}
	}
}