/**
 * @author xiaotie@geblab.com 
 */

package geb.shapes
{
	import flash.display.Graphics;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class AntLine extends BaseShape
	{
		private var _lines:Vector.<Vector.<Point>>;
		
		public function get lines():Vector.<Vector.<Point>>
		{
			return _lines;
		}
		
		public function set lines(value:Vector.<Vector.<Point>>):void
		{
			if(_lines == value) return;
			
			_lines = value;
			this.draw();
		}
		
		private var _alternativeColor:uint = 0x000000;
		
		public function get alternativeColor():uint
		{
			return _alternativeColor;
		}
		
		public function set alternativeColor(value:uint):void
		{
			if(_alternativeColor ==value) return;
			
			_alternativeColor = value;
			this.invalidate();
		}
		
		public var thickness:Number = 1;
		
		private var timer:Timer;
		
		private var odd:Boolean = false;
		
		public function start():void
		{
			if(timer == null)
			{
				timer = new Timer(300,int.MAX_VALUE);
				timer.addEventListener(TimerEvent.TIMER, onTimer);
			}
			timer.start();
		}
		
		private  function onTimer(e:TimerEvent):void
		{
			this.draw();
		}
		
		public override function draw():void
		{
			odd = !odd;
			
			var g:Graphics = this.graphics;
			g.clear();
			
			if(lines == null || lines.length == 0) return;
			
			for(var i:int = 0; i< _lines.length; i++)
			{
				var line:Vector.<Point> = _lines[i];
				if(line.length > 1)
				{
					if(odd == false)
					{
						g.lineStyle(thickness, this.color, 1,true);
						
						for(var k:int = 0; k < line.length; k++)
						{
							if(k%2 == 0)
							{
								g.moveTo(line[k].x,line[k].y);
							}
							else
							{
								g.lineTo(line[k].x,line[k].y);
							}
						}
						
						g.lineStyle(thickness, this.alternativeColor, 1,true);

						for(k = 1; k < line.length; k++)
						{
							if(k%2 == 1)
							{
								g.moveTo(line[k].x,line[k].y);
							}
							else
							{
								g.lineTo(line[k].x,line[k].y);
							}
						}
					}
					else
					{
						g.lineStyle(thickness, this.color, 1,true);
						
						for(k = 1; k < line.length; k++)
						{
							if(k%2 == 1)
							{
								g.moveTo(line[k].x,line[k].y);
							}
							else
							{
								g.lineTo(line[k].x,line[k].y);
							}
						}
						
						g.lineStyle(thickness, this.alternativeColor, 1,true);
						
						for(var k:int = 0; k < line.length; k++)
						{
							if(k%2 == 0)
							{
								g.moveTo(line[k].x,line[k].y);
							}
							else
							{
								g.lineTo(line[k].x,line[k].y);
							}
						}
					}
				}
			}
		}
	}
}