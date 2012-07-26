////////////////////////////////////////////////////////////////////////////////
//
//  XBRLCloud
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.networks.controllers
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

	public class NetworkListController
	{
		
		/*******************************************************************************************************************
		 * Properties
		 *******************************************************************************************************************/
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject("networksListService")]
		public var service:HTTPService;
		
		[Inject("networksListServiceHelper")]
		public var srvHelper:ServiceHelper;
		
		[Inject("networksXMLParser")]
		public var xmlParser:IXMLResourceParser;

		[Inject]
		public var dataConnect:NetworksSignalsDataConnect;
		
		
		/*******************************************************************************************************************
		 * Methods
		 *******************************************************************************************************************/
		
		[Mediate(event="URLParserManagerEvent.PARSED", properties="networksURL")]
		public function getNetworksList(networksURL:String):void
		{
			service.url =  networksURL;
			srvHelper.executeServiceCall(service.send(), getNetworksListResult, getNetworksListFault);
		}
		
		
		public function getNetworksListResult(evt:ResultEvent):void
		{
			dataConnect.connectNetworks(xmlParser.parse(evt.result as XML));
		}
		
		
		public function getNetworksListFault(info:FaultEvent):void
		{
			var errorMessage:String  = "The server has failed to get the Networks data. Please, contact the administrators:  " + service.url;
			dispatcher.dispatchEvent(new WindowMessageEvent(WindowMessageEvent.OPEN, errorMessage));
		}
		
	}
}