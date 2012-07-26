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
	
	import com.xbrlcloud.assurance.main.components.windowMessage.events.WindowMessageEvent;
	import com.xbrlcloud.assurance.networks.vos.ConceptVO;
	import com.xbrlcloud.assurance.networks.vos.NetworkVO;
	
	import flash.events.IEventDispatcher;
	import flash.external.ExternalInterface;
	
	import mx.utils.UIDUtil;
	
	
	public class URLParserManager
	{
		
		
		[Dispatcher]
		public var dispatcher     :IEventDispatcher;
		
		public var selNetwork     :NetworkVO;
		
		public var selConcept     :ConceptVO;
		
		public var headerTitle    :String;
		
		
		private var URL           :String;
		
		private var URLDomain     :String;
		
		private var networksURL   :String;
		
		private var validationURL :String;
		
		private var selNetworkURI :String;
		
		private var selConceptURI :String;
		
		
		public function URLParserManager()
		{
			URL = ExternalInterface.call('eval','document.location.href');
		}
		
		
		public function parse():void
		{
			
			var errorMessage:String;
			
			try
			{
				URLDomain = URL.split("?")[0];
			}
			catch(e:Error)
			{
				// Exception
			}
			
			
			try
			{
<<<<<<< .mine
				networksURL = URL.match(/networks=(.*?)media=xml/i)[1] + "media=xml";
				//networksURL = URL.match(/networks=(.*?).xml/i)[1] + ".xml";
=======
				//networksURL = URL.match(/networks=(.*?)media=xml/i)[1] + "media=xml";
				networksURL = URL.match(/networks=(.*)/i)[1];
                networksURL = networksURL.replace(/.validation=.*/,"");
                networksURL = networksURL.replace(/.networks=.*/,"");
                networksURL = networksURL.replace(/.selected-network=.*/,"");
                networksURL = networksURL.replace(/.selected-concept=.*/,"");
                networksURL = networksURL.replace(/.header-title=.*/,"");
>>>>>>> .r444
			}
			catch(e:Error)
			{
				errorMessage = "The networks URL is empty or incorrect. Please choose another one or contact the administrators";
				dispatcher.dispatchEvent(new WindowMessageEvent(WindowMessageEvent.OPEN, errorMessage));
			}
			
			
			if(URL.match(/validation=(.*?)media=xml/i) != null)
			{
				validationURL = URL.match(/validation=(.*?)media=xml/i)[1] + "media=xml";
			}
			
			
<<<<<<< .mine
			/*if(URL.match(/validation=(.*?).xml/i))
=======
			if(URL.match(/validation=(.*)/i))
>>>>>>> .r444
			{
				validationURL = URL.match(/validation=(.*)/i)[1];
                validationURL = validationURL.replace(/.validation=.*/g, "");
                validationURL = validationURL.replace(/.networks=.*/g, "");
                validationURL = validationURL.replace(/.selected-network=.*/g, "");
                validationURL = validationURL.replace(/.selected-concept=.*/g, "");
                validationURL = validationURL.replace(/.header-title=.*/g, "");
			}*/

			
			if(URL.match(/selected-network=(.*?)(\&|\z)/i) != null)
			{
				selNetworkURI = URL.match(/selected-network=(.*?)(\&|\z)/i)[1];
                selNetworkURI = selNetworkURI.replace(/.validation=.*/g, "");
                selNetworkURI = selNetworkURI.replace(/.networks=.*/g, "");
                selNetworkURI = selNetworkURI.replace(/.selected-network=.*/g, "");
                selNetworkURI = selNetworkURI.replace(/.selected-concept=.*/g, "");
                selNetworkURI = selNetworkURI.replace(/.header-title=.*/g, "");
			}

			
			if(URL.match(/selected-concept=(.*?)(\&|\z)/i) != null)
			{
				selConceptURI = URL.match(/selected-concept=(.*?)(\&|\z)/i)[1];
                selConceptURI = selConceptURI.replace(/.validation=.*/g, "");
                selConceptURI = selConceptURI.replace(/.networks=.*/g, "");
                selConceptURI = selConceptURI.replace(/.selected-network=.*/g, "");
                selConceptURI = selConceptURI.replace(/.selected-concept=.*/g, "");
                selConceptURI = selConceptURI.replace(/.header-title=.*/g, "");
			}
			
			
			if(URL.match(/header-title=(.*?)(\&|\z)/i) != null)
			{
				headerTitle = URL.match(/header-title=(.*?)(\&|\z)/i)[1];
                headerTitle = headerTitle.replace(/.validation=.*/g, "");
                headerTitle = headerTitle.replace(/.networks=.*/g, "");
                headerTitle = headerTitle.replace(/.selected-network=.*/g, "");
                headerTitle = headerTitle.replace(/.selected-concept=.*/g, "");
                headerTitle = headerTitle.replace(/.header-title=.*/g, "");
			}
			
			
			var URLEvent:URLParserManagerEvent = new URLParserManagerEvent(URLParserManagerEvent.PARSED);
			URLEvent.URL                       = URL;
			URLEvent.URLDomain                 = URLDomain;
			URLEvent.networksURL               = networksURL;
			URLEvent.validationURL             = validationURL;
			URLEvent.selNetworkURI             = selNetworkURI;
			URLEvent.selConceptQname           = selConceptURI;
			URLEvent.headerTitle               = headerTitle;
			
			dispatcher.dispatchEvent(URLEvent);
			
		}
		
		/**
		 * Called when a network item is selected on the NetworksList U.I
		 * @param network NetworkVO
		 **/
		[Mediate(event="NetworkSelectEvent.CHANGE", properties="network")]
		public function selectNetworkHandler(network:NetworkVO):void
		{
			selNetwork = network;
			selConcept = null;
		}
		
		/**
		 * Called when a concept item is selected on the Concept Tree U.I
		 * @param concept ConceptVO
		 **/
		[Mediate(event="ConceptSelectEvent.CHANGE", properties="concept")]
		public function selectConceptHandler(concept:ConceptVO):void
		{
			selConcept = concept;
		}
		
		/**
		 * Export the URL according to the selected network and concept
		 * @return a string that corresponds the full URL and the selected network and concept 
		 */
		public function exportURL():String
		{
			
			var URL:String = URLDomain + "?" + "networks=" + networksURL;
			
			if(validationURL)
				URL += "&validation=" + validationURL;
			
			if(selNetwork)
				URL += "&selected-network=" + selNetwork.uri;
			 
			if(selConcept)
				URL += "&selected-concept=" + selConcept.qname;
			
			return URL;
		}
		
	}
	
}