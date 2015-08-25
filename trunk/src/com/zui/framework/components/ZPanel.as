package com.zui.framework.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import com.zui.framework.managers.DataManager;
	
	public class ZPanel extends Sprite
	{
		private var  _dragAble:Boolean = false;
		
		public function ZPanel()
		{
			super();	
		}
		
		private function onMouseDown(event:MouseEvent):void{
			this.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			this.startDrag(false,new Rectangle(-this.width/2,-this.height/2,DataManager.getInstance().root.width,DataManager.getInstance().root.height));
		}
		

		
		
		
		private function onMouseUp(event:MouseEvent):void{
			this.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			this.stopDrag();
		}

		public function get dragAble():Boolean
		{
			return _dragAble;
		}

		public function set dragAble(value:Boolean):void
		{
			_dragAble = value;
			if(value){
				addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			}else{
				removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			}
		}

	}
}