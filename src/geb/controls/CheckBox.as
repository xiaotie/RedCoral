package geb.controls
{
	import fl.controls.CheckBox;

	public class CheckBox extends fl.controls.CheckBox
	{
		[Bindable]
		public override function set selected(val:Boolean):void
		{
			super.selected = val;
		}
	}
}