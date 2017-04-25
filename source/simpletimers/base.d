module simpletimers.base;

import core.thread : Thread;
import core.time;

class TimerBase
{
public:
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
