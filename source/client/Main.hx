package client;

import client.WebSocktClientJS;
import common.ParamServer;
import flixel.FlxGame;
import js.Browser;
import openfl.display.Sprite;

class Main extends Sprite
{
	var param_server:ParamServer;

	public function new()
	{
		super();
		param_server = new ParamServer();
		addChild(new FlxGame(336, 240, PlayState));
		addWebSocket();
	}

	public function addWebSocket()
	{
		var button = Browser.document.createButtonElement();
		button.textContent = "Click me!";
		button.onclick = function(event)
		{
			var ws = new WebSocketClientJS(param_server.host, param_server.port);
		}
		Browser.document.body.appendChild(button);
	}
}
