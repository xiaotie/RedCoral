package geb.utils
{
	import flash.filters.ColorMatrixFilter;

	public final class FilterHelper
	{
		public static function createGrayFilter(a:Number = 1, r:Number = 0.212672, g:Number = 0.715160, b:Number = 0.072169):ColorMatrixFilter
		{
			return new ColorMatrixFilter(
					[r, g, b, 0, 0,
					r, g, b, 0, 0,
					r, g, b, 0, 0,
					0, 0, 0, a, 0]);
		}
	}
}