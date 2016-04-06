package com.luchanso.glassl.ui;

import flash.text.TextField;
import flash.text.TextFormat;
import motion.Actuate;
import motion.easing.Linear;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Score extends TextField
{
	var bindX : Float = 0;
	var bindY : Float = 0;
	var score : Int = 0;
	
	static var animationTime = 0.2;
	
	public function new()
	{
		super();
		this.defaultTextFormat = new TextFormat("Arial", 100, Config.colorScore);
		this.autoSize = TextFieldAutoSize.LEFT;
		this.selectable = false;
		this.mouseEnabled = false;
		
		setScore(0);
	}
	
	public function setScore(score : Int)
	{
		this.score = score;
		var fontScale : Float = 0;
		
		if (score < 10) 
		{
			fontScale = 5;
		}
		if (score >= 10 && score < 100) 
		{
			fontScale = 4;
		}
		if (score >= 100) 
		{
			fontScale = 2.7;
		}
		
		this.defaultTextFormat = new TextFormat("Arial", 100);
		this.scaleX = fontScale;
		this.scaleY = fontScale;
		
		this.text = score + "";
		this.x = Lib.current.stage.window.width / 2 - this.width / 2;
		this.y = Lib.current.stage.window.height / 2 - this.height / 2;
		
		var scale = 0.5;
		var tx = x - (width / (scale + scaleX)) / 4;
		var ty = y - (height / (scale + scaleY)) / 4;
		
		Actuate.tween(this, animationTime, { scaleX: scaleX + scale, scaleY: scaleY + scale, x: tx, y: ty } ).ease(Linear.easeNone).reverse();
	}
	
	public function getScore()
	{
		return score;
	}
}