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
	import com.xbrlcloud.assurance.networks.vos.NetworkVO;
	
	import flash.events.Event;
	
	public class SignalsConceptsConnectEvent extends Event
	{
		
		public static const CONNECTED:String = "com.xbrlcloud.assurance.shared.data.SignalsConceptsConnectEvent.CONNECTED";
		
		
		public var network:NetworkVO;
		
		public function SignalsConceptsConnectEvent(type:String, network:NetworkVO = null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.network = network;
		}
		
		override public function clone():Event
		{
			return new SignalsConceptsConnectEvent(CONNECTED);
		}
		
	}
}