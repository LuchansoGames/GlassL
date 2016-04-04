package com.luchanso.glassl.effects;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Expo;
import motion.easing.Linear;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Circle extends Sprite
{
	var radius : Float = 0;
	var lifeTime  : Float = 0;
	
	static var minimalRadius = 10;
	public static var maximalRadius = 200 + minimalRadius;
	

	public function new(x : Float, y : Float)
	{
		super();
		
		this.x = x;
		this.y = y;
		
		this.alpha = 0;
		
		radius = minimalRadius + Math.random() * (maximalRadius - minimalRadius);
		lifeTime = 3 + Math.random() * 6;
		
		draw();
		addAnimation();
	}
	
	function addAnimation() 
	{
		var direction = Math.random() > 0.5 ? -1 : 1;
		var speed = 15 + Math.random() * 20;
		var distance = direction * speed * lifeTime;
		
		Actuate.tween(this, lifeTime / 2, { alpha : 1 } ).ease(Back.easeOut).onComplete(function() {
			Actuate.tween(this, lifeTime / 2, { alpha: 0 } ).ease(Back.easeIn).onComplete(destroy);			
		});
		Actuate.tween(this, lifeTime, { x: x + distance } ).ease(Linear.easeNone);
	}
	
	function destroy()
	{
		dispatchEvent(new Event(Event.REMOVED));
		this.parent.removeChild(this);		
	}
	
	function draw()
	{
		graphics.beginFill(0xFFFFFF, 0.2);
		graphics.drawCircle(0, 0, radius);
		graphics.endFill();
	}
	
	
	
}