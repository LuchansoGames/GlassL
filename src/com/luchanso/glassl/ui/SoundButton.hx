package com.luchanso.glassl.ui;

import flash.display.Bitmap;
import flash.events.Event;
import openfl.Assets;
import openfl.display.PixelSnapping;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Loutchansky Oleg
 */
class SoundButton extends Sprite
{
	public var isStateOn(get, null) : Bool;
	
	var soundOff : Bitmap;
	var soundOn : Bitmap;
	var _isStateOn : Bool;

	public function new()
	{
		super();
		
		soundOn = new Bitmap(Assets.getBitmapData("img/sound-on.png"), PixelSnapping.NEVER, true);
		soundOff = new Bitmap(Assets.getBitmapData("img/sound-off.png"), PixelSnapping.NEVER, true);
		
		mouseEnabled = true;		
		this.buttonMode = true;
		
		this.addEventListener(MouseEvent.CLICK, click);
		
		addChild(soundOn);
		addChild(soundOff);
		
		if (Config.soundOn) 
		{
			setStateOn();
		} 
		else 
		{
			setStateOff();
		}
	}
	
	private function click(e:MouseEvent):Void 
	{
		if (_isStateOn) 
		{
			setStateOff();
		}
		else 
		{
			setStateOn();
		}
	}
	
	public function setStateOff() : Void
	{
		soundOff.visible = true;
		soundOn.visible = false;
		Config.soundOn = _isStateOn = false;
	}
	
	public function setStateOn() : Void
	{
		soundOff.visible = false;
		soundOn.visible = true;
		Config.soundOn = _isStateOn = true;
	}
	
	function get_isStateOn() : Bool 
	{
		return _isStateOn;
	}
}