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
	import com.xbrlcloud.assurance.main.http.URLParserManager;
	import com.xbrlcloud.assurance.main.ui.Main;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;

	public class MainPresentationModel extends EventDispatcher
	{
		
		
		private static const VIEW_CHANGED:String = "viewChanged";
		
		private var loadingBar:IFlexDisplayObject;
		
		
		[Inject]
		public var urlParseManager:URLParserManager;
		
		
		public function MainPresentationModel():void
		{
			addEventListener(VIEW_CHANGED, initApp);
		}
		
		
		private function initApp(evt:Event):void
		{
			urlParseManager.parse();
			/*showLoadingBar();*/
		}
		
		
		private function showLoadingBar():void
		{
			/*loadingBar = PopUpManager.createPopUp(view, LoadingBar, true);
			PopUpManager.centerPopUp(loadingBar);*/
		}
		
		
		[Mediate(event="SignalsNetworksConnectEvent.CONNECTED")]
		public function closeLoadingBar():void
		{
			PopUpManager.removePopUp(loadingBar);
		}

		
		private var _view:Main;
		
		[Bindable(event="viewChanged")]
		public function get view():Main
		{
			return _view;
		}
		
		
		public function set view(value:Main):void
		{
			_view = value;
			dispatchEvent(new Event(VIEW_CHANGED));
		}

	}
	
}