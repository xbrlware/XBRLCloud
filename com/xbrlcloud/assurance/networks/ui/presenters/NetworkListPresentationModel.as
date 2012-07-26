////////////////////////////////////////////////////////////////////////////////
//
//  XBRLCloud
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.networks.ui.presenters
{
	
	
	import com.xbrlcloud.assurance.main.http.URLParserManagerEvent;
	import com.xbrlcloud.assurance.networks.events.NetworkSelectEvent;
	import com.xbrlcloud.assurance.networks.ui.NetworkList;
	import com.xbrlcloud.assurance.networks.vos.ConceptVO;
	import com.xbrlcloud.assurance.networks.vos.NetworkVO;
	import com.xbrlcloud.assurance.validation.vos.SignalVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	import spark.events.IndexChangeEvent;

	
	public class NetworkListPresentationModel extends EventDispatcher
	{
		
		
		private static const NETWORKS_CHANGED:String = "networksChanged";
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		
		public function NetworkListPresentationModel()
		{
			_networks = new ArrayCollection();
			addEventListener(NETWORKS_CHANGED, initialization);
		}
		
		/*******************************************************************************************************************
		 * Initialization
		 *******************************************************************************************************************/
		
		/**
		 * Called once when the view is initialized.
		 * This method creates an IViewCursor to perform searches.
		 * It checks the parameters "selected-network" and "selected-concept". 
		 * In case one of these parameters exist, a searching method is invoked to highlight a network
		 **/
		private function initialization(evt:Event):void
		{
			createCursor();
			
			if(selNetworkURI)
			{
				selectNetworkByURI();
			}
			else if(selConceptQname)
			{
				selectNetworkByConceptName();
			}
		}
		
		
		private var cursor:IViewCursor;
		
		private function createCursor():void
		{
			var sort:Sort = new Sort();
			sort.fields = [new SortField(null)];
			
			_networks.sort = sort;
			_networks.refresh();
			
			cursor = _networks.createCursor();
		}

		
		/*******************************************************************************************************************
		* Handlers
		*******************************************************************************************************************/
		
		/**
		 * Called when a network item is selected on the NetworksList U.I
		 * @param e	IndexChangeEvent
		 **/
		public function displayNetwork(e:IndexChangeEvent):void
		{
			dispatcher.dispatchEvent(new NetworkSelectEvent(NetworkSelectEvent.CHANGE, e.target.selectedItem));
		}
		
		
		private var _networks:ArrayCollection;
		
		[Bindable(event="networksChanged")]
		public function get networks():ArrayCollection
		{
			return _networks;
		}
		
		
		[Mediate(event="SignalsNetworksConnectEvent.CONNECTED", properties="networks")]
		public function setNetworks(value:ArrayCollection):void
		{
			_networks.source = value.source;
			dispatchEvent(new Event(NETWORKS_CHANGED));
		}
		
		
		private var selNetworkURI   :String;
		
		private var selConceptQname :String;
		
		/**
		 * Called once when the application is initialized.
		 * This method stores the "selected-network" and "selected-concept" parameters to start up the NetworksList(U.I) highlighted.
		 **/
		[Mediate(event="URLParserManagerEvent.PARSED")]
		public function selectNetworkURI(e:URLParserManagerEvent):void
		{
			selNetworkURI   = e.selNetworkURI;
			selConceptQname = e.selConceptQname;
		}
		
		
		/*******************************************************************************************************************
		 * Searching Methods
		 *******************************************************************************************************************/
		
		/**
		* Perform a search to find a network with a selected signal on the Validation Panel
		* @param signal a signal selected on the Validation Panel 
		**/
		[Mediate(event="SignalSelectedEvent.SELECTED", properties="signal")]
		public function selectNetworkBySignal(signal:SignalVO):void
		{
			if(cursor.findFirst(signal.network))
			{
				view.networkList.selectedItem = cursor.current as NetworkVO;
				view.networkList.ensureIndexIsVisible(cursor.bookmark.getViewIndex());
				
				// Dispatch the IndexChangeEvent to display the networks concepts
				view.networkList.dispatchEvent(new IndexChangeEvent(IndexChangeEvent.CHANGE));
			}
		}
		
		
		/**
		 * Called once in case the "selected-network" parameter has been passed by URL
		 **/
		private function selectNetworkByURI():void
		{
			while(!cursor.afterLast)
			{
				var network:NetworkVO = cursor.current as NetworkVO;
				
				if(network.uri == selNetworkURI)
				{
					selectItemToNetworkList(network);
					break;
				}
				cursor.moveNext();
			}
		}
		
		
		/**
		 * Called once in case the "selected-concept" parameter has been passed and "selected-network" ommited on the URL
		 **/
		private function selectNetworkByConceptName():void
		{
			while(!cursor.afterLast)
			{
				var network:NetworkVO = cursor.current as NetworkVO;
				
				if(network.presentation)
				{
					for each(var presentationConcept:ConceptVO in network.presentation.concepts)
					{
						openConcepts.push(presentationConcept);
					}
					if(scanConcepts())
					{
						selectItemToNetworkList(network);
						break;
					}
				}
				if(network.calculation)
				{
					for each(var calculationConcept:ConceptVO in network.calculation.concepts)
					{
						openConcepts.push(calculationConcept);
					}
					if(scanConcepts())
					{
						selectItemToNetworkList(network);
						break;
					}
				}
				if(network.hypercube)
				{
					for each(var hypercubeConcept:ConceptVO in network.hypercube.concepts)
					{
						openConcepts.push(hypercubeConcept);
					}
					if(scanConcepts())
					{
						selectItemToNetworkList(network);
						break;
					}
				}
				cursor.moveNext();
			}
		}
		
		
		/**
		 * Called once when the application is initialized to highlight a network on the U.I Network List
		 * @param network an item to be selected
		 **/
		private function selectItemToNetworkList(network:NetworkVO):void
		{
			view.networkList.validateNow();
			view.networkList.selectedItem = network;
			view.networkList.ensureIndexIsVisible(cursor.bookmark.getViewIndex());
			view.networkList.dispatchEvent(new IndexChangeEvent(IndexChangeEvent.CHANGE));
			selNetworkURI   = null;
			selConceptQname = null;
		}
		
		
		/* Store the concepts to be scanned */
		private var openConcepts:Vector.<ConceptVO> = new Vector.<ConceptVO>();
		
		/**
		 * Breadth First Search to scan the concepts of a specific view
		 * @return a boolen. If the concept is found this value is true, otherwise false.
		 **/
		private function scanConcepts():Boolean
		{
			
			while(openConcepts.length > 0)
			{
				
				var selConcept:ConceptVO = openConcepts.shift();
				
				if(selConcept.qname == selConceptQname)
				{
					return true;
				}
				
				if(selConcept.concepts)
				{
					for each(var concept:ConceptVO in selConcept.concepts)
					{
						openConcepts.push(concept);
					}
				}
				
			}
			return false;
		}
		
		
		/*******************************************************************************************************************
		* Implicit Getters and Setters
		*******************************************************************************************************************/
		
		private var _view:NetworkList;
		
		public function get view():NetworkList
		{
			return _view;
		}
		
		public function set view(value:NetworkList):void
		{
			_view = value;
		}
		
	}
	
}