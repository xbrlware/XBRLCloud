////////////////////////////////////////////////////////////////////////////////
//
//  XBRLCloud
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.main.components.windowMessage.events
{
	
	import flash.events.Event;
	
	public class WindowMessageEvent extends Event
	{
		
		
		public static const OPEN   :String = "com.xbrlcloud.assurance.main.components.windowMessage.events.WindowMessageEvent.OPEN";
		
		public static const CLOSE  :String = "com.xbrlcloud.assurance.main.components.windowMessage.events.WindowMessageEvent.CLOSE";
		
		public static const REFRESH:String = "com.xbrlcloud.assurance.main.components.windowMessage.events.WindowMessageEvent.REFRESH";
		
		public static const BACK   :String = "com.xbrlcloud.assurance.main.components.windowMessage.events.WindowMessageEvent.BACK";
		
		
		public var message:String;
		
		
		public function WindowMessageEvent(type:String, message:String = null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.message = message;
			
		}
		
		
		override public function clone():Event
		{
			return new WindowMessageEvent(OPEN);
		}
	}
}