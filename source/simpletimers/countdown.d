module simpletimers.countdown;

import core.time;
import simpletimers.base;

class CountdownTimer : TimerBase
{
protected:
	override void run()
	{
		immutable MonoTime before = MonoTime.currTime;

		while(running_)
		{
			thread_.sleep(dur!("msecs")(10)); // Throttle so we don't take up too much CPU

			immutable MonoTime after = MonoTime.currTime;
			immutable Duration dur = after - before;

			if(dur >= dur_)
			{
				onTimer();
				running_ = false;
			}
		}
	}
}

unittest
{
	class TestCountdownTimer : CountdownTimer
	{
		override void onTimer()
		{
			import std.stdio : writeln;
			writeln("TestCountdownTimer.onTimer");
		}
	}

	TestCountdownTimer countdownTimer = new TestCountdownTimer;
	countdownTimer.start();
}
