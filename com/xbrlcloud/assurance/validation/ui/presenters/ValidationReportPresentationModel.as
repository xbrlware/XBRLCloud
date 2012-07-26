////////////////////////////////////////////////////////////////////////////////
//
//  XBRLCloud
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.validation.ui.presenters
{
	
	import com.xbrlcloud.assurance.networks.vos.ConceptVO;
	import com.xbrlcloud.assurance.networks.vos.NetworkVO;
	import com.xbrlcloud.assurance.shared.ResourceFinder;
	import com.xbrlcloud.assurance.validation.events.SignalSelectedEvent;
	import com.xbrlcloud.assurance.validation.events.ValidationReportDataEvent;
	import com.xbrlcloud.assurance.validation.ui.ValidationReport;
	import com.xbrlcloud.assurance.validation.vos.SignalVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.GroupingField;
	import mx.collections.IHierarchicalCollectionView;
	import mx.collections.IViewCursor;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.events.ListEvent;
	import mx.utils.ObjectUtil;
	
	
	public class ValidationReportPresentationModel extends EventDispatcher
	{
		
		
		private static const SIGNALS_CHANGED:String = "signalsChanged";
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher
		
		[Bindable]
		public var selNetwork:NetworkVO;
		
		
		public function ValidationReportPresentationModel():void
		{

		}
		
		
		/*******************************************************************************************************************
		* Handlers and Dispatchers
		*******************************************************************************************************************/
		
		private var selectedSignal:SignalVO;
		
		public function validationReportClickHandler(e:ListEvent):void
		{
			if(!(e.target.selectedItem is SignalVO) || !SignalVO(e.target.selectedItem).network)return;
			
			selectedSignal = e.target.selectedItem as SignalVO;
			
			dispatcher.dispatchEvent(new SignalSelectedEvent(SignalSelectedEvent.SELECTED, e.target.selectedItem as SignalVO));
		}
		
		
		/**
		* 
		*/
		[Mediate(event="ConceptSelectEvent.CHANGE", properties="concept")]
		public function selectConcept(concept:ConceptVO):void
		{
			// Check weither the concept was selected by a signal to prevent circular events
			if(selectedSignal)
			{
				selectedSignal = null;
				return;
			}
			
			if(concept.signal)
			{
				// Open the three to perform a search
				view.ADGValidationReport.expandAll();
				view.ADGValidationReport.callLater(lazyIndexSelection, [concept]);
			}

		}
		
		
		/**
		 * Called when a network item is selected on the NetworksList U.I
		 * @param network NetworkVO
		 **/
		[Mediate(event="NetworkSelectEvent.CHANGE", properties="network")]
		public function selectNetworkHandler(network:NetworkVO):void
		{
			if(network)
			{
				if(selNetwork != network)
				{
					selNetwork = network;
					if(signals && view.toggleButton.selectedIndex == 0)
					{
						applyFilterBySelectedNetwork();
					}
				}
			}
			else
			{
				selNetwork = null;
				clearNetworkFilter()
			}
		}
		
		
		/**
		 * Called when the checkbox on the validation panel is checked.
		 * It will apply or remove a filter function to the selected network
		 **/
		public function applyFilterBySelectedNetwork():void
		{
			signals.filterFunction = filterSignals;
			signals.refresh();
			view.gc.refresh();
		}
		
		
		public function clearNetworkFilter():void
		{
			signals.filterFunction = null;
			signals.refresh();
			view.gc.refresh();
		}
		
		
		private function lazyIndexSelection(concept:ConceptVO):void
		{
			var cursor:IViewCursor = IHierarchicalCollectionView(view.ADGValidationReport.dataProvider).createCursor(); 
			
			var index:int = 0;
			while(!cursor.afterLast)
			{	
				if(cursor.current is SignalVO)
				{
					if(cursor.current.uid == concept.signal.uid)
					{
						view.ADGValidationReport.validateNow();
						view.ADGValidationReport.selectedItem = cursor.current;
						view.ADGValidationReport.scrollToIndex(index);
						break;
					}
				}
				cursor.moveNext();
				index++;
			}
			
		}
	
		
		/*******************************************************************************************************************
		* Ordering, Formatting and Filter Functions
		*******************************************************************************************************************/
		
		private function severityGroupCompareFunction(itemA:SignalVO, itemB:SignalVO):int
		{
			if(itemA.severity == SignalVO.ERROR && itemB.severity != SignalVO.ERROR)
			{
				return -1;
			}
			if(itemA.severity == SignalVO.ERROR && itemB.severity == SignalVO.ERROR)
			{
				return 0;
			}
			if(itemA.severity != SignalVO.ERROR && itemB.severity == SignalVO.ERROR)
			{
				return 1;
			}
			if(itemA.severity == SignalVO.WARNING && itemB.severity != SignalVO.WARNING)
			{
				return -1;
			}
			if(itemA.severity == SignalVO.WARNING && itemB.severity == SignalVO.WARNING)
			{
				return 0;
			}
			if(itemA.severity != SignalVO.WARNING && itemB.severity == SignalVO.WARNING)
			{
				return 1;
			}
			if(itemA.severity == SignalVO.INCONSISTENCY && itemB.severity != SignalVO.INCONSISTENCY)
			{
				return -1;
			}
			if(itemA.severity == SignalVO.INCONSISTENCY && itemB.severity == SignalVO.INCONSISTENCY)
			{
				return 0;
			}
			if(itemA.severity != SignalVO.INCONSISTENCY && itemB.severity == SignalVO.INCONSISTENCY)
			{
				return 1;
			}
			if(itemA.severity == SignalVO.BEST_PRACTICE && itemB.severity != SignalVO.BEST_PRACTICE)
			{
				return -1;
			}
			if(itemA.severity == SignalVO.BEST_PRACTICE && itemB.severity == SignalVO.BEST_PRACTICE)
			{
				return 0;
			}
			if(itemA.severity != SignalVO.BEST_PRACTICE && itemB.severity == SignalVO.BEST_PRACTICE)
			{
				return 1;
			}
			if(itemA.severity == SignalVO.INFORMATION && itemB.severity != SignalVO.INFORMATION )
			{
				return -1;
			}
			if(itemA.severity == SignalVO.INFORMATION  && itemB.severity == SignalVO.INFORMATION )
			{
				return 0;
			}
			if(itemA.severity != SignalVO.INFORMATION  && itemB.severity == SignalVO.INFORMATION )
			{
				return 1;
			}
			return 0;
		}
		
	
		private function sectionGroupFunction(item:SignalVO, column:GroupingField):String
		{
			return (item.section != "")?item.section:item.qname.split(":")[1];
		}

		
		public function groupLabelFunction(signalGroup:Object, column:AdvancedDataGridColumn):String
		{
			
			if(view.ADGValidationReport.getParentItem(signalGroup))return signalGroup.severity;
				
			numSignals = 0;
			
			var label:String = signalGroup.severity + " (" + getNumSignals(signalGroup) + ")";
			
			return label;
			
		}
		
		private var numSignals:int;
		
		private function getNumSignals(signalGroup:Object):int
		{
			
			if(signalGroup.children)
			{
				var len:int = signalGroup.children.length;
				
				for(var i:int = 0; i < len; i++)
				{
					var child:Object = signalGroup.children[i];
					
					if(child.properties)
					{
						numSignals++
					}
					else
					{
						numSignals = getNumSignals(child);
					}
				}
			}
			return numSignals;
		}
		
		/** 
		* Chooses the properly icon for each signal group
		* @param item Object
		* @param depth 
		* @return an icon which represents the severity of a certain signals group
		*/ 
		public function iconGroupFunction(item:Object, depth:int):Class
		{
			if(!view.ADGValidationReport.getParentItem(item))
			{
				return iconFunction(item);
			}
			return iconGroupFunction(view.ADGValidationReport.getParentItem(item), depth-1);
		}
		
		
		/** 
		* Chooses the properly icon for each signal
		* @param item Object 
		* @return an icon which represents the signal's severity 
		*/ 
		public function iconFunction(item:Object):Class
		{
			switch(item.severity)
			{
				case SignalVO.ERROR:
					return ResourceFinder.validation_report_error_icon;
				break;
				case SignalVO.WARNING:
					return ResourceFinder.validation_report_warning_icon;
				break;
				case SignalVO.INFORMATION:
					return ResourceFinder.validation_report_information_icon;
				break;
				case SignalVO.BEST_PRACTICE:
					return ResourceFinder.validation_report_best_practices_icon;
				break;
				case SignalVO.INCONSISTENCY:
					return ResourceFinder.validation_report_inconsistency_icon;
				break;
				default:
					return ResourceFinder.validation_report_error_icon;
				break;
			}
		}
		
		
		public function compareFunction(signal1:SignalVO, signal2:SignalVO):int
		{
			return (signal1.network && signal2.network)?ObjectUtil.stringCompare(signal1.network.definition, signal2.network.definition):0
		}
		
		
		private function filterSignals(signal:SignalVO):Boolean
		{
			return (signal.network == selNetwork);
		}

		
		/*******************************************************************************************************************
		* Implicit Getters and Setters
		*******************************************************************************************************************/
		
		private var _view:ValidationReport;
		
		public function get view():ValidationReport
		{
			return _view;
		}
		
		
		public function set view(value:ValidationReport):void
		{
			
			if(value != null && value.severityGroup)
			{
				_view = value;
				_view.severityGroup.compareFunction = severityGroupCompareFunction;
				_view.sectionGroup.groupingFunction = sectionGroupFunction;
				_view.sectionGroup.compareFunction  = compareFunction;
				/*_view.sectionGroup.groupingObjectFunction   = sectionGroupFunction2*/
				
				dispatcher.dispatchEvent(new ValidationReportDataEvent(ValidationReportDataEvent.GET_ALL));
			}
		}
		
		
		private var _signals:ArrayCollection;
		
		[Bindable(event="signalsChanged")]
		public function get signals():ArrayCollection
		{
			return _signals;
		}
		
		
		[Mediate(event="SignalsNetworksConnectEvent.CONNECTED", properties="signals")]
		public function setSignals(value:ArrayCollection):void
		{
			if(value)
			{
				_signals = value;
				dispatchEvent(new Event(SIGNALS_CHANGED));
				if(selNetwork)
				{
					signals.filterFunction = filterSignals;
				}
				signals.refresh();
				view.gc.refresh();
			}
		}
		
	}
	
}