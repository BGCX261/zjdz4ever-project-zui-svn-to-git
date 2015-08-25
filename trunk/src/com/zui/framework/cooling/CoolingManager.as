package com.zui.framework.cooling
{

	
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-9-17 下午03:10:17
	 * 
	 */
	public class CoolingManager
	{
		//======================================================================
		//        property
		//======================================================================
		private static var instance:CoolingManager;
		private var observers:Dictionary;
		private var times:Dictionary;
		//======================================================================
		//        constructor
		//======================================================================
		
		public function CoolingManager()
		{
			this.observers = new Dictionary();
			this.times = new Dictionary();
		}
		
		//======================================================================
		//        public function
		//======================================================================

		
		public function getCooling(name:String):Cooling{
			if(observers[name] == null){
				observers[name] = new Cooling(name);
			}
			return observers[name];
		}

		
		public function removeObserver(cooling:Cooling) : void
		{
			
			if (cooling)
			{
				delete this.observers[cooling.getName()];
			}
		}
		
		public function startCooling(name:String, totalTime:int, startTime:int = 0,completeListener:Function = null) : void
		{
			
			var nowTime:int = getTimer();
			this.times[name] = {startTime:nowTime, endTime:nowTime + (totalTime - startTime), totalTime:totalTime, hasGoTime:startTime};
			if(observers[name] == null){
				observers[name] = new Cooling(name);
			}
			(observers[name] as Cooling).start(totalTime,startTime);
			if(completeListener!=null){
				(observers[name] as Cooling).addCompleteListener(completeListener);
			}
			
		}
		
		public function currentCoolingTime(name:String) : int
		{
			var endTime:int = 0;
			var nowTime:int = 0;
			var time:Object = this.times[name];
			if (time)
			{
				endTime = time.endTime;
				nowTime = getTimer();
				if (nowTime >= endTime)
				{
					return 0;
				}
				return endTime - nowTime;
			}
			return 0;
		}
		
		public function isCoolingByName(name:String) : Boolean
		{
			var endTime:int = 0;
			var nowTime:int = 0;
			var time:* = this.times[name];
			if (time)
			{
				endTime = time.endTime;
				nowTime = getTimer();
				if (nowTime >= endTime)
				{
					return false;
				}
				return true;
			}
			return false;
		}
		
		public function updateCooling(cooling:Cooling) : void
		{
			var startTime:int = 0;
			var endTime:int = 0;
			var nowTime:int = 0;
			var totalTime:int = 0;
			var hasGoTime:int = 0;
			var ob:Cooling = null;

			var time:* = this.times[cooling.getName()];
			if (time)
			{
				startTime = time.startTime;
				endTime = time.endTime;
				nowTime = getTimer();
				totalTime = time.totalTime;
				hasGoTime = time.hasGoTime;
				ob = this.observers[cooling.getName()] as Cooling;
				if (nowTime < endTime && nowTime >= startTime)
				{
					
					ob.start(endTime - nowTime, hasGoTime);
				}
			}
		}
		
		public function stopCooling(name:String) : void
		{
			var ob:Cooling = null;
			for each (ob in this.observers)
			{
				
				if (ob.getName() == name)
				{
					ob.stop();
				}
			}
			delete this.times[name];
		}
		

		

		

		
		
		//======================================================================
		//        private function
		//======================================================================
		
		//======================================================================
		//        event handler
		//======================================================================
		
		//======================================================================
		//        getter&setter
		//======================================================================
		public static function getIntance():CoolingManager{
			return instance ||= new CoolingManager();
		}
		
	}
} 