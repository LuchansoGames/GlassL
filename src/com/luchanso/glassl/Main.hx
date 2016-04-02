package com.luchanso.glassl;

import com.luchanso.glassl.scenes.Game;
import com.luchanso.glassl.scenes.MainMenu;
import com.luchanso.glassl.ui.MoneyLable;
import com.luchanso.glassl.ui.SoundButton;
import flash.events.Event;
import flash.text.TextField;
import openfl.Lib;
import openfl.display.FPS;
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
	var soundButton : SoundButton;
	var mainMenu : MainMenu;
	var marginUi : Float = 10;

	public function new() 
	{
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, addedToStage);
	}
	
	private function addedToStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		
		initMainMenu();		
		//drawDebug();
		
		addFps();
	}
	
	function addFps() 
	{
		var fps = new FPS(marginUi, Lib.current.stage.window.height - 18 - marginUi, 0xFFFFFF);
		addChild(fps);
	}
	
	function initMainMenu() : Void
	{
		mainMenu = new MainMenu();
		mainMenu.addEventListener(MainMenu.EVENT_PLAY, startGame);
		
		addChild(mainMenu);
	}
	
	function addSoundButtonToStage()
	{		
		soundButton = new SoundButton();
		
		soundButton.width = 40;
		soundButton.height = 40;
		
		soundButton.x = Lib.current.stage.window.width - soundButton.width - marginUi;
		soundButton.y = marginUi;
		
		addChild(soundButton);
	}
	
	private function startGame(e:Event)
	{
		if (mainMenu != null) 
		{
			removeChild(mainMenu);
			mainMenu = null;
		}
		
		if (game != null)
		{
			this.removeChild(game);
		}
		else 
		{
			addSoundButtonToStage();
		}
		
		game = new Game();
		Lib.current.stage.focus = game;
		
		game.addEventListener("lose", lose);
		addChild(game);
	}	
	
	private function lose(e:Event):Void 
	{
		
	}
	
	private function drawDebug() : Void
	{		
		var width = Lib.current.stage.window.width;
		var height = Lib.current.stage.window.height;
		
		graphics.lineStyle(1, 0xFF0000);
		graphics.moveTo(width / 2, 0);
		graphics.lineTo(width / 2, height);
		graphics.moveTo(0, height / 2);
		graphics.lineTo(width, height / 2);
	}
}