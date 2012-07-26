////////////////////////////////////////////////////////////////////////////////
//
//  XBRLCloud
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.main.components.windowURLExporter.events
{
	import com.xbrlcloud.assurance.main.components.windowMessage.events.WindowMessageEvent;
	
	import flash.events.Event;
	
	
	public class WindowURLExportEvent extends WindowMessageEvent
	{
		
		public static const OPEN   :String = "com.xbrlcloud.assurance.main.components.windowURLExporter.events.WindowURLExportEvent.OPEN";
		
		public static const CLOSE  :String = "com.xbrlcloud.assurance.main.components.windowURLExporter.events.WindowURLExportEvent.CLOSE";
		
		
		public function WindowURLExportEvent(type:String, message:String=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, message, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new WindowURLExportEvent(OPEN);
		}
	}
}