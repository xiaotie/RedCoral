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
		
		public var fontName:String = "Microsoft YaHei";
		public var fontSize:Number = 12;
		private var _fontColor:uint = 0x000000;
		private var _align:String = "left";
		private var _editable:Boolean = true;
		
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
			_format = new TextFormat(fontName, fontSize, fontColor);
			_tf = new TextField();
			_tf.x = 2;
			_tf.y = 2;
			_tf.height = _height;
			_tf.multiline = true;
			_tf.wordWrap = true;
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
			
			if(_tf == null) return;
			
			_tf.width = _width - 4;
			_tf.height = _height - 4;
			
			var f:TextFormat = new TextFormat(fontName,fontSize,fontColor);
			f.align = this.align;
			f.font = fontName;
			_tf.height = _height;
			
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