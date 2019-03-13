From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Wed, 13 Mar 2019 18:27:59 +0900
Message-ID: <20190313092759.GA10060@jagdpanzerIV>
References: <20190213025520.GA5803@jagdpanzerIV>
 <874l9721hf.fsf@linutronix.de>
 <20190304052335.GA6648@jagdpanzerIV>
 <87lg1rggcz.fsf@linutronix.de>
 <20190311105411.GA368@jagdpanzerIV>
 <20190312123857.juatd6fwtfmqajze@pathway.suse.cz>
 <874l8815uc.fsf@linutronix.de>
 <20190313021534.GB783@jagdpanzerIV>
 <87d0mv9off.fsf@linutronix.de>
 <20190313084028.f2m4qhxd5sjzzawr@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190313084028.f2m4qhxd5sjzzawr@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Siewior <bigeasy@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (03/13/19 09:40), Sebastian Siewior wrote:
> On 2019-03-13 09:19:32 [+0100], John Ogness wrote:
> > recursive situation. As you are pointing out, the notification/wake
> > component of printk_safe will still be needed. I will leave that (small)
> > part in printk_safe.c.
> 
> Does this mean we keep irq_work part or we bury it and solve it by other
> means?

That's a very good question. Because if we add console_trylock()
to printk(), then we can't invoke ->atomic() consoles when console_sem
is already locked, because one of the registered drivers is currently
being modified by a 3rd party and printk(), thus, must stay away.
Once that modification will be done console_unlock() will print all
pending messages. This is current design. And this conflicts with the
whole idea of ->atomic() consoles.

So may be we need a whole new scheme in this department as well.

For instance [*and this is completely untested idea* !!!]

*May be* we can take a closer look and find cases when ->atomic
consoles don't really depend on console_sem. And *may be* we can
split the console drivers list and somehow forbid removal and
modification (ioctl) of ->atomic consoles under us. Assuming that
this is doable we then can start iterating ->atomic consoles list
with unlocked console_sem.
Non->atomic consoles or consoles which depend on console_sem (VT,
fbcon and so on) will stay in another list, and we will take
console_sem before we iterate that list and invoke those drivers.

One more time - a completely random thought.

	-ss
