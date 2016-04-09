package com.luchanso.glassl.ui.dialogs;

import com.luchanso.glassl.ui.TextButton;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;

/**
 * ...
 * @author Loutchansky Oleg
 */
class ReliveDialog extends Dialog
{
	var headerRelive : TextField;
	var headerPurchase : TextField;
	var descriptionRelive : TextField;
	var descriptionPurchases : TextField;
	
	var reliveButton : TextButton;
	var purchasesButton : TextButton;
	
	static var margin : Float = 10;
	static var padding : Float = 10;
	
	var splitLineY : Float = 0;

	public function new() 
	{
		super();
		
		addHeaderRelive();	
		addDescriptionRelive();
		addReliveButton();
		
		addSplitLine();
		
		addHeadePurchase();
		addDescriptionPurchases();		
		addPurchasesButton();
	}
	
	function addPurchasesButton() 
	{
		purchasesButton = new TextButton();
		purchasesButton.text = "Купить монетки";
		
		purchasesButton.x = this.marginLeft + this.dWidth / 2 - purchasesButton.width / 2;
		purchasesButton.y = descriptionPurchases.y + descriptionPurchases.height + padding;
		
		addChild(purchasesButton);
	}
	
	function addDescriptionPurchases() 
	{
		descriptionPurchases = getNewLable(16);
		
		#if vk_build
		
		descriptionPurchases.htmlText = "Монетки покупаются за голоса ВК, 1 голос = 3 монетки.";		
		
		#end
		
		descriptionPurchases.x = marginLeft + margin;
		descriptionPurchases.y = headerPurchase.y + headerPurchase.height + padding;
		descriptionPurchases.autoSize = TextFieldAutoSize.NONE;
		descriptionPurchases.width = dWidth - margin * 2;
		descriptionPurchases.height = 25;
		descriptionPurchases.wordWrap = true;
		
		addChild(descriptionPurchases);
		
	}
	
	function addHeadePurchase() 
	{
		headerPurchase = getNewLable();
		
		headerPurchase.text = "Покупка монеток";
		headerPurchase.x = marginLeft + margin;
		headerPurchase.y = splitLineY + margin;
		
		addChild(headerPurchase);
	}
	
	function addSplitLine() 
	{
		graphics.lineStyle(1, 0xE2E2E2);
		
		splitLineY = reliveButton.y + reliveButton.height + padding * 2;
		
		graphics.moveTo(marginLeft + margin, splitLineY);
		graphics.lineTo(marginLeft + dWidth - margin, splitLineY);
	}
	
	function addDescriptionRelive() 
	{
		descriptionRelive = getNewLable(16);
		
		#if vk_build
		
		descriptionRelive.htmlText = "Вы можете продолжить игру с того же места, без потерь очков, всего за <b>одну монетку</b>. Монетки приобретаются за голоса.";
		var textHeight = 60;
		
		#end
		
		descriptionRelive.x = marginLeft + margin;
		descriptionRelive.y = headerRelive.y + headerRelive.height + padding;
		descriptionRelive.autoSize = TextFieldAutoSize.NONE;
		descriptionRelive.width = dWidth - margin * 2;
		descriptionRelive.height = textHeight;
		descriptionRelive.wordWrap = true;
		
		addChild(descriptionRelive);
	}
	
	function addHeaderRelive() 
	{
		headerRelive = getNewLable();
		
		headerRelive.text = "Продолжить игру без потерь очков";
		
		headerRelive.x = marginLeft + margin;
		headerRelive.y = marginTop + margin;
		
		addChild(headerRelive);
	}
	
	function getNewLable(fontSize : Int = 23) : TextField
	{
		var lable = new TextField();
		lable.defaultTextFormat = new TextFormat("Arial", fontSize, 0x333333);
		
		lable.autoSize = TextFieldAutoSize.LEFT;
		lable.mouseEnabled = false;
		lable.selectable = false;
		
		return lable;
	}
	
	function addReliveButton() 
	{
		reliveButton = new TextButton();
		reliveButton.text = "Ожить за 1 монетку";
		
		reliveButton.x = this.marginLeft + this.dWidth / 2 - reliveButton.width / 2;
		reliveButton.y = descriptionRelive.y + descriptionRelive.height + padding;
		
		addChild(reliveButton);
	}
	
}