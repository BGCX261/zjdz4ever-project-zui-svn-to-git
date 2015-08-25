package com.zui.framework.components
{
	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-9-27 下午04:10:33
	 * 
	 */
	import com.zui.framework.managers.LayerManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	public class ClickPopTip
	{
		//======================================================================
		//        property
		//======================================================================
		private static var instance:ClickPopTip;
		private var sprite:DisplayObject;
		//======================================================================
		//        constructor
		//======================================================================
		
		public function ClickPopTip()
		{
			super();
			
		}
		
		//======================================================================
		//        public function
		//======================================================================
		public function addPop(displayObject:DisplayObject):void{
			var spriteX:int = LayerManager.getInstance().stage.mouseX;
			var spriteY:int = LayerManager.getInstance().stage.mouseY;
			
			if((spriteX + displayObject.width/2)<LayerManager.getInstance().stage.stageWidth/2){
				displayObject.x = spriteX;
			}else{
				displayObject.x = spriteX - displayObject.width;
			}
			
			if((spriteY - displayObject.height)<0){
				displayObject.y = 0;
			}else{
				displayObject.y = spriteY - displayObject.height;
			}
			onRemove();
			setTimeout(function ():void{
				LayerManager.getInstance().stage.addChild(displayObject);
				sprite = displayObject;
				setTimeout(addClick,0);
			},0);

		}
		
		public function dispose():void{
			LayerManager.getInstance().stage.removeEventListener(MouseEvent.CLICK,onClick);
			onRemove();
		}
		//======================================================================
		//        private function
		//======================================================================
		private function addClick():void{
			LayerManager.getInstance().stage.addEventListener(MouseEvent.CLICK,onClick);
		}
		//======================================================================
		//        event handler
		//======================================================================
		public static function getInstance():ClickPopTip{
			return instance ||= new ClickPopTip();
		}
		
		private function onClick(event:MouseEvent):void{
			LayerManager.getInstance().stage.removeEventListener(MouseEvent.CLICK,onClick);
			onRemove();
		}
		
		private function onRemove():void{
			
			if(sprite && sprite.parent){
				sprite.parent.removeChild(sprite);
			}
			sprite = null;
			
			
		}
		//======================================================================
		//        getter&setter
		//======================================================================
		
		
	}
} 