/**
	A Simple library for creating a countdown timer.
*/
module simpletimers.countdown;

import core.time;
import simpletimers.base;

/**
	A Class for creating a countdown timer.
*/
class CountdownTimer : TimerBase
{
protected:
	override void run()
	{
		immutable MonoTime before = MonoTime.currTime;

		while(super.isRunning())
		{
			thread_.sleep(dur!("msecs")(10)); // Throttle so we don't take up too much CPU

			immutable MonoTime after = MonoTime.currTime;
			immutable Duration dur = after - before;

			if(dur >= dur_)
			{
				onTimer();
				super.stop();
			}
		}
	}
}

unittest
{
	class TestCountdownTimer : CountdownTimer
	{
		~this()
		{
			assert(onTimerExecuted_ == true);
		}

		override void onTimer()
		{
			onTimerExecuted_ = true;
		}

		bool onTimerExecuted_;
	}

	TestCountdownTimer countdownTimer = new TestCountdownTimer;
	countdownTimer.start();
}
