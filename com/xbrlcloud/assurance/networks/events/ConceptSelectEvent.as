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
	import com.xbrlcloud.assurance.networks.vos.ConceptVO;
	
	import flash.events.Event;
	
	public class ConceptSelectEvent extends Event
	{
		
		public static const CHANGE:String = "com.xbrlcloud.assurance.networks.events.ConceptSelectEvent.CHANGE" ;
		
		public var concept:ConceptVO;
		
		public function ConceptSelectEvent(type:String, concept:ConceptVO = null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.concept = concept;
		}
		
		override public function clone():Event
		{
			return new ConceptSelectEvent(CHANGE);
		}
		
	}
}