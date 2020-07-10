# HaxeFlixelPythonServerDemo

This project is a demonstration of communication between a HaxeFlixel game (JS) and a server (Python) written in Haxe. The benefit of doing this is being able to write common code for both the game/client and the server in Haxe. This is a bare bones proof of concept repo, and is functionally nothing more than Haxeflixel's 58th demo game.

## Dependencies

Install [Haxe](https://haxe.org/download/) and [HaxeFlixel](https://haxeflixel.com/documentation/getting-started/).

Additionally, you'll need to install the following haxelib dependencies:

```
haxelib install haxe-ws
```

## Execution

The current implementation showcases how to transmit a common class `PointArray` from the game to the server. To transmit the message, click the "Send message" button in the game on your web browser. If you open the console on your browser, you should see messages being exchanged between the client and server. In the server window output, you should see the same set of points as printed to the client console when you pressed the "Send message" button.

### Server

To build the server, execute

```
haxe WebSocketServerPy.hxml
```

After building, the server build output is located at [export/server](export/server).

Launch the server by executing

```
python export/server/python/WebSocketServerPy.py
```

### Client

To build and run the client, execute

```
lime test Project.xml html5 --connect 6000
```

This should launch your web browser at http://127.0.0.1:3000/. If you just wish to build the output, you can run `lime build Project.xml html5 --connect 6000`

After building, the client build output is located at [export/client](export/client).
