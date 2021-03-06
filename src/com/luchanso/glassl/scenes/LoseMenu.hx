package com.luchanso.glassl.scenes;

import com.luchanso.glassl.ui.ADScap;
import com.luchanso.glassl.ui.dialogs.DialogReliveEvent;
import com.luchanso.glassl.ui.dialogs.ReliveDialog;
import com.luchanso.glassl.ui.table.Rating;
import com.luchanso.glassl.vk.VKController;
import openfl.display.Loader;
import openfl.net.URLRequest;
import openfl.system.ApplicationDomain;
import openfl.system.LoaderContext;
import openfl.system.SecurityDomain;
import openfl.text.TextField;
import motion.Actuate;
import openfl.Assets;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.PixelSnapping;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.ui.Keyboard;
import vk.Ads;
import vk.Vk;

/**
 * ...
 * @author Loutchansky Oleg
 */
class LoseMenu extends Scene
{
	var bPlay : Sprite;
	var bRelive : Sprite;
	var bShare : Sprite;
	var scoreLable : TextField;
	var reliveDialog : ReliveDialog;
	
	var adscap : ADScap;
	var ads : Dynamic;
	
	static var firstColor = 0xFFFFFF;
	static var secondColor = Config.colorLight;
	
	static var buttonSize = 125;
	static var margin = 15;
	
	var tableSizeWidth = Lib.current.stage.window.width - 250;
	var tableSizeHeight = Lib.current.stage.window.height - 185;
	var paddingTopBtn : Float;
	var marginBtn = 15;
	var tableRating : Rating;
	
	var score : Int = 0;
	
	// Рекламный блок = 185px
	public function new() 
	{
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		
		paddingTopBtn = tableSizeHeight / 2 - ((buttonSize) * 3 + marginBtn * 2) / 2 + 35;
		
		addButtonPlay();
		addButtonRelive();
		addButtonShare();
		
		addScoreLable();
		
		addAnimationForButtons();
		
		addTableRating();
		
		addReliveDialog();
	}
	
	function addReliveDialog() 
	{
		reliveDialog = new ReliveDialog();
		reliveDialog.visible = false;
		reliveDialog.alpha = 0;
		
		reliveDialog.addEventListener(DialogReliveEvent.BUY_COINS, buy_coins);
		
		addChild(reliveDialog);
	}
	
	private function buy_coins(e:DialogReliveEvent):Void 
	{
		#if vk_build
		
		VKController.paymentActivate();
		
		#end
	}
	
	function addTableRating() 
	{
		tableRating = new Rating(tableSizeWidth, tableSizeHeight);
		
		addChild(tableRating);
	}
	
	private function addedToStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		
		addADS();
		
		this.stage.addEventListener(KeyboardEvent.KEY_DOWN, function(_)
		{
			if (this.visible)
				dispatchEvent(new Event(GameEvent.PLAY));
		});
	}
	
	public function setScore(score : Int)
	{
		this.score = score;
		var windowWidth = Lib.current.stage.window.width;
		scoreLable.text = score + " pts";
		scoreLable.x = windowWidth - (windowWidth - (tableSizeWidth + margin)) / 2 - scoreLable.width / 2;
	}
	
	function addScoreLable()
	{
		scoreLable = new TextField();
		scoreLable.defaultTextFormat = new TextFormat("Arial", 50, 0xFFFFFF);
		scoreLable.autoSize = TextFieldAutoSize.LEFT;
		scoreLable.selectable = false;
		scoreLable.mouseEnabled = false;
		
		scoreLable.y = margin;
		
		setScore(0);
		
		addChild(scoreLable);
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
		
		bPlay.addEventListener(MouseEvent.MOUSE_OVER, fadeIn);
		bShare.addEventListener(MouseEvent.MOUSE_OVER, fadeIn);
		bRelive.addEventListener(MouseEvent.MOUSE_OVER, fadeIn);

		bPlay.addEventListener(MouseEvent.MOUSE_OUT, fadeOut);
		bShare.addEventListener(MouseEvent.MOUSE_OUT, fadeOut);
		bRelive.addEventListener(MouseEvent.MOUSE_OUT, fadeOut);
	}
	
	function addButtonPlay() 
	{		
		var windowWidth = Lib.current.stage.window.width;
		
		bPlay = new Sprite();
		bPlay.addChild(new Bitmap(Assets.getBitmapData("img/play.png"), PixelSnapping.NEVER, true));
		
		bPlay.width = LoseMenu.buttonSize;
		bPlay.height = LoseMenu.buttonSize;
		
		bPlay.x = windowWidth - (windowWidth - (tableSizeWidth + margin)) / 2 - bPlay.width / 2;
		bPlay.y = paddingTopBtn;
		
		bPlay.buttonMode = true;
		
		bPlay.addEventListener(MouseEvent.CLICK, bPlay_click);
		
		addChild(bPlay);
	}
	
	function addButtonRelive() 
	{
		var windowWidth = Lib.current.stage.window.width;
		
		bRelive = new Sprite();
		bRelive.addChild(new Bitmap(Assets.getBitmapData("img/health.png"), PixelSnapping.NEVER, true));
		
		bRelive.width = LoseMenu.buttonSize;
		bRelive.height = LoseMenu.buttonSize;
		
		bRelive.x = windowWidth - (windowWidth - (tableSizeWidth + margin)) / 2 - bRelive.width / 2;
		bRelive.y = bPlay.y + bPlay.height + marginBtn;
		
		bRelive.buttonMode = true;
		
		bRelive.addEventListener(MouseEvent.CLICK, click_bRelive);
		
		addChild(bRelive);
	}
	
	private function click_bRelive(e:MouseEvent):Void 
	{
		reliveDialog.show();
	}
	
	function addButtonShare() 
	{
		var windowWidth = Lib.current.stage.window.width;
		
		bShare = new Sprite();
		bShare.addChild(new Bitmap(Assets.getBitmapData("img/share.png"), PixelSnapping.NEVER, true));
		
		bShare.width = LoseMenu.buttonSize;
		bShare.height = LoseMenu.buttonSize;
		
		bShare.x = windowWidth - (windowWidth - (tableSizeWidth + margin)) / 2 - bShare.width / 2;
		bShare.y = bRelive.y + bRelive.height + marginBtn;
		
		bShare.buttonMode = true;
		
		bShare.addEventListener(MouseEvent.CLICK, bShare_click);
		
		addChild(bShare);
	}
	
	private function bShare_click(e:MouseEvent):Void 
	{
		VKController.publicateWallResult(this.score);
	}
	
	private function bPlay_click(e:MouseEvent):Void 
	{
		dispatchEvent(new Event(GameEvent.PLAY));
	}
	
	function addADS()
	{
		adscap = new ADScap();		
		adscap.x = 0;
		adscap.y = Lib.current.stage.window.height - 185;
		addChildAt(adscap, getChildIndex(tableRating));
		
		Vk.initADS(finishAddADS);
	}
	
	function finishAddADS(_)
	{		
		ads = Ads.create(Config.adsId, adscap.x, adscap.y, adscap.width, adscap.height, Lib.current.stage.loaderInfo.parameters, 4, true);

		addChildAt(ads, getChildIndex(adscap) + 1);
	}
}