/**
 * @author xiaotie@geblab.com 
 */

package geb.controls
{
	[Bindable]
	public class ListItem
	{
		public var key:String;
		public var label:String;
		
		public function ListItem(key:String = null, label:String = null):void
		{
			this.key = key;
			this.label = label;
		}
	}
}