package com.zui.framework.components.classes
{
	import com.zui.framework.components.ZMcButton;
	import com.zui.framework.events.ZEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class ScrollThumb extends Sprite
	{
		
		public var skin:MovieClip;
		private var mc:ZMcButton;
		private var scrollHeight:int;
		private var clickSprite:Sprite;
		private var backColor:uint;
		private var backAlpha:Number = 1;
		private var upDownBtHeight:int = 0;
		private var ellispeWidth:int = 5;
		
		public var scrollMovePercent:Number = 0;
		
		public function ScrollThumb(skinThumb:Object,scrollHeight:int,backColor:uint = 0xffffff,backAlpha:Number = 1,upDownBtHeight:int = 0,ellispeWidth:int = 5)
		{
			if(skinThumb is Class){
				this.skin = new skinThumb();
			}else{
				this.skin = skinThumb as MovieClip;
			}
			this.backColor = backColor;
			this.backAlpha = backAlpha;
			this.upDownBtHeight = upDownBtHeight;
			this.ellispeWidth = ellispeWidth;
			clickSprite = new Sprite();

			clickSprite.graphics.beginFill(backColor,backAlpha);
			clickSprite.graphics.drawRoundRect(0,-upDownBtHeight,skin.width,scrollHeight+2*upDownBtHeight,ellispeWidth);
			clickSprite.graphics.endFill();
			addChild(clickSprite);
			clickSprite.addEventListener(MouseEvent.CLICK,onClickSprite);

			
			mc = new ZMcButton();
			mc.setSkin(skin);
			addChild(mc.getSkin());
			this.scrollHeight = scrollHeight;
			skin = mc.getSkin();
			skin.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			
		}
		
		public function scrollMove(percent:Number):void{
			scrollMovePercent+=percent;
			scrollMovePercent = scrollMovePercent<0?0:scrollMovePercent;
			scrollMovePercent = scrollMovePercent>1?1:scrollMovePercent;
			skin.y = scrollMovePercent*(scrollHeight - skin.height);
			this.parent.dispatchEvent(new ZEvent(ZEvent.SCROLL_CHANGE,scrollMovePercent));
		}
		
		public function dispose():void{
			skin.stopDrag();
			skin.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			skin.stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			skin.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			skin = null;
			mc.dispose();
			mc = null;
		}
		
		public function reset():void{
			scrollMovePercent = 0;
			skin.y = 0;
		}
		
		private function onMouseDown(event:MouseEvent):void{
			skin.startDrag(false,new Rectangle(0,0,0,scrollHeight - skin.height));
			skin.stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			skin.stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		private function onMouseUp(event:MouseEvent):void{
			skin.stopDrag();
			skin.stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			skin.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		private function onMouseMove(event:MouseEvent):void{
			eventDispatch();
		}
		
		private function eventDispatch():void{
			scrollMovePercent = skin.y/(scrollHeight - skin.height);
			this.parent.dispatchEvent(new ZEvent(ZEvent.SCROLL_CHANGE,scrollMovePercent));
		}
		
		private function onClickSprite(event:MouseEvent):void{
			skin.y = mouseY - skin.height/2;
			
			if(skin.y>(scrollHeight - skin.height)){
				skin.y = scrollHeight - skin.height;
			}
			
			if(skin.y<0){
				skin.y = 0;
			}
			
			eventDispatch();
		
		}
		
		public function setScrollHeight(height:int):void{
			this.scrollHeight = height;
			clickSprite.graphics.clear();
			clickSprite.graphics.beginFill(backColor,backAlpha);
			clickSprite.graphics.drawRoundRect(0,-upDownBtHeight,skin.width,scrollHeight+2*upDownBtHeight,ellispeWidth);
			clickSprite.graphics.endFill();
			reset();
		}
	}
}