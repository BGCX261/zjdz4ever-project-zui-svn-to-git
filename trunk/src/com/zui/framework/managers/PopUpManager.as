package com.zui.framework.managers
{
	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2011-5-11 上午09:31:50
	 * 
	 * POP弹出框
	 * 在主场景中注册
	 * add和remove两个方法
	 *
	 */


	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	public class PopUpManager extends EventDispatcher
	{
		
		//======================================================================
		//        const
		//======================================================================
		private  static var instance:PopUpManager;
		//======================================================================
		//        constructor
		//======================================================================
		
		public function PopUpManager()
		{
			super();
			dic = new Dictionary();
			backDic = new Dictionary();
			back = draw();
			LayerManager.getInstance().popUpLayer.addChild(back);
			ResizeManager.getInstance().addHandler(onResize);
			back.visible = false;
		}
		
		//======================================================================
		//        property
		//======================================================================
		private var dic:Dictionary;
		private var back:Sprite;
		private var backDic:Dictionary;
		private var havePop:Boolean = false;
		//======================================================================
		//        method
		//======================================================================

		
		public static function addPopUp(app:DisplayObject,isShowBack:Boolean = true,autoSize:Boolean = true):void{		
			PopUpManager.getInstance()._addPopUp(app,isShowBack,autoSize);
		}
		
		public static function removePopUp(app:DisplayObject):void{
			PopUpManager.getInstance()._removePopUp(app);
		}
		
		public static function removeAll():void{
			PopUpManager.getInstance()._removeAll();
		}

		//======================================================================
		//        variable
		//======================================================================
		private function searchDic():void{
			
			for (var item:String in dic){
				if(dic[item] != null){
					havePop = true; 
				}
			}
			
			if(havePop == false){
				back.visible = false;
			}else{
				back.visible = true;
			}
		}
		//======================================================================
		//        private function
		//======================================================================
		private  function _removeAll():void{
			for(var itemName:String in dic){
				if(dic[itemName]){
					LayerManager.getInstance().popUpLayer.removeChild(dic[itemName]);
					dic[itemName] = null;
					delete dic[itemName];
					if(backDic[itemName]){
						backDic[itemName] = null;
						delete backDic[itemName];
					}
				}
				
			}
			
			searchDic();
		
		}
		private static function getInstance():PopUpManager{
			return instance ||=new PopUpManager();
		}
		
		private function _addPopUp(app:DisplayObject,isShow:Boolean,autoSize:Boolean):void{		
			if(dic[app.name]){
				removePopUp(app);
			}else{
				if(autoSize){
					app.x = (LayerManager.getInstance().stage.stageWidth - app.width)/2;
					app.y = (LayerManager.getInstance().stage.stageHeight - app.height)/2;
				}
				
				dic[app.name] = app;
				backDic[app.name] = isShow;
				LayerManager.getInstance().popUpLayer.addChild(app);
				if(isShow){
					back.visible = true;
					LayerManager.getInstance().popUpLayer.setChildIndex(back,LayerManager.getInstance().popUpLayer.numChildren - 2);
					
				}
			}
			
		}
		
		private function _removePopUp(app:DisplayObject):void{
			if(dic[app.name]){
				
				LayerManager.getInstance().popUpLayer.removeChild(dic[app.name]);
				dic[app.name] = null;
				backDic[app.name] = null;
				delete dic[app.name];
				delete backDic[app.name];
				
			}
			back.visible = false;
		
			for each(var tmp:* in backDic){
				if(tmp == true){
					back.visible = true;
					
					LayerManager.getInstance().popUpLayer.setChildIndex(back,LayerManager.getInstance().popUpLayer.numChildren - 2);
					break;
				}
			}
			
			LayerManager.getInstance().stage.focus = LayerManager.getInstance().stage;
			
			
			
		}

		
		private function draw():Sprite{
			var back:Sprite = new Sprite();
			back.graphics.beginFill(0,.4);
			back.graphics.drawRect(0,0,LayerManager.getInstance().stage.stageWidth,LayerManager.getInstance().stage.stageHeight);
			back.graphics.endFill();
			return back;
		}
		
		private function onResize():void{
			back.width = LayerManager.getInstance().stage.stageWidth;
			back.height = LayerManager.getInstance().stage.stageHeight;
			for each(var item:DisplayObject in dic){
				ResizeManager.getInstance().setMiddle(item);
			}
		}





		
		
		//======================================================================
		//        event handler
		//======================================================================

		//======================================================================
		//        getter&setter
		//======================================================================

	}
} 