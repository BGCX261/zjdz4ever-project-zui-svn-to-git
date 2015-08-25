package com.zui.framework.components
{
	import com.zui.framework.interfaces.ISelect;
	import com.zui.framework.managers.DataManager;
	import com.zui.framework.utils.Reflection;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.system.ApplicationDomain;

	/**
	 * 
	 * @author zhoujun
	 * 
	 */	
	public class ZTabButton implements ISelect
	{
		private var btnBg:MovieClip;
		private var btnTxt:ZLabel;
		private var _selected:Boolean = false;
		private var curEnabled:Boolean = true;
		
		public function ZTabButton(skin:Object)
		{
			if(skin is Class){
				this.btnBg = new skin() as MovieClip;
			}else{
				this.btnBg = skin as MovieClip;
			}

			this.selected = false;
			btnBg.buttonMode = true;
		}


		
		public function setLocationXY($x:int, $y:int) : void
		{
			btnBg.x = $x;
			btnBg.y = $y;
		}

		public function setText(value:String) : void
		{
			if(btnTxt == null){
				btnTxt = new ZLabel();
				btnTxt.mouseEnabled = false;
				btnTxt.setFont();
				btnTxt.setSizeWH(btnBg.width,btnBg.height);
				btnBg.addChild(btnTxt);
			}
			
			this.btnTxt.setText(value);
		}
		
		public function setTextFilter(ary:Array) : void
		{
			this.btnTxt.filters = ary;
		}

		public function setTextFont(font:String = "Tahoma", size:Number = 11, color:uint = 0x0,bold:Boolean = false, italic:Boolean = false, underline:Boolean = false, align:String = "left") : void
		{
			this.btnTxt.setFont(font, size,color, bold, italic, underline, align);
		}

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
			var str:int = value ? 2 : 1;
			this.btnBg.gotoAndStop(str);
		}
		
		public function set enabled(value:Boolean):void{
			curEnabled = value;
			if(value){
				btnBg.filters = [];
				btnBg.buttonMode = true;
			}else{
				btnBg.buttonMode = false;
				btnBg.filters = [new ColorMatrixFilter([.5,0,0,0,-15,.5,0,0,0,-15,.5,0,0,0,-15,0,0,0,1,0])];
			}
		}
		
		public function get skin():MovieClip{
			return btnBg;
		}
		
		

		
		
	}
}