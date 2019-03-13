From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Wed, 13 Mar 2019 17:46:00 +0900
Message-ID: <20190313084600.GA1748@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213025520.GA5803@jagdpanzerIV>
 <874l9721hf.fsf@linutronix.de>
 <20190304052335.GA6648@jagdpanzerIV>
 <87lg1rggcz.fsf@linutronix.de>
 <20190311105411.GA368@jagdpanzerIV>
 <20190312123857.juatd6fwtfmqajze@pathway.suse.cz>
 <874l8815uc.fsf@linutronix.de>
 <20190313021534.GB783@jagdpanzerIV>
 <87d0mv9off.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87d0mv9off.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sebastian Siewior <bigeasy@linutronix.de>
List-Id: linux-serial@vger.kernel.org

On (03/13/19 09:19), John Ogness wrote:
> >> Yes. I will post a series that only implements the ringbuffer using
> >> your simplified API. That will be enough to remove printk_safe and
> >> actually does most of the work of updating devkmsg, kmsg_dump, and
> >> syslog.
> >
> > This may _not_ be enough to remove printk_safe. One of the reasons
> > printk_safe "condom" came into existence was console_sem (which
> > is a bit too important to ignore it):
> >
> > 	printk()
> > 	 console_trylock()
> > 	  console_unlock()
> > 	   up()
> > 	    raw_spin_lock_irqsave(&sem->lock, flags)
> > 	     __up()
> > 	      wake_up_process()
> > 	       WARN/etc
> > 	        printk()
> > 		 console_trylock()
> > 		  down_trylock()
> > 		   raw_spin_lock_irqsave(&sem->lock, flags)  << deadlock
> >
> > Back then we were looking at
> >
> > 	printk->console_sem->lock->printk->console_sem->lock
> >
> > deadlock report from LG, if I'm not mistaken.
> 
> The main drawback of printk_safe is the safe buffers, which, aside from
> bogus timestamping, may never make it back to the printk log buffer.
>
> With the new ring buffer the safe buffers are not needed, even in the
> recursive situation. As you are pointing out, the notification/wake
> component of printk_safe will still be needed. I will leave that (small)
> part in printk_safe.c.

Yeah, all I'm saying is that as it stands new printk() is missing a huge
and necessary part - console semaphore. And things can get very different
once you add that missing part. It brings a lot of stuff back to printk.

logbuf and logbuf_lock are not really huge printk problems. scheduler,
timekeeping locks, etc. are much bigger ones. Those dependencies don't
come from logbuf/logbuf_lock.

	-ss
