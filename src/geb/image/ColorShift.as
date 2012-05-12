package geb.image
{
	import flash.geom.ColorTransform;
	
	/**
	 * 颜色偏移
	 */
	public class ColorShift
	{
		public var RedShift : Number;
		public var GreenShift : Number;
		public var BlueShift : Number;
		public var name : String;
		
		public function ColorShift(_name : String,  rf : Number = 0, gf : Number = 0, bf : Number = 0)
		{
			name = _name;
			this.RedShift = rf;
			this.GreenShift = gf;
			this.BlueShift = bf;
		}
		
		public function CreateColorTransform() : ColorTransform
		{
			return new ColorTransform(1,1,1,1,this.RedShift,this.GreenShift,this.BlueShift,0);
		}
		
		public static var Color_DefaultShift : ColorShift = new ColorShift("Black", -92, -97, -107);
		public static var Color_Gray:ColorShift=new ColorShift("Gray", 32, 25, 13);
		public static var Color_Platinum_Blonde:ColorShift=new ColorShift("Platinum Blonde", 49, 39, 16);
		public static var Color_Light_Blonde:ColorShift=new ColorShift("Light Blonde", 23, 5, -23);
		public static var Color_Dark_Blonde:ColorShift=new ColorShift("Dark Blonde", -23, -42, -65);
		public static var Color_Brown:ColorShift=new ColorShift("Brown", -50, -65, -86);
		public static var Color_Light_Brown:ColorShift=new ColorShift("Light Brown", -33, -50, -74);
		public static var Color_Darkest_Brown:ColorShift=new ColorShift("Darkest Brown", -79, -90, -105);
		public static var Color_Black:ColorShift=new ColorShift("Black", -92, -97, -107);
		public static var Color_Blonde:ColorShift=new ColorShift("Blonde", 5, -12, -37);
		public static var Color_Lightest_Blonde:ColorShift=new ColorShift("Lightest Blonde", 38, 23, -5);
		public static var Color_Dark_Brown:ColorShift=new ColorShift("Dark Brown", -61, -75, -93);
		public static var Color_Lightest_Ash_Blonde:ColorShift=new ColorShift("Lightest Ash Blonde", 37, 30, 10);
		public static var Color_Lightest_Golden_Blonde:ColorShift=new ColorShift("Lightest Golden Blonde", 36, 15, -19);
		public static var Color_Light_Copper_Chestnut:ColorShift=new ColorShift("Light Copper Chestnut", -7, -56, -85);
		public static var Color_Ash_Blonde:ColorShift=new ColorShift("Ash Blonde", 17, 8, -10);
		public static var Color_Golden_Blonde:ColorShift=new ColorShift("Golden Blonde", 8, -17, -51);
		public static var Color_Copper_Blonde:ColorShift=new ColorShift("Copper Blonde", 22, -35, -88);
		public static var Color_Light_Ash_Brown:ColorShift=new ColorShift("Light Ash Brown", -20, -29, -47);
		public static var Color_Light_Golden_Brown:ColorShift=new ColorShift("Light Golden Brown", -14, -42, -73);
		public static var Color_Lightest_Copper_Blonde:ColorShift=new ColorShift("Lightest Copper Blonde", 37, -7, -58);
		public static var Color_Light_Hazelnut_Brown:ColorShift=new ColorShift("Light Hazelnut Brown", -3, -30, -60);
		public static var Color_Darkest_Red:ColorShift=new ColorShift("Darkest Red", -71, -117, -120);
		public static var Color_Dark_Ash_Blonde:ColorShift=new ColorShift("Dark Ash Blonde", -8, -17, -35);
		public static var Color_Dark_Golden_Brown:ColorShift=new ColorShift("Dark Golden Brown", -38, -65, -94);
		public static var Color_Light_Golden_Copper:ColorShift=new ColorShift("Light Golden Copper", 29, -24, -81);
		public static var Color_Caramel_Brown:ColorShift=new ColorShift("Caramel Brown", -16, -41, -70);
		public static var Color_Red:ColorShift=new ColorShift("Red", -31, -86, -90);
		public static var Color_Blue_Black:ColorShift=new ColorShift("Blue Black", -75, -75, -55);
		public static var Color_Dark_Golden_Blonde:ColorShift=new ColorShift("Dark Golden Blonde", 0, -27, -61);
		public static var Color_Dark_Copper_Blonde:ColorShift=new ColorShift("Dark Copper Blonde", 10, -38, -78);
		public static var Color_Chestnut_Brown:ColorShift=new ColorShift("Chestnut Brown", -32, -67, -95);
		public static var Color_Dark_Red_Blonde:ColorShift=new ColorShift("Dark Red Blonde", 0, -66, -80);
		public static var Color_Artic_Blonde:ColorShift=new ColorShift("Artic Blonde", 53, 45, 28);
		public static var Color_Light_Ash_Blonde:ColorShift=new ColorShift("Light Ash Blonde", 27, 20, 0);
		public static var Color_Light_Golden_Blonde:ColorShift=new ColorShift("Light Golden Blonde", 18, -5, -35);
		public static var Color_Light_Titian:ColorShift=new ColorShift("Light Titian", 55, 16, -32);
		public static var Color_Light_Bronzed_Brown:ColorShift=new ColorShift("Light Bronzed Brown", 0, -32, -70);
		public static var Color_Red_Blonde:ColorShift=new ColorShift("Red Blonde", 15, -47, -65);
		public static var Color_Strawberry_Blonde:ColorShift=new ColorShift("Strawberry Blonde", 53, 33, 11);
		public static var Color_Platinum_Ash_Blonde:ColorShift=new ColorShift("Platinum Ash Blonde", 53, 44, 23);
		public static var Color_Golden_Brown:ColorShift=new ColorShift("Golden Brown", -25, -52, -81);
		public static var Color_Copper_Chestnut:ColorShift=new ColorShift("Copper Chestnut", -27, -76, -99);
		public static var Color_Auburn_Brown:ColorShift=new ColorShift("Auburn Brown", -15, -56, -98);
		public static var Color_Ruby_Red:ColorShift=new ColorShift("Ruby Red", 0, -99, -109);
		public static var Color_Beige_Blonde:ColorShift=new ColorShift("Beige Blonde", 43, 27, 0);
		public static var Color_Mocha_Brown:ColorShift=new ColorShift("Mocha Brown", -45, -70, -90);
		public static var Color_Darkest_Violet:ColorShift=new ColorShift("Darkest Violet", -60, -100, -80);
		public static var Color_Dark_Red:ColorShift=new ColorShift("Dark Red", -55, -106, -106);
		public static var Color_Ultra_Light_Golden_Blonde:ColorShift=new ColorShift("Ultra Light Golden Blonde", 55, 36, -1);
		public static var Color_Violet:ColorShift=new ColorShift("Violet", -40, -80, -60);
		public static var Color_Honey_Blonde:ColorShift=new ColorShift("Honey Blonde", 45, 25, -11);
		public static var Color_Light_Violet:ColorShift=new ColorShift("Light Violet", -30, -70, -50);
		public static var Color_Dark_Violet:ColorShift=new ColorShift("Dark Violet", -50, -90, -70);
		
		/**
		 */
		public static function CombineTwo(first:ColorShift, second:ColorShift): ColorShift
		{
			return new ColorShift(first.name, first.RedShift + second.RedShift, first.GreenShift + second.GreenShift,
				first.BlueShift + second.BlueShift);
		}
		
		public static function CombineThree(first:ColorShift, second:ColorShift, third:ColorShift): ColorShift
		{
			return new ColorShift(first.name, 
				first.RedShift + second.RedShift + third.RedShift, 
				first.GreenShift + second.GreenShift + third.GreenShift,
				first.BlueShift + second.BlueShift + third.BlueShift);
		}
		
		public static function CreateColorFamilyNameList() : Array
		{
			var a : Array = new Array();
			a.push("天然色","金黄色","灰色","金色","棕色","铜色","紫色","红色");
			return a;
		}
		
		public static function CreateNaturalColorFamily() : Array
		{
			var colors : Array = new Array(11);
			
			colors[0] = ColorShift.Color_Black;
			colors[1] = ColorShift.Color_Darkest_Brown;
			colors[2] = ColorShift.Color_Dark_Brown;
			colors[3] = ColorShift.Color_Brown;
			colors[4] = ColorShift.Color_Light_Brown;
			colors[5] = ColorShift.Color_Dark_Blonde
			colors[6] = ColorShift.Color_Blonde;
			colors[7] = ColorShift.Color_Light_Blonde;
			colors[8] = ColorShift.Color_Lightest_Blonde;
			colors[9] = ColorShift.Color_Platinum_Blonde;
			colors[10] = ColorShift.Color_Gray;
			return colors;
		}
		
		public static function CreateBlondeColorFamily() : Array
		{
			var colors : Array = new Array(5);
			colors[0] = ColorShift.Color_Strawberry_Blonde;
			colors[1] = ColorShift.Color_Beige_Blonde;
			colors[2] = ColorShift.Color_Honey_Blonde;
			colors[3] = ColorShift.Color_Ultra_Light_Golden_Blonde;
			colors[4] = ColorShift.Color_Artic_Blonde;
			return colors;
		}
		
		public static function CreateAshColorFamily() : Array
		{
			var colors : Array = new Array(7);
			colors[0] = ColorShift.Color_Blue_Black;
			colors[1] = ColorShift.Color_Light_Ash_Brown;
			colors[2] = ColorShift.Color_Dark_Ash_Blonde;
			colors[3] = ColorShift.Color_Ash_Blonde;
			colors[4] = ColorShift.Color_Light_Ash_Blonde;
			colors[5] = ColorShift.Color_Lightest_Ash_Blonde;
			colors[6] = ColorShift.Color_Platinum_Ash_Blonde;
			return colors;
		}
		
		public static function createGoldColorFamily() : Array
		{
			var colors : Array = new Array(7);
			colors[0] = ColorShift.Color_Dark_Golden_Brown;
			colors[1] = ColorShift.Color_Golden_Brown;
			colors[2] = ColorShift.Color_Light_Golden_Brown;
			colors[3] = ColorShift.Color_Dark_Golden_Blonde;
			colors[4] = ColorShift.Color_Golden_Blonde;
			colors[5] = ColorShift.Color_Light_Golden_Blonde;
			colors[6] = ColorShift.Color_Lightest_Golden_Blonde;
			return colors;
		}
		
		public static function CreateBrownColorFamily() : Array
		{
			var colors : Array = new Array(6);
			colors[0] = ColorShift.Color_Mocha_Brown;
			colors[1] = ColorShift.Color_Chestnut_Brown;
			colors[2] = ColorShift.Color_Auburn_Brown;
			colors[3] = ColorShift.Color_Caramel_Brown;
			colors[4] = ColorShift.Color_Light_Bronzed_Brown;
			colors[5] = ColorShift.Color_Light_Hazelnut_Brown;
			return colors;
		}
		
		public static function CreateCopperColorFamily() : Array
		{
			var colors : Array = new Array(7);
			colors[0] = ColorShift.Color_Copper_Chestnut;
			colors[1] = ColorShift.Color_Light_Copper_Chestnut;
			colors[2] = ColorShift.Color_Dark_Copper_Blonde;
			colors[3] = ColorShift.Color_Copper_Blonde;
			colors[4] = ColorShift.Color_Light_Golden_Copper;
			colors[5] = ColorShift.Color_Lightest_Copper_Blonde;
			colors[6] = ColorShift.Color_Light_Titian;
			return colors;
		}
		
		public static function CreateVioletColorFamily() : Array
		{
			var colors : Array = new Array(4);
			colors[0] = ColorShift.Color_Darkest_Violet;
			colors[1] = ColorShift.Color_Dark_Violet;
			colors[2] = ColorShift.Color_Violet;
			colors[3] = ColorShift.Color_Light_Violet;
			return colors;
		}
		
		public static function CreateRedColorFamily() : Array
		{
			var colors : Array = new Array(6);
			colors[0] = ColorShift.Color_Darkest_Red;
			colors[1] = ColorShift.Color_Dark_Red;
			colors[2] = ColorShift.Color_Red;
			colors[3] = ColorShift.Color_Ruby_Red;
			colors[4] = ColorShift.Color_Dark_Red_Blonde;
			colors[5] = ColorShift.Color_Red_Blonde;
			return colors;
		}
		
		public static function CreateColorFamily(index:Number) : Array
		{
			switch(index)
			{
				case 0:
					return CreateNaturalColorFamily();
					break;
				case 1:
					return CreateBlondeColorFamily();
					break;
				case 2:
					return CreateAshColorFamily();
					break;
				case 3:
					return createGoldColorFamily();
					break;
				case 4:
					return CreateBrownColorFamily();
					break;
				case 5:
					return CreateCopperColorFamily();
					break;
				case 6:
					return CreateVioletColorFamily();
					break;
				case 7:
					return CreateRedColorFamily();
					break;
				default:
					return new Array();
					break;
			}
		}
		
		public static function CreateMiniToneShifts():Array
		{
			var c : Array = new Array();
			c.push(new ColorShift("",-12,-2,7));
			c.push(new ColorShift("",-10,-2,8));
			c.push(new ColorShift("",-8,-1,5));
			c.push(new ColorShift("",-6,-1,4));
			c.push(new ColorShift("",-4,-1,3));
			c.push(new ColorShift("",-2,0,1));
			c.push(new ColorShift("",0,0,0));
			c.push(new ColorShift("",2,0,-1));
			c.push(new ColorShift("",4,1,-3));
			c.push(new ColorShift("",6,1,-4));
			c.push(new ColorShift("",8,1,-5));
			c.push(new ColorShift("",10,2,-7));
			c.push(new ColorShift("",12,2,-8));
			return c;
		}
		
		public static function CreateMiniBrightShifts():Array
		{
			var c : Array = new Array();
			for(var i: int = 0; i<13; i++)
			{
				var shift: int = (i - 6) * 5;
				c.push(new ColorShift("",shift,shift,shift));
			}
			return c;
		}
	}
}