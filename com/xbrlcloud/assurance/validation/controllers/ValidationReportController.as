////////////////////////////////////////////////////////////////////////////////
//
//  XBRLCloud
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.validation.controllers
{
	import com.xbrlcloud.assurance.main.components.windowMessage.events.WindowMessageEvent;
	import com.xbrlcloud.assurance.shared.data.NetworksSignalsDataConnect;
	import com.xbrlcloud.assurance.shared.parser.IXMLResourceParser;
	
	import flash.events.IEventDispatcher;
	import flash.external.ExternalInterface;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	import mx.utils.UIDUtil;
	
	import org.swizframework.utils.services.ServiceHelper;
	
	public class ValidationReportController
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject("validationReportService")]
		public var service:HTTPService;
		
		[Inject("validationServiceHelper")]
		public var sh:ServiceHelper;
		
		[Inject("validationReportXMLParser")]
		public var xmlParser:IXMLResourceParser;
		
		[Inject]
		public var dataConnect:NetworksSignalsDataConnect
		
		
		[Mediate(event="URLParserManagerEvent.PARSED", properties="validationURL")]
		public function getValidationReportsData(validationURL:String):void
		{
			if(validationURL)
			{
				service.url = validationURL;
				sh.executeServiceCall(service.send(), getValidationReportsDataResult, getValidationReportsDataFault);
			}
		}
		
		
		public function getValidationReportsDataResult(evt:ResultEvent):void
		{
			try
			{
				dataConnect.connectSignals(xmlParser.parse(evt.result as XML));
			}
			catch(e:Error)
			{
				var errorMessage:String = "The validation data could not be loaded. Please, contact the administrators:  " + service.url;
				dispatcher.dispatchEvent(new WindowMessageEvent(WindowMessageEvent.OPEN, errorMessage));
			}
		}
		
		
		public function getValidationReportsDataFault(evt:FaultEvent):void
		{
			var errorMessage:String  = "The server has failed to get the validation information. Please, contact the administrators:  " + service.url;
			dispatcher.dispatchEvent(new WindowMessageEvent(WindowMessageEvent.OPEN, errorMessage));
		}
		
	}
}