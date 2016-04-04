package com.luchanso.glassl.ui;

import openfl.display.Bitmap;
import openfl.Assets;
import openfl.Lib;
import openfl.display.PixelSnapping;
import openfl.display.Sprite;

/**
 * ...
 * @author Loutchansky Oleg
 */
class ADS extends Sprite
{
	var adblockMsg : Bitmap;
	
	public function new() 
	{
		super();
		
		addAdblockMsg();
	}
	
	function addAdblockMsg() 
	{
		adblockMsg = new Bitmap(Assets.getBitmapData("img/adblock-message.png"), PixelSnapping.AUTO, true);
		addChild(adblockMsg);
	}
	
}