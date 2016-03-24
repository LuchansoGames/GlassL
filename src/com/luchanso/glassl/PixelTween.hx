package com.luchanso.glassl;

import openfl.display.Sprite;

/**
 * ...
 * @author Loutchansky Oleg
 */
class PixelTween
{
	public static var pixels : Array<Pixel> = new Array<Pixel>();
	
	public static function generate(stage : Sprite, count : Int, x : Float, y : Float) : Void
	{
		for (i in 0...count) 
		{
			var pixel = new Pixel();
			pixel.x = x;
			pixel.y = y;
			
			var angle = -Math.PI + Math.random() * Math.PI * 2;
			
			pixel.speedX = Math.cos(angle) * Math.random() * 15;
			pixel.speedY = Math.sin(angle) * Math.random() * 15;
			
			stage.addChild(pixel);
			pixels.push(pixel);
		}
	}
	
	public static function update(deltaTime : Float)
	{
		for (pixel in pixels)
		{
			pixel.x += pixel.speedX * deltaTime;
			pixel.y += pixel.speedY * deltaTime;
			
			if (pixel.isDead)
			{
				pixels.remove(pixel);
			}
		}
	}	
}