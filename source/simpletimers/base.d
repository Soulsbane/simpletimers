/**
	Base library for creating timers.
*/
module simpletimers.base;

import core.thread : Thread;
import core.time;

/**
	Base class for creating a timer.
*/
class TimerBase
{
public:
	/**
		Starts a timer.

		Params:
			dur = $(LINK2 http://dlang.org/phobos/core_time.html#.Duration, Duration) in which onTimer should be called.
			initialDelay = The $(LINK2 http://dlang.org/phobos/core_time.html#.Duration, Duration) to wait before
				starting the timer.
	*/
	void start(const Duration dur = dur!("seconds")(1), const Duration initialDelay = dur!("seconds")(0))
	{
		dur_ = dur;
		initialDelay_ = initialDelay;
		thread_ = new Thread(&startInfiniteLoop);

		thread_.start();
	}

	private void startInfiniteLoop()
	{
		MonoTime before = MonoTime.currTime;

		startInitialDelay();

		while(isRunning())
		{
			thread_.sleep(dur!("msecs")(10)); // Throttle so we don't take up too much CPU

			MonoTime after = MonoTime.currTime;
			immutable Duration dur = after - before;

			if(dur >= dur_)
			{
				run();

				before = MonoTime.currTime;
				after = MonoTime.currTime;
			}
		}
	}

	private void startInitialDelay()
	{
		if(initialDelay_ != seconds(0))
		{
			thread_.sleep(initialDelay_);
		}

		onTimer();
	}

	/**
		Starts a timer.

		Params:
			seconds = Duration in which onTimer should be called.
			initialDelay = The $(LINK2 http://dlang.org/phobos/core_time.html#.Duration, Duration) to wait before
				starting the timer.
	*/
	/*void start(const size_t seconds = 1, const size_t initialDelay = 0)
	{
		start(dur!("seconds")(seconds), dur!("seconds")(initialDelay));
	}*/

	/**
		Stops a timer.
	*/
	void stop()
	{
		running_ = false;
	}

	/**
		Returns whether the timer is running.

		Returns:
			True if the timer is running false otherwise.
	*/
	bool isRunning() const
	{
		return running_;
	}

	void onTimerStop() {}
	void onTimerStart() {}

	abstract void run() {}
	abstract void onTimer() {}

protected:
	bool running_ = true;
	Thread thread_;
	Duration dur_;
	Duration initialDelay_;
}
