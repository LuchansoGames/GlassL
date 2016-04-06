package com.luchanso.glassl.ui.dialogs;

import openfl.events.Event;

/**
 * ...
 * @author Loutchansky Oleg
 */
class DialogReliveEvent extends DialogEvent
{
	public static RELIVE = "relive";

	public function new(type:String, bubbles:Bool=false, cancelable:Bool=false) 
	{
		super(type, bubbles, cancelable);		
	}
	
}