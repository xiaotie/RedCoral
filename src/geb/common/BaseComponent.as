/**
 * Component.as
 * Keith Peters
 * version 0.97
 * 
 * Base class for all components
 * 
 * Copyright (c) 2009 Keith Peters
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
 * 
 * 
 * Components with text make use of the font PF Ronda Seven by Yuusuke Kamiyamane
 * This is a free font obtained from http://www.dafont.com/pf-ronda-seven.font
 */

package geb.common
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	import geb.containers.PopUpCanvas;
	import geb.utils.CallLaterHelper;
	import geb.utils.MouseHelper;
	
	[Bindable]
	[Event(name="resize", type="flash.events.Event")] 
	[Event(name="mouseStick",type="flash.events.Event")]
	[Event(name="closed",type="flash.events.Event")]
	[Event(name="draw",type="flash.events.Event")]
	public class BaseComponent extends Sprite
	{
		protected var _width:Number = NaN;
		protected var _height:Number = NaN;
		protected var _tag:int = -1;
		protected var _enabled:Boolean = true;
		
		public var updateNextFrame:Boolean = true;
		
		public var toolTipClass:Class;
		
		protected var inited:Boolean = false;
		
		[Bindable]
		public var toolTip:Object;
		
		public static const DRAW:String = "draw";
		
		private var _mouseHelper:MouseHelper;

		private function get mouseHelper():MouseHelper
		{
			if(_mouseHelper == null) _mouseHelper = new MouseHelper();
			return _mouseHelper;
		}
		
		public function get mouseStickIntervalMiniSeconds():uint
		{
			return mouseHelper.stickHelper.intervalMiniSeconds;
		}

		public function set mouseStickIntervalMiniSeconds(value:uint):void
		{
			mouseHelper.stickHelper.intervalMiniSeconds = value;
		}
		
		private var _enableMouseStick:Boolean = false;

		public function get enableMouseStick():Boolean
		{
			return _enableMouseStick;
		}

		public function set enableMouseStick(value:Boolean):void
		{
			_enableMouseStick = value;
			if(value == true)
			{
				var self:BaseComponent = this;
				mouseHelper.stickHelper.bind(this);
				mouseHelper.stickHelper.callback = 
					function():void
					{
						self.dispatchEvent(new Event("mouseStick"));
					};
			}
			else
			{
				mouseHelper.stickHelper.unbind();
			}
		}
		
		public function show(x:Number = NaN, y:Number = NaN):void
		{
			var pop:PopUpCanvas = new PopUpCanvas();
			pop.show();
			pop.setContent(this,x,y);
		}
		
		public function showDialog(x:Number = NaN, y:Number = NaN):void
		{
			var pop:PopUpCanvas = new PopUpCanvas();
			pop.showDialog();	
			pop.setContent(this,x,y);
		}
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this component.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
		public function BaseComponent(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0)
		{
			move(xpos, ypos);
			if(parent != null)
			{
				parent.addChild(this);
			}
			init();
		}
		
		/**
		 * Initilizes the component.
		 */
		protected function init():void
		{
			addChildren();
			invalidate();
		}
		
		/**
		 * Overriden in subclasses to create child display objects.
		 */
		protected function addChildren():void
		{
		}
		
		/**
		 * Marks the component to be redrawn on the next frame.
		 */
		public function invalidate():void
		{
			if(updateNextFrame == true)
			{
				removeEventListener(Event.ENTER_FRAME, onInvalidate);
				addEventListener(Event.ENTER_FRAME, onInvalidate);
			}
			else
			{
				onInvalidate(null);
			}
		}
		
		public function invalidateNow():void
		{
			onInvalidate(null);
		}
		
		/**
		 * DropShadowFilter factory method, used in many of the components.
		 * @param dist The distance of the shadow.
		 * @param knockout Whether or not to create a knocked out shadow.
		 */
		protected function getShadow(dist:Number, knockout:Boolean = false):DropShadowFilter
		{
			return new DropShadowFilter(dist, 45, Style.DROPSHADOW, 1, dist, dist, .3, 1, knockout);
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Utility method to set up usual stage align and scaling.
		 */
		public static function initStage(stage:Stage):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		/**
		 * Moves the component to the specified position.
		 * @param xpos the x position to move the component
		 * @param ypos the y position to move the component
		 */
		public function move(xpos:Number, ypos:Number):void
		{
			x = Math.round(xpos);
			y = Math.round(ypos);
		}
		
		/**
		 * Sets the size of the component.
		 * @param w The width of the component.
		 * @param h The height of the component.
		 */
		public function setSize(w:Number, h:Number):void
		{
			_width = w;
			_height = h;
			invalidate();
		}
		
		/**
		 * Abstract draw function.
		 */
		public function draw():void
		{
			dispatchEvent(new Event(BaseComponent.DRAW));
		}
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Called one frame after invalidate is called.
		 */
		protected function onInvalidate(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
			
			if(inited == false)
			{
				inited = true;
				this.dispatchEvent(new Event("inited"));
			}
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets/gets the width of the component.
		 */
		override public function set width(w:Number):void
		{
			_width = w;
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		/**
		 * Sets/gets the height of the component.
		 */
		override public function set height(h:Number):void
		{
			_height = h;
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get height():Number
		{
			return _height;
		}
		
		override public function set x(value:Number):void
		{
			super.x = value;
		}
		
		override public function set y(value:Number):void
		{
			super.y = value;
		}
		
		/**
		 * Sets/gets in integer that can identify the component.
		 */
		public function set tag(value:int):void
		{
			_tag = value;
		}
		
		public function get tag():int
		{
			return _tag;
		}
		
		/**
		 * Sets/gets whether this component is enabled or not.
		 */
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			mouseEnabled = mouseChildren = _enabled;
			tabEnabled = value;
			alpha = _enabled ? 1.0 : 0.5;
		}
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function close():void
		{
			if(this.parent != null)
			{
				this.parent.removeChild(this);
			}
			
			this.dispatchEvent(new Event("closed"));
		}
		
		public function callLater(callback:Function):void
		{
			new CallLaterHelper(this.stage,callback);
		}
	}
}