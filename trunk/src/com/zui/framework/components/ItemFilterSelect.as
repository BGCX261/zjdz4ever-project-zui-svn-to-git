package com.zui.framework.components
{
	import com.dolo.arpg.globals.LangConfig;
	import com.zui.framework.utils.HtmlTextUtils;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-8-30 下午02:59:31
	 * 
	 */
	public class ItemFilterSelect
	{
		//======================================================================
		//        property
		//======================================================================
		private var ary:Array = [];
		private var filters:Array = [];
		private var roleID:int = 0;
		private var selected:int =  -1;
		private var nowID:int = 0;
		private var callback:Function;
		private var intro:MovieClip
		//======================================================================
		//        constructor
		//======================================================================
		
		public function ItemFilterSelect(ary:Array,filters:Array,callback:Function = null,selected:int = -1,intro:MovieClip = null)
		{
			this.filters = filters;
			this.ary = ary;
			this.callback = callback;
			this.selected = selected;
			this.intro = intro;
			for(var i:int = 0; i<ary.length; i++){
				var obj:Object = ary[i];
				(obj as MovieClip).buttonMode = true;
				(obj as MovieClip).addEventListener(MouseEvent.CLICK,onClick);
				if(intro != null)
				{
					intro.visible = false;
					(obj as MovieClip).addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
					(obj as MovieClip).addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
				}
				if(i  == selected){
					obj.filters = filters;
				}else{
					obj.filters = [];
				}
			}
		}
		
		//======================================================================
		//        public function
		//======================================================================
		public function dispose():void{
			for(var i:int = 0; i<ary.length; i++){
				var obj:Object = ary[i];
				(obj as MovieClip).buttonMode = false;
				(obj as MovieClip).removeEventListener(MouseEvent.CLICK,onClick);
				
				obj.filters = [];
				
			}
			
			ary = [];
			filters = [];
			callback = null;
		}
		
		public function initFilter(isJob:Boolean = false):void
		{
			if(selected!=-1)
			{
				ary[selected].filters = [];
				if(isJob)
				{
					selected = 0;
					ary[selected].filters = filters;
				}
			}
		}

		//======================================================================
		//        private function
		//======================================================================
		
		//======================================================================
		//        event handler
		//======================================================================
		private function onClick(event:MouseEvent):void
		{
			if(ary[selected]){
				ary[selected].filters = [];
			}
			selected = ary.indexOf(event.currentTarget);
			ary[selected].filters = filters ;
			if(callback!=null)
			{
				callback(selected);
			}
		}
		
		private function onMouseOver(event:MouseEvent):void
		{
			var id:int = ary.indexOf(event.currentTarget);
			intro.visible = true;
			intro.y = event.currentTarget.y;
			intro.txt.htmlText = HtmlTextUtils.createHtmlText(LangConfig.getJob(id),12,"ffffff");
		}
		
		private function onMouseOut(event:MouseEvent):void
		{
			intro.visible = false;
		}
		//======================================================================
		//        getter&setter
		//======================================================================
	}
} 