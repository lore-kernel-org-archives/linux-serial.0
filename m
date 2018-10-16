From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Date: Tue, 16 Oct 2018 21:27:34 +0900
Message-ID: <20181016122734.GA1259@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181016072719.GB4030@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (10/16/18 09:27), Peter Zijlstra wrote:
> 
> So I really _really_ hate all this. Utterly detest it.

I learned a new word today - detest. I can haz re-entrant consoles now please?

> That whole magic 'safe' printk buffer crap is just that crap.

No, I don't see it this way; printk_safe is *semi-magic* at best! :)

> Instead of this tinkering around the edges, why don't you make the main
> logbuf a lockless ringbuffer and then delegate the actual printing of
> that buffer to a kthread, except for earlycon, which can do synchronous
> output.

Well, hmm. These are good questions. Let me think.

per-CPU printk_safe _semi-magic_ makes some things simple to handle.
We can't just remove per-CPU buffers and add a wake_up_process() at
the bottom of vprintk_emit(). Because this will deadlock:

  printk()
   wake_up_process()
    try_to_wake_up()
     raw_spin_lock_irqsave()
 <NMI>
      printk()
       wake_up_process()
        try_to_wake_up()
         raw_spin_lock_irqsave()

So we still need some amount of per-CPU printk() semi-magic anyway.

And printk-kthread offloding will not eliminate the need of
printk_deferred(). Which is very hard to use in the right places, like
always; and we don't have any ways to find out that a random innocently
looking printk() may actually be invoked from somewhere deep in the
call-chain with rq lock or pi_lock being locked some 5 frames ago, until
that printk() actually gets invoked and possibly deadlocks the system.

Having "unprotected" wake_up_process() in vprintk_emit(), in fact,
will make the need for printk_deferred() even bigger.

On the other hand, we have wake_up_klogd_work_func() in printk, which
uses irq work, so we, may be, can wakeup printk_kthread from there and,
thus, remove all the external locks from printk()... But I doubt it that
anyone will ever ACK such a patch.

Speaking of lockless logbuf,
logbuf buffer and logbuf_lock are the smallest of the problems printk
currently has. Mainly because of lockless semi-magical printk_safe
buffers. Replacing one lockless buffer with another lockless buffer will
not simplify things in this department. We probably additionally will
have some nasty screw ups, e.g. when NMI printk on CPUA interrupts normal
printk on the same CPUA and now we have mixed in characters; and so on.
per-CPU printk_safe at least keeps us on the safe side in these cases and
looks fairly simple. I also sort of like that logbuf_lock lets us to have
a single static textbuf buffer which we use to vscnprintf() printk messages,
and how printk_safe helps us to get recursive errors/warnings from
vscnprintf(). So printk_safe/printk_nmi things are not _entirely_ crappy,
I guess.

We do, however, have loads of problems with all those dependencies which
come from serial drivers and friends: timekeeping, scheduler (scheduler
is brilliant and cool, but we do have some deadlocks in printk because of
it ;), tty, net, MM, wq, etc. So I generally like the idea of "detached
serial consoles" (that's what I call it). IOW, elimination of the direct
printk -> serial console path. I don't hate the idea of a complete printk
re-work. But some people do, tho. And they have their points. Some people
like the synchronous printk nature and see scheduler dependency as a
"regression".

The current approach - use the existing printk_safe mechanism and
case-by-case, manually, break dependencies which can deadlock us is
a lazy approach, yes; and not very convenient. I'm aware of it.

So, unless I'm missing something, things are not entirely that simple:
- throw away printk_safe semi-magic
- add a lockless logbuf
- add wake_up_process() to vprintk_emit().

It does not completely remove dependency on "external" locks - scheduler,
etc. And as long as we have them - printk can deadlock.

Am I missing something?


Another idea, which I had like a year ago, was to treat printk logbuf
messages in serial consoles the same way they treat uart xmit buffer.
Each console has an IRQ handler, which reads pending messages from xmit
buffer and prints them to the console:

	int serial_foo_irq(...)
	{
		unsigned int max_count = TX_FIFO_DEPTH;

		while (max_count) {
			unsigned int c;

			if (uart_circ_empty(xmit))
				break;

			c = xmit->buf[xmit->tail];
			writel(port, UART_TX, c);
			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
			max_count--;
		}
	}

We can do the same for printk logbuf. Each console can have last_seen_idx.
And read logbuf messages (poll logbuf) starting from that per-console
last_seen_idx in IRQ handler; we don't have to call into scheduler, net,
etc. printk() will simply add messages to logbuf, consoles will poll pending
messages from IRQs handlers; and everyone is happy... And we will do direct
printk -> console_drivers only for early_con or when in panic().

	-ss
