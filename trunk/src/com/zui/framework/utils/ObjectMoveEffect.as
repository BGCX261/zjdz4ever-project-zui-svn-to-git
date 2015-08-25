package com.zui.framework.utils
{
	import flash.display.DisplayObject;

	public class ObjectMoveEffect
	{
		private var sx:int;
		private var sy:int;
		private var ex:int;
		private var ey:int;
		private var xMoveSpeed:Number;
		private var yMoveSpeed:Number;
		private var moveFrame:int;
		private var moveDisplayObject:DisplayObject;
		private var moveResponderFun:Function;
		private var frameCount:int;
		private var curFrame:int = 0;
		
		/**
		 * 用来实现单个物体向某个方向移动
		 * @param moveDisplayObject 需要移动的object
		 * @param sx				起始点x
		 * @param sy				起始点y
		 * @param ex				目标点x
		 * @param ey				目标点y
		 * @param speed				速度（像素）
		 * @param moveResponderFun	移动到目标点后回调的函数
		 * @param frameCount		最多播放几帧
		 * 
		 */		
		public function ObjectMoveEffect(moveDisplayObject:DisplayObject, sx:int, sy:int, ex:int, ey:int, speed:int, moveResponderFun:Function = null, frameCount:int = 0) : void
		{
			this.moveDisplayObject = moveDisplayObject;
			this.sx = sx;
			this.sy = sy;
			this.ex = ex;
			this.ey = ey;
			this.moveDisplayObject.x = sx;
			this.moveDisplayObject.y = sy;
			this.moveResponderFun = moveResponderFun;
			this.frameCount = frameCount;
			this.xMoveSpeed = Math.abs(sx - ex) / speed;
			this.yMoveSpeed = Math.abs(sy - ey) / speed;
			EnterFrame.pushFunc(this.move);
		}
		
		private function move() : void
		{
			curFrame++;
			if (this.ex > this.sx)
			{
				this.moveDisplayObject.x = this.moveDisplayObject.x + this.xMoveSpeed;
				if (this.moveDisplayObject.x > this.ex)
				{
					this.moveDisplayObject.x = this.ex;
				}
			}
			if (this.ex < this.sx)
			{
				this.moveDisplayObject.x = this.moveDisplayObject.x - this.xMoveSpeed;
				if (this.moveDisplayObject.x < this.ex)
				{
					this.moveDisplayObject.x = this.ex;
				}
			}
			if (this.ey > this.sy)
			{
				this.moveDisplayObject.y = this.moveDisplayObject.y + this.yMoveSpeed;
				if (this.moveDisplayObject.y > this.ey)
				{
					this.moveDisplayObject.y = this.ey;
				}
			}
			if (this.ey < this.sy)
			{
				this.moveDisplayObject.y = this.moveDisplayObject.y - this.yMoveSpeed;
				if (this.moveDisplayObject.y < this.ey)
				{
					this.moveDisplayObject.y = this.ey;
				}
			}
			if (this.moveDisplayObject.x == this.ex && this.moveDisplayObject.y == this.ey || this.frameCount != 0 && this.curFrame >= this.frameCount)
			{
				EnterFrame.popFunc(this.move);
				if (this.moveResponderFun != null)
				{
					this.moveResponderFun();
				}
			}
			
		}
		
		public function dispose() : void
		{
			EnterFrame.popFunc(this.move);
		}
	}
}