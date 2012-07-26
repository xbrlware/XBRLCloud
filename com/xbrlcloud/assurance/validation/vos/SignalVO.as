////////////////////////////////////////////////////////////////////////////////
//
//  XBRLCloud
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.validation.vos
{
	import com.xbrlcloud.assurance.networks.vos.NetworkVO;
	
	import mx.core.IUID;
	import mx.utils.UIDUtil;

	[Bindable]
	public class SignalVO implements IUID
	{
		
		// Public const
		
		public static const ERROR:String         = "ERROR";
		
		public static const WARNING:String       = "WARNING";
		
		public static const BEST_PRACTICE:String = "BEST_PRACTICE";
		
		public static const INFORMATION:String   = "INFORMATION";
		
		public static const INCONSISTENCY:String = "INCONSISTENCY";
		
		
		public var qname        :String;
		public var uri          :String;
		public var heading      :String;
		public var severity     :String;
		public var message      :String;
		public var section      :String;
		public var baseSet      :BaseSetVO;
		public var properties   :Vector.<PropertyVO> = new Vector.<PropertyVO>();
		public var network      :NetworkVO;
		public var lineNumber   :String;
		public var columnNumber :String;
		
		
		private var _uid        :String;
		
		
		public function SignalVO()
		{
			_uid = UIDUtil.createUID();
		}
		
		
		public function get uid():String
		{
			return _uid;
		}
		
		
		public function set uid(value:String):void
		{
			// Do nothing, the constructor created the uid.
		}
		
	}
}