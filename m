From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 20/25] serial: 8250: implement write_atomic
Date: Wed, 27 Feb 2019 10:46:55 +0100
Message-ID: <20190227094655.ecdwhsc2bf5spkqx@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-21-john.ogness@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-21-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue 2019-02-12 15:29:58, John Ogness wrote:
> Implement a non-sleeping NMI-safe write_atomic console function in
> order to support emergency printk messages.

It uses console_atomic_lock() added in 18th patch. That one uses
prb_lock() added by 2nd patch.

Now, prb_lock() allows recursion on the same CPU. But it still needs
to wait until it is released on another CPU.

It means that it is not completely save when NMIs happen on more CPUs in
parallel, for example, when calling nmi_trigger_cpumask_backtrace().

OK, it would be safe when prb_lock() is the only lock taken
in the NMI handler. But printk() should not make such limitation
to the rest of the system. Not to say, that we would most
likely need to add a lock back into nmi_cpu_backtrace()
to keep the output sane.


Peter Zijlstra several times talked about fully lockless
consoles. He is using the early console for debugging, see
the patchset
https://lkml.kernel.org/r/20170928121823.430053219@infradead.org

I am not sure if it is always possible. I personally see
the following way:

   1. Make the printk ring buffer fully lockless. Then we reduce
      the problem only to console locking. And we could
      have a per-console-driver lock (no the big lock like
      prb_lock()).

   2. I am afraid that we need to add some locking between CPUs
      to avoid mixing characters from directly printed messages.
      This would be safe everywhere expect in NMI. Then we could
      either risk ignoring the lock in NMI (there should be few
      messages anyway, the backtraces would get synchronized
      another way). Or we might need a compromise between
      handling console using the current owner and offload.


Best Regards,
Petr
