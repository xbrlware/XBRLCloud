////////////////////////////////////////////////////////////////////////////////
//
//  XBRCloud - Flex Assurance Application
//  Copyright 2010
//  All Rights Reserved.
//
//  Autor: Eduardo Dias
////////////////////////////////////////////////////////////////////////////////

package com.xbrlcloud.assurance.shared
{
	[Bindable]
	public class ResourceFinder
	{
		
		/********************************************************************************************************************************
		| Global
		********************************************************************************************************************************/
		
		[Embed(source = '/../assets/imgs/main_bg.png')]
		public static const main_bg:Class;
		
		[Embed(source = '/../assets/swf/Assets.swf', symbol="TreeFolderClosed")] 
		public static const folderClosedIcon:Class;
		
		[Embed(source = "/../assets/swf/Assets.swf", symbol = "TreeFolderOpen")] 
		public static const folderOpenIcon:Class;
		
		[Embed(source="/../assets/swf/Assets.swf",symbol="TreeNodeIcon")] 
		public static const defaultLeafIcon:Class;
		
		
		/********************************************************************************************************************************
		| Window Message
		********************************************************************************************************************************/
		
		/* Background */
		[Embed(source='/../assets/imgs/window_message_bg.png', scaleGridTop="60", scaleGridBottom="80", scaleGridLeft="60", scaleGridRight="80")]
		public static const window_message_bg:Class;
		
		/* Logo */
		[Embed(source='/../assets/imgs/window_message_logo.png')]
		public static const window_message_logo:Class;
		
		/* Error Icon */
		[Embed(source='/../assets/imgs/window_message_error_icon.png')]
		public static const window_message_error_icon:Class;
		
		/* Button Background Up */
		[Embed(source='/../assets/imgs/window_message_button_up.png', scaleGridTop="10", scaleGridBottom="15", scaleGridLeft="10", scaleGridRight="15")]
		public static const window_message_button_up:Class;
		
		/* Button Background Over */
		[Embed(source='/../assets/imgs/window_message_button_over.png', scaleGridTop="10", scaleGridBottom="15", scaleGridLeft="10", scaleGridRight="15")]
		public static const window_message_button_over:Class;
		
		/* Button Background Down */
		[Embed(source='/../assets/imgs/window_message_button_down.png', scaleGridTop="10", scaleGridBottom="15", scaleGridLeft="10", scaleGridRight="15")]
		public static const window_message_button_down:Class;
		
		/* Button Refresh Icon */
		[Embed(source='/../assets/imgs/window_message_refresh_icon.png')]
		public static const window_message_refresh_icon:Class;
		
		/* Button Back Icon */
		[Embed(source='/../assets/imgs/window_message_back_icon.png')]
		public static const window_message_back_icon:Class;
		
		
		/********************************************************************************************************************************
		| Header
		********************************************************************************************************************************/
		
		/* Header Background */
		[Embed(source='/../assets/imgs/header_bg.png', scaleGridTop="25", scaleGridBottom="28", scaleGridLeft="25", scaleGridRight="28")]
		public static const header_bg:Class;
		
		/* Section Background*/
		[Embed(source='/../assets/imgs/section_bg.png', scaleGridTop="5", scaleGridBottom="6", scaleGridLeft="55", scaleGridRight="56")]
		public static const section_bg:Class;
		
		/* Content Background */
		[Embed(source='/../assets/imgs/content_bg.png', scaleGridTop="20", scaleGridBottom="22", scaleGridLeft="25", scaleGridRight="28")]
		public static const content_bg:Class;
		
		/* Footer Background */
		[Embed(source='/../assets/imgs/footer_bg.png', scaleGridTop="25", scaleGridBottom="28", scaleGridLeft="25", scaleGridRight="28")]
		public static const footer_bg:Class;
		
		/* Main Title */
		[Embed(source='/../assets/imgs/title.png')]
		public static const title:Class;
		
		/* Title Bar Background */
		[Embed(source='/../assets/imgs/title_bar_bg.png', scaleGridTop="15", scaleGridBottom="20", scaleGridLeft="25", scaleGridRight="30")]
		public static const title_bar_bg:Class;
		
		/* Logo */
		[Embed(source='/../assets/imgs/logo.png')]
		public static const logo:Class;
		
		/* Taxonomy - Icon */
		[Embed('/../assets/imgs/taxonomy_icon.png')]
		public static const taxonomy_icon:Class;
		
		/* Taxonomy Concepts - Icon */
		[Embed('/../assets/imgs/taxonomy_concepts_icon.png')]
		public static const taxonomy_concepts_icon:Class;
		
		/* Calculation - Icon */
		[Embed('/../assets/imgs/calculation_icon.png')]
		public static const calculation_icon:Class;
		
		/* Forms - Icon */
		[Embed('/../assets/imgs/forms_icon.png')]
		public static const forms_icon:Class;
		
		/* Documents - Icon */
		[Embed('/../assets/imgs/documents_icon.png')]
		public static const documents_icon:Class;
		
		/* Menu Separator */
		[Embed(source='/../assets/imgs/menu_separator.png')]
		public static const separator:Class;
		
		/* Menu Button - Down State */
		[Embed(source='/../assets/imgs/menu_button_down.png', scaleGridTop="10", scaleGridBottom="11", scaleGridLeft="8", scaleGridRight="9")]
		public static const menu_button_down:Class;
		
		/* Menu Button - Over State */
		[Embed(source='/../assets/imgs/menu_button_over.png', scaleGridTop="10", scaleGridBottom="11", scaleGridLeft="8", scaleGridRight="9")]
		public static const menu_button_over:Class;
		
		
		/********************************************************************************************************************************
		| Application Buttons Bar
		********************************************************************************************************************************/
		
		/* Application Bar - Divisor */
		[Embed(source='/../assets/imgs/application_bar_divisor.png')]
		public static const application_bar_divisor:Class;
		
		/* Application Button - Up State */
		[Embed(source='/../assets/imgs/application_button_bg_up.png', scaleGridTop="1", scaleGridBottom="2", scaleGridLeft="3", scaleGridRight="5")]
		public static const application_button_bg_up:Class;
		
		/* Application Button - Over State */
		[Embed(source='/../assets/imgs/application_button_bg_over.png', scaleGridTop="1", scaleGridBottom="2", scaleGridLeft="3", scaleGridRight="5")]
		public static const application_button_bg_over:Class;
		
		/* Application Button - Down State */
		[Embed(source='/../assets/imgs/application_button_bg_down.png', scaleGridTop="1", scaleGridBottom="2", scaleGridLeft="3", scaleGridRight="5")]
		public static const application_button_bg_down:Class;
		
		/* Application Button - URL Icon Export */
		[Embed(source='/../assets/imgs/application_icon_url_export.png')]
		public static const application_icon_url_export:Class;
		
		
		/********************************************************************************************************************************
		| Buttons Navigation Bar
		********************************************************************************************************************************/
		
		/* Buttom Bar Nav - First Item - Up State */
		[Embed(source='/../assets/imgs/button_bar_nav_first_up.png', scaleGridTop="5", scaleGridBottom="6", scaleGridLeft="5", scaleGridRight="6")]
		public static const button_bar_nav_first_up:Class;
		
		/* Buttom Bar Nav - First Item - Over State */
		[Embed(source='/../assets/imgs/button_bar_nav_first_over.png', scaleGridTop="5", scaleGridBottom="6", scaleGridLeft="5", scaleGridRight="6")]
		public static const button_bar_nav_first_over:Class;
		
		/* Buttom Bar Nav - First Item - Down State */
		[Embed(source='/../assets/imgs/button_bar_nav_first_down.png', scaleGridTop="5", scaleGridBottom="6", scaleGridLeft="5", scaleGridRight="6")]
		public static const button_bar_nav_first_down:Class;
		
		/* Buttom Bar Nav - Middle Item - Up State */
		[Embed(source='/../assets/imgs/button_bar_nav_middle_up.png', scaleGridTop="5", scaleGridBottom="6", scaleGridLeft="5", scaleGridRight="6")]
		public static const button_bar_nav_middle_up:Class;
		
		/* Buttom Bar Nav - Middle Item - Over State */
		[Embed(source='/../assets/imgs/button_bar_nav_middle_over.png', scaleGridTop="5", scaleGridBottom="6", scaleGridLeft="5", scaleGridRight="6")]
		public static const button_bar_nav_middle_over:Class;
		
		/* Buttom Bar Nav - Middle Item - Down State */
		[Embed(source='/../assets/imgs/button_bar_nav_middle_down.png', scaleGridTop="5", scaleGridBottom="6", scaleGridLeft="5", scaleGridRight="6")]
		public static const button_bar_nav_middle_down:Class;
		
		/* Buttom Bar Nav - Last Item - Up State */
		[Embed(source='/../assets/imgs/button_bar_nav_last_up.png', scaleGridTop="5", scaleGridBottom="6", scaleGridLeft="5", scaleGridRight="6")]
		public static const button_bar_nav_last_up:Class;
		
		/* Buttom Bar Nav - Last Item - Over State */
		[Embed(source='/../assets/imgs/button_bar_nav_last_over.png', scaleGridTop="5", scaleGridBottom="6", scaleGridLeft="5", scaleGridRight="6")]
		public static const button_bar_nav_last_over:Class;
		
		/* Buttom Bar Nav - Last Item - Down State */
		[Embed(source='/../assets/imgs/button_bar_nav_last_down.png', scaleGridTop="5", scaleGridBottom="6", scaleGridLeft="5", scaleGridRight="6")]
		public static const button_bar_nav_last_down:Class;
		
		
		/********************************************************************************************************************************
		| Network Itens
		********************************************************************************************************************************/
		
		/* Network Item - Background - Up State */
		[Embed(source='/../assets/imgs/network_item_bg_up.png')]
		public static const network_item_bg_up:Class;
		
		/* Network Item - Background - Hovered State */
		[Embed(source='/../assets/imgs/network_item_bg_hovered.png')]
		public static const network_item_bg_hovered:Class;
		
		/* Network Item - Background - Selected State */
		[Embed(source='/../assets/imgs/network_item_bg_selected.png')]
		public static const network_item_bg_selected:Class;
		
		/* Network Item - Arrow - Up State */
		[Embed(source='/../assets/imgs/network_item_arrow_up.png')]
		public static const network_item_arrow_up:Class;
		
		/* Network Item - Arrow - Hovered State */
		[Embed(source='/../assets/imgs/network_item_arrow_hovered.png')]
		public static const network_item_arrow_hovered:Class;
		
		/* Network Item - Arrow - Selected State */
		[Embed(source='/../assets/imgs/network_item_arrow_selected.png')]
		public static const network_item_arrow_selected:Class;
		
		
		/********************************************************************************************************************************
		| Network Concept Itens
		********************************************************************************************************************************/
		
		/* Concept - Error Icon */
		[Embed(source='/../assets/imgs/concept_error_icon.png')]
		public static const concept_error_icon:Class;
		
		/* Concept - Warning Icon */
		[Embed(source='/../assets/imgs/concept_warning_icon.png')]
		public static const concept_warning_icon:Class;
		
		/* Concept - Information Icon */
		[Embed(source='/../assets/imgs/concept_information_icon.png')]
		public static const concept_information_icon:Class;
		
		/* Concept - Best Practice Icon */
		[Embed(source='/../assets/imgs/concept_best_practice_icon.png')]
		public static const concept_best_practice_icon:Class;
		
		/* Concept - Inconsistency Icon */
		[Embed(source='/../assets/imgs/concept_inconsistency_icon.png')]
		public static const concept_inconsistency_icon:Class;
		

		/* Concept Extension - Error Icon */
		[Embed(source='/../assets/imgs/concept_error_extension_icon.png')]
		public static const concept_error_extension_icon:Class;
		
		/* Concept Extension - Warning Icon */
		[Embed(source='/../assets/imgs/concept_warning_extension_icon.png')]
		public static const concept_warning_extension_icon:Class;
		
		/* Concept Extension - Information Icon */
		[Embed(source='/../assets/imgs/concept_information_extension_icon.png')]
		public static const concept_information_extension_icon:Class;
		
		/* Concept Extension - Best Practice Icon */
		[Embed(source='/../assets/imgs/concept_best_practice_extension_icon.png')]
		public static const concept_best_practice_extension_icon:Class;
		
		/* Concept Extension - Best Practice Icon */
		[Embed(source='/../assets/imgs/concept_inconsistency_extension_icon.png')]
		public static const concept_inconsistency_extension_icon:Class;
		
		
		/* Concept Details - Error Icon */
		[Embed(source='/../assets/imgs/concept_error_details_icon.png')]
		public static const concept_error_details_icon:Class;
		
		/* Concept Details - Warning Icon */
		[Embed(source='/../assets/imgs/concept_warning_details_icon.png')]
		public static const concept_warning_details_icon:Class;
		
		/* Concept Details - Information Icon */
		[Embed(source='/../assets/imgs/concept_information_details_icon.png')]
		public static const concept_information_details_icon:Class;
		
		/* Concept Details - Best Practice Icon */
		[Embed(source='/../assets/imgs/concept_best_practice_details_icon.png')]
		public static const concept_best_practice_details_icon:Class;
		
		/* Concept Details - Best Practice Icon */
		[Embed(source='/../assets/imgs/concept_inconsistency_details_icon.png')]
		public static const concept_inconsistency_details_icon:Class;
		
		
		/* Concept Details - Error Icon */
		[Embed(source='/../assets/imgs/concept_error_extension_details_icon.png')]
		public static const concept_error_extension_details_icon:Class;
		
		/* Concept Details - Warning Icon */
		[Embed(source='/../assets/imgs/concept_warning_extension_details_icon.png')]
		public static const concept_warning_extension_details_icon:Class;
		
		/* Concept Details - Information Icon */
		[Embed(source='/../assets/imgs/concept_information_extension_details_icon.png')]
		public static const concept_information_extension_details_icon:Class;
		
		/* Concept Details - Best Practice Icon */
		[Embed(source='/../assets/imgs/concept_best_practice_extension_details_icon.png')]
		public static const concept_best_practice_extension_details_icon:Class;
		
		/* Concept Details - Best Practice Icon */
		[Embed(source='/../assets/imgs/concept_inconsistency_extension_details_icon.png')]
		public static const concept_inconsistency_extension_details_icon:Class;
		
		
		/* Concept Extension - Best Practice Icon */
		[Embed(source='/../assets/imgs/concept_extension_icon.png')]
		public static const concept_extension_icon:Class;
		
		/* Concept Extension - Best Practice Icon */
		[Embed(source='/../assets/imgs/concept_extension_details_icon.png')]
		public static const concept_extension_details_icon:Class;
		
		/********************************************************************************************************************************
		| Validation Report
		********************************************************************************************************************************/
		
		/* Validation Report Error Icon */
		[Embed(source='/../assets/imgs/validation_report_error_icon.png')]
		public static const validation_report_error_icon:Class;
		
		/* Validation Report Warning Icon */
		[Embed(source='/../assets/imgs/validation_report_warning_icon.png')]
		public static const validation_report_warning_icon:Class;
		
		/* Validation Report Information Icon */
		[Embed(source='/../assets/imgs/validation_report_information_icon.png')]
		public static const validation_report_information_icon:Class;
		
		/* Validation Report Best Practices Icon */
		[Embed(source='/../assets/imgs/validation_report_best_practices_icon.png')]
		public static const validation_report_best_practices_icon:Class;
		
		/* Validation Report Inconsistency Icon */
		[Embed(source='/../assets/imgs/validation_report_inconsistency_icon.png')]
		public static const validation_report_inconsistency_icon:Class;
		
		// 
		[Embed(source='/../assets/imgs/validation_filter_button_left_down.png')]
		public static const validation_filter_button_left_down:Class;
		
		[Embed(source='/../assets/imgs/validation_filter_button_left_up.png')]
		public static const validation_filter_button_left_up:Class;
		
		[Embed(source='/../assets/imgs/validation_filter_button_left_over.png')]
		public static const validation_filter_button_left_over:Class;
		
		[Embed(source='/../assets/imgs/validation_filter_button_right_down.png')]
		public static const validation_filter_button_right_down:Class;
		
		[Embed(source='/../assets/imgs/validation_filter_button_right_up.png')]
		public static const validation_filter_button_right_up:Class;
		
		[Embed(source='/../assets/imgs/validation_filter_button_right_over.png')]
		public static const validation_filter_button_right_over:Class;

		
	}

}