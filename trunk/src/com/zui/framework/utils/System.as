package com.zui.framework.utils
{
	import flash.net.LocalConnection;

	public class System
	{
		public function System()
		{
		}
		/**
		 *垃圾回收 
		 * 
		 */	
		public static function gc() : void
		{
			try
			{
				new LocalConnection().connect("SystemGC");
				new LocalConnection().connect("SystemGC");
			}
			catch (error:Error)
			{
			}
			return;
		}
	}
}