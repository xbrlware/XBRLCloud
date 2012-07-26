////////////////////////////////////////////////////////////////////////////////
//
//  XBRLCloud
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.main.http
{
	import flash.events.Event;
	
	public class URLParserManagerEvent extends Event
	{
		
		
		public var URL             :String;
		
		public var URLDomain       :String;
		
		public var networksURL     :String;
		
		public var validationURL   :String;
		
		public var selNetworkURI   :String;
		
		public var selConceptQname :String;
		
		public var headerTitle     :String;
		
		
		public static const PARSED:String = "com.xbrlcloud.assurance.main.http.URLParserAnalyzerEvent.PARSED";
		
		
		public function URLParserManagerEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new URLParserManagerEvent(PARSED);
		}
		
		
		
	}
	
}