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

	import com.xbrlcloud.assurance.networks.vos.ConceptVO;
	import com.xbrlcloud.assurance.networks.vos.GraphVO;
	import com.xbrlcloud.assurance.networks.vos.NetworkVO;
	import com.xbrlcloud.assurance.shared.parser.IXMLResourceParser;
	
	import mx.collections.ArrayCollection;
	
	public class NetworksXMLParser implements IXMLResourceParser
	{
		
		private var networks:Vector.<Object>;
		
		public function NetworksXMLParser()
		{
			networks = new Vector.<Object>();
		}
		
		
		public function parse(data:XML):Vector.<Object>
		{
			return parseNetworkGroups(data..group);
		}
		
		
		private function parseNetworkGroups(groups:XMLList):Vector.<Object>
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
				graphVO.concepts = new ArrayCollection();
				
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
			conceptVO.concepts      = new ArrayCollection();
			
			var props:XMLList = concept.children();
			for each(var prop:XML in props)
			{
				
				if(prop.name().toString().toLowerCase() == "concept")
				{
					conceptVO.concepts.addItem(parseConcept(prop));
				}
			}
			
			// Ensure that empty concepts remain null
			if(conceptVO.concepts.length == 0)
				conceptVO.concepts = null;
			
			return conceptVO;
			
		}
	}
}