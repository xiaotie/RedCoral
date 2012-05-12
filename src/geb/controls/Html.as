/**
 * Label.as
 * Keith Peters
 * version 0.9.10
 * 
 * A Label component for displaying a single line of text.
 * 
 * Copyright (c) 2011 Keith Peters
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package geb.controls
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import geb.common.BaseComponent;
	import geb.common.Style;
	
	[Event(name="resize", type="flash.events.Event")]
	public class Html extends BaseComponent
	{
		protected var _autoSize:Boolean = false;
		protected var _tf:TextField;
		
		public var fontName:String = Style.fontName;
		public var fontSize:Number = Style.fontSize;
		
		private var _htmlText:String = null;
		
		public function get htmlText():String
		{
			return _htmlText;
		}
		
		public function set htmlText(value:String):void
		{
			_htmlText = value;
			invalidate();
		}
		
		public function Html(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0)
		{
			super(parent, xpos, ypos);
		}
		
		override protected function init():void
		{
			super.init();
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		override protected function addChildren():void
		{
			_height = height > 0? height : 18;
			_tf = new TextField();
			_tf.height = _height;
			_tf.selectable = true;
			_tf.mouseEnabled = false;
			addChild(_tf);
			draw();
		}
		
		override public function draw():void
		{
			super.draw();
			_height = height > 0? height : 18;
			var f:TextFormat = new TextFormat(fontName,fontSize);
			_tf.height = _height;
			_tf.multiline = true;
			_tf.wordWrap = true;
			_tf.htmlText = htmlText;
			_tf.autoSize = TextFieldAutoSize.NONE;
			_tf.width = _width;
		}
		
		public function get textField():TextField
		{
			return _tf;
		}
	}
}