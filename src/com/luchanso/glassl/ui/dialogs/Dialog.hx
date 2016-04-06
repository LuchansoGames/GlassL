package com.luchanso.glassl.ui.dialogs;

import flash.display.Sprite;
import openfl.Lib;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Dialog extends Sprite
{	
	var dWidth : Float;
	var dHeight : Float;
	
	var marginLeft : Float;
	var marginTop : Float;

	public function new()
	{
		super();
		
		initVars();
		draw();
		
		addEventListener(Event.ADDED_TO_STAGE, addedToStage);
	}
	
	private function addedToStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		
		addMouseEvent();
	}
	
	function initVars() 
	{
		dWidth = Lib.current.stage.window.width * 0.75;
		dHeight = Lib.current.stage.window.height * 0.75;
		
		marginLeft = Lib.current.stage.window.width / 2 - dWidth / 2;
		marginTop = Lib.current.stage.window.height / 2 - dHeight / 2;
	}
	
	function addMouseEvent() 
	{
		this.stage.addEventListener(MouseEvent.CLICK, click);
	}
	
	private function click(e:MouseEvent):Void 
	{
		if (e.stageX < marginLeft ||
			e.stageX > marginLeft + dWidth ||
			e.stageY < marginTop || 
			e.stageX > marginTop + dHeight) 
		{
			dispatchEvent(new DialogEvent(DialogEvent.CLOSE));
			this.hide();
		}
	}
	
	function draw() 
	{	
		graphics.beginFill(0x000000, 0.6);
		graphics.drawRect(0, 0, Lib.current.stage.window.width, Lib.current.stage.window.height);
		graphics.endFill();		
		
		graphics.beginFill(0xFFFFFF);
		graphics.drawRect(marginLeft, marginTop, dWidth, dHeight);
		graphics.endFill();
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