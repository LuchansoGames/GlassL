package com.luchanso.glassl.scenes;

import openfl.display.Sprite;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Scene extends Sprite
{

	public function new() 
	{
		super();
		
	}
	
	public function show() : Void
	{
		visible = true;
	}
	
	public function hide() : Void
	{
		visible = false;
	}
	
}