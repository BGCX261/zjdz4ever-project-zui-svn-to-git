package com.zui.framework.components
{
	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-8-27 下午02:14:45
	 * 
	 */
	import com.zui.framework.managers.DataManager;
	import com.zui.framework.managers.DepthManager;
	import com.zui.framework.managers.ResizeManager;
	import com.zui.framework.utils.HtmlTextUtils;
	
	import flash.display.Sprite;
	import flash.media.Video;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class ProcessBar extends Sprite
	{
		//======================================================================
		//        property
		//======================================================================
		private static var _instance:ProcessBar;
		private var txt:ZTextArea;
		//======================================================================
		//        constructor
		//======================================================================
		
		public function ProcessBar()
		{
			super();
			txt = new ZTextArea();
			txt.autoSize = TextFieldAutoSize.CENTER;
			txt.multiline = false;
			txt.wordWrap = false;
			addChild(txt);
		}
		
		//======================================================================
		//        public function
		//======================================================================
		public function setPercent(number:Number):void{
			txt.htmlText = HtmlTextUtils.createHtmlText("加载:"+int(number*100).toString()+"%",30,"ff0000");
			ResizeManager.getInstance().setMiddle(txt);
			this.visible = true;
		}
		
		public  function start():void{
			setPercent(0);
			this.visible = true;
			
		}
		
		public function onComplete():void{
			this.visible = false;
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
		public static function get instance():ProcessBar{
			return _instance ||= new ProcessBar();
		}
		
	}
} 