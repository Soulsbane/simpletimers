/**
*	Base library for creating timers.
*/
module simpletimers.base;

import core.thread : Thread;
import core.time;

/**
*	Base class for creating a timer.
*/
class TimerBase
{
public:
	/**
	*	Starts a timer.
	*
	*	Params:
	*		dur = $(LINK2 http://dlang.org/phobos/core_time.html#.Duration, Duration) in which onTimer should be called.
	*		initialDelay = The $(LINK2 http://dlang.org/phobos/core_time.html#.Duration, Duration) to wait before
	*			starting the timer.
	*/
	void start(const Duration dur = dur!("seconds")(1), const Duration initialDelay = dur!("seconds")(0))
	{
		dur_ = dur;
		initialDelay_ = initialDelay;
		thread_ = new Thread(&run);
		thread_.start();
	}

	void stop()
	{
		running_ = false;
	}

	abstract void run() {}
	abstract void onTimer() {}

protected:
	bool running_ = true;
	Thread thread_;
	Duration dur_;
	Duration initialDelay_;
}
