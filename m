From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Date: Tue, 16 Oct 2018 14:54:15 +0200
Message-ID: <20181016125415.GA3121@hirez.programming.kicks-ass.net>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016122734.GA1259@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181016122734.GA1259@jagdpanzerIV>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 16, 2018 at 09:27:34PM +0900, Sergey Senozhatsky wrote:
> per-CPU printk_safe _semi-magic_ makes some things simple to handle.
> We can't just remove per-CPU buffers and add a wake_up_process() at
> the bottom of vprintk_emit(). Because this will deadlock:
> 
>   printk()
>    wake_up_process()
>     try_to_wake_up()
>      raw_spin_lock_irqsave()
>  <NMI>
>       printk()
>        wake_up_process()
>         try_to_wake_up()
>          raw_spin_lock_irqsave()
> 
> So we still need some amount of per-CPU printk() semi-magic anyway.

All we need is 4 max-line-length buffers per-CPU. Nothing more.

The above trainwreck is the direct result of forcing synchronous
printk'ing (which I'm otherwise a big fan of, but regular console
drivers stink and are unfixable).

> And printk-kthread offloding will not eliminate the need of
> printk_deferred().

Why not? printk() will reduce to a lockless buffer insert. IOW _all_
printk is deferred.

All you need are 4 max-line-length buffers per CPU and a global/shared
lockless buffer.

printk will determine the current context:

  task, softirq, hardirq or NMI

and pick the corresponding per-cpu line buffer and do the vsnprintf()
thing. Then we have the actual line length and content. With the length
we reserve the bytes from the global buffer, we memcpy into the buffer
and commit.

Done.

The printk thread will observe it lags behind the buffer head and will
start printk-ing crud from task context.

> Speaking of lockless logbuf,
> logbuf buffer and logbuf_lock are the smallest of the problems printk
> currently has. Mainly because of lockless semi-magical printk_safe
> buffers.

Which are rubbish. You now have two buffers with duplicated
functionality and wildly different semantics.

Why not have a single buffer that does it all?

> Replacing one lockless buffer with another lockless buffer will
> not simplify things in this department. We probably additionally will
> have some nasty screw ups, e.g. when NMI printk on CPUA interrupts normal
> printk on the same CPUA and now we have mixed in characters; and so on.

Line buffers fix that. You don't need anything fancy for that.

> per-CPU printk_safe at least keeps us on the safe side in these cases and
> looks fairly simple.

printk_safe is an abomination, it fixes something that shouldn't need
fixing. See above.

> We do, however, have loads of problems with all those dependencies which
> come from serial drivers and friends: timekeeping, scheduler (scheduler
> is brilliant and cool, but we do have some deadlocks in printk because of
> it ;), tty, net, MM, wq, etc. So I generally like the idea of "detached
> serial consoles" (that's what I call it). IOW, elimination of the direct
> printk -> serial console path. 

Right; we need to get rid of that in the generic case. Only allow
lockless consoles (earlycon) to be used synchonously. With maybe a
special case for the BUG/PANIC case to push things out ASAP.

But given 'fine' console drivers like USB-serial, or DRM-framebuffer, I
don't know if it makes much difference to wake a thread and rely on that
or call it directly and deadlock :/

> The current approach - use the existing printk_safe mechanism and
> case-by-case, manually, break dependencies which can deadlock us is
> a lazy approach, yes; and not very convenient. I'm aware of it.

It's ugly and pushes ugly all over :/

> So, unless I'm missing something, things are not entirely that simple:
> - throw away printk_safe semi-magic
> - add a lockless logbuf
> - add wake_up_process() to vprintk_emit().

No, no wakups. irq_work to wake the printk-thread, at most.
