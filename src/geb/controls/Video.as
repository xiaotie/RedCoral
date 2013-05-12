package geb.controls
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;

	public class Video extends flash.media.Video
	{
		private var _timer:Timer;
		
		private var _source:String;
		
		private var _stream:NetStream;
		
		private var soundTransform:SoundTransform = new SoundTransform();
		
		public function get volume():Number
		{
			return soundTransform.volume;
		}

		[Bindable]
		public function set volume(value:Number):void
		{
			soundTransform.volume = value;
			updateSoundTransform();
		}
		
		public function get leftToLeft():Number
		{
			return soundTransform.leftToLeft;
		}

		[Bindable]
		public function set leftToLeft(value:Number):void
		{
			soundTransform.leftToLeft = value;
			updateSoundTransform();
		}
		
		public function get leftToRight():Number
		{
			return soundTransform.leftToRight;
		}
		
		[Bindable]
		public function set leftToRight(value:Number):void
		{
			soundTransform.leftToRight = value;
			updateSoundTransform();
		}
		
		public function get rightToLeft():Number
		{
			return soundTransform.rightToLeft;
		}
		
		[Bindable]
		public function set rightToLeft(value:Number):void
		{
			soundTransform.rightToLeft = value;
			updateSoundTransform();
		}
		
		public function get rightToRight():Number
		{
			return soundTransform.rightToRight;
		}
		
		[Bindable]
		public function set rightToRight(value:Number):void
		{
			soundTransform.rightToRight = value;
			updateSoundTransform();
		}
		
		private function updateSoundTransform():void
		{
			var t:SoundTransform = new SoundTransform(volume);
			t.leftToLeft = this.leftToLeft;
			t.leftToRight = this.leftToRight;
			t.rightToLeft = this.rightToLeft;
			t.rightToRight = this.rightToRight;
			soundTransform = t;
			if(_stream != null)
			{
				_stream.soundTransform = soundTransform;
			}
		}
		
		[Bindable]
		public var totalTime:Number = 0;
		
		[Bindable]
		public var time:Number = 0;

		public function get stream():NetStream
		{
			return _stream;
		}

		[Bindable]
		public function set stream(value:NetStream):void
		{
			_stream = value;
		}

		public function get source():String
		{
			return _source;
		}
		
		public function play():void
		{
			if(stream != null)
			{
				if(paused == true && stream.time > 0)
				{
					stream.resume();
					paused = false;
					return;
				}
				
				if(_timer == null)
				{
					_timer = new Timer(0.5,int.MAX_VALUE);
					_timer.addEventListener(TimerEvent.TIMER,
						function(e:TimerEvent):void
						{
							if(stream != null)
							{
								var streamTime:Number = stream.time;
								if(time != streamTime)
								{
									time = streamTime;
								}
							}
						});
					_timer.start();
				}
				
				stream.soundTransform = this.soundTransform;
				stream.play(_source);
				paused = false;
				this.attachNetStream(stream);
			}
		}
		
		[Bindable]
		public var paused:Boolean;
		
		public function pause():void
		{
			if(_stream)
			{
				_stream.pause();
				paused = true;
			}
		}
		
		public function seek(offset:Number):void
		{
			if(offset > 0 && stream != null)
			{
				stream.seek(offset);
			}
		}

		public function set source(value:String):void
		{
			_source = value;
			reset();
		}
		
		public function reset():void
		{
			if(stream)
			{
				stream.close();
			}
			
			stream = null;
			if(_source)
			{
				var nc:NetConnection = new NetConnection();
				//nc.connect(null);
				nc.connect(null);
				stream =  new NetStream(nc);
				stream.client = {onMetaData:function(obj:Object){
					totalTime = obj.duration;
				}};
			}
		}
		
		public function getSnapshot():Bitmap
		{
			var bmpData:BitmapData = new BitmapData(this.width,this.height);
			bmpData.draw(this, new Matrix(this.scaleX,0,0, this.scaleY));
			var bmp:Bitmap = new Bitmap(bmpData);
			return bmp;
		}
	}
}