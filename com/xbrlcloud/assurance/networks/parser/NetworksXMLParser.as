////////////////////////////////////////////////////////////////////////////////
//
//  XBRLCloud
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.networks.parser
{

	
	import com.xbrlcloud.assurance.main.components.windowMessage.events.WindowMessageEvent;
	import com.xbrlcloud.assurance.networks.vos.ConceptVO;
	import com.xbrlcloud.assurance.networks.vos.GraphVO;
	import com.xbrlcloud.assurance.networks.vos.NetworkVO;
	import com.xbrlcloud.assurance.shared.parser.IXMLResourceParser;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	
	public class NetworksXMLParser implements IXMLResourceParser
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		private var networks:Array
		
		
		public function NetworksXMLParser()
		{
			networks = new Array();
		}
		
		
		public function parse(data:XML):Array
		{
			
			var networks:Array;
			
			try
			{
				networks = parseNetworkGroups(data..group);
			}
			catch(e:Error)
			{
				var errorMessage:String  = "The Networks data seems to be corrupted or invalid. Please, contact the administrators";
				dispatcher.dispatchEvent(new WindowMessageEvent(WindowMessageEvent.OPEN, errorMessage));
			}
			return networks;
		}
		
		
		private function parseNetworkGroups(groups:XMLList):Array
		{

			for each(var item:XML in groups)
			{
				var networkVO:NetworkVO = new NetworkVO();
				networkVO.uri           = item.uri;
				networkVO.definition    = item.definition;
				
				if(item.graph.(@type=="presentation-network").length() > 0)
				{
					networkVO.presentation = parseGraph(item.graph.(@type=="presentation-network")[0]);
				}
				
				if(item.graph.(@type=="calculation-network").length() > 0)
				{
					networkVO.calculation = parseGraph(item.graph.(@type=="calculation-network")[0]);
				}
				
				if(item.graph.(@type=="hypercube-hierarchy").length() > 0)
				{
					networkVO.hypercube = parseGraph(item.graph.(@type=="hypercube-hierarchy")[0]);
				}
				
				networks.push(networkVO);
			}
			
			return networks;
			
		}
		
		
		private function parseGraph(graph:XML):GraphVO
		{
			
			if(graph.children().length() > 0)
			{
				
				var graphVO:GraphVO = new GraphVO();
				graphVO.concepts = new ArrayCollection()
				
				var concepts:XMLList = graph.children();
				for each(var concept:XML in concepts)
				{
					graphVO.concepts.addItem(parseConcept(concept));
				}
				
				return graphVO;
				
			}
			
			return null;
			
		}

		
		private function parseConcept(concept:XML):ConceptVO
		{
			
			var conceptVO:ConceptVO = new ConceptVO();
			conceptVO.qname         = concept["qname"];
			conceptVO.period        = concept["period-type"];
			conceptVO.depth         = concept["depth"];
			conceptVO.label         = concept["label"];
			conceptVO.parent        = concept["parent-concept"]
			conceptVO.documentation = concept["documentation"];
			conceptVO.isAbstract    = Boolean(concept["is-abstract"] == "true");
			conceptVO.isExtension   = Boolean(concept["is-extension"] == "true");
			conceptVO.isNegated     = Boolean(concept["label-role"].toLowerCase().search("negated") != -1);
			conceptVO.isTotal       = Boolean(concept["label-role"].toLowerCase().search("total") != -1);
			conceptVO.concepts      = new Array();
			
			var props:XMLList = concept.children();
			for each(var prop:XML in props)
			{
				if(prop.name().toString().toLowerCase() == "concept")
				{
					conceptVO.concepts.push(parseConcept(prop));
				}
			}
			
			// Ensure that empty concepts remain null
			if(conceptVO.concepts.length == 0)
				conceptVO.concepts = null;
			
			return conceptVO;
			
		}
		
		
	}
	
	
}