/**
	A Simple library for creating a repeating timer.
*/
module simpletimers.repeating;

import core.time;
import simpletimers.base;

/**
	A Class for creating a repeating timer.
*/
class RepeatingTimer : TimerBase
{
protected:
	override void run()
	{
		onTimer();
	}
}

unittest
{
	class TestRepeatingTimer : RepeatingTimer
	{
		~this()
		{
			assert(count_ == 3);
		}

		override void onTimer()
		{
			import std.stdio : writeln;

			++count_;

			if(count_ == 3)
			{
				stop();
			}
		}

	private:
		size_t count_;
	}

	TestRepeatingTimer repeatingTimer = new TestRepeatingTimer;
	repeatingTimer.start();
}
