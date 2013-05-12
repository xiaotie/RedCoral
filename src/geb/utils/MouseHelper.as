package geb.utils
{
	public class MouseHelper
	{
		private var _stickHelper:MouseStickHelper;

		public function get stickHelper():MouseStickHelper
		{
			if(_stickHelper == null) _stickHelper = new MouseStickHelper();
			return _stickHelper;
		}
	}
}