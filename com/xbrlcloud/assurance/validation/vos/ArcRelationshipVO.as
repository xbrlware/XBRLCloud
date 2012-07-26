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
	public class ArcRelationshipVO
	{
		public var from        :ElementGroupVO;
		public var to          :ElementGroupVO;
		public var arc         :ElementGroupVO;
		public var fromLocator :ElementGroupVO;
		public var toLocator   :ElementGroupVO;
	}
}