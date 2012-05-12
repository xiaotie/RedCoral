package geb.controls.fl
{
	import fl.controls.CheckBox;

	public class FlCheckBox extends fl.controls.CheckBox
	{
		[Bindable]
		public override function set selected(val:Boolean):void
		{
			super.selected = val;
		}
	}
}