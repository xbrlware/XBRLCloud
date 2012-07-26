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
	
	
	import com.xbrlcloud.assurance.networks.ui.NetworkAbstractConcept;
	import com.xbrlcloud.assurance.networks.ui.NetworkConcepts;
	import com.xbrlcloud.assurance.networks.vos.NetworkVO;
	import com.xbrlcloud.assurance.validation.vos.SignalVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.IHierarchicalCollectionView;
	import mx.collections.IViewCursor;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	
	import spark.components.ButtonBarButton;
	
	
	public class NetworkConceptsPresentationModel extends EventDispatcher
	{
		
		
		// Constants --------------------------------------------------------------------------------------------------------
		
		public static const VIEW_CHANGED             :String = "viewChanged";
		
		public static const SELECTED_NETWORK_CHANGED :String = "selectedNetworkChanged";
		
		
		// Global Event Dispatcher ------------------------------------------------------------------------------------------
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		
		public function NetworkConceptsPresentationModel()
		{
			addEventListener(SELECTED_NETWORK_CHANGED, selectedNetworkChangeHandler );
		}
		
		
		/*******************************************************************************************************************
		* Implicit Getters and Setters
		*******************************************************************************************************************/
		
		private var _view:NetworkConcepts;
		
		[Bindable(event="viewChanged")]
		public function get view():NetworkConcepts
		{
			return _view;
		}
		
		
		public function set view(value:NetworkConcepts):void
		{
			_view = value;
			dispatchEvent(new Event(VIEW_CHANGED));
		}
		
		
		private var _selectedNetwork:NetworkVO;
		
		[Bindable(event="selectedNetworkChanged")]
		public function get selectedNetwork():NetworkVO
		{
			return _selectedNetwork;
		}
		
		
		/*******************************************************************************************************************
		* Handlers
		*******************************************************************************************************************/
		
		[Mediate(event="NetworkSelectEvent.CHANGE", properties="network")]
		public function selectNetwork(network:NetworkVO):void
		{
			_selectedNetwork = network;
			dispatchEvent(new Event(SELECTED_NETWORK_CHANGED));
		}
		
		
		private var selSignal:SignalVO;
		
		[Mediate(event="SignalSelectedEvent.SELECTED", properties="signal")]
		public function selectSignal(signal:SignalVO):void
		{
			selSignal = signal
		}
		
		
		private var selConceptQname:String;
		
		[Mediate(event="URLParserManagerEvent.PARSED", properties="selConceptQname")]
		public function selectConceptQName(qName:String):void
		{
			this.selConceptQname = qName;
		}
		
		private function selectedNetworkChangeHandler(e:Event):void
		{
			if(selectedNetwork)
			{
				updateTabsModel();
			}
		}
		
		
		/*******************************************************************************************************************
		* U.I Methods
		*******************************************************************************************************************/

		/**
		* Create the tabs view according with the selected Network
		**/
		private function updateTabsModel():void
		{
			
			var len:int = view.conceptsNav.dataProvider.length;		
			
			while(len > 2)
			{
				view.conceptsNavContent.removeItemAt(len-1);
				len--;
			}
			
			if(selectedNetwork.hypercube)
			{
				var conceptsNum:int = selectedNetwork.hypercube.concepts.length;
				
				for(var w:int = 0; w < conceptsNum; w++)
				{
					var abstractConcept:NetworkAbstractConcept = new NetworkAbstractConcept();
					abstractConcept.label    = selectedNetwork.hypercube.concepts[w].label;
					abstractConcept.concepts = selectedNetwork.hypercube.concepts;
					abstractConcept.addEventListener(FlexEvent.SHOW, showConceptViewHandler);
					view.conceptsNavContent.addChild(abstractConcept);
				}
			}
			
			view.conceptsNavContent.callLater(lazyButtonsInitialization);
			
		}
		
		/**
		* Add a handler to concept views
		**/
		public function showConceptViewHandler(e:FlexEvent = null):void
		{
			if(selSignal)
			{
				scanConceptsViewByParameter("signal", selSignal);
			}
			else if(selConceptQname)
			{
				scanConceptsViewByParameter("qname", selConceptQname);
			}
		}
		
		/**
		 * 
		 **/
		private function lazyButtonsInitialization():void
		{
			
			var presentationButton:ButtonBarButton = view.conceptsNav.dataGroup.getElementAt(0) as ButtonBarButton;
			
			var calculationButton :ButtonBarButton = view.conceptsNav.dataGroup.getElementAt(1) as ButtonBarButton;
			
			if(presentationButton != null)
				presentationButton.enabled = (selectedNetwork.presentation != null);
			
			if(presentationButton != null)
				calculationButton.enabled  = (selectedNetwork.calculation  != null);
			
			if(presentationButton != null && presentationButton != null)
			{
				view.conceptsNav.selectedIndex = view.conceptsNavContent.selectedIndex = (presentationButton.enabled)?0:(calculationButton.enabled)?1:2;
			}

			showConceptViewHandler();
			
		}
		
		
		public function scanConceptsViewByParameter(param:String, target:*):void
		{
			
			if(!target)return
			
			if(!findConceptByParameter(param, target))
			{
				
				var index   :int = view.conceptsNavContent.selectedIndex;
				
				var length  :int = view.conceptsNavContent.length;
				
				if(index == length - 1)
				{
					selSignal       = null;
					selConceptQname = null;
					view.conceptsNav.selectedIndex = view.conceptsNavContent.selectedIndex = 0;
				}
					
				while(index < length - 1)
				{
					index++;
					
					var buttonBar:ButtonBarButton = view.conceptsNav.dataGroup.getElementAt(index) as ButtonBarButton;
					
					if(buttonBar.enabled)
					{
						view.conceptsNav.selectedIndex = view.conceptsNavContent.selectedIndex = index;
						view.conceptsNav.dispatchEvent(new Event(Event.CHANGE));
						break;
					}
				}
			}
		}
		
		
		private function findConceptByParameter(param:String, target:*):Boolean
		{
			
			var abstractConcept:NetworkAbstractConcept = view.conceptsNavContent.selectedChild as NetworkAbstractConcept;
			
			var cursor:IViewCursor = IHierarchicalCollectionView(abstractConcept.dgConcepts.dataProvider).createCursor(); 
			
			var index:int = 0;
			while(!cursor.afterLast)
			{	
				if(cursor.current[param] == target)
				{
					abstractConcept.dgConcepts.selectedIndex = index;
					abstractConcept.dgConcepts.scrollToIndex(index);
					abstractConcept.dgConcepts.dispatchEvent(new ListEvent(ListEvent.CHANGE));
					if(param == "signal")
						selSignal = null
					else
						selConceptQname = null;
					return true;
				}
				cursor.moveNext();
				index++;
			}
			return false;
		}
		
	}
		
}