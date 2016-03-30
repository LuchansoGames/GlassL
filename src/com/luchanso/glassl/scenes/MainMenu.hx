package com.luchanso.glassl.scenes;
import com.luchanso.glassl.ui.SoundButton;
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
class MainMenu extends Sprite
{
	public static var EVENT_PLAY = "play";	

	static var buttonSize = 185;
	
	var bPlay : Sprite;
	var bPay : Sprite;
	var soundButton : SoundButton;

	public function new() 
	{
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		addButtonPlay();
		addButtonPay();
		addSoundBtton();
	}
	
	function addSoundBtton() 
	{
		soundButton = new SoundButton();
		
		soundButton.width = 80;
		soundButton.height = 80;
		soundButton.x = Lib.current.stage.window.width / 2 - soundButton.width / 2;
		soundButton.y = Lib.current.stage.window.height / 2 - soundButton.height / 2 + Lib.current.stage.window.height / 12;
		
		addChild(soundButton);
	}
	
	function addButtonPay() 
	{
		bPay = new Sprite();
		bPay.addChild(new Bitmap(Assets.getBitmapData("img/star.png"), PixelSnapping.NEVER, true));
		
		bPay.width = MainMenu.buttonSize;
		bPay.height = MainMenu.buttonSize;
		
		bPay.x = Lib.current.stage.window.width / 2 - bPay.width / 2 - Lib.current.stage.window.width / 4;
		bPay.y = Lib.current.stage.window.height / 2 - bPay.height / 2 - Lib.current.stage.window.height / 8;
		
		bPay.buttonMode = true;
		
		bPay.addEventListener(MouseEvent.CLICK, paymentActivate);
		bPay.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		
		addChild(bPay);
	}
	
	private function mouseOver(e:MouseEvent):Void 
	{
		//Actuate.tween(e.target, 100, { width: e.target.width * 1.1, height: e.target.height * 1.1 } ).reverse();
	}
	
	private function paymentActivate(e:MouseEvent):Void 
	{
		
	}
	
	function addButtonPlay() 
	{	
		bPlay = new Sprite();
		bPlay.addChild(new Bitmap(Assets.getBitmapData("img/play.png"), PixelSnapping.NEVER, true));
		
		bPlay.width = MainMenu.buttonSize;
		bPlay.height = MainMenu.buttonSize;
		
		bPlay.x = Lib.current.stage.window.width / 2 - bPlay.width / 2 + Lib.current.stage.window.width / 4;
		bPlay.y = Lib.current.stage.window.height / 2 - bPlay.height / 2 - Lib.current.stage.window.height / 8;
		
		bPlay.buttonMode = true;		
		
		bPlay.addEventListener(MouseEvent.CLICK, bPlay_click);
		
		addChild(bPlay);
	}	
	
	private function bPlay_click(e:MouseEvent):Void 
	{
		this.dispatchEvent(new Event(MainMenu.EVENT_PLAY));
	}
}