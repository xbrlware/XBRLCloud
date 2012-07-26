////////////////////////////////////////////////////////////////////////////////
//
//  XBRLCloud
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.networks.vos
{
	import com.xbrlcloud.assurance.validation.vos.SignalVO;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class NetworkVO
	{
		
		public var uri          :String;
		public var definition   :String;
		public var presentation :GraphVO;
		public var calculation  :GraphVO;
		public var hypercube    :GraphVO;
		public var signals      :Vector.<SignalVO> = new Vector.<SignalVO>();
		public var connected    :Boolean;
		
		public function toString():String
		{
			return definition;
		}
		
	}
}