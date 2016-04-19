package com.luchanso.glassl.client;

import com.luchanso.tools.http.LWeb;
import haxe.Json;
import haxe.crypto.Md5;
import haxe.crypto.Base64;
import haxe.io.Bytes;
import haxe.io.BytesBuffer;
import openfl.events.Event;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.net.URLVariables;
import pgr.dconsole.DC;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Client
{
	public static function getCoinsById(id : String, callback : Dynamic)
	{
		var data = LWeb.DynamicToPOST( { id : id } );
		
		var loader = getLoader(Config.urlAddress + "/glassl/getcoins", true, data);
		loader.addEventListener(Event.COMPLETE, function(e:Event)
		{			
			var loader = cast(e.target, URLLoader);
			var data = loader.data;
			
			callback(Json.parse(data).coins);
		});
	}
	
	public static function getScoreTable(callback : Dynamic)
	{
		var loader = getLoader(Config.urlAddress + "/glassl/getrating");
		loader.addEventListener(Event.COMPLETE, function(e:Event)
		{
			var loader = cast(e.target, URLLoader);
			var data = loader.data;
			
			callback(data);
		});
	}
	
	/**
	 * Потратить N монеток
	 */
	public static function useCoins(n : Int, id : String, callback : Dynamic)
	{
		var data = LWeb.DynamicToPOST(addSignToData( { id: id, coins: Std.string(n) } ));
		
		var loader = getLoader(Config.urlAddress + "/glassl/writeoffcoins", true, data);
		loader.addEventListener(Event.COMPLETE, function(e:Event)
		{			
			var loader = cast(e.target, URLLoader);
			var data = loader.data;
			
			callback(data);
		});
	}
	
	public static function setNewScore(n : Int, id : String, callback : Dynamic) : Void
	{
		var data = LWeb.DynamicToPOST(addSignToData( { id: id, score: Std.string(n) } ));
		
		var loader = getLoader(Config.urlAddress + "/glassl/newattaitment", true, data);
		loader.addEventListener(Event.COMPLETE, function(e:Event)
		{			
			var loader = cast(e.target, URLLoader);
			var data = loader.data;
			
			callback(data);
		});
	}
	
	static function addSignToData(data : Dynamic) : Dynamic
	{
		var secret = Config.secret;
		
		var bytesBuffer = new BytesBuffer();
		bytesBuffer.addString(Std.string(Math.random()));
				
		var rand = Base64.encode(bytesBuffer.getBytes());
		
		var verefyString = Md5.encode(rand + Json.stringify(data) + secret);
		trace(rand + Json.stringify(data) + secret);
		
		data.key = rand;
		data.sign = verefyString;
		
		return data;
	}
	
	static function getLoader(url : String, isPost : Bool = false, data : Dynamic = null) : URLLoader
	{
		var request = new URLRequest(url);
		if (isPost)
		{
			request.method = "POST";
		}
		else 
		{
			request.method = "GET";
		}
		if (data)
		{
			request.data = data;
		}
		var loader = new URLLoader(request);
		
		return loader;
		
	}
}