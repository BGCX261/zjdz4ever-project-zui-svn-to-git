package com.zui.framework.components
{
	import com.zui.framework.components.classes.ScrollThumb;
	import com.zui.framework.events.ZEvent;
	import com.zui.framework.geom.IntDimension;
	import com.zui.framework.geom.IntRectangle;
	import com.zui.framework.utils.HtmlTextUtils;
	import com.zui.framework.utils.ZMath;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	public class ZScrollBar extends Sprite
	{
		private var upBt:ZMcButton;
		private var downBt:ZMcButton;
		private var scrollHeight:int;
		private var _clickRollPixel:int = 50;//点击滚动的像素值
		
		private var scrollThumb:ScrollThumb;
		private var scrollTarget:DisplayObject;
		private var targetRect:Rectangle;
		private var targetHeight:int;
		private var delayCall:int;
		private var tweenDirection:int = 1;
		private var mouseDownRollSpeedPercent:Number = .02;//点击鼠标的
		private var mouseDownResponseTime:int = 500;//点击鼠标的滚动延迟时间 毫秒
		
		/**
		 * 
		 * @param upSkin 可以是class 或者 movieClip
		 * @param downSkin 可以是class 或者 movieClip
		 * @param thumbSkin 可以是class 或者 movieClip
		 * @param scrollHeight 长度
		 * @param backColor 颜色
		 * @param backAlpha 透明度
		 * 
		 */		
		public function ZScrollBar(upSkin:Object,downSkin:Object,thumbSkin:Object,scrollHeight:int = 100,backColor:uint = 0xffffff,backAlpha:Number = 1)
		{
			super();
	
			upBt = new ZMcButton(HtmlTextUtils.createHtmlText("向上翻",14,"ffffff"));
			if(upSkin is Class){
				upBt.setSkin(new upSkin());
			}else{
				upBt.setSkin(upSkin as MovieClip);
			}
			
			downBt = new ZMcButton(HtmlTextUtils.createHtmlText("向下翻",14,"ffffff"));
			
			if(downSkin is Class){
				downBt.setSkin(new downSkin());
			}else{
				downBt.setSkin(downSkin as MovieClip);
			}
			
			scrollThumb = new ScrollThumb(thumbSkin,scrollHeight-upBt.getSkin().height*2,backColor,backAlpha,upBt.getSkin().height);

			
			addChild(scrollThumb);
			this.scrollHeight =scrollHeight;
			addChild(upBt.getSkin());
			addChild(downBt.getSkin());
	
			upBt.addEventListener(MouseEvent.MOUSE_DOWN,onUpBtMouseDown);
			downBt.addEventListener(MouseEvent.MOUSE_DOWN,onDownBtMouseDown);
			downBt.y = scrollHeight - downBt.height; 
			scrollThumb.x = (upBt.width - scrollThumb.width)/2;
			scrollThumb.y = upBt.height;
			addEventListener(ZEvent.SCROLL_CHANGE,onScrollChange);
		}
		
		public function dispose():void{
			clearTimeout(delayCall);
			scrollThumb.dispose();
			upBt.dispose();
			downBt.dispose();
			removeEventListener(ZEvent.SCROLL_CHANGE,onScrollChange);	
			removeEventListener(Event.ENTER_FRAME,onEf);
		}
		
		/**
		 * 设置scrollbar滚动的对象
		 * @param scrollTarget scrollbar滚动的对象
		 * @param intDimension 设置显示区域长宽
		 * 
		 */		
		public function setScrollTarget(scrollTarget:DisplayObject,intDimension:IntDimension):void{
			targetHeight = ZMath.getFullBounds(scrollTarget).height;
			targetRect = new Rectangle(0,0,intDimension.width,intDimension.height);
			this.scrollTarget = scrollTarget;
			this.scrollTarget.scrollRect = targetRect;
			if(targetHeight<=intDimension.height){
				this.mouseEnabled = false;
				this.mouseChildren = false;
				scrollThumb.skin.visible = false;
			}else{
				this.mouseEnabled = true;
				this.mouseChildren = true;
				scrollThumb.skin.visible = true;
			}
		}
		
		/**
		 * 修改srcollTarget显示后，调用此函数可以刷新到正确的thumb和显示的位置,范围0-1，0表示顶，1表示底部
		 * 
		 * 
		 */		
		public function update(scrollMovePercent:Number):void{
			scrollThumb.scrollMove(scrollMovePercent);
			
			
		}

		
		private function onScrollChange(event:ZEvent):void{
			if(targetHeight<targetRect.height){
				targetRect.y = 0;
			}else{
				targetRect.y = (targetHeight - targetRect.height)*(event.data as Number);
			}
			
			scrollTarget.scrollRect = targetRect;
		}
		
		private function onUpBtMouseDown(event:MouseEvent):void{	
			upClick();
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			tweenDirection = -1;
			delayCall = setTimeout(onTweenTarget,mouseDownResponseTime);
		}
		
		private function upClick():void{
			if(scrollTarget){
				if(targetHeight>0){
					scrollThumb.scrollMove(-_clickRollPixel/targetHeight);
					return;
				}
			}
			scrollThumb.scrollMove(-1);
		}
		
		private function onTweenTarget():void{
			addEventListener(Event.ENTER_FRAME,onEf);
		}
		
		private function onEf(event:Event):void{
			scrollThumb.scrollMove(mouseDownRollSpeedPercent*tweenDirection);
		}
		
		private function onMouseUp(event:MouseEvent):void{
			clearTimeout(delayCall);
			removeEventListener(Event.ENTER_FRAME,onEf);
		}
		
		private function downClick():void{
			if(scrollTarget){
				if(targetHeight>0){
					scrollThumb.scrollMove(_clickRollPixel/targetHeight);
					return;
				}
			}
			scrollThumb.scrollMove(1);
		}

		private function onDownBtMouseDown(event:MouseEvent):void{
			downClick();

			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			tweenDirection = 1;
			delayCall = setTimeout(onTweenTarget,mouseDownResponseTime);
		}

		public function set enable(value:Boolean):void{
			this.mouseChildren = value;
		}

		public function set clickRollPixel(value:int):void{
			_clickRollPixel = Math.abs(value);
		}
		
		public function resetScrollHeight(height:int):void{
			this.scrollHeight = height;
			scrollThumb.setScrollHeight(height - downBt.height*2);
			downBt.y = scrollHeight - downBt.height; 
			scrollThumb.x = (upBt.width - scrollThumb.width)/2;
			scrollThumb.y = upBt.height;
		}

		

	}
}