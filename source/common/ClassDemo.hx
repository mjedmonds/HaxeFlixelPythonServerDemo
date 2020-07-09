package common;

// This class provides a demo of how a class can be used on both the JS and Python side of the program
class Point
{
	var x:Int;
	var y:Float;

	public function toString()
	{
		return "Point(" + this.x + "," + this.y + ")";
	}
}

class ClassDemo
{
	var points:Array<Point>;

	public function toString()
	{
		for (p in points)
		{
			trace(p.toString());
		}
	}
}
