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
		onTimer();
		super.stop();
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
