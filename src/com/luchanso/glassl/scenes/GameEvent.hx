package com.luchanso.glassl.scenes;

import flash.events.Event;

/**
 * ...
 * @author Loutchansky Oleg
 */
class GameEvent extends Event
{
	public var score : Int = 0;
	
	public static var LOSE = "lose";
	public static var PLAY = "play";

	public function new(type:String, bubbles:Bool=false, cancelable:Bool=false) 
	{
		super(type, bubbles, cancelable);		
	}
	
}