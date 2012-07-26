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
	
	import flash.events.Event;
	
	public class ValidationReportDataEvent extends Event
	{
		
		public static const GET_ALL:String = "com.xbrlcloud.assurance.validation.events.ValidationReportDataEvent.GET_ALL";
		
		public function ValidationReportDataEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ValidationReportDataEvent(GET_ALL);
		}
		
	}
	
}