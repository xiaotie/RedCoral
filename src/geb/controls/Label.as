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
	public class Label extends BaseComponent
	{
		protected var _autoSize:Boolean = false;
		protected var _text:String = "";
		protected var _tf:TextField;
		
		public var fontName:String = Style.fontName;
		public var fontSize:Number = Style.fontSize;
		
		private var _fontColor:uint = 0x000000;
		
		[Bindable]
		public var textWidth:Number;
		[Bindable]
		public var textHeight:Number;

		public function get fontColor():uint
		{
			return _fontColor;
		}

		public function set fontColor(value:uint):void
		{
			_fontColor = value;
			invalidate();
		}
		
		private var _fontFamily:String;

		public function get fontFamily():String
		{
			return _fontFamily;
		}

		public function set fontFamily(value:String):void
		{
			_fontFamily = value;
			invalidate();
		}

		public var align:String = "left";
		public var bold:Boolean = false;
		public var underline:Boolean = false;
		public var italic:Boolean = false;
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
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this Label.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param text The string to use as the initial text in this component.
		 */
		public function Label(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, text:String = "")
		{
			this.text = text;
			super(parent, xpos, ypos);
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			_height = height > 0? height : 18;
			_tf = new TextField();
			_tf.height = _height;
			_tf.selectable = false;
			_tf.mouseEnabled = false;
			_tf.text = _text;	
			textWidth = _tf.textWidth;
			textHeight = _tf.textHeight;
			addChild(_tf);
			draw();
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			_height = height > 0? height : 18;
			if(_tf == null) return;
			
			var f:TextFormat = new TextFormat(fontName,fontSize,fontColor);
			f.align = this.align;
			f.bold = this.bold;
			f.underline = this.underline;
			f.italic = this.italic;
			if(fontFamily)
			{
				f.font = fontFamily;
			}
			_tf.height = _height;
			if(htmlText)
			{
				_tf.multiline = true;
				_tf.wordWrap = true;
				_tf.htmlText = htmlText;
			}
			else
			{
				_tf.defaultTextFormat = f;
				_tf.text = _text;
			}
			
			textWidth = _tf.textWidth;
			textHeight = _tf.textHeight;

			if(_autoSize)
			{
				_tf.autoSize = TextFieldAutoSize.LEFT;
				_width = _tf.width;
				dispatchEvent(new Event(Event.RESIZE));
			}
			else
			{
				_tf.autoSize = TextFieldAutoSize.NONE;
				_tf.width = _width;
			}
		}
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Gets / sets the text of this Label.
		 */
		public function set text(t:String):void
		{
			_text = t;
			if(_text == null) _text = "";
			invalidate();
		}
		
		public function get text():String
		{
			return _text;
		}
		
		/**
		 * Gets / sets whether or not this Label will autosize.
		 */
		public function set autoSize(b:Boolean):void
		{
			_autoSize = b;
		}
		
		public function get autoSize():Boolean
		{
			return _autoSize;
		}
		
		/**
		 * Gets the internal TextField of the label if you need to do further customization of it.
		 */
		public function get textField():TextField
		{
			return _tf;
		}
	}
}