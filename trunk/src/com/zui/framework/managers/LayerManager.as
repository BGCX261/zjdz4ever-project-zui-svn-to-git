package com.zui.framework.managers
{
	import com.dolo.arpg.globals.GameData;
	import com.zui.framework.layers.DebugLayer;
	import com.zui.framework.layers.LoadLayer;
	import com.zui.framework.utils.EnterFrame;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-8-29 上午11:12:05
	 * 
	 */
	public class LayerManager
	{
		//======================================================================
		//        property
		//======================================================================
		private static var instance:LayerManager;
		
		public var root:Sprite;
		public var moduleContainer:Sprite;
		public var uiContainer:Sprite;
		public var toolTipContainer:Sprite;//tip层
		public var popUpLayer:Sprite;//弹出层 
		public var effectLayer:Sprite;//特效层
		public var loadLayer:LoadLayer;//加载层
		public var debugLayer:DebugLayer;//debug层
		public var stage:Stage;
		//======================================================================
		//        constructor
		//======================================================================
		
		public function LayerManager()
		{
		}
		
		//======================================================================
		//        public function
		//======================================================================
		public function initialize(sprite:Sprite):void{
			var root:Sprite = sprite;
			root = sprite;
			this.stage = root.stage;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageFocusRect = false;
			stage.align = "TL";
			stage.scaleMode = "noScale";

			moduleContainer = root.addChild(new Sprite()) as Sprite;
			
			uiContainer = root.addChild(new Sprite()) as Sprite;
			WindowsManager.getInstance().registerWindows(uiContainer);
			toolTipContainer = root.addChild(new Sprite()) as Sprite;
			toolTipContainer.mouseChildren = false;
			toolTipContainer.mouseEnabled = false;
			
			popUpLayer = root.addChild(new Sprite()) as Sprite;
			
			effectLayer = root.addChild(new Sprite()) as Sprite;
			effectLayer.mouseChildren = false;
			effectLayer.mouseEnabled = false;
			
			loadLayer = root.addChild(new LoadLayer()) as LoadLayer;
				
			if(GameData.instance.is_debug){
				debugLayer = root.addChild(new DebugLayer()) as DebugLayer;
				
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
		public static function getInstance():LayerManager{
			return instance ||= new LayerManager();
		}
		
	}
} 