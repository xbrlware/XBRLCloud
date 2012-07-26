////////////////////////////////////////////////////////////////////////////////
//
//  XBRLCloud
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.main.controllers
{
	
	import com.xbrlcloud.assurance.main.components.windowMessage.ui.views.WindowMessage;
	import com.xbrlcloud.assurance.main.components.windowURLExporter.ui.views.WindowURLExport;
	import com.xbrlcloud.assurance.main.http.URLParserManager;
	import com.xbrlcloud.assurance.shared.components.LoadingBar;
	
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.external.ExternalInterface;
	
	import mx.core.IFlexDisplayObject;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	
	public class MainController extends EventDispatcher
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var urlParseManager:URLParserManager;
		
		
		private var mainView        :DisplayObject
		
		private var loadingBar      :IFlexDisplayObject;
		
		private var windowMessage   :IFlexDisplayObject;
		
		private var windowURLExport :IFlexDisplayObject;
		
		
		public function MainController(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		[Mediate(event="mx.events.FlexEvent.APPLICATION_COMPLETE")]
		public function init(e:FlexEvent):void
		{
			mainView = DisplayObject(e.currentTarget);
			loadingBar = PopUpManager.createPopUp(mainView, LoadingBar, true);
			PopUpManager.centerPopUp(loadingBar);
			
			urlParseManager.parse();
		}

		
		[Mediate(event="SignalsNetworksConnectEvent.CONNECTED")]
		public function removeLoadingBar():void
		{
			PopUpManager.removePopUp(loadingBar);
			loadingBar = null;
		}
		
		
		/*******************************************************************************************************************
		* Window Message Handlers
		*******************************************************************************************************************/
		
		[Mediate(event="WindowMessageEvent.OPEN", properties="message")]
		public function openWindowMessage(message:String):void
		{
			if(loadingBar)
				removeLoadingBar();
			
			windowMessage = PopUpManager.createPopUp(mainView, WindowMessage, true);
			WindowMessage(windowMessage).msg = message;
			PopUpManager.centerPopUp(windowMessage);
		}
		
		
		[Mediate(event="WindowMessageEvent.REFRESH")]
		public function refreshApplication():void
		{
			ExternalInterface.call('eval','document.location.href=document.location.href');
		}
		
		
		[Mediate(event="WindowMessageEvent.BACK")]
		public function backToPreviousPage():void
		{
			ExternalInterface.call('eval','history.back()');
		}
		
		
		/*******************************************************************************************************************
		 * Window URL Export Handlers
		 *******************************************************************************************************************/
		
		[Mediate(event="WindowURLExportEvent.OPEN", properties="message")]
		public function openWindowURLExport(message:String):void
		{
			if(loadingBar)
				removeLoadingBar();
			
			windowURLExport = PopUpManager.createPopUp(mainView, WindowURLExport, true);
			WindowURLExport(windowURLExport).msg = message;
			PopUpManager.centerPopUp(windowURLExport);
		}
		
		
		[Mediate(event="WindowURLExportEvent.CLOSE")]
		public function closeWindowURLExport():void
		{
			PopUpManager.removePopUp(windowURLExport);
		}
		
	}
	
}