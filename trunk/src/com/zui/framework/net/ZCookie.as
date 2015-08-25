package com.zui.framework.net
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.SharedObject;
	
	import com.zui.framework.events.ZEvent;
	
	public class ZCookie extends EventDispatcher
	{
		private var isOpend:Boolean = false;
		private var so:SharedObject;
		
		public function ZCookie(name:String)
		{
			super();
			try
			{
				this.so = SharedObject.getLocal(name);
				this.isOpend = true;
			}
			catch (err:Error)
			{
				isOpend = false;
				dispatchEvent(new ZEvent(ZEvent.ERROR));
			}
		}
		
		public function close() : void
		{
			if (!this.isOpend)
			{
				return;
			}
			this.so.close();
		}
		
		public function getAttributes(name:String) : Object
		{
			if (!this.isOpend)
			{
				return null;
			}
			return this.so.data[name];
		}
		
		public function setAttributes(name:String, value:Object) : Boolean
		{
	
			if (!this.isOpend)
			{
				return false;
			}
			try
			{
				if (value == null)
				{
					delete this.so.data[name];
				}
				else
				{
					this.so.data[name] = value;
				}
				return true;
			}
			catch (err:Error)
			{
			}
			return false;
		}
		
		public function removeAll() : void
		{
			if (!this.isOpend)
			{
				return;
			}
			this.so.clear();
		}
	}
}