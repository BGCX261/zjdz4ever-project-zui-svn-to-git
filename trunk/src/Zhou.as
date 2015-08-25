package
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.sensors.Accelerometer;
	
	import flashx.textLayout.debug.assert;
	
	import com.zui.framework.components.ZComboBox;
	import com.zui.framework.components.ZList;
	import com.zui.framework.components.ZMcButton;
	import com.zui.framework.components.ZScrollBar;
	import com.zui.framework.components.ZTabButton;
	import com.zui.framework.components.ZToggleButton;
	import com.zui.framework.components.ZViewStack;
	import com.zui.framework.components.classes.ListItem;
	import com.zui.framework.components.classes.ListItemVO;
	import com.zui.framework.core.Flow;
	import com.zui.framework.geom.IntDimension;
	import com.zui.framework.managers.DataManager;
	import com.zui.framework.managers.PopUpManager;
	import com.zui.framework.managers.SoundManager;
	import com.zui.framework.managers.SwfManager;
	import com.zui.framework.utils.Reflection;

	[SWF(frameRate="24",width="800",height="600")]
	public class Zhou extends Sprite
	{
		private var loader:Loader;
		private var myView:Sprite;
		public function Zhou()
		{
			var flow:Flow = new Flow(this);//初始化组件
			loader = new Loader();
			loader.load(new URLRequest("scrollbar.swf"));//加载组件素材
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,ecpHandler);
		
		}
		
		private function ecpHandler(event:Event):void{
			SwfManager.instance.setApplicationDomain(SwfManager.UI_LIBRARY,loader.contentLoaderInfo.applicationDomain);
			var scrollBar:ZScrollBar = new ZScrollBar(
				Reflection.getClass("up",SwfManager.instance.getUILibrary()),
				Reflection.getClass("down",SwfManager.instance.getUILibrary()),
				Reflection.getClass("drag",SwfManager.instance.getUILibrary()),200,0x00ffff,.5);
			addChild(scrollBar);
			var sprite:Sprite = Reflection.createDisplayObjectInstance("rect",SwfManager.instance.getUILibrary()) as Sprite;
			scrollBar.setScrollTarget(sprite,new IntDimension(100,200));
			addChild(sprite);
			sprite.x = 50;

			var combo:ZComboBox = new ZComboBox(
				Reflection.getClass("SkinComboBox",SwfManager.instance.getUILibrary()),
				Reflection.getClass("SkinComboBoxArrow",SwfManager.instance.getUILibrary()),
				Reflection.getClass("SkinListItemBackground",SwfManager.instance.getUILibrary()));
			addChild(combo);
	
			combo.x = 200;
			var tmp:Vector.<ListItemVO> = new Vector.<ListItemVO>();
			tmp.push(new ListItemVO("1"),
				new ListItemVO("2"),
				new ListItemVO("3"),
				new ListItemVO("4"),
				new ListItemVO("5"),
				new ListItemVO("6"));
			combo.dataProvider = tmp;
			var a:Array = [];
			for(var i:int = 0; i<3; i++){
				var tabb:ZTabButton = new ZTabButton(Reflection.getClass("up",SwfManager.instance.getUILibrary()));
				a.push(tabb);
			}
			
			var mc:MovieClip = Reflection.createInstance("t",SwfManager.instance.getUILibrary()) as MovieClip;
			var tab:ZToggleButton = new ZToggleButton(a);
			addChild(tab);
			tab.x = 380;
			var v:ZViewStack = new ZViewStack([mc.a,mc.b,mc.c]);
			tab.setViewStack(v);
			addChild(v);
			v.x = 500;
			
		
			var bt:ZMcButton = new ZMcButton();
			bt.setSkin(Reflection.createInstance("up",SwfManager.instance.getUILibrary()) as MovieClip);
			addChild(bt.getSkin());
			bt.x = 600;
			bt.enabled = false;
			
			

			
		}
		
		
	}
}