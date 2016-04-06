package com.luchanso.glassl.ui.dialogs;

import flash.display.Sprite;
import openfl.Lib;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Dialog extends Sprite
{

	public function new()
	{
		super();
		
		draw();
	}
	
	function draw() 
	{
		var dWidth = Lib.current.stage.window.width * 0.75;
		var dHeight = Lib.current.stage.window.height * 0.75;
		
		var marginLeft = Lib.current.stage.window.width / 2 - dWidth / 2;
		var marginTop = Lib.current.stage.window.height / 2 - dHeight / 2;
		
		
		graphics.beginFill(0x000000, 0.6);
		graphics.drawRect(0, 0, Lib.current.stage.window.width, Lib.current.stage.window.height);
		graphics.endFill();		
		
		graphics.beginFill(0xFFFFFF);
		graphics.drawRect(marginLeft, marginTop, dWidth, dHeight);
		graphics.endFill();
	}
	
	public function show() : Void
	{
		visible = true;
	}
	
	public function hide() : Void
	{
		visible = false;
	}	
}