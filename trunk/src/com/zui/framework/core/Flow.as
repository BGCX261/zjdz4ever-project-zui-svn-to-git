package com.zui.framework.core
{
	import com.dolo.arpg.debug.ScreenDebugTrace;
	import com.dolo.arpg.globals.GameConfig;
	import com.dolo.arpg.globals.GameData;
	import com.dolo.game.load.AssetLoader;
	import com.dolo.game.load.BulkLoader;
	import com.zui.framework.components.ProcessBar;
	import com.zui.framework.managers.DataManager;
	import com.zui.framework.managers.JSManager;
	import com.zui.framework.managers.KeyboardManager;
	import com.zui.framework.managers.LayerManager;
	import com.zui.framework.managers.SwfManager;
	import com.zui.framework.utils.EnterFrame;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.system.Security;
	import flash.ui.Keyboard;

	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-6-27 下午03:13:27
	 * 
	 */
	public class Flow
	{
		//======================================================================
		//        property
		//======================================================================
		
		//======================================================================
		//        constructor
		//======================================================================
		
		public function Flow(sprite:Sprite)
		{
			this.init(sprite);
		}
		
		//======================================================================
		//        public function
		//======================================================================
		
		//======================================================================
		//        private function
		//======================================================================
		private function init(sprite:Sprite):void{
			
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			EnterFrame.linstener = sprite;
			LayerManager.getInstance().initialize(sprite);

			DataManager.getInstance().resManager = new AssetLoader("",GameConfig.version);
			JSManager.call(JSManager.autoSizeOn);
		}
		//======================================================================
		//        event handler
		//======================================================================
		
		//======================================================================
		//        getter&setter
		//======================================================================
		
		
	}
} 