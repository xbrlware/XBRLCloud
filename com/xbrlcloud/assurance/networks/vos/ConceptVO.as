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
	public class ConceptVO
	{
		public var qname         :String;
		public var period        :String;
		public var depth         :int;
		public var parent        :String;
		public var label         :String;
		public var documentation :String;
		public var concepts      :Array;
		public var signal        :SignalVO;
		public var isExtension   :Boolean;
		public var isAbstract    :Boolean;
		public var isTotal       :Boolean;
		public var isNegated     :Boolean;
	}
}