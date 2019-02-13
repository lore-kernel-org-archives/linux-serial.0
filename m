From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Wed, 13 Feb 2019 10:31:01 +0900
Message-ID: <20190213013101.GA8097@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (02/12/19 15:29), John Ogness wrote:
>
> 1. The printk buffer is protected by a global raw spinlock for readers
>    and writers. This restricts the contexts that are allowed to
>   access the buffer.

[..]

> 2. Because of #1, NMI and recursive contexts are handled by deferring
>    logging/printing to a spinlock-safe context. This means that
>    messages will not be visible if (for example) the kernel dies in
>    NMI context and the irq_work mechanism does not survive.

panic() calls printk_safe_flush_on_panic(), which iterates all per-CPU
buffers and moves data to the main logbuf; so then we can flush pending
logbuf message

	panic()
	  printk_safe_flush_on_panic();
	  console_flush_on_panic();

We don't really use irq_work mechanism for that.

> 3. Because of #1, when *not* using features such as PREEMPT_RT, large
>    latencies exist when printing to slow consoles.

Because of #1? I'm not familiar with PREEMPT_RT; but logbuf spinlock
should be unlocked while we print messages to slow consoles
(call_consoles_drivers() is protected by console_sem, not logbuf
lock).

So it's

	spin_lock_irqsave(logbuf);
	vsprintf();
	memcpy();
	spin_unlock_irqrestore(logbuf);

	console_trylock();
	for (;;)
	    call_console_drivers();
	    				// console_owner handover
	console_unlock();

Do you see large latencies because of logbuf spinlock?

> 5. Printing to consoles is the responsibility of the printk caller
>    and that caller may be required to print many messages that other
>    printk callers inserted. Because of this there can be enormous
>    variance in the runtime of a printk call.

That's complicated. Steven's console_owner handover patch makes
printk() more fair. We can have "winner takes it all" scenarios,
but significantly less often, IMO. Do you have any data that
suggest otherwise?

> 7. Loglevel INFO is handled the same as ERR. There seems to be an
>    endless effort to get printk to show _all_ messages as quickly as
>    possible in case of a panic (i.e. printing from any context), but
>    at the same time try not to have printk be too intrusive for the
>    callers. These are conflicting requirements that lead to a printk
>    implementation that does a sub-optimal job of satisfying both
>    sides.

Per my experience, fully preemptible "print it sometime maybe"
printk() does not work equally well for everyone.

	-ss
