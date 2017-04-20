module simpletimers.repeating;

import core.time;
import simpletimers.base;

class RepeatingTimer : TimerBase
{
public:
	override void run()
	{
		if(initialDelay_ != seconds(0))
		{
			thread_.sleep(initialDelay_);
		}

		onTimer();

		MonoTime before = MonoTime.currTime;

		while(running_)
		{
			thread_.sleep(dur!("msecs")(10)); // Throttle so we don't take up too much CPU

			MonoTime after = MonoTime.currTime;
			immutable Duration dur = after - before;

			if(dur >= dur_)
			{
				onTimer();

				before = MonoTime.currTime;
				after = MonoTime.currTime;
			}
		}
	}
}

unittest
{
	class TestRepeatingTimer : RepeatingTimer
	{
		override void onTimer()
		{
			import std.stdio : writeln;

			++count_;
			writeln("TestRepeatingTimer.onTimer");

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
