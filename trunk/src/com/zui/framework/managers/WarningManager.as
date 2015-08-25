package com.zui.framework.managers
{
	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2011-9-21 上午10:06:48
	 * 
	 */
	import com.dolo.arpg.globals.FilterConfig;
	import com.dolo.arpg.globals.TextFormatConfig;
	import com.greensock.TweenMax;
	import com.zui.framework.managers.DataManager;
	import com.zui.framework.managers.LayerManager;
	import com.zui.framework.managers.ResizeManager;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class WarningManager extends Sprite
	{
		//======================================================================
		//        const
		//======================================================================
		private static var instance:WarningManager;
		private static var max:int = 3;
		
		//======================================================================
		//        constructor
		//======================================================================
		
		public function WarningManager()
		{
			super();
			this.mouseChildren = false;
			this.mouseEnabled = false;
			ResizeManager.getInstance().addHandler(onResize);
			LayerManager.getInstance().effectLayer.addChild(this);
		}
		
		//======================================================================
		//        property
		//======================================================================

		private var warningList:Array = [];
		private var totalNum:int = 0;
		private var txtHeight:Number = 20;
		//======================================================================
		//        method
		//======================================================================
	
		private static function getInstance():WarningManager{
			return instance ||= new WarningManager();
		}
		
		public static function addWarning(arg:String,txtFormat:TextFormat = null,filters:Array = null):void{
			WarningManager.getInstance().addWarning(arg,txtFormat,filters);
		}
		

		//======================================================================
		//        variable
		//======================================================================
		
		//======================================================================
		//        private function
		//======================================================================
		private function addWarning(arg:String,txtFormat:TextFormat,filters:Array):void{
			var txt:TextField = new TextField();
			txt.wordWrap = false;
			txt.multiline = false;
			txt.width = 800;
			txt.autoSize = TextFieldAutoSize.CENTER;
			txt.height = 30;
			addChild(txt);
			txt.defaultTextFormat = txtFormat;
			txt.text = arg;
			totalNum++;
			txt.alpha = 0;
			txt.mouseEnabled = false;
			txt.filters = filters;
			warningList.unshift(txt);
			TweenMax.killChildTweensOf(this);
			TweenMax.killDelayedCallsTo(this);
			TweenMax.killTweensOf(this);
			WarningManager.getInstance().alpha = 1;
			tween();
			onResize();
			LayerManager.getInstance().effectLayer.setChildIndex(this,LayerManager.getInstance().effectLayer.numChildren - 1);
		}
		
		private function tween():void{
			TweenMax.delayedCall(.4,warnCp);
			for(var i:int =0 ;i<max; i++){
				if(warningList[i]){
					if(warningList[i].alpha >0 &&warningList[i].alpha<1){
						warningList[i].alpha = 1;
					}
				}
			}
			for(i = 0; i<warningList.length; i++){
				if(i<max){
					TweenMax.to(warningList[i],.4,{alpha:1,y:i*txtHeight});
					
				}else{
					TweenMax.to(warningList[i],.4,{alpha:0,y:i*txtHeight,onComplete:onCp});
				}
				
			}
			
		}
		//======================================================================
		//        event handler
		//======================================================================
		private function warnCp():void{
			TweenMax.to(this,.4,{alpha:0,delay:.4,onComplete:hideAll});
			
		}
		private function onResize():void{
			this.x = (LayerManager.getInstance().stage.stageWidth - 800)/2;
			this.y = 120;
		}
		
		private function onCp():void{
			for(var i:int = max; i<warningList.length; i++){
				if(this.contains(warningList[i]) == true){
					removeChild(warningList[i]);
					totalNum--;
				}
			}
			if(warningList.length>4){
				warningList.length = 4;
			}
			
		}
	
		
		private function hideAll():void{
			for each(var txt:TextField in warningList){
				txt.filters = null;
				if(this.contains(txt) == true){
					removeChild(txt);
				}
			}
			warningList = [];
			totalNum = 0;
		}
		
		
		//======================================================================
		//        getter&setter
		//======================================================================
		
		
	}
} 