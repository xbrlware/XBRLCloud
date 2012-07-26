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
	
	import com.xbrlcloud.assurance.main.ui.views.Content;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class ContentPresentationModel extends EventDispatcher
	{
		
		[Bindable]
		public var contentMode:String = FULL_MODE;
		
		public var _view:Content;
		
		
		public static const FULL_MODE:String     = "fullMode";
		
		public static const STANDARD_MODE:String = "standardMode";
		
		
		public function set view(value:Content):void
		{
			_view = value;
		}
		
		
		/**
		 * Called once when the application is initialized.
		 * It checks if the validation-url parameter exists to determine weither Validation Panel will be visible or not.
		 **/
		[Mediate(event="URLParserManagerEvent.PARSED", properties="validationURL")]
		public function enableValidationPanel(validationURL:String):void
		{
			_view.currentState = (validationURL != null)?FULL_MODE:STANDARD_MODE;
		}
		
	}
	
}