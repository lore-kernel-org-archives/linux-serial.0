From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 02/25] printk-rb: add prb locking functions
Date: Fri, 15 Feb 2019 11:26:35 +0100
Message-ID: <20190215102635.kdo4yxifh5dt2yj7@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-3-john.ogness@linutronix.de>
 <20190213154541.wvft64nf352vghou@pathway.suse.cz>
 <87pnrvs707.fsf@linutronix.de>
 <20190214103324.viexpifsyons5qya@pathway.suse.cz>
 <87y36ih8p7.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87y36ih8p7.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu 2019-02-14 13:10:28, John Ogness wrote:
> On 2019-02-14, Petr Mladek <pmladek@suse.com> wrote:
> >>> cpu_store looks like an implementation detail. The caller
> >>> needs to remember it to handle the nesting properly.
> >>> 
> >>> We could achieve the same with a recursion counter hidden
> >>> in struct prb_lock.
> >
> > The atomic operations are tricky. I feel other lost in them.
> > Well, I still think that it might easier to detect nesting
> > on the same CPU, see below.
> >
> > Also there is no need to store irq flags in per-CPU variable.
> > Only the first owner of the lock need to store the flags. The others
> > are spinning or nested.
> >
> > struct prb_cpulock {
> > 	atomic_t		owner;
> > 	unsigned int		flags;
> > 	int			nesting; /* intialized to 0 */
> > };
> >
> > void prb_lock(struct prb_cpulock *cpu_lock)
> > {
> > 	unsigned int flags;
> > 	int cpu;
> 
> I added an explicit preempt_disable here:
> 
>         cpu = get_cpu();

It is superfluous. Preemption is not possible when interrupts
are disabled.


> It looks great. I've run my stress tests on it and everything is running
> well.

I am glad to read this.
 
> Thanks for simplifying this!

You are welcome.

Best Regards,
Petr
