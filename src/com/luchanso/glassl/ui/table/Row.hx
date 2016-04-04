package com.luchanso.glassl.ui.table;

import motion.Actuate;
import motion.easing.Linear;
import motion.easing.Quint;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Row extends Sprite
{
	public static var heightRow = 30;

	static var marginLR = 10;
	static var padding = 10;
	
	var tableWidth : Float;
	
	var position : TextField;
	var avatar : Bitmap;
	var username : TextField;
	var score : TextField;
	
	public function new(position : Int, avatar : Bitmap, username : String, score : Int, tableWidth : Float)
	{
		super();
		
		this.tableWidth = tableWidth;
		
		addPositionLable(position);
		addAvatar(avatar);
		addScore(score);
		addPlayerName(username);
	}
	
	function addScore(score : Int) 
	{	
		this.score = initTextField(this.score);
		this.score.text = Std.string(score) + " pts";
		
		this.score.x = tableWidth - this.score.width;
		this.score.y = heightRow / 2 - this.score.height / 2;
		
		addChild(this.score);
	}
	
	function addPlayerName(username : String)
	{		
		var usernameWidth = this.score.x - (avatar.x + avatar.width) - padding * 2;
		
		this.username = initTextField(this.username);
		this.username.text = username;
		
		var textSizePx = Std.int(this.username.width);
		
		trace(textSizePx);
		
		if (this.username.width > usernameWidth) 
		{
			this.username.autoSize = TextFieldAutoSize.NONE;
			this.username.width = usernameWidth;
			
			Actuate.tween(this.username, 5, { scrollH : textSizePx } ).repeat().ease(Linear.easeNone);
		}
		
		this.username.x = avatar.x + avatar.height + padding;
		this.username.y = heightRow / 2 - this.username.height / 2;
		
		addChild(this.username);
	}
	
	function addAvatar(avatar : Bitmap) 
	{
		this.avatar = avatar;
		this.avatar.height = heightRow * 0.75;
		this.avatar.width = heightRow * 0.75;
		this.avatar.x = position.x + position.width + padding;
		this.avatar.y = heightRow / 2 - this.avatar.height / 2;
		
		addChild(this.avatar);
	}
	
	function addPositionLable(position : Int)
	{
		this.position = initTextField(this.position);
		this.position.text = Std.string(position) + ".";
		
		this.position.x = marginLR;
		this.position.y = heightRow / 2 - this.position.height / 2;
		
		addChild(this.position);
	}
	
	function initTextField(textField : TextField)
	{
		textField = new TextField();
		textField.defaultTextFormat = new TextFormat("Arial", 16, 0xFFFFFF);
		textField.selectable = false;
		textField.mouseEnabled = false;
		textField.autoSize = TextFieldAutoSize.LEFT;
		
		return textField;
	}
}