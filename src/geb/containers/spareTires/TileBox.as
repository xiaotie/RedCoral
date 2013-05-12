package geb.containers.spareTires
{
	import com.yahoo.astra.fl.containers.TilePane;

	public class TileBox extends TilePane
	{
		public function removeAllChildren():void
		{
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
	}
}