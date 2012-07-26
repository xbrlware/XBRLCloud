////////////////////////////////////////////////////////////////////////////////
//
//  XBRLCloud
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.validation.parser
{
	
	import com.xbrlcloud.assurance.shared.parser.IXMLResourceParser;
	import com.xbrlcloud.assurance.validation.vos.ArcRelationshipVO;
	import com.xbrlcloud.assurance.validation.vos.BaseSetVO;
	import com.xbrlcloud.assurance.validation.vos.ElementGroupVO;
	import com.xbrlcloud.assurance.validation.vos.PropertyVO;
	import com.xbrlcloud.assurance.validation.vos.SignalVO;
	
	import flash.events.EventDispatcher;
	
	public class ValidationReportXMLParser extends EventDispatcher implements IXMLResourceParser
	{
		
		
		private var signals:Array
		
		
		public function ValidationReportXMLParser()
		{
			signals = new Array();
		}

		
		public function parse(data:XML):Array
		{
			var xmlData:XMLList = data..signal;
			
			for each(var signal:XML in xmlData)
			{
				var signalVO:SignalVO = new SignalVO();
				signalVO.heading      = signal["heading"];
				signalVO.qname        = signal["qname"];
				signalVO.uri          = signal["uri"];
				signalVO.severity     = signal["severity"];
				signalVO.message      = signal["message"];
				signalVO.lineNumber   = signal["line-number"];
				signalVO.columnNumber = signal["column-number"];
				signalVO.message      = signal["message"];
				signalVO.section      = signal["section"];
				
				if(signal["base-set"].length() > 0)
				{
					signalVO.baseSet = parseBaseSet(signal["base-set"][0]);
				}
				
				if(signal.properties)
				{
					var properties:XMLList = signal.properties.property;
					for each(var property:XML in properties)
					{
						signalVO.properties.push(parseProperty(property));
					}
				}
				signals.push(signalVO);
			}
			
			return signals;
			
		}
		
		
		private function parseBaseSet(baseSet:XML):BaseSetVO
		{
			var baseSetVO:BaseSetVO = new BaseSetVO();
			baseSetVO.description         = baseSet["description"];
			baseSetVO.extendedLinkRoleUri = baseSet["extended-link-role-uri"];
			baseSetVO.arcRoleUri          = baseSet["arcrole-uri"];
			baseSetVO.arcQname            = baseSet["arc-qname"];
			
			return baseSetVO;
		}
		
		
		private function parseProperty(property:XML):PropertyVO
		{
			var propertyVO:PropertyVO = new PropertyVO();
			propertyVO.propertyName   = property["property-name"];
			
			
			
			if(property["arc-relationship"].length() > 0)
			{
				propertyVO.arcRelationship = parseArcRelationship(property["arc-relationship"][0]);
				return propertyVO;
			}
			else
			{
				propertyVO.elementGroup = parseElementGroup(property);
				return propertyVO;
			}
		}
	
		
		private function parseElementGroup(eGroup:XML):ElementGroupVO
		{
			var elementGroup:ElementGroupVO = new ElementGroupVO();
			elementGroup.id            = eGroup["id"];
			elementGroup.xpath         = eGroup["xpath"];
			elementGroup.label         = eGroup["label"];
			elementGroup.concept       = eGroup["concept"];
			elementGroup.lineNumber    = eGroup["line-number"];
			elementGroup.documentUri   = eGroup["document-uri"];
			elementGroup.propertyName  = eGroup["property-name"];
			elementGroup.documentValue = eGroup["document-value"];
			
			return  elementGroup
		}
	
	
		private function parseArcRelationship(arcRelationship:XML):ArcRelationshipVO
		{
			var arcRelationshipVO:ArcRelationshipVO = new ArcRelationshipVO();
			
			var children:XMLList = arcRelationship.children();
			
			for each(var node:XML in children)
			{
				switch(node.localName())
				{
					case "from":
						arcRelationshipVO.from        = parseElementGroup(node);
					break;
					case "to":
						arcRelationshipVO.to          = parseElementGroup(node);
					break;
					case "arc":
						arcRelationshipVO.arc         = parseElementGroup(node);
					break;
					case "from-locator":
						arcRelationshipVO.fromLocator = parseElementGroup(node);
					break;
					default:
						arcRelationshipVO.toLocator   = parseElementGroup(node);
					break;
				}
			}
			return arcRelationshipVO;
		}
		
	}
	
}