////////////////////////////////////////////////////////////////////////////////
//
//  XBRLCloud
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.validation.events
{	
	
	
	import com.xbrlcloud.assurance.validation.vos.SignalVO;
	
	import flash.events.Event;
	
	
	public class SignalSelectedEvent extends Event	
	{
		
		public static const SELECTED:String = "com.xbrlcloud.assurance.validation.events.SignalSelectedEvent.SELECTED";
		
		public var signal:SignalVO;
		
		public function SignalSelectedEvent(type:String, signal:SignalVO = null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.signal = signal;
		}
		
		override public function clone():Event
		{
			return new SignalSelectedEvent(SELECTED);
		}
		
	}
}