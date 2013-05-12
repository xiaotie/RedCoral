/**
 * @author xiaotie@geblab.com 
 */

package geb.shapes
{
	import flash.display.Graphics;
	
	import geb.common.BaseComponent;
	
	public class Ellipse extends BaseShape
	{
		public override function draw():void
		{
			var g:Graphics = this.graphics;
			g.clear();
			if(width > 0 && height > 0)
			{
				if(isNaN(borderThickness) == false && borderThickness > 0)
				{
					g.lineStyle(this.borderThickness, this.borderColor, this.borderAlpha);
				}
				
				if(this.texture)
				{
					g.beginBitmapFill(this.texture);					
				}
				else
				{
					g.beginFill(color, this.fillAlpha);
				}
				g.drawEllipse(0,0,width,height);
				g.endFill();
			}
			
			super.draw();
		}
	}
}