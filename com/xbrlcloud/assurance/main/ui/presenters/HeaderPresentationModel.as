////////////////////////////////////////////////////////////////////////////////
//
//  XBRLCloud
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.main.ui.presenters
{
	import com.xbrlcloud.assurance.main.components.windowURLExporter.events.WindowURLExportEvent;
	import com.xbrlcloud.assurance.main.http.URLParserManager;
	import com.xbrlcloud.assurance.shared.ResourceFinder;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	public class HeaderPresentationModel
	{

		[Bindable]
		public var menuCollection:ArrayCollection;
		
		[Inject]
		public var urlParserManager:URLParserManager
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		public function HeaderPresentationModel()
		{
			
			/*menuCollection = new ArrayCollection([
				{label:"Taxonomy",     icon:ResourceFinder.taxonomy_icon},
				{label:"Calculations", icon:ResourceFinder.calculation_icon},
				{label:"Forms",        icon:ResourceFinder.forms_icon}
			]);*/
			menuCollection = new ArrayCollection([
				{label:"Taxonomy",     icon:ResourceFinder.taxonomy_icon}
			]);
		}
		
		
		public function exportButtonHandler():void
		{
			
			var exportEvt:WindowURLExportEvent = new WindowURLExportEvent(WindowURLExportEvent.OPEN, urlParserManager.exportURL());
			
			dispatcher.dispatchEvent(exportEvt);

		}
		
	}
	
}