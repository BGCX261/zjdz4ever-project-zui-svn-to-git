package com.zui.framework.layers
{
	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-8-29 上午11:42:51
	 * 
	 */
	import com.greensock.plugins.VolumePlugin;
	import com.zui.framework.components.ProcessBar;
	import com.zui.framework.managers.LayerManager;
	import com.zui.framework.managers.ResizeManager;
	
	import flash.display.Sprite;
	
	public class LoadLayer extends Sprite
	{
		//======================================================================
		//        property
		//======================================================================
		
		//======================================================================
		//        constructor
		//======================================================================
		
		public function LoadLayer()
		{
			super();
			addChild(ProcessBar.instance);
			ResizeManager.getInstance().addHandler(onResize);
			this.visible = false;
		}
		
		//======================================================================
		//        public function
		//======================================================================
		public function setPercent(number:Number):void{
			ProcessBar.instance.setPercent(number);
			this.visible = true;
		}
		
		public function onComplete():void{
			this.visible = false;
		}
		
		public  function start():void{
			ProcessBar.instance.setPercent(0);
			this.visible = true;
			
		}
		//======================================================================
		//        private function
		//======================================================================
		private function onResize():void{
			this.graphics.clear();
			this.graphics.beginFill(0xffff00,1);
			this.graphics.drawRect(0,0,LayerManager.getInstance().stage.stageWidth,LayerManager.getInstance().stage.stageHeight);
			this.graphics.endFill();
		}
		//======================================================================
		//        event handler
		//======================================================================
		
		//======================================================================
		//        getter&setter
		//======================================================================
		
		
	}
} 