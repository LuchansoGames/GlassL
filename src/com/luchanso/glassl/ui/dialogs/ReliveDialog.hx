package com.luchanso.glassl.ui.dialogs;

import com.luchanso.glassl.ui.TextButton;
import openfl.display.Sprite;
import openfl.text.TextField;

/**
 * ...
 * @author Loutchansky Oleg
 */
class ReliveDialog extends Dialog
{
	var headerRelive : TextField;
	var descriptionRelive : TextField;
	var descriptionPurchases : TextField;
	
	var reliveButton : TextButton;
	var purchasesButton : TextButton;

	public function new() 
	{
		super();
		
		addReliveButton();		
	}
	
	function addReliveButton() 
	{
		reliveButton = new TextButton();
		reliveButton.text = "Ожить за 1 монетку";
		
		reliveButton.x = this.marginLeft + 50;
		reliveButton.y = this.marginTop + 50;
		
		addChild(reliveButton);
	}
	
}