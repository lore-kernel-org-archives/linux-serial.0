From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Date: Wed, 17 Oct 2018 13:32:51 +0900
Message-ID: <20181017043251.GC1068@jagdpanzerIV>
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
> On Tue, Oct 16, 2018 at 09:27:34PM +0900, Sergey Senozhatsky wrote:
> > per-CPU printk_safe _semi-magic_ makes some things simple to handle.
> > We can't just remove per-CPU buffers and add a wake_up_process() at
> > the bottom of vprintk_emit(). Because this will deadlock:
> > 
> >   printk()
> >    wake_up_process()
> >     try_to_wake_up()
> >      raw_spin_lock_irqsave()
> >  <NMI>
> >       printk()
> >        wake_up_process()
> >         try_to_wake_up()
> >          raw_spin_lock_irqsave()
> > 
> > So we still need some amount of per-CPU printk() semi-magic anyway.
> 
> All we need is 4 max-line-length buffers per-CPU. Nothing more.

OK, similar to what Steven did with cpu_buffer->current_context.

> The above trainwreck is the direct result of forcing synchronous
> printk'ing (which I'm otherwise a big fan of, but regular console
> drivers stink and are unfixable).

Yep.

> > And printk-kthread offloding will not eliminate the need of
> > printk_deferred().
> 
> Why not? printk() will reduce to a lockless buffer insert. IOW _all_
> printk is deferred.

Aha! Interesting. I didn't realize you were talking about
"all printk()-s are deferred".
OK, jump to the last part of this mail.

> All you need are 4 max-line-length buffers per CPU and a global/shared
> lockless buffer.
> 
> printk will determine the current context:
> 
>   task, softirq, hardirq or NMI
> 
> and pick the corresponding per-cpu line buffer and do the vsnprintf()
> thing. Then we have the actual line length and content. With the length
> we reserve the bytes from the global buffer, we memcpy into the buffer
> and commit.
> 
> Done.
> 
> The printk thread will observe it lags behind the buffer head and will
> start printk-ing crud from task context.

[you can skip this part]

This probably will be a bit more hairy. logbuf is written to by many
sources and is read from by many sides, including user-space [both read()
and write()]. So we will need more flags/magic around memcpy(). A simple,
"grab the logbuf entry, set the proper offset to point to the next available
logbuf record and then do memcpy()" won't suffice. We need a flag for
"memcpy() complete, we can read this entry". Otherwise:

CPU0		CPU1		CPU2			CPU3
printk		printk					printk_kthread
logbuf_entry A	logbuf_entry B  syslog(read all)	call_console_drivers
memcpy		memcpy		read unfinished		print unfinished
					A and B			A and B

[..]

> > We do, however, have loads of problems with all those dependencies which
> > come from serial drivers and friends: timekeeping, scheduler (scheduler
> > is brilliant and cool, but we do have some deadlocks in printk because of
> > it ;), tty, net, MM, wq, etc. So I generally like the idea of "detached
> > serial consoles" (that's what I call it). IOW, elimination of the direct
> > printk -> serial console path. 
> 
> Right; we need to get rid of that in the generic case. Only allow
> lockless consoles (earlycon) to be used synchonously. With maybe a
> special case for the BUG/PANIC case to push things out ASAP.
[..]
> > So, unless I'm missing something, things are not entirely that simple:
> > - throw away printk_safe semi-magic
> > - add a lockless logbuf
> > - add wake_up_process() to vprintk_emit().
> 
> No, no wakups. irq_work to wake the printk-thread, at most.

All right. OK. So we are on the same page here:

printk has internal locks - logbuf spin_lock; and external locks - all
the scheduler locks, console_sem, net, tty, wq, you name it. printk() is
not aware of those external locks; the only way to fix it is to remove
them from printk(). And that's why

	"turn printk() into printk_deferred() and fix printk() deadlocks
	 in general case"

was my final proposal at the 2016 KS, NM, USA [1] (grep for printk_deferred).
I mentioned this idea several times since then, and even sent a patch, doing
this "printk is now printk_deferred unless we are in panic" thing. As far
as I remember, back then the idea/patch were rejected [2], and one of
reviewers even hinted that I was crazy :-) I have absolutely no issues
with that, but, considering past experiences, I'd really like to:

- Have more opinions on this. People please speak out.
- Have clear "let's do it" from Cc-ed people.


If we are really doing this, then let's split it and have
incremental changes. Namely, what I suggest is:

- keep internal printk lock - logbuf lock for now; we know how to
  handle it. I promise.

- keep printk_safe for now, we need it to deal with logbuf lock

- keep printk_safe completely internal to printk

- add printk_kthread

- do printk()->irq_work()->wake_up_process(printk_kthread)
  change and remove external locks dependency

- use direct printk() for panic() case

- do something about early_printk


That's big enough already.
>From there, once we land this thing, we can start building new logbuf,
stealing code from Steven, improving per-CPU buffers and so on.


Are we doing this?


[1] https://lwn.net/Articles/705938/
[2] https://lore.kernel.org/lkml/20170202090722.GW6515@twins.programming.kicks-ass.net/

	-ss
