/**
 * Text.as
 * Keith Peters
 * version 0.9.10
 * 
 * A Text component for displaying multiple lines of text.
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
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import geb.common.BaseComponent;
	import geb.common.Style;
	import geb.containers.spareTires.Panel;
	import geb.shapes.Rectangle;
	import geb.utils.Padding;
	
	[Event(name="change", type="flash.events.Event")]
	[Event(name="click", type="flash.events.MouseEvent")]
	[Event(name="focusIn", type="flash.events.FocusEvent")]
	[Event(name="focusOut", type="flash.events.FocusEvent")]
	public class Text extends BaseComponent
	{
		protected var _tf:TextField;
		protected var _text:String = "";
		protected var _panel:Panel;
		protected var _selectable:Boolean = true;
		protected var _html:Boolean = false;
		protected var _format:TextFormat;
		
		private var _fontName:String = "Microsoft YaHei";
		private var _fontSize:Number = 12;
		private var _fontColor:uint = 0x000000;
		private var _align:String = "left";
		private var _editable:Boolean = true;
		private var _restrict:String;
		private var _bgColor:uint = 0xFFFFFF;
		private var _borderColor:uint = 0x999999;
		private var _borderThickness:int = 1;
		private var _transparent:Boolean = false;
		private var _bg:Rectangle;
		
		private var _padding:Padding;
		private var _multiline:Boolean = true;
		private var _wordWrap:Boolean = true;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this Label.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param text The initial text to display in this component.
		 */
		public function Text(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, text:String = "")
		{
			this.text = text;
			super(parent, xpos, ypos);
			setSize(200, 100);
		}

		public function get fontSize():Number
		{
			return _fontSize;
		}

		public function set fontSize(value:Number):void
		{
			_fontSize = value;
			this.invalidate();
		}

		public function get fontName():String
		{
			return _fontName;
		}

		public function set fontName(value:String):void
		{
			_fontName = value;
			this.invalidate();
		}

		public function get wordWrap():Boolean
		{
			return _wordWrap;
		}

		public function set wordWrap(value:Boolean):void
		{
			_wordWrap = value;
			this.invalidate();
		}

		public function get multiline():Boolean
		{
			return _multiline;
		}

		public function set multiline(value:Boolean):void
		{
			_multiline = value;
			this.invalidate();
		}

		public function get padding():Padding
		{
			return _padding;
		}

		public function set padding(value:Padding):void
		{
			_padding = value;
			this.invalidate();
		}

		public function get transparent():Boolean
		{
			return _transparent;
		}

		public function set transparent(value:Boolean):void
		{
			_transparent = value;
			this.invalidate();
		}

		public function get borderThickness():int
		{
			return _borderThickness;
		}

		public function set borderThickness(value:int):void
		{
			_borderThickness = value;
			this.invalidate();
		}

		public function get borderColor():uint
		{
			return _borderColor;
		}

		public function set borderColor(value:uint):void
		{
			_borderColor = value;
			this.invalidate();
		}

		public function get bgColor():uint
		{
			return _bgColor;
		}

		public function set bgColor(value:uint):void
		{
			_bgColor = value;
			this.invalidate();
		}
		
		public function get restrict():String
		{
			return _restrict;
		}

		public function set restrict(value:String):void
		{
			_restrict = value;
			this.invalidate();
		}

		public function get fontColor():uint
		{
			return _fontColor;
		}

		public function set fontColor(value:uint):void
		{
			_fontColor = value;
			this.invalidate();
		}

		public function updateContent(txt:String):void
		{
			_text = txt;
			this._tf.text = txt;
		}
		
		public function get align():String
		{
			return _align;
		}

		public function set align(value:String):void
		{
			_align = value;
			this.invalidate();
		}

		public function get editable():Boolean
		{
			return _editable;
		}

		public function set editable(value:Boolean):void
		{
			_editable = value;
			this.invalidate();
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			_bg = new Rectangle();
			addChild(_bg);
			
			_format = new TextFormat(fontName, fontSize, fontColor);
			_tf = new TextField();
			if(_padding == null)
			{
				_tf.x = 2;
				_tf.y = 2;
			}
			else
			{
				_tf.x = _padding.left;
				_tf.y = _padding.top;
			}
			_tf.restrict = _restrict;
			_tf.height = _height;
			_tf.multiline = _multiline;
			_tf.wordWrap = this.wordWrap;
			_tf.selectable = true;
			_tf.defaultTextFormat = _format;
			_tf.addEventListener(Event.CHANGE, onChange);
			_tf.addEventListener(MouseEvent.CLICK, onClick);
			//_tf.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			//_tf.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
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
			
			if(_bg == null) return;
			
			_bg.width = this.width;
			_bg.height = this.height;
			_bg.color = this.bgColor;
			_bg.fillAlpha = this.transparent ? 0 : 1;
			_bg.borderThickness = this.borderThickness;
			_bg.borderColor = this.borderColor;
			_bg.draw();
			
			if(_tf == null) return;
			
			var f:TextFormat = new TextFormat(fontName,fontSize,fontColor);
			f.align = this.align;
			f.font = fontName;
			_tf.multiline = multiline;
			_tf.restrict = restrict;
			_tf.wordWrap = wordWrap;
			if(_padding == null)
			{
				_tf.x = 2;
				_tf.y = 2;
				_tf.width = _width - 4;
				_tf.height = _height - 4;
			}
			else
			{
				_tf.x = _padding.left;
				_tf.y = _padding.top;
				_tf.width = _width - _padding.left - _padding.right;
				_tf.height = _height - _padding.top - _padding.bottom;
			}
			
			if(editable)
			{
				_tf.defaultTextFormat = f;
				_tf.mouseEnabled = true;
				_tf.selectable = true;
				_tf.type = TextFieldType.INPUT;
			}
			else
			{
				_tf.mouseEnabled = _selectable;
				_tf.selectable = _selectable;
				_tf.type = TextFieldType.DYNAMIC;
				_tf.defaultTextFormat = f;
			}
			
			if(_html)
			{
				_tf.htmlText = _text;
				_tf.condenseWhite = true;
			}
			else
			{
				_tf.text = _text;
			}
			
		}
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Called when the text in the text field is manually changed.
		 */
		protected function onChange(event:Event):void
		{
			_text = _tf.text;
			dispatchEvent(event);
		}
		
		protected function onClick(event:Event):void
		{
			dispatchEvent(event);
		}
		
		protected function onFocusIn(event:FocusEvent):void
		{
			dispatchEvent(event);
		}
		
		protected function onFocusOut(event:FocusEvent):void
		{
			dispatchEvent(event);
		}
		
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
		 * Returns a reference to the internal text field in the component.
		 */
		public function get textField():TextField
		{
			return _tf;
		}
		
		/**
		 * Gets / sets whether or not this text component will be selectable. Only meaningful if editable is false.
		 */
		public function set selectable(b:Boolean):void
		{
			_selectable = b;
			invalidate();
		}
		public function get selectable():Boolean
		{
			return _selectable;
		}
		
		/**
		 * Gets / sets whether or not text will be rendered as HTML or plain text.
		 */
		public function set html(b:Boolean):void
		{
			_html = b;
			invalidate();
		}
		public function get html():Boolean
		{
			return _html;
		}

        /**
         * Sets/gets whether this component is enabled or not.
         */
        public override function set enabled(value:Boolean):void
        {
            super.enabled = value;
            _tf.tabEnabled = value;
        }

	}
}