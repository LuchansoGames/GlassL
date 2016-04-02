package com.luchanso.glassl.scenes;

import motion.Actuate;
import openfl.Assets;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.PixelSnapping;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Loutchansky Oleg
 */
class LoseMenu extends Scene
{
	var bPlay : Sprite;
	var bRelive : Sprite;
	var bShare : Sprite;
	
	static var firstColor = 0xFFFFFF;
	static var secondColor = Config.colorLight;
	
	static var buttonSize = 115;
	static var margin = 15;
	
	var tableSizeWidth = Lib.current.stage.window.width - 250;
	var tableSizeHeight = Lib.current.stage.window.height - (185 + margin * 2);
	
	// Рекламный блок = 185px
	public function new() 
	{
		super();
		
		addButtonPlay();
		addButtonRelive();
		addButtonShare();
		
		drawScore();
		drawRating();
		drawADS();
	}
	
	public function setScore(score : Int)
	{
		
	}
	
	function addAnimationForButtons() 
	{
		var fadeIn = function(e:MouseEvent) 
		{
			Actuate.transform(e.target, 0.25).color(secondColor);
		}
		
		var fadeOut = function(e:MouseEvent)
		{
			Actuate.transform(e.target, 0.25).color(firstColor);
		}
		
		bRelive.addEventListener(MouseEvent.MOUSE_OVER, fadeIn);
		bPlay.addEventListener(MouseEvent.MOUSE_OVER, fadeIn);

		bRelive.addEventListener(MouseEvent.MOUSE_OUT, fadeOut);
		bPlay.addEventListener(MouseEvent.MOUSE_OUT, fadeOut);
	}
	
	function addButtonPlay() 
	{		
		var windowWidth = Lib.current.stage.window.width;
		
		bPlay = new Sprite();
		bPlay.addChild(new Bitmap(Assets.getBitmapData("img/play.png"), PixelSnapping.NEVER, true));
		
		bPlay.width = LoseMenu.buttonSize;
		bPlay.height = LoseMenu.buttonSize;
		
		bPlay.x = windowWidth - (windowWidth - (tableSizeWidth + margin)) / 2 - bPlay.width;
		bPlay.y = margin;
		
		bPlay.buttonMode = true;
		
		bPlay.addEventListener(MouseEvent.CLICK, bPlay_click);
		
		addChild(bPlay);
	}
	
	private function bPlay_click(e:MouseEvent):Void 
	{
		dispatchEvent(new Event(GameEvent.PLAY));
	}
	
	function addButtonRelive() 
	{
		var windowWidth = Lib.current.stage.window.width;
		
		bRelive = new Sprite();
		bRelive.addChild(new Bitmap(Assets.getBitmapData("img/shield.png"), PixelSnapping.NEVER, true));
		
		bRelive.width = LoseMenu.buttonSize;
		bRelive.height = LoseMenu.buttonSize;
		
		bRelive.x = windowWidth - (windowWidth - (tableSizeWidth + margin)) / 2;
		bRelive.y = margin;
		
		bRelive.buttonMode = true;
		
		bRelive.addEventListener(MouseEvent.CLICK, VKController.paymentActivate);
		
		addChild(bRelive);
	}
	
	function addButtonShare() 
	{
		var windowWidth = Lib.current.stage.window.width;
		
		bShare = new Sprite();
		bShare.addChild(new Bitmap(Assets.getBitmapData("img/share.png"), PixelSnapping.NEVER, true));
		
		bShare.width = LoseMenu.buttonSize;
		bShare.height = LoseMenu.buttonSize;
		
		bShare.x = windowWidth - (windowWidth - (tableSizeWidth + margin)) / 2 - bShare.width / 2;
		bShare.y = margin + bRelive.y + bRelive.height;
		
		bShare.buttonMode = true;
		
		bShare.addEventListener(MouseEvent.CLICK, VKController.paymentActivate);
		
		addChild(bShare);
	}
	
	function drawScore()
	{
		var windowWidth = Lib.current.stage.window.width;
		var sizeScore = 100;
		
		graphics.lineStyle(3, Config.colorLight);
		graphics.drawRect(tableSizeWidth + margin * 2, tableSizeHeight - sizeScore + margin, (windowWidth - (tableSizeWidth + 3 * margin)), sizeScore);
	}
	
	function drawRating()
	{		
		graphics.lineStyle(3, Config.colorLight);
		graphics.drawRect(margin, margin, tableSizeWidth, tableSizeHeight);
	}
	
	function drawADS()
	{
		graphics.lineStyle(3, 0xFF2D32);
		graphics.drawRect(0, Lib.current.stage.window.height - 185, Lib.current.stage.window.width, 185);
	}
}