/**
 * Slider.as
 * Keith Peters
 * version 0.9.10
 * 
 * Abstract base slider class for HSlider and VSlider.
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
 * 
 * version 1.0
 * By. xiaotie@geblab.com
 * Changes: [2012-02-11] make it skinable 
 */
package geb.controls
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import geb.common.BaseComponent;
	import geb.shapes.RectangleUI;
	
	[Event(name="change", type="flash.events.Event")]
	[Event(name="backClick", type="flash.events.Event")]
	[Event(name="drop", type="flash.events.Event")]
	public class Slider extends BaseComponent
	{
		[Bindable]
		public var thumb:Sprite;
		[Bindable]
		public var track:Sprite;
		[Bindable]
		public var trackHighlight:Sprite;
		
		public var clickable:Boolean = true;
		
		[Bindable]
		public var orientation:String = "horizontal";
		
		private var _defaultTrackColor:uint = 0xcccccc;
		private var _defaultHighlightColor:uint = 0x94c615;

		public var trackClickable:Boolean = true;
		
		[Bindable]
		public var ignoreThumbSize:Boolean = false;

		protected var _value:Number = 0;
		protected var _max:Number = 100;
		protected var _min:Number = 0;
		protected var _tick:Number = 0.01;
		
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String = "vertical";
		
		private var _isDragging:Boolean;
		
		public function get defaultHighlightColor():uint
		{
			return _defaultHighlightColor;
		}

		public function set defaultHighlightColor(value:uint):void
		{
			_defaultHighlightColor = value;
			this.invalidate();
		}

		public function get defaultTrackColor():uint
		{
			return _defaultTrackColor;
		}

		public function set defaultTrackColor(value:uint):void
		{
			_defaultTrackColor = value;
			this.invalidate();
		}

		public function get isDragging():Boolean
		{
			return _isDragging;
		}

		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			
			if(orientation == HORIZONTAL)
			{
				setSize(width, height);
			}
			else
			{
				setSize(width, height);
			}
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			super.addChildren();
		}
		
		/**
		 * Adjusts value to be within minimum and maximum.
		 */
		protected function correctValue():void
		{
			if(_max > _min)
			{
				_value = Math.min(_value, _max);
				_value = Math.max(_value, _min);
			}
			else
			{
				_value = Math.max(_value, _max);
				_value = Math.min(_value, _min);
			}
		}
		
		private function get thumbSize():Number
		{
			if(thumb == null || ignoreThumbSize == true) return 0;
			else if(orientation == HORIZONTAL)
			{
				return thumb.width;
			}
			else
			{
				return thumb.height;
			}
		}
		
		/**
		 * Adjusts position of handle when value, maximum or minimum have changed.
		 * TODO: Should also be called when slider is resized.
		 */
		protected function updateDislpay():void
		{
			var range:Number;
			var highlightRange:Number;
			var pos:Number;
			var ts:Number = thumbSize;
			var dftTrackSize:Number = this.orientation == HORIZONTAL ? this.height : this.width;
			
			if(track == null)
			{
				var t:RectangleUI = new RectangleUI();
				t.x = 0;
				t.y = 0;
				t.width = dftTrackSize;
				t.height = dftTrackSize;
				t.color = this.defaultTrackColor;
				track = t;
			}
			
			if(trackHighlight == null)
			{
				var th:RectangleUI = new RectangleUI();
				th.x = 0;
				th.y = 0;
				th.width = dftTrackSize;
				th.height = dftTrackSize;
				th.color = this.defaultHighlightColor;
				trackHighlight = th;
			}
			
			if(orientation == HORIZONTAL)
			{
				range = _width - ts;
				pos = (_value - _min) / (_max - _min) * range;
				highlightRange = pos + ts * 0.5;
				
				if(track != null)
				{
					track.width = width;
					track.height = Math.min(height,track.height);
					track.y = Math.max(0, 0.5 * (height - track.height));
					if(track is BaseComponent)
					{
						BaseComponent(track).invalidateNow();
					}
				}
				
				if(trackHighlight != null)
				{
					trackHighlight.width = pos + 0.5 * ts;
					trackHighlight.height = Math.min(height,trackHighlight.height);
					trackHighlight.y = Math.max(0, 0.5 * (height - trackHighlight.height));
					if(trackHighlight is BaseComponent)
					{
						BaseComponent(trackHighlight).invalidateNow();
					}
				}
				
				if(thumb!=null)
				{
					thumb.x = pos - (ignoreThumbSize ? thumb.width * 0.5 : 0);
					thumb.y = 0.5 * (this.height - thumb.height);
				}
			}
			else
			{
				range = _height - ts;
				pos = height - ts - (_value - _min) / (_max - _min) * range;
				highlightRange = pos + ts * 0.5;
				
				if(thumb != null)
				{
					thumb.x = 0.5 * (this.width - thumb.width);
					thumb.y = pos - (ignoreThumbSize ? thumb.height * 0.5 : 0);
				}
				
				if(trackHighlight != null)
				{
					trackHighlight.width = Math.min(width,trackHighlight.width);
					trackHighlight.y = pos + 0.5 * ts;
					trackHighlight.height = height - trackHighlight.y;
					trackHighlight.x = Math.max(0, 0.5 * (width - trackHighlight.width));
					if(trackHighlight is BaseComponent)
					{
						BaseComponent(trackHighlight).invalidateNow();
					}
				}
				
				if(track != null)
				{
					track.height = height;
					track.width = Math.min(width,track.width);
					track.x = Math.max(0, 0.5 * (width - track.width));
					if(track is BaseComponent)
					{
						BaseComponent(track).invalidateNow();
					}
				}
			}
			
			if(track != null && this.contains(track) == false)
			{
				addChild(track);
				if(trackClickable)
				{
					track.useHandCursor = true;
					track.buttonMode = true;
					track.addEventListener(MouseEvent.MOUSE_DOWN, onBackClick);
				}
				else
				{
					track.removeEventListener(MouseEvent.MOUSE_DOWN, onBackClick);
				}
			}
			
			if(trackHighlight != null && this.contains(trackHighlight) == false)
			{
				addChild(trackHighlight);
				if(trackClickable)
				{
					trackHighlight.useHandCursor = true;
					trackHighlight.buttonMode = true;
					trackHighlight.addEventListener(MouseEvent.MOUSE_DOWN, onBackClick);
				}
				else
				{
					trackHighlight.removeEventListener(MouseEvent.MOUSE_DOWN, onBackClick);
				}
			}
			
			if(thumb != null && this.contains(thumb) == false)
			{
				thumb.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
				thumb.buttonMode = true;
				thumb.useHandCursor = true;
				addChild(thumb);
			}
			
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
			updateDislpay();
		}
		
		/**
		 * Convenience method to set the three main parameters in one shot.
		 * @param min The minimum value of the slider.
		 * @param max The maximum value of the slider.
		 * @param value The value of the slider.
		 */
		public function setSliderParams(min:Number, max:Number, value:Number):void
		{
			this.minimum = min;
			this.maximum = max;
			this.value = value;
		}
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Handler called when user clicks the background of the slider, causing the handle to move to that point. Only active if backClick is true.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onBackClick(event:MouseEvent):void
		{
			if(clickable == false) return;
			
			var ts:Number = thumbSize;
			var pos:Number;
			if(orientation == HORIZONTAL)
			{
				pos = mouseX - this.thumbSize * 0.5;
				pos = Math.max(pos, 0);
				pos = Math.min(pos, _width - ts);
				value = pos / (width - ts) * (_max - _min) + _min;
			}
			else
			{
				pos = mouseY - this.thumbSize * 0.5;
				pos = Math.max(pos, 0);
				pos = Math.min(pos, _height - ts);
				value = (_height - ts - pos) / (height - ts) * (_max - _min) + _min;
			}
			
			dispatchEvent(new Event(Event.CHANGE));
			dispatchEvent(new Event("backClick"));
		}
		
		/**
		 * Internal mouseDown handler. Starts dragging the handle.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onDrag(event:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			_isDragging = true;
			if(orientation == HORIZONTAL)
			{
				var xStart:Number =  ignoreThumbSize? - thumb.width * 0.5 : 0;;
				thumb.startDrag(false, new Rectangle(xStart, thumb.y, _width - thumbSize, 0));
			}
			else
			{
				var yStart:Number = ignoreThumbSize? - thumb.height * 0.5 : 0;
				thumb.startDrag(false, new Rectangle(thumb.x, yStart, 0, _height - thumbSize));
			}
		}
		
		/**
		 * Internal mouseUp handler. Stops dragging the handle.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onDrop(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			stopDrag();
			dispatchEvent(new Event("backClick"));
			_isDragging = false;
		}
		
		/**
		 * Internal mouseMove handler for when the handle is being moved.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onSlide(event:MouseEvent):void
		{
			var oldValue:Number = _value;
			var pos:Number;
			if(orientation == HORIZONTAL)
			{
				pos = ignoreThumbSize ? (thumb.x + thumb.width * 0.5) : thumb.x;
				value = pos / (width - thumbSize) * (_max - _min) + _min;
			}
			else
			{
				pos = ignoreThumbSize ? (thumb.y + thumb.height * 0.5) : thumb.y;
				value = (height - thumbSize - pos) / (height - thumbSize) * (_max - _min) + _min;
			}
			
			if(value != oldValue)
			{
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets / gets whether or not a click on the background of the slider will move the handler to that position.
		 */
		public function set backClick(b:Boolean):void
		{
			trackClickable = b;
			invalidate();
		}
		
		public function get backClick():Boolean
		{
			return trackClickable;
		}
		
		/**
		 * Sets / gets the current value of this slider.
		 */
		[Bindable]
		public function set value(v:Number):void
		{
			_value = v;
			correctValue();
			updateDislpay();
		}

		[Bindable]
		public function get value():Number
		{
			return Math.round(_value / _tick) * _tick;
		}
		
		/**
		 * Gets the value of the slider without rounding it per the tick value.
		 */
		public function get rawValue():Number
		{
			return _value;
		}
		
		[Bindable]
		/**
		 * Gets / sets the maximum value of this slider.
		 */
		public function set maximum(m:Number):void
		{
			_max = m;
			correctValue();
			updateDislpay();
		}
		
		public function get maximum():Number
		{
			return _max;
		}
		
		[Bindable]
		/**
		 * Gets / sets the minimum value of this slider.
		 */
		public function set minimum(m:Number):void
		{
			_min = m;
			correctValue();
			updateDislpay();
		}
		
		public function get minimum():Number
		{
			return _min;
		}
		
		/**
		 * Gets / sets the tick value of this slider. This round the value to the nearest multiple of this number. 
		 */
		public function set tick(t:Number):void
		{
			_tick = t;
		}
		
		public function get tick():Number
		{
			return _tick;
		}
	}
}