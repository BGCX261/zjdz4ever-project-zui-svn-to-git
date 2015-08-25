package com.zui.framework.cooling
{
	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-9-17 下午03:41:41
	 * 
	 */

	import com.zui.framework.utils.EnterFrame;
	
	import flash.display.DisplayObject;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	public class Cooling extends EventDispatcher
	{
		//======================================================================
		//        property
		//======================================================================
		public var running:Boolean = false;
		public var beginTime:Number = 0;
		public var totalTime:Number = 0;
		public var startFrom:Number = 0;
		private var postTime:Number = 0;

		private var name:String;
		private var cpFunc:Function;
		private var coolingObjs:Vector.<Sprite> = new Vector.<Sprite>;
		private var shapes:Vector.<Shape> = new Vector.<Shape>;
		//======================================================================
		//        constructor
		//======================================================================
		
		public function Cooling(name:String)
		{
			this.name = name;
		}
		
		public function getName():String
		{
			return this.name;
		}
		
		public function setName(name:String):void{
			
		}
		
		public function start(totalTime:Number, startFrom:Number = 0) : void
		{
			this.startFrom = startFrom;
			this.totalTime = totalTime;
			this.postTime = 0;
			this.beginTime = getTimer();
			this.running = true;
			EnterFrame.pushFunc(this.enterFrameHandler);
		}
		
		
		public function setCoolingObj(obj:Sprite,rect:Rectangle):void{
			if(coolingObjs.indexOf(obj) == -1){
				coolingObjs.push(obj);
			}
			
		}
		
		public function removeCoolingObj(obj:DisplayObject):void{
			var index:int = coolingObjs.indexOf(obj);
			if(index>=0){
				coolingObjs.splice(index,1);
			}
		}
		
		//======================================================================
		//        public function
		//======================================================================
		public function getRestTime() : int
		{
			return this.totalTime - this.postTime;
		}
		
		public function stop() : void
		{
			EnterFrame.popFunc(this.enterFrameHandler);
			this.running = false;
		}
		
		public function addCompleteListener(func:Function):void{
			this.cpFunc = func;
		}
		//======================================================================
		//        private function
		//======================================================================
		private function enterFrameHandler() : void
		{
			
			this.postTime = getTimer() - this.beginTime;
			updateCoolingSprite((totalTime-postTime)/totalTime);
			if (this.postTime >= this.totalTime)
			{
				
				EnterFrame.popFunc(this.enterFrameHandler);
				this.running = false;
				dispatchEvent(new Event(Event.COMPLETE));
				if(cpFunc!=null){
					cpFunc(this.getName());
				}
			}

		}
		
		private function updateCoolingSprite(restPercent:Number):void{
			if(restPercent>0){
				if(shapes.length == 0){
					for(var i:int = 0; i<coolingObjs.length; i++){
						var shape:Shape = new Shape();
						shape.graphics.beginFill(0,.5);
						shape.graphics.drawRect(0,0,coolingObjs[i].width,coolingObjs[i].height);
						shape.graphics.endFill();
						shapes.push(shape);
						coolingObjs[i].addChild(shape);
					}
				}
				for(i = 0; i<shapes.length; i++){
					var obj:DisplayObject = coolingObjs[i];
					shapes[i].scrollRect = new Rectangle(0,(1-restPercent)*obj.height,obj.width,obj.height);
				}
			}
		}
		

		
		public function isCooling() : Boolean
		{

			return this.running;
		}
		//======================================================================
		//        event handler
		//======================================================================
		
		//======================================================================
		//        getter&setter
		//======================================================================

		
	}
} 