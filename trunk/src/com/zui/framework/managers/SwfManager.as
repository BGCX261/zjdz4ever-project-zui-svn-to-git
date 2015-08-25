package com.zui.framework.managers
{
	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-6-28 下午03:55:42
	 * 
	 */
	import com.zui.framework.utils.HashMap;
	
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	
	
	public class SwfManager extends EventDispatcher
	{
		//======================================================================
		//        property
		//======================================================================
		public static var UI_LIBRARY:String = "uiLibrary";
		public static var characterInit:String = "characterInit";
		public static var battle:String = "battle";
		private var domainObj:HashMap = new HashMap;
		private static var _instance:SwfManager;
		//======================================================================
		//        constructor
		//======================================================================
		
		public function SwfManager()
		{
			super();
		
		}
		
		//======================================================================
		//        public function
		//======================================================================
		public function getUILibrary() : ApplicationDomain
		{
			return this.getApplicationDomain(UI_LIBRARY);
		}
		
		public function getCharacterInitLib():ApplicationDomain{
			return this.getApplicationDomain(characterInit);
		}
		
		public function getBattleLib():ApplicationDomain{
			return this.getApplicationDomain(battle);
		}
		

		//======================================================================
		//        private function
		//======================================================================
		
		//======================================================================
		//        event handler
		//======================================================================
		private function getApplicationDomain(appName:String) : ApplicationDomain
		{
			if (this.domainObj.containsKey(appName) == false)
			{
				return null;
			}
			return this.domainObj.get(appName) as ApplicationDomain;
		}
		
		public function setApplicationDomain(appName:String, app:ApplicationDomain) : void
		{

			this.domainObj.put(appName,app);
		}
		
		public function removeApplicationDomain(appName:String) : Boolean
		{
			if (this.domainObj.containsKey(appName) == false)
			{
				return false;
			}
			delete this.domainObj.get(appName);
			return true;
		}

		public static function get instance():SwfManager
		{
			if(_instance == null){
				_instance = new SwfManager();
			}
			return _instance;
		}



		//======================================================================
		//        getter&setter
		//======================================================================


	}
} 