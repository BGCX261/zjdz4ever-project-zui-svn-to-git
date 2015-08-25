package com.zui.framework.components
{
	import com.zui.framework.components.tootips.TipDefault;
	import com.zui.framework.components.tootips.TipType;
	import com.zui.framework.core.Config;
	import com.zui.framework.interfaces.ITip;
	import com.zui.framework.managers.DataManager;
	import com.zui.framework.managers.LayerManager;
	import com.zui.framework.utils.HtmlTextUtils;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	public class ToolTip
	{
		public function ToolTip()
		{
			
		
			
		}
		
		private static var _instance:ToolTip;
		
		private var tipSprite:Sprite;
		private var delayCall:int;
		
		private var tipTarget:DisplayObject;
		private var tipHtmlStr:String;
		private var tipType:String;
		
		
		public function showTip(tipTarget:DisplayObject,tipHtmlStr:String,tipType:String = TipType.DEFAULT,showTipDelay:Number = .2):void
		{
			this.tipTarget = tipTarget;
			this.tipHtmlStr = tipHtmlStr;
			this.tipType = tipType;
			clearTimeout(delayCall);
			delayCall = setTimeout(_showTip,showTipDelay*1000);
		}
		
		public function hideTip():void{
			clearTimeout(delayCall);
			LayerManager.getInstance().toolTipContainer.visible = false;
		}
		
		private function _showTip():void{
			if(tipSprite!=null){
				LayerManager.getInstance().toolTipContainer.removeChild(tipSprite);
				(tipSprite as ITip).dispose();
				tipSprite = null;
			}
			switch(tipType){
				case TipType.DEFAULT:
					tipSprite = new TipDefault();
					break;
			}
			LayerManager.getInstance().toolTipContainer.addChild(tipSprite);
			(tipSprite as ITip).setTipString(tipHtmlStr);
			setLocal(tipTarget,tipSprite);
			LayerManager.getInstance().toolTipContainer.visible = true;	
		}
		

		private function setLocal(displayObject:DisplayObject,tip:Sprite):void{
			if(displayObject.stage){
				var spriteX:Number = displayObject.localToGlobal(new Point(displayObject.stage.x,displayObject.stage.y)).x;
				var spriteY:Number = displayObject.localToGlobal(new Point(displayObject.stage.x,displayObject.stage.y)).y;
				if((spriteX + displayObject.width/2)<displayObject.stage.stageWidth/2){
					tip.x = spriteX + displayObject.width;
				}else{
					tip.x = spriteX - tip.width;
				}
				
				if((spriteY - tip.height)<0){
					tip.y = 0;
				}else{
					tip.y = spriteY - tip.height;
				}
			}	
		}
		
		

		public static function get instance():ToolTip
		{
			if(!_instance){
				_instance = new ToolTip();
			}
			return _instance;
		}

	}
}