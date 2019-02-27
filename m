From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 20/25] serial: 8250: implement write_atomic
Date: Wed, 27 Feb 2019 14:55:04 +0100
Message-ID: <20190227135504.gqtcsdwpy4rd7xvs@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-21-john.ogness@linutronix.de>
 <20190227094655.ecdwhsc2bf5spkqx@pathway.suse.cz>
 <87zhqhed3u.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87zhqhed3u.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed 2019-02-27 11:32:05, John Ogness wrote:
> On 2019-02-27, Petr Mladek <pmladek@suse.com> wrote:
> >> Implement a non-sleeping NMI-safe write_atomic console function in
> >> order to support emergency printk messages.
> >
> > It uses console_atomic_lock() added in 18th patch. That one uses
> > prb_lock() added by 2nd patch.
> >
> > Now, prb_lock() allows recursion on the same CPU. But it still needs
> > to wait until it is released on another CPU.
> >
> > [...]
> >
> > OK, it would be safe when prb_lock() is the only lock taken
> > in the NMI handler.
> 
> Which is the case. As I wrote to you already [0], NMI contexts are
> _never_ allowed to do things that rely on waiting forever for other
> CPUs.

Who says _never_? I agree that it is not reasonable. But the
history shows that it happens. In principle, there is nothing wrong
in using spinlock in NMI when it is used only in NMI.


> > Not to say, that we would most
> > likely need to add a lock back into nmi_cpu_backtrace()
> > to keep the output sane.
> 
> No. That is why CPU-IDs were added to the output. It is quite sane and
> easy to read.

And I already wrote that they are not added by default and they
does not solve kmsg interface.

Also we might need to provide a userspace support in advance.
We could not release kernel that will make logs hard to read
without post processing. At least I do not have the balls
to do so.


> > Peter Zijlstra several times talked about fully lockless
> > consoles. He is using the early console for debugging, see
> > the patchset
> > https://lkml.kernel.org/r/20170928121823.430053219@infradead.org
> 
> That is an interesting thread to quote. In that thread Peter actually
> wrote the exact implementation of prb_lock() as the method to
> synchronize access to the serial console.

The synchronization was added just for the thread. I am not sure
if Peter is using it in the real life.


> > I am not sure if it is always possible. I personally see
> > the following way:
> >
> >    1. Make the printk ring buffer fully lockless. Then we reduce
> >       the problem only to console locking. And we could
> >       have a per-console-driver lock (no the big lock like
> >       prb_lock()).
> 
> A fully lockless ring buffer is an option. But as you said, it only
> reduces the window, which is why I decided it is not so important (at
> least for now). Creating a per-console-driver lock would probably be a
> good idea anyway as long as we can guarantee the ordering (which
> shouldn't be a problem as long as emergency console ordering remains
> fixed and emergency writers always follow that ordering).
> 
> >    2. I am afraid that we need to add some locking between CPUs
> >       to avoid mixing characters from directly printed messages.
> 
> That is exactly what console_atomic_lock() (actually prb_lock) is!

Sure. But it should not be a common lock for the ring buffer and
all consoles. Also there are still open questions with NMI
and the direct console handling itself.

Best Regards,
Petr
