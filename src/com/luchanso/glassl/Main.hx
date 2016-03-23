package com.luchanso.glassl;

import flash.events.Event;
import flash.text.TextField;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.ui.Keyboard;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Main extends Sprite
{
	var game : Game;
	var lable : TextField;

	public function new() 
	{
		super();		
		
		addLable();
		init();
	}
	
	function addLable() 
	{
		lable = new TextField();
		lable.defaultTextFormat = new TextFormat("Arial", 25, 0xFFFFFF);
		lable.selectable = false;
		lable.mouseEnabled = false;
		lable.autoSize = TextFieldAutoSize.LEFT;
		lable.text = "Для продолжения нажмите \"Пробел\"";
		lable.x = Config.width / 2 - lable.width / 2;
		lable.y = Config.height - 50;
		lable.visible = false;
		
		addChild(lable);
	}
	
	private function lose(e:Event) : Void 
	{
		lable.visible = true;
		this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
	}
	
	private function keyDown(e:KeyboardEvent) : Void
	{
		if (e.keyCode == Keyboard.SPACE) 
		{
			this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			init();
		}
	}
	
	private function init()
	{
		if (game != null) 
		{
			this.removeChild(game);
		}
		
		game = new Game();
		game.addEventListener("lose", lose);
		addChild(game);
		
		lable.visible = false;
	}	
}