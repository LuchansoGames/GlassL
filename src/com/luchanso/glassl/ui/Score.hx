package com.luchanso.glassl.ui;

import flash.text.TextField;
import flash.text.TextFormat;
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
	
	public function new()
	{
		super();
		this.defaultTextFormat = new TextFormat("Arial", 500, Config.colorScore);
		this.autoSize = TextFieldAutoSize.LEFT;
		this.selectable = false;
		this.mouseEnabled = false;
		
		this.text = "0";
		
		this.x = Config.width / 2 - this.width / 2;
		this.y = Config.height / 2 - this.height / 2;
	}
	
	public function setScore(score : Int)
	{
		this.score = score;
		var fontSize = 0;
		
		if (score < 10) 
		{
			fontSize = 500;
		}
		if (score >= 10 && score < 100) 
		{
			fontSize = 400;
		}
		if (score >= 100) 
		{
			fontSize = 270;
		}
		
		this.defaultTextFormat = new TextFormat("Arial", fontSize);
		this.text = score + "";
		this.x = Config.width / 2 - this.width / 2;
		this.y = Config.height / 2 - this.height / 2;
	}
	
	public function getScore()
	{
		return score;
	}
}