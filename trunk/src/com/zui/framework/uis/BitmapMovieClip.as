package com.zui.framework.uis
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	
	import com.zui.framework.utils.EnterFrame;

	/**
	 * 位图动画类
	 * @author zhoujun
	 * 
	 */	
	public class BitmapMovieClip extends Bitmap
	{
		private var _bitmapDataArr:Array = [];
		private var _offsetArr:Array  = [];
		public var currentFrame:int = 1;
		private var _startFrame:int;
		private var _endFrame:int;
		private var _frameScriptArr:Array  = [];
		public var rate:int;
		public var timeCount:int = 0;
		public var isPlaying:Boolean = false;
		private var frameStepper:int = 1;
		private var onUpdate:Function;
		
		
		public function BitmapMovieClip()
		{
			super(null, PixelSnapping.NEVER, true);
		}
		/**
		 * 
		 * @param $startFrame 			起始帧
		 * @param $endFrame				结束帧
		 * @param $rate					帧率
		 * @param restart				是否从新开始（从起始帧或者结束帧，取决于是顺时播放还是逆时）
		 * @param $frameStepper			正序播放（或者倒序）
		 * @param restartFrame			重新开始播放的起始帧	
		 * 
		 */		
		public function loopPlay($startFrame:int, $endFrame:int, $rate:int = 2, restart:Boolean = true, $frameStepper:int = 1, restartFrame:int = -1) : void
		{
			this.frameStepper = $frameStepper;
			this._startFrame = $startFrame;
			this._endFrame = $endFrame;
			this.rate = $rate;
			if (restart)
			{
				this.currentFrame = $frameStepper > 0 ? ($startFrame) : ($endFrame);
			}
			else
			{
				this.currentFrame = restartFrame == -1 ? (Math.random() * ($endFrame - $startFrame + 1) + $startFrame) : (restartFrame);
			}
			bitmapData = this._bitmapDataArr[(this.currentFrame - 1)];
			x = this._offsetArr[(this.currentFrame - 1)][0];
			y = this._offsetArr[(this.currentFrame - 1)][1];
			this.timeCount = $rate - 1;
			if ($startFrame != $endFrame)
			{
				if (!this.isPlaying)
				{
					this.play();
				}
			}
			else
			{
				if (this.isPlaying)
				{
					EnterFrame.popFunc(this.loopEnterFramePlay);
					this.isPlaying = false;
				}
				this.loopEnterFramePlay();
			}
		}
		
		public function addFrameScript(frame:int, func:Function, ... args) : void
		{
			args = 0;
			if (func == null)
			{
				args = this._frameScriptArr.length - 1;
				while (args >= 0)
				{
					
					if (this._frameScriptArr[args][0] == frame)
					{
						this._frameScriptArr.splice(args, 1);
					}
					args = args - 1;
				}
			}
			else
			{
				args = this._frameScriptArr.length - 1;
				while (args >= 0)
				{
					
					if (this._frameScriptArr[args][0] == frame)
					{
						this._frameScriptArr[args][1] = func;
						this._frameScriptArr[args][2] = args;
						return;
					}
					args--;
				}
				this._frameScriptArr.push([frame, func, args]);
			}
		}
		
		public function clearFrameScript() : void
		{
			this._frameScriptArr.splice(0);
		}
		
		public function regUpdateCallBack(callback:Function) : void
		{
			this.onUpdate = callback;
		}
		
		public function unregUndateCallBack() : void
		{
			this.onUpdate = null;
		}
		
		public function stop() : void
		{
			if (this.isPlaying)
			{
				this.isPlaying = false;
				EnterFrame.popFunc(this.loopEnterFramePlay);
			}
		}
		
		public function play() : void
		{
			if (this._startFrame != this._endFrame && this._startFrame > 0)
			{
				this.isPlaying = true;
				EnterFrame.pushFunc(this.loopEnterFramePlay);
			}
		}
		/**
		 * 移除的时候必须调用！否则会导致内存溢出 
		 * 
		 */		
		public function dispose() : void
		{
			EnterFrame.popFunc(this.loopEnterFramePlay);
			this._bitmapDataArr = null;
			this._frameScriptArr = null;
		}
		
		private function loopEnterFramePlay() : void
		{
			if (this.timeCount != (this.rate - 1))
			{
				this.timeCount++;
				return;
			}
			this.timeCount = 0;
			var nextFrame:int = this.currentFrame + this.frameStepper;
			if (nextFrame < this._startFrame)
			{
				nextFrame = this._endFrame;
			}
			else if (nextFrame > this._endFrame)
			{
				nextFrame = this._startFrame;
			}
			this.currentFrame = nextFrame;
			bitmapData = this._bitmapDataArr[(this.currentFrame - 1)];
			x = this._offsetArr[(this.currentFrame - 1)][0];
			y = this._offsetArr[(this.currentFrame - 1)][1];
			var tmpInt:int = this._frameScriptArr.length - 1;
			while (tmpInt >= 0)
			{
				if (this._frameScriptArr.length == 0)
				{
					break;
				}
				if (tmpInt > (this._frameScriptArr.length - 1))
				{
					tmpInt = this._frameScriptArr.length - 1;
				}
				if (this.currentFrame == this._frameScriptArr[tmpInt][0])
				{
					this._frameScriptArr[tmpInt][1].apply(null, this._frameScriptArr[tmpInt][2]);
				}
				tmpInt--;
			}
			if (this.onUpdate != null)
			{
				this.onUpdate();
			}
		}
		
		
		public function set bitmapDatadArr(value:Array) : void
		{
			this._bitmapDataArr = value;	
		}
		
		public function get bitmapDatadArr() : Array
		{
			return this._bitmapDataArr;
		}
		
		public function set offsetArr(value:Array) : void
		{
			this._offsetArr = value;
		}
		
		public function get offsetArr() : Array
		{
			return this._offsetArr;
		}
		
		public function get totalFrame() : int
		{
			return this._bitmapDataArr.length;
		}
		
	}
}