package com.luchanso.glassl.ui.dialogs;
import flash.events.Event;

/**
 * ...
 * @author Loutchansky Oleg
 */
class DialogEvent extends Event
{	
	public static CLOSE = "close";

	public function new(type:String, bubbles:Bool=false, cancelable:Bool=false) 
	{
		super(type, bubbles, cancelable);
	}
	
}