package client;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		// launch game
		addChild(new FlxGame(336, 240, PlayState));
	}
	// public function addWebSocket()
	// {
	// 	var button = Browser.document.createButtonElement();
	// 	button.textContent = "Click me!";
	// 	button.onclick = function(event)
	// 	{
	// 		var ws = new WebSocketClientJS(param_server.host, param_server.port);
	// 	}
	// 	Browser.document.body.appendChild(button);
	// }
}
