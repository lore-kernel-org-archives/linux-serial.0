From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Mon, 4 Mar 2019 14:31:30 +0900
Message-ID: <20190304053130.GB6648@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213014141.GB8097@jagdpanzerIV>
 <878syj22r5.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <878syj22r5.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (02/13/19 15:15), John Ogness wrote:
> I don't like bust_spinlocks() because drivers end up implementing
> oops_in_progress with exactly that... ignoring their own locks. I prefer
> consoles are provided with a locking mechanism that they can use to
> support a separate NMI-safe write function. My series introduces
> console_atomic_lock() for exactly this purpose.
> 
> But this doesn't help here. Here we are talking about a crashing system
> that does _not_ have an emergency console. And in this case I would say
> messages would be lost (just like they are now if all you have is a vt
> console and it was busy).
> 
> I suppose we could keep the current bust_spinlocks() stuff for the
> special case that there are no emergency consoles available. It's better
> than nothing, but also not really reliable. Preferrably we figure out
> how to implement write_atomic for all console drivers.

Right. We set console loglevel to verbose before the final panic flush,
so flush of all unseen messages (regardless of importance) does look quite
reasonable (and this is what panic() has been doing for many years).

	-ss
