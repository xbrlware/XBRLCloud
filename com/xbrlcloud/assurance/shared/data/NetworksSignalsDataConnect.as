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
	import com.xbrlcloud.assurance.main.components.windowMessage.events.WindowMessageEvent;
	import com.xbrlcloud.assurance.networks.vos.ConceptVO;
	import com.xbrlcloud.assurance.networks.vos.GraphVO;
	import com.xbrlcloud.assurance.networks.vos.NetworkVO;
	import com.xbrlcloud.assurance.validation.vos.PropertyVO;
	import com.xbrlcloud.assurance.validation.vos.SignalVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	[Event(name="networksChanged", type="flash.events.Event")]
	[Event(name="signalsChanged",  type="flash.events.Event")]
	public class NetworksSignalsDataConnect extends EventDispatcher
	{
		
		
		//Constants
		public static const NETWORKS_CHANGED_EVENT:String = "networksChanged";
		
		public static const SIGNALS_CHANGED_EVENT:String  = "signalsChanged";
		
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		
		public function NetworksSignalsDataConnect()
		{
			addEventListener(NETWORKS_CHANGED_EVENT, linkData);
			addEventListener(SIGNALS_CHANGED_EVENT,  linkData);
		}
		
		
		private function linkData(evt:Event):void
		{	
			
			if(!validationURL)
			{
				var signalsNetworksEvent:SignalsNetworksConnectEvent = new SignalsNetworksConnectEvent(SignalsNetworksConnectEvent.CONNECTED);
				signalsNetworksEvent.networks = new ArrayCollection(networks);
				
				dispatcher.dispatchEvent(signalsNetworksEvent);
			}
			if(networks && signals)
			{
				linkSignalsToNetworks();
			}
			
		}
		
		
		/*******************************************************************************************************************
		 * Link Signals to Networks
		 *******************************************************************************************************************/
		
		private function linkSignalsToNetworks():void
		{
			
			var signalLen:int   = signals.length;
			var networksLen:int = networks.length;
			
			for(var i:int = 0; i < signalLen; i++)
			{
				
				var signal:SignalVO = signals[i] as SignalVO;
				
				// Check whether the signal is orphan
				if(signal.properties.length == 0)
					continue
				
				for(var j:int = 0; j < networksLen; j++)
				{
					
					var network:NetworkVO = networks[j] as NetworkVO;
					
					if(signal.baseSet)
					{
						if(signal.baseSet.extendedLinkRoleUri == network.uri)
						{
							// Linking Signals and Network to each other
							network.signals.push(signal);
							signal.network = network;
						}
						
					}
					// Linking signals to concepts
					linkSignalsToConcepts(network, signal);
				}
			}
			
			var signalsNetworksEvent:SignalsNetworksConnectEvent = new SignalsNetworksConnectEvent(SignalsNetworksConnectEvent.CONNECTED);
			signalsNetworksEvent.networks = new ArrayCollection(networks);
			signalsNetworksEvent.signals  = new ArrayCollection(signals);
				
			dispatcher.dispatchEvent(signalsNetworksEvent);
				
		}
		
		
		/*******************************************************************************************************************
		*  Link Signals to Concepts
		*******************************************************************************************************************/

		public function linkSignalsToConcepts(network:NetworkVO, signal:SignalVO):void
		{

			var signalProperties:Vector.<PropertyVO> = signal.properties;
			
			if(signalProperties.length == 0)
			{
				return;
			}
			
			var presentation:GraphVO = network.presentation;
			var calculation:GraphVO  = network.calculation;
			var hypercube:GraphVO    = network.hypercube;
			
			signalProperties.forEach(
				function(property:PropertyVO, index:int, properties:Vector.<PropertyVO>):void
				{
					if(property.elementGroup)
					{
						if(presentation)
						{
							for each(var presentationConcept:ConceptVO in presentation.concepts)
							{
								openConcepts.push(presentationConcept);
							}
							if(openConcepts.length > 0)
							{
								scanConceptsByElementGroup(signal, property, network);
							}
						}
						
						if(calculation)
						{
							for each(var calculationConcept:ConceptVO in calculation.concepts)
							{
								openConcepts.push(calculationConcept);
							}
							if(openConcepts.length > 0)
							{
								scanConceptsByElementGroup(signal, property, network);
							}
						}
						
						if(hypercube)
						{
							for each(var hypercubeConcept:ConceptVO in hypercube.concepts)
							{
								openConcepts.push(hypercubeConcept);
							}
							if(openConcepts.length > 0)
							{
								scanConceptsByElementGroup(signal, property, network);
							}
						}
					}
					else if(property.arcRelationship)
					{	
						
						var arcConcept:GraphVO;
						
						if(signal.baseSet.arcQname == "link:calculationArc" && calculation)
						{
							arcConcept = calculation;
						}
						else if(signal.baseSet.arcQname == "link:definitionArc" && hypercube)
						{
							arcConcept = hypercube;
						}
						else if(signal.baseSet.arcQname  == "link:presentationArc" && presentation)
						{
							arcConcept = presentation;
						}
						
						if(arcConcept)
						{
							for each(var concept:ConceptVO in arcConcept.concepts)
							{
								openConcepts.push(concept);
							}
							scanConceptsByArcRelationship(signal, property, network);
						}
					}
				})
			
			network.connected = true;
			
			dispatcher.dispatchEvent(new SignalsConceptsConnectEvent(SignalsConceptsConnectEvent.CONNECTED, network));
			
		}
		
		
		/*******************************************************************************************************************
		 * Scan Concepts by arcRelationship
		 *******************************************************************************************************************/
		
		private function scanConceptsByArcRelationship(signal:SignalVO, property:PropertyVO, network:NetworkVO):void
		{
			while(openConcepts.length > 0)
			{
				var selConcept:ConceptVO = openConcepts.shift();
				
				if(selConcept.qname == property.arcRelationship.from.concept)
				{
					if(selConcept.concepts)
					{
						for each(var conceptSelected:ConceptVO in selConcept.concepts)
						{
							if(conceptSelected.qname == property.arcRelationship.to.concept)
							{
								network.signals.push(signal);
								selConcept.signal      = signal;
								conceptSelected.signal = signal;
							}
							openConcepts.push(conceptSelected);
						}
						continue;
					}
				}
				
				if(selConcept.concepts)
				{
					for each(var concept:ConceptVO in selConcept.concepts)
					{
						openConcepts.push(concept);
					}
				}
			}
		}
		
		/*******************************************************************************************************************
		* Scan Concepts by Element Group - Breadth First Search
		*******************************************************************************************************************/
		
		private var openConcepts:Vector.<ConceptVO> = new Vector.<ConceptVO>();
		
		private function scanConceptsByElementGroup(signal:SignalVO, property:PropertyVO, network:NetworkVO):void
		{
	
			while(openConcepts.length > 0)
			{
				var selConcept:ConceptVO = openConcepts.shift();
				
				if(selConcept.qname == property.elementGroup.concept)
				{
					
					if(signal.baseSet)
					{
						if(signal.baseSet.extendedLinkRoleUri == network.uri)
						{
							// Linking Concepts to Signals
							network.signals.push(signal);
							selConcept.signal = signal;
						}
					}
					else
					{
						if(selConcept.signal == null)
						{
							// Linking Concepts to Signals
							network.signals.push(signal);
							selConcept.signal = signal;
						}
						// Linking Signal to Networks by Concepts
						if(!signal.network)
						{
							signal.network = network;
						}
					}
					
				}
				
				if(selConcept.concepts)
				{
					for each(var concept:ConceptVO in selConcept.concepts)
					{
						openConcepts.push(concept);
					}
				}
			}
		}
		
		
		/*******************************************************************************************************************
		* Handlers
		*******************************************************************************************************************/
		
		private var validationURL:String;
		
		/**
		 * Called once when the application is initialized.
		 * It checks if the validation-url parameter exists to determine weither Validation Panel will be visible or not.
		 **/
		[Mediate(event="URLParserManagerEvent.PARSED", properties="validationURL")]
		public function enableValidationPanel(validationURL:String):void
		{
			this.validationURL = validationURL;
		}
		
		
		/*******************************************************************************************************************
		* Implicit Getters and Setters
		*******************************************************************************************************************/
		
		private var networks:Array;

		public function connectNetworks(value:Array):void
		{
			if (networks != value && value.length > 0)
			{
				networks = value;
				dispatchEvent(new Event(NETWORKS_CHANGED_EVENT));
			}
			else
			{
				var errorMessage:String  = "The Network data seems to be null or empty. Please, contact the administrators";
				dispatcher.dispatchEvent(new WindowMessageEvent(WindowMessageEvent.OPEN, errorMessage));
			}
		}
		
		
		private var signals:Array;
		
		public function connectSignals(value:Array):void
		{
			if (signals != value && value.length > 0)
			{
				signals = value;
				dispatchEvent(new Event(SIGNALS_CHANGED_EVENT));
			}
			else
			{
                // CB:  Okay to have no signals!
                // TODO:  If I comment the following lines, system appears to "hang"
                var errorMessage:String  = "The Signals data seems to be null or empty. Please, contact the administrators";
                dispatcher.dispatchEvent(new WindowMessageEvent(WindowMessageEvent.OPEN, errorMessage));
			}
		}
		
	}
}