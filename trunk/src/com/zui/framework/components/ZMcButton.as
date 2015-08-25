﻿package com.zui.framework.components
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.ColorMatrixFilter;
	
	import com.zui.framework.managers.SoundManager;
	import com.zui.framework.utils.HtmlTextUtils;
	
	public class ZMcButton
	{
		protected var bt:MovieClip;
		private var curEnabled:Boolean = true;
		protected var frameArr:Array;
		protected var tipsLabel:String;
		protected var lastClickTime:int = 0;
		protected var actionListener:Function;
		protected var args:Array;
		protected var overSound:String;
		protected var clickSound:String;
		private var rollOverFunc:Function;
		private var rollOutFunc:Function;
		
		public function ZMcButton(tooltip:String = "", overSound:String = "", clickSound:String = "")
		{
			this.frameArr = [1, 2, 3, 4];
			this.overSound = overSound;
			this.clickSound = clickSound;
			this.resetToolTips(tooltip);
			this.frameArr = this.frameArr;
		}
		
		public function dispose() : void
		{
			this.removeEvent();
			this.bt.stop();
			this.frameArr = null;
			this.actionListener = null;
			this.args = null;
		}
		
		public function set overFunc(func:Function) : void
		{
			this.rollOverFunc = func;
		}
		
		public function set outFunc(func:Function) : void
		{
			this.rollOutFunc = func;
		}
		
		public function set(arg:String, obj:*) : void
		{
			if (this.bt == null)
			{
				return;
			}
			this.bt[arg] = obj;
		}
		
		public function get(arg:String):*
		{
			if (this.bt == null)
			{
				return;
			}
			return this.bt[arg];
		}
		
		
		/**
		 *	加入点击事件 
		 * @param func
		 * @param args
		 * 
		 */		
		public function addActionEventListener(func:Function, ... args) : void
		{
			this.actionListener = func;
			this.args = args;
		}
		
		public function removeActionEventListener() : void
		{
			this.actionListener = null;
		}
		
		public function addEventListener(arg:String, func:Function) : void
		{
			if (this.bt == null)
			{
				return;
			}
			this.bt.addEventListener(arg, func);
		}
		
		public function removeEventListener(arg:String, func:Function) : void
		{
			if (this.bt == null)
			{
				return;
			}
			this.bt.removeEventListener(arg, func);
		}
		
		public function resetToolTips(str:String = "") : void
		{
			this.tipsLabel = str;
			if (str != "")
			{
			}
		}
		
		public function setFrameIndex(array:Array = null) : void
		{
			if (array != null)
			{
				this.frameArr = array;
				if (this.bt != null)
				{
					this.bt.gotoAndStop(array[0]);
				}
			}
		}
		
		public function getFrameIndexArr() : Array
		{
			return this.frameArr;
		}
		
		public function getSkin() : MovieClip
		{
			return this.bt;
		}
		
		public function setSkin(mc:MovieClip, array:Array = null) : void
		{
			if (array != null)
			{
				this.frameArr = array;
			}
			if (this.bt == mc)
			{
				return;
			}
			if (mc == null)
			{
				throw new Error("MyButton对象的皮肤不能为空");
			}
			if (this.bt != null)
			{
				this.removeEvent();
			}
			this.bt = mc;
			this.bt.mouseChildren = false;
			this.bt.buttonMode = true;
			this.bt.gotoAndStop(this.frameArr[0]);
			this.addEvent();
		}
		
		public function set enabled(arg:Boolean) : void
		{
			if (this.bt == null)
			{
				return;
			}
			this.curEnabled = arg;
			if (arg)
			{
				this.bt.buttonMode = true;
				this.bt.filters = [];
			}
			else
			{
				this.bt.buttonMode = false;
				this.bt.filters = [new ColorMatrixFilter([.5,0,0,0,-15,.5,0,0,0,-15,.5,0,0,0,-15,0,0,0,1,0])];
			}
			this.bt.gotoAndStop(this.frameArr[0]);
		}
		
		public function get enabled() : Boolean
		{
			return this.curEnabled;
		}
		
		private function addEvent() : void
		{
			if (this.bt == null)
			{
				return;
			}
			this.bt.addEventListener(MouseEvent.MOUSE_OVER, this.onRollOver);
			this.bt.addEventListener(MouseEvent.MOUSE_OUT, this.onRollOut);
			this.bt.addEventListener(MouseEvent.MOUSE_DOWN, this.onPressDown);
			this.bt.addEventListener(MouseEvent.MOUSE_UP, this.onReleaseUp);
			this.bt.addEventListener(MouseEvent.CLICK, this.onClickBt);
		}
		
		private function onClickBt(event:MouseEvent) : void
		{
			if (this.curEnabled && this.actionListener != null)
			{
				this.actionListener.apply(null, this.args);
			}
		}
		
		private function removeEvent() : void
		{
			if (this.bt == null)
			{
				return;
			}
			this.bt.removeEventListener(MouseEvent.MOUSE_OVER, this.onRollOver);
			this.bt.removeEventListener(MouseEvent.MOUSE_OUT, this.onRollOut);
			this.bt.removeEventListener(MouseEvent.MOUSE_DOWN, this.onPressDown);
			this.bt.removeEventListener(MouseEvent.MOUSE_UP, this.onReleaseUp);
			this.bt.removeEventListener(MouseEvent.CLICK, this.onClickBt);
		}
		
		protected function onRollOver(event:MouseEvent) : void
		{
			if (this.tipsLabel != "")
			{
				ToolTip.instance.showTip(event.currentTarget as Sprite,this.tipsLabel);
			}
			if (this.curEnabled)
			{
				if (this.overSound != "")
				{
					SoundManager.instance.playSound(overSound);
				}
				this.bt.gotoAndStop(this.frameArr[1]);
			}
			if (this.rollOverFunc != null)
			{
				this.rollOverFunc();
			}
		}
		
		protected function onRollOut(event:MouseEvent) : void
		{
			if (this.tipsLabel != "")
			{
				ToolTip.instance.hideTip();
			}
			if (this.curEnabled)
			{
				this.bt.gotoAndStop(this.frameArr[0]);
			}
			if (this.rollOutFunc != null)
			{
				this.rollOutFunc();
			}
		}
		
		protected function onPressDown(event:MouseEvent) : void
		{
			if (this.curEnabled)
			{
				if (this.clickSound != "")
				{
					SoundManager.instance.playSound(clickSound);
				}
				this.bt.gotoAndStop(this.frameArr[2]);
			}
		}
		
		protected function onReleaseUp(event:MouseEvent) : void
		{
			if (this.tipsLabel != "")
			{
				//todo
				ToolTip.instance.hideTip();
			}
			if (this.curEnabled)
			{
				this.bt.gotoAndStop(this.frameArr[1]);
			}
		}
		
		public function get width():Number{
			return bt?bt.width:0;
		}
		
		public function get height():Number{
			return bt?bt.height:0;
		}
		
		public function get y():Number{
			return bt?bt.y:0;
		}
		
		public function set y(value:Number):void{
			if(bt) bt.y = value;
		}
		
		public function get x():Number{
			return bt?bt.x:0;
		}
		
		public function set x(value:Number):void{
			if(bt) bt.x = value;
		}
		
	}
}
