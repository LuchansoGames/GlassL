package com.luchanso.glassl;

import motion.Actuate;
import motion.easing.Linear;
import openfl.utils.Timer;
import src.com.luchanso.glassl.Wall;

/**
 * ...
 * @author Loutchansky Oleg
 */
class DynamicWall extends Wall
{
	public var isActive : Bool = false;
	public var isSleep : Bool = false;

	public function new(x, y, width, height) 
	{
		super(x, y, width, height);
		this.alpha = 0;
	}
	
	private override function draw(width : Float, height : Float) : Void
	{
		var countSprips = 10;
		var x : Float = 0;
		var y : Float = 0;
		var tempWidth = width / (countSprips * 2 + 1);
		
		for (i in 0...(countSprips))
		{
			x = tempWidth + tempWidth * 2 * i;
			
			graphics.beginFill(Config.colorLight);
			graphics.drawRect(x, y, tempWidth, height);
			graphics.endFill();
		}
	}
	
	public function show(time : Float) : Void
	{
		this.isActive = true;
		this.isSleep = true;
		
		Actuate.tween(this, time / 2, { alpha: 1 } ).ease(Linear.easeNone).onComplete(function() {
			hide(time / 2);
		});
		Actuate.tween(this, time * 1.2, { } ).onComplete(function() {
			this.isSleep = false;
		});
	}
	
	public function hide(time : Float) : Void
	{
		Actuate.tween(this, time, { alpha: 0 } ).ease(Linear.easeNone).onComplete(function() {
			this.isActive = false;
		});
	}
}