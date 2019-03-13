From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Wed, 13 Mar 2019 11:15:34 +0900
Message-ID: <20190313021534.GB783@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213025520.GA5803@jagdpanzerIV>
 <874l9721hf.fsf@linutronix.de>
 <20190304052335.GA6648@jagdpanzerIV>
 <87lg1rggcz.fsf@linutronix.de>
 <20190311105411.GA368@jagdpanzerIV>
 <20190312123857.juatd6fwtfmqajze@pathway.suse.cz>
 <874l8815uc.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874l8815uc.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sebastian Siewior <bigeasy@linutronix.de>
List-Id: linux-serial@vger.kernel.org

On (03/12/19 16:15), John Ogness wrote:
> > I suggest the following way forward (separate patchsets):
> >
> >     1. Replace log buffer (least controversial thing)
> 
> Yes. I will post a series that only implements the ringbuffer using your
> simplified API. That will be enough to remove printk_safe and actually
> does most of the work of updating devkmsg, kmsg_dump, and syslog.

This may _not_ be enough to remove printk_safe. One of the reasons
printk_safe "condom" came into existence was console_sem (which
is a bit too important to ignore it):

	printk()
	 console_trylock()
	  console_unlock()
	   up()
	    raw_spin_lock_irqsave(&sem->lock, flags)
	     __up()
	      wake_up_process()
	       WARN/etc
	        printk()
		 console_trylock()
		  down_trylock()
		   raw_spin_lock_irqsave(&sem->lock, flags)  << deadlock

Back then we were looking at

	printk->console_sem->lock->printk->console_sem->lock

deadlock report from LG, if I'm not mistaken.

	-ss
