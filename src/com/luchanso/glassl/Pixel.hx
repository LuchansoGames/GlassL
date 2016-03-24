package com.luchanso.glassl;

import motion.Actuate;
import openfl.display.Sprite;
import openfl.events.Event;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Pixel extends Sprite
{
	private var colors : Array<Int> = [0xF44336, 0xE91E63, 0xEF9A9A, 0x7B1FA2, 0x7B1FA2, 0x2196F3, 
									   0x1A237E, 0x6200EA, 0x00BCD4, 0x004D40, 0x18FFFF, 0xCDDC39,
									   0x00E676, 0x76FF03, 0xEEFF41, 0xE65100, 0xE65100, 0xE65100,
									   0x795548, 0x795548, 0x795548, 0x000000, 0xFFFFFF];
									   
	public var speedX : Float = 0;
	public var speedY : Float = 0;
	public var isDead : Bool = false;

	public function new() 
	{
		super();
		draw();
		
		addEventListener(Event.ADDED_TO_STAGE, addedToStage);
	}
	
	private function addedToStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		
		Actuate.tween(this, 3, { alpha: 0 } ).onComplete(function() {
			this.isDead = true;
			this.parent.removeChild(this);
		});
	}
	
	private function draw() : Void
	{
		graphics.beginFill(colors[Math.round(Math.random() * (colors.length - 1))]);
		graphics.drawRect(0, 0, 3, 3);
		graphics.endFill();
	}	
}