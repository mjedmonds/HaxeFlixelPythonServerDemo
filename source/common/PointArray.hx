package common;

// This class provides a demo of how a class can be used on both the JS and Python side of the program
class Point
{
	public var x:Float;
	public var y:Float;

	public function new(x:Float, y:Float)
	{
		this.x = x;
		this.y = y;
	}

	public function toString()
	{
		return "Point(" + this.x + "," + this.y + ")";
	}
}

class PointArray
{
	public var points:Array<Point>;

	public function new()
	{
		// dummy instantiation to fill the array with some points
		points = new Array<Point>();
		for (i in 0...3)
		{
			var p = new Point(i, i + 5);
			points.push(p);
		}
	}

	public function toString()
	{
		var s = "";
		for (p in points)
		{
			s += "\t" + p.toString();
		}
		return s;
	}
}
