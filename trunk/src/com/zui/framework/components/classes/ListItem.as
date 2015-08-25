package com.zui.framework.components.classes
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import com.zui.framework.components.ZLabel;
	import com.zui.framework.interfaces.ISelect;
	import com.zui.framework.utils.ASFont;
	
	public class ListItem extends Sprite implements ISelect
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
		private var label:ZLabel;
		private var _selected:Boolean = false;
		private var _listItemVO:ListItemVO;
		
		public function ListItem(skin:MovieClip,tooltip:String = "", overSound:String = "", clickSound:String = "")
		{
			super();
			this.frameArr = [1, 2, 3, 4];
			this.overSound = overSound;
			this.clickSound = clickSound;
			this.resetToolTips(tooltip);
			this.frameArr = this.frameArr;
			setSkin(skin);
			addChild(skin);
			label = new ZLabel();
			label.setSizeWH(bt.width,bt.height);
			label.multiline = false;
			label.mouseEnabled = false;
			label.setFont("Microsoft YaHei",14);
			addChild(label);
	
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
		
		public function setLabel(arg:String):void{
			if(label){
				label.text = arg;
			}
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
		
		
		
		public function resetToolTips(param1:String = "") : void
		{
			this.tipsLabel = param1;
			if (param1 != "")
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
		
		
		
		
		public function setFont(textFormat:TextFormat):void{
			label.setFont(textFormat.font,Number(textFormat.size),uint(textFormat.color),Boolean(textFormat.bold),Boolean(textFormat.italic),Boolean(textFormat.underline),textFormat.align);
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
			if(selected){
				return;
			}
			
			if (this.tipsLabel != "")
			{
				//todo
			}
			if (this.curEnabled)
			{
				if (this.overSound != "")
				{
					//todo
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
			if(selected){
				return ;
			}
			
			if (this.tipsLabel != "")
			{
				//todo
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
			if(selected){
				return;	
			}
			
			if (this.curEnabled)
			{
				if (this.clickSound != "")
				{
					//todo
				}
				this.bt.gotoAndStop(this.frameArr[2]);
			}
		}
		
		protected function onReleaseUp(event:MouseEvent) : void
		{
			if(selected){
				return;
			}
			
			if (this.tipsLabel != "")
			{
				//todo
			}
			if (this.curEnabled)
			{
				this.bt.gotoAndStop(this.frameArr[1]);
			}
		}
		
		

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
			if(value){
				this.bt.gotoAndStop(this.frameArr[1]);
			}else{
				this.bt.gotoAndStop(this.frameArr[0]);
			}
			
		}

		public function get listItemVO():ListItemVO
		{
			return _listItemVO;
		}

		public function set listItemVO(value:ListItemVO):void
		{
			_listItemVO = value;
			setLabel(value.label);
		}
		

		
	
	}
}