From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Date: Tue, 23 Oct 2018 15:25:35 +0900
Message-ID: <20181023062535.GA504@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016122734.GA1259@jagdpanzerIV>
 <20181016125415.GA3121@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181016125415.GA3121@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (10/16/18 14:54), Peter Zijlstra wrote:
> 
> No, no wakups. irq_work to wake the printk-thread, at most.
> 

There are cases when we probably prefer to be in "direct printk" mode.
E.g. sysrq or late PM stages (probably).

Doing irq_work->wake_up_process->printk_kthread from sysrq probably
might not work all the time, so direct printk path may look more
"reliable" in some cases. In *theory* (just in theory), we can do

	void __handle_sysrq(int key, bool check_mask)
	{
		...
		op_p->handler(key);
		...

+		if (console_trylock())
+			console_unlock();
	}

type of thing. So sysrq handler will just log_store() the data and we
will try to flush logbuf immediately once we are dont with sysrq handler.
This will require additional work, tho. Some sysrq handlers can print
significant (depends on serial console baud) amounts of data. For instance,
sysrq_handle_showstate() calls show_workqueue_state() and show_state(),
which do numerous printk()-s. Therefore, those functions touch NMI and
softlockup watchdogs:

	void show_workqueue_state(void)
	{
		for_each_pwq(pwq, wq) {
			...
			touch_nmi_watchdog();
		}

		for_each_pool(pool, pi) {
			...
			touch_nmi_watchdog();
		}
	}

and

	void show_state_filter(unsigned long state_filter)
	{
		for_each_process_thread(g, p) {
			touch_nmi_watchdog();
			touch_all_softlockup_watchdogs();
			...
		}
	}

If we will move the actual printout to console_unlock() then we will
have to start touching watchdogs from console_unlock().

Another troubling moment might be that with completely async printk()
it's easier to cause logbuf wrap around; because CPU which does printk()
in a loop is always async, console drivers don't throttle it anymore;
currently it's sometimes sync (when console_sem is not locked, or locked
but we have active console_sem_owner) or async (when console_sem is
locked and there is no active console_sem_owner).

	-ss
