/**
 * @author xiaotie@geblab.com 
 */

package geb.utils
{
	public class Padding
	{
		public var left:Number = 0;
		public var right:Number = 0;
		public var top:Number = 0;
		public var bottom:Number = 0;
		
		public function Padding(top:Number = 0,right:Number = 0,bottom:Number = 0,left:Number = 0):void
		{
			this.left = left;
			this.bottom = bottom;
			this.top = top;
			this.right = right;
		}
	}
}