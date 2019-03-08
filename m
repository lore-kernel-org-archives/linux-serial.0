From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Date: Fri, 8 Mar 2019 11:04:49 +0100
Message-ID: <20190308100449.dccctqo6i4xa6bhq@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
 <20190304073856.GA552@jagdpanzerIV>
 <87va0uopmd.fsf@linutronix.de>
 <20190308013134.GB4063@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190308013134.GB4063@jagdpanzerIV>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Fri 2019-03-08 10:31:34, Sergey Senozhatsky wrote:
> On (03/07/19 13:06), John Ogness wrote:
> > On 2019-03-04, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> > > This, theoretically, creates a whole new world of possibilities for
> > > console drivers. Now they can do GFP_KERNEL allocations and stall
> > > printk_kthread during OOM; or they can explicitly reschedule from
> > > ->write() callback (via console_conditional_schedule()) because
> > > console_lock() sets console_may_schedule.
> > 
> This can stall the entire printing pipeline
> 
> OOM -> printk_kthread() -> console_lock() -> con_foo() -> kmalloc(GFP_KERNEL) -> OOM
> 
> > Although, as I mentioned in a previous response[0], perhaps we should
> > not loosen the requirements on write().
> 
> Right. Console drivers better stay restricted; very restricted.

I agree here.

> > It is exactly that disable_preempt() that is so harmful for realtime tasks.

> I'll reply in another email (later today, or tomorrow).

I see. But I have troubles to imagine a preemtible direct console
output. The result would be mixed messages on a single line.

Best Regards,
Petr
