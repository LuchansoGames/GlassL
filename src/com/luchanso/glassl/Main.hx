package com.luchanso.glassl;

import flash.events.Event;
import flash.text.TextField;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
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
	var soundButton : SoundButton;

	public function new() 
	{
		super();		
		
		addLable();
		addSoundButtonToStage();
		this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		this.stage.addEventListener(MouseEvent.CLICK, click);
	}
	
	private function click(e:MouseEvent):Void 
	{
		this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		this.stage.removeEventListener(MouseEvent.CLICK, click);
		init();
	}
	
	function addSoundButtonToStage()
	{		
		soundButton = new SoundButton();
		
		soundButton.width = 40;
		soundButton.height = 40;
		
		soundButton.x = 10;
		soundButton.y = 10;
		
		addChild(soundButton);
	}
	
	function addLable() 
	{
		lable = new TextField();
		lable.defaultTextFormat = new TextFormat("Arial", 25, 0xFFFFFF);
		lable.selectable = false;
		lable.mouseEnabled = false;
		lable.autoSize = TextFieldAutoSize.LEFT;
		lable.text = "Нажимай пробел";
		lable.x = Config.width / 2 - lable.width / 2;
		lable.y = Config.height - 50;
		
		addChild(lable);
	}
	
	private function lose(e:Event) : Void 
	{
		lable.visible = true;
		this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		Lib.current.stage.addEventListener(MouseEvent.CLICK, click);
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
		
		game = new Game(soundButton);
		game.addEventListener("lose", lose);
		addChild(game);
		
		lable.visible = false;
	}	
}