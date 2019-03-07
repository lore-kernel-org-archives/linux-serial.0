From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Date: Thu, 7 Mar 2019 15:41:52 +0900
Message-ID: <20190307064152.GA425@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
 <20190304073856.GA552@jagdpanzerIV>
 <20190304100044.GC21004@jagdpanzerIV>
 <20190304110703.GA960@tigerII.localdomain>
 <87o96p9gtx.fsf@linutronix.de>
 <20190306155701.wc22i2no5swdcids@pathway.suse.cz>
 <87r2bjbt47.fsf@linutronix.de>
 <87k1hbbq2m.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87k1hbbq2m.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (03/06/19 23:22), John Ogness wrote:
> On 2019-03-06, Petr Mladek <pmladek@suse.com> wrote:
> >> _Both_ categories are important for the user, but their requirements
> >> are different:
> >> 
> >>    informational: non-disturbing
> >>    emergency:     reliable
> >
> > Isn't this already handled by the console_level?
> >
> > The informational messages can be reliably read via syslog, /dev/kmsg.
> > They are related to the normal works when the system works well.
> >
> > The emergency messages (errors, warnings) are printed in emergency
> > situations. They are printed as reliably as possible to the console
> > because the userspace might not be reliable enough.
> 
> I've never viewed console_level this way. _If_ console_level really is
> supposed to define the emergency/informational boundary, all
> informational messages are supposed to be handled by userspace, and
> console printing's main objective is reliability... then I would change
> my proposal such that:

OK, you guys are ahead of me.

FB folks want to have a per-console sysfs knob to dynamically adjust
loglevel on each console. The use case is to temporarily set loglevel
to, say, debug on fast consoles, gather some data/logs, set loglevel
back to less verbose afterwards.

Preserving the existing loglevel behaviour looks right to me.

> - if a console supports write_atomic(), _all_ console printing for that
>   console would use write_atomic()

Sounds right.
But Big-Konsole-Lock looks suspicious.

> - only consoles without write_atomic() will be printing via the
>   printk-kthread(s)
> 
> IMO, for consoles with write_atomic(), this would increase reliability
> over the current mainline implementation. It would also simplify
> write_atomic() implementations because they would no longer need to
> synchronize against write().

[..]
> For those consoles that cannot implement write_atomic() (vt and
> netconsole come to mind), or as a transition period until remaining
> console drivers have implemented write_atomic(), these would use the
> "fallback" of printing fully preemptively in their own kthread using
> write().

This sounds concerning. IMHO, netconsole is too important to rely
on preemptible printk and scheduler. Especially those netcons which
run in "report only when oops_in_progress" mode. Sometimes netconsole
is the fastest console available, but preemptible printk may turn it
into the slowest one.

	-ss
