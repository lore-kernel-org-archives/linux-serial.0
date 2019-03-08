From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Date: Fri, 8 Mar 2019 10:31:34 +0900
Message-ID: <20190308013134.GB4063@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
 <20190304073856.GA552@jagdpanzerIV>
 <87va0uopmd.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87va0uopmd.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (03/07/19 13:06), John Ogness wrote:
> On 2019-03-04, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> >> +	/* the printk kthread never exits */
> >> +	for (;;) {
> >> +		ret = prb_iter_wait_next(&iter, buf,
> >> +					 PRINTK_RECORD_MAX, &master_seq);
> >> +		if (ret == -ERESTARTSYS) {
> >> +			continue;
> >> +		} else if (ret < 0) {
> >> +			/* iterator invalid, start over */
> >> +			prb_iter_init(&iter, &printk_rb, NULL);
> >> +			continue;
> >> +		}
> >> +
> >> +		msg = (struct printk_log *)buf;
> >> +		format_text(msg, master_seq, ext_text, &ext_len, text,
> >> +			    &len, printk_time);
> >> +
> >> +		console_lock();
> >> +		if (len > 0 || ext_len > 0) {
> >> +			call_console_drivers(ext_text, ext_len, text, len);
> >> +			boot_delay_msec(msg->level);
> >> +			printk_delay();
> >> +		}
> >> +		console_unlock();
> >> +	}
> >
> > This, theoretically, creates a whole new world of possibilities for
> > console drivers. Now they can do GFP_KERNEL allocations and stall
> > printk_kthread during OOM; or they can explicitly reschedule from
> > ->write() callback (via console_conditional_schedule()) because
> > console_lock() sets console_may_schedule.
> 
> This was the intention.

This can stall the entire printing pipeline

OOM -> printk_kthread() -> console_lock() -> con_foo() -> kmalloc(GFP_KERNEL) -> OOM

> Although, as I mentioned in a previous response[0], perhaps we should
> not loosen the requirements on write().

Right. Console drivers better stay restricted; very restricted.

> It is exactly that disable_preempt() that is so harmful for realtime tasks.

I'll reply in another email (later today, or tomorrow).

	-ss
