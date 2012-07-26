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
	import com.xbrlcloud.assurance.networks.vos.ConceptVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.controls.Alert;
	
	public class NetworkDetailsPresentationModel extends EventDispatcher
	{
		
		
		private static const CONCEPT_SELECT_CHANGED:String = "selectedConceptChanged";
		
		
		public function NetworkDetailsPresentationModel()
		{
			
		}
		
		
		/*******************************************************************************************************************
		* Implicit Getters and Setters
		*******************************************************************************************************************/
		
		private var _selectedConcept:ConceptVO;
		
		[Bindable(event="selectedConceptChanged")]
		public function get selectedConcept():ConceptVO
		{
			return _selectedConcept;
		}
		
		
		[Mediate(event="ConceptSelectEvent.CHANGE", properties="concept")]
		public function selectConcept(concept:ConceptVO):void
		{
			_selectedConcept = concept;
			dispatchEvent(new Event(CONCEPT_SELECT_CHANGED));
		}
		
	}
}