package com.luchanso.glassl.scenes;
import com.luchanso.glassl.client.Client;
import com.luchanso.glassl.effects.Circle;
import com.luchanso.glassl.effects.CircleTween;
import com.luchanso.glassl.ui.MoneyLable;
import com.luchanso.glassl.ui.SoundButton;
import com.luchanso.glassl.vk.VKController;
import flash.text.TextField;
import motion.Actuate;
import openfl.Assets;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.PixelSnapping;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.AntiAliasType;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import pgr.dconsole.DC;
import vk.Vk;

/**
 * ...
 * @author Loutchansky Oleg
 */
class MainMenu extends Scene
{
	public static var EVENT_PLAY = "play";	

	static var buttonSize = 185;
	static var firstColor = 0xFFFFFF;
	static var secondColor = Config.colorLight;
	static var marginButtonsTop = 0;
	
	var bPlay : Sprite;
	var bPay : Sprite;
	var soundButton : SoundButton;
	
	var moneyLable : MoneyLable;

	public function new() 
	{
		super();
		
		addEventListener(Event.ENTER_FRAME, update);
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function update(e:Event):Void 
	{
		if (CircleTween.cirlces.length < 5) 
		{
			CircleTween.generate(this,  
				Math.random() * (Lib.current.stage.window.width - Circle.maximalRadius / 4),
				Math.random() * (Lib.current.stage.window.height - Circle.maximalRadius / 4));
		}
	}
	
	function addMoneyLable()
	{
		moneyLable = new MoneyLable();
		
		moneyLable.x = (bPay.x + bPay.width / 2) - moneyLable.width / 2;
		moneyLable.y = (bPay.y + bPay.height);
		
		Config.events.addEventListener(Config.COINS_CHANGE, function (_)
		{
			moneyLable.money = Config.coins;
			moneyLable.x = (bPay.x + bPay.width / 2) - moneyLable.width / 2;
		});
		
		addChild(moneyLable);
		
		if (VKController.vk.isVKEnvironment()) 
		{
			if (VKController.user == null) 
			{
				VKController.vk.api("users.get", { fields: "photo_50"}, function (user)
				{	
					Client.getCoinsById(user[0].uid);
				}, function(_)
				{
					DC.log(_);
				});
			} 
			else 
			{
				Client.getCoinsById(VKController.user.uid);
			}
		}		
	}
	
	private function init(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		addButtonPlay();
		addButtonPay();
		addSoundBtton();
		addMoneyLable();
		
		addAnimationForButtons();
		
		addGameName();
	}
	
	function addGameName() 
	{
		var logo = new Bitmap(Assets.getBitmapData("img/logo.png"), PixelSnapping.AUTO, true);
		
		logo.x = Lib.current.stage.window.width / 2 - logo.width / 2;
		logo.y = 30;
		
		addChild(logo);
	}
	
	function addAnimationForButtons() 
	{
		var fadeIn = function(e:MouseEvent) 
		{
			if (e.target == bPay) 
			{
				Actuate.transform(moneyLable, 0.25).color(secondColor);
			}
			Actuate.transform(e.target, 0.25).color(secondColor);
		}
		
		var fadeOut = function(e:MouseEvent)
		{
			if (e.target == bPay) 
			{
				Actuate.transform(moneyLable, 0.25).color(firstColor);
			}
			Actuate.transform(e.target, 0.25).color(firstColor);
		}
		
		bPay.addEventListener(MouseEvent.MOUSE_OVER, fadeIn);
		bPlay.addEventListener(MouseEvent.MOUSE_OVER, fadeIn);
		soundButton.addEventListener(MouseEvent.MOUSE_OVER, fadeIn);		
		
		bPay.addEventListener(MouseEvent.MOUSE_OUT, fadeOut);
		bPlay.addEventListener(MouseEvent.MOUSE_OUT, fadeOut);
		soundButton.addEventListener(MouseEvent.MOUSE_OUT, fadeOut);
	}
	
	function addSoundBtton() 
	{
		var paddingTop = 150;
		
		soundButton = new SoundButton();
		
		soundButton.width = 80;
		soundButton.height = 80;
		soundButton.x = Lib.current.stage.window.width / 2 - soundButton.width / 2;
		soundButton.y = Lib.current.stage.window.height / 2 - soundButton.height / 2 + paddingTop  + marginButtonsTop;
		
		addChild(soundButton);
	}
	
	function addButtonPay() 
	{
		bPay = new Sprite();
		bPay.addChild(new Bitmap(Assets.getBitmapData("img/basket.png"), PixelSnapping.NEVER, true));
		
		bPay.width = MainMenu.buttonSize;
		bPay.height = MainMenu.buttonSize;
		
		bPay.x = Lib.current.stage.window.width / 2 - bPay.width / 2 - Lib.current.stage.window.width / 4;
		bPay.y = Lib.current.stage.window.height / 2 - bPay.height / 2 + marginButtonsTop;
		
		bPay.buttonMode = true;
		
		#if vk_build
		
		bPay.addEventListener(MouseEvent.CLICK, VKController.paymentActivate);
		
		#end
		
		addChild(bPay);
	}
	
	function addButtonPlay() 
	{	
		bPlay = new Sprite();
		bPlay.addChild(new Bitmap(Assets.getBitmapData("img/play.png"), PixelSnapping.NEVER, true));
		
		bPlay.width = MainMenu.buttonSize;
		bPlay.height = MainMenu.buttonSize;
		
		bPlay.x = Lib.current.stage.window.width / 2 - bPlay.width / 2 + Lib.current.stage.window.width / 4;
		bPlay.y = Lib.current.stage.window.height / 2 - bPlay.height / 2 + marginButtonsTop;
		
		bPlay.buttonMode = true;		
		
		bPlay.addEventListener(MouseEvent.CLICK, bPlay_click);
		
		addChild(bPlay);
	}	
	
	private function bPlay_click(e:MouseEvent):Void 
	{
		this.dispatchEvent(new Event(MainMenu.EVENT_PLAY));
	}
}