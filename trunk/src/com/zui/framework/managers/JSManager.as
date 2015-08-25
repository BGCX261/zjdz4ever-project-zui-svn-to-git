package com.zui.framework.managers
{
	import flash.external.ExternalInterface;

	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-8-27 下午05:52:40
	 * 
	 */
	public class JSManager
	{
		//======================================================================
		//        property
		//======================================================================
		public static const autoSizeOn:String = "autoSizeOn";
		public static const getCookies:String = "getCookies";
		public static const reflash:String = "reflash";
		//======================================================================
		//        constructor
		//======================================================================
		
		public function JSManager()
		{
		}
		
		//======================================================================
		//        public function
		//======================================================================
		public static function call(name:String,args:String = ""):*{
			if(ExternalInterface.available){
				return ExternalInterface.call(name,args);
			}
			
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
		
		
	}
} 