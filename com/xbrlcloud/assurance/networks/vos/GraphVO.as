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
	import mx.collections.ArrayCollection;

	[Bindable]
	public class GraphVO
	{
		
		[ArrayElementType("com.xbrlcloud.assurance.validation.vos.ConceptVO")]
		public var concepts:ArrayCollection;
	}
}