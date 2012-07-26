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
	[Bindable]
	public class ElementGroupVO
	{
		public var id            :String;
		public var xpath         :String;
		public var label         :String;
		public var concept       :String;
		public var lineNumber    :String;
		public var columnNumber  :String;
		public var documentUri   :String;
		public var propertyName  :String;
		public var documentValue :String;
		public var effectiveValue:String;
	}
}