////////////////////////////////////////////////////////////////////////////////
//
//  XBRLCloud
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.networks.events
{
	import com.xbrlcloud.assurance.networks.vos.NetworkVO;
	
	import flash.events.Event;
	
	public class NetworkSelectEvent extends Event
	{
		
		public static const CHANGE:String = "com.xbrlcloud.assurance.networks.events.NetworkSelectEvent.CHANGE" ;
		
		public var network:NetworkVO;
		
		public function NetworkSelectEvent(type:String, network:NetworkVO = null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.network = network;
		}
		
		override public function clone():Event
		{
			return new NetworkSelectEvent(CHANGE);
		}
		
	}
}