////////////////////////////////////////////////////////////////////////////////
//
//  XBRCloud
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.shared.data
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class SignalsNetworksConnectEvent extends Event
	{
		
		public static const CONNECTED:String = "com.xbrlcloud.assurance.shared.data.SignalsNetworksConnectEvent.CONNECTED";
		
		public var networks:ArrayCollection;
		public var signals :ArrayCollection;
		
		public function SignalsNetworksConnectEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new SignalsNetworksConnectEvent(CONNECTED);
		}
		
	}
}