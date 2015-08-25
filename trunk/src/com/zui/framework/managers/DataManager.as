package com.zui.framework.managers
{
	
	
	import com.dolo.game.load.IResLoader;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	

	public class DataManager extends EventDispatcher
	{
		

		public var resManager:IResLoader;
	

		
		public function DataManager()
		{
		}
		
		private static var instance:DataManager;
		
		
		public static function getInstance():DataManager{
			return instance ||=new DataManager();
		}
		

		

	}
}