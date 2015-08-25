package com.zui.framework.layers
{
	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-8-29 上午11:37:10
	 * 
	 */
	import com.dolo.arpg.debug.ScreenDebugTrace;
	import com.dolo.arpg.globals.GameData;
	import com.zui.framework.managers.KeyboardManager;
	
	import flash.display.Sprite;
	import flash.ui.Keyboard;
	
	public class DebugLayer extends Sprite
	{
		//======================================================================
		//        property
		//======================================================================
		
		//======================================================================
		//        constructor
		//======================================================================
		
		public function DebugLayer()
		{
			super();
			
				
				this.visible = false;
				addChild(ScreenDebugTrace.instance);
				KeyboardManager.getInstance().registerKey(Keyboard.BACKQUOTE,onKeyBoard);
				
			
		}
		
		//======================================================================
		//        public function
		//======================================================================
		
		//======================================================================
		//        private function
		//======================================================================
		private function onKeyBoard():void{
			this.visible = !visible;
		}
		//======================================================================
		//        event handler
		//======================================================================
		
		//======================================================================
		//        getter&setter
		//======================================================================
		
		
	}
} 