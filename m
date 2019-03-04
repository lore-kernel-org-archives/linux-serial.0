From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Mon, 4 Mar 2019 15:39:56 +0900
Message-ID: <20190304063956.GC6648@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213013101.GA8097@jagdpanzerIV>
 <87d0nv248b.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87d0nv248b.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi John,

On (02/13/19 14:43), John Ogness wrote:
> Hi Sergey,
> 
> I am glad to see that you are getting involved here. Your previous
> talks, work, and discussions were a large part of my research when
> preparing for this work.

YAYY! Thanks!

That's a pretty massive research and a patch set!

[..]
> If we are talking about an SMP system where logbuf_lock is locked, the
> call chain is actually:
> 
>     panic()
>       crash_smp_send_stop()
>         ... wait for "num_online_cpus() == 1" ...
>       printk_safe_flush_on_panic();
>       console_flush_on_panic();
> 
> Is it guaranteed that the kernel will successfully stop the other CPUs
> so that it can print to the console?

Right. By the way, this reminds that I sort of wanted to send a patch
which would unconditionally raw_spin_lock_init(&logbuf_lock) (without
the num_online_cpus() check) in printk_safe_flush_on_panic().

> And then there is console_flush_on_panic(), which will ignore locks and
> write to the consoles, expecting them to check "oops_in_progress" and
> ignore their own internal locks.
>
> Is it guaranteed that locks can just be ignored and backtraces will be
> seen and legible to the user?

That's a tricky question. In the same way we may have no guarantees that
all consoles can sport ->atomic() write API. And then have no guarantees
that every system will have ->atomic consoles.

> > Do you see large latencies because of logbuf spinlock?
>
[..]
>
> For slow consoles, this can cause large latencies for some misfortunate
> tasks.

Yes, makes sense.

> > One thing that I have learned is that preemptible printk does not work
> > as expected; it wants to be 'atomic' and just stay busy as long as it
> > can.
> > We tried preemptible printk at Samsung and the result was just bad:
> >    preempted printk kthread + slow serial console = lots of lost
> > messages
> 
> As long as all critical messages are print directly and immediately to
> an emergency console, why is it is problem if the informational messages
> to consoles are sometimes delayed or lost? And if those informational
> messages _are_ so important, there are things the user can do. For
> example, create a realtime userspace task to read /dev/kmsg.
> 
> > We also had preemptile printk in the upstream kernel and reverted the
> > patch (see fd5f7cde1b85d4c8e09); same reasons - we had reports that
> > preemptible printk could "stall" for minutes.
> 
> But in this case the preemptible task was used for printing critical
> tasks as well. Then the stall really is a problem. I am proposing to
> rely on emergency consoles for critical messages. By changing printk to
> support 2 different channels (emergency and non-emergency), we can focus
> on making each of those channels optimal.

Right. Assuming that we always have at least one ->atomic channel
we can prioritize (and sacrifice !atomic channels, etc.). People,
sort of, already can prioritize some channels; IIRC, netcon can be
configured to print messages only when oops_in_progress and to drop
messages otherwise.

Things can get different if ->atomic channel is not available.

	-ss
