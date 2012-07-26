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
	
	
	import com.xbrlcloud.assurance.networks.events.ConceptSelectEvent;
	import com.xbrlcloud.assurance.networks.ui.NetworkAbstractConcept;
	import com.xbrlcloud.assurance.networks.vos.ConceptVO;
	import com.xbrlcloud.assurance.shared.ResourceFinder;
	import com.xbrlcloud.assurance.validation.vos.SignalVO;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.events.ListEvent;
	
	
	public class NetworkAbstractConceptPresentationModel extends EventDispatcher
	{
		
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		
		public function NetworkAbstractConceptPresentationModel()
		{
			// Contructor
		}
		
		
		public function iconFunction(concept:ConceptVO):Class
		{
			
			var iconClass:Class;
			
			if(!concept.signal)
			{
				//return (!concept.concepts)?ResourceFinder.defaultLeafIcon:ResourceFinder.folderClosedIcon;
				//return ResourceFinder.defaultLeafIcon;
				if(concept.isExtension)
				{
					iconClass = (concept.documentation)?ResourceFinder.concept_extension_details_icon:ResourceFinder.concept_extension_icon;
				}
				else
				{
					iconClass = ResourceFinder.defaultLeafIcon;
				}
				return iconClass;
			}
			
			
			
			switch(concept.signal.severity)
			{
				case SignalVO.ERROR:
					if(concept.isExtension)
					{
						iconClass = (concept.documentation)?ResourceFinder.concept_error_extension_details_icon:ResourceFinder.concept_error_extension_icon;
					}
					else
					{
						iconClass = (concept.documentation)?ResourceFinder.concept_error_details_icon:ResourceFinder.concept_error_icon;
					}
				break;
				case SignalVO.WARNING:
					if(concept.isExtension)
					{
						iconClass = (concept.documentation)?ResourceFinder.concept_warning_extension_details_icon:ResourceFinder.concept_warning_extension_icon;
					}
					else
					{
						iconClass = (concept.documentation)?ResourceFinder.concept_warning_details_icon:ResourceFinder.concept_warning_icon;
					}
				break;
				case SignalVO.INFORMATION:
					if(concept.isExtension)
					{
						iconClass = (concept.documentation)?ResourceFinder.concept_information_extension_details_icon:ResourceFinder.concept_information_extension_icon;
					}
					else
					{
						iconClass = (concept.documentation)?ResourceFinder.concept_information_details_icon:ResourceFinder.concept_information_icon;
					}
				break;
				case SignalVO.BEST_PRACTICE:
					if(concept.isExtension)
					{
						iconClass = (concept.documentation)?ResourceFinder.concept_best_practice_extension_details_icon:ResourceFinder.concept_best_practice_extension_icon;
					}
					else
					{
						iconClass = (concept.documentation)?ResourceFinder.concept_best_practice_details_icon:ResourceFinder.concept_best_practice_icon;
					}
				break;
				case SignalVO.INCONSISTENCY:
					if(concept.isExtension)
					{
						iconClass = (concept.documentation)?ResourceFinder.concept_inconsistency_extension_details_icon:ResourceFinder.concept_inconsistency_extension_icon;
					}
					else
					{
						iconClass = (concept.documentation)?ResourceFinder.concept_inconsistency_details_icon:ResourceFinder.concept_inconsistency_icon;
					}
				break;
				default:
					iconClass = ResourceFinder.concept_error_icon;
				break;
			}
			return iconClass;
		}
		
		/**
		* Format the labels of abstract concepts
		*/
		public function labelFunction(concept:ConceptVO, column:AdvancedDataGridColumn):Object
		{
			
			var styleObj:Object = {};
			
			if(concept.isAbstract)
			{
				styleObj["fontStyle"] = "italic";
			}
			if(concept.isTotal)
			{
				styleObj["fontWeight"] = "bold";
				
			}
			if(concept.isNegated)
			{
				styleObj["color"] = "#D70000";
			}
			
			return styleObj;
			
		}
		
		
		/*******************************************************************************************************************
		 * Handlers
		 *******************************************************************************************************************/
		
		public function conceptChangeHandler(evt:ListEvent):void
		{
			dispatcher.dispatchEvent(new ConceptSelectEvent(ConceptSelectEvent.CHANGE, evt.target.selectedItem as ConceptVO));
		}
		
		
		/*******************************************************************************************************************
		* Implicit Getters and Setters
		*******************************************************************************************************************/
		
		private var _view:NetworkAbstractConcept;
		
		public function get view():NetworkAbstractConcept
		{
			return _view;
		}
		
		public function set view(value:NetworkAbstractConcept):void
		{
			_view = value;
		}

	}
}