package com.luchanso.glassl;
import flash.events.EventDispatcher;
import openfl.events.Event;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Config
{
	public static var COINS_CHANGE = 'set_coins';
	public static var events : EventDispatcher = new EventDispatcher();
	
	public static var colorBounce : Int = 0xFFFF00;
	public static var colorLight : Int = 0x03A9F4;
	public static var colorScore : Int = 0xAFE7FE;
	
	public static var soundOn : Bool = true;
	
	public static var secret : String = "$1$cpwdDRMK$P7z564nKedEutjtSISisp1";
	public static var urlAddress : String = "http://37.139.30.134";
	public static var adsId : String = "75540";
	
	public static var coins(get, set) : Int;
	private static var _coins : Int = 0;
	
	static function get_coins():Int 
	{
		return _coins;
	}
	
	static function set_coins(value:Int):Int 
	{
		_coins = value;
		
		events.dispatchEvent(new Event(COINS_CHANGE));
		
		return _coins;
	}
}
