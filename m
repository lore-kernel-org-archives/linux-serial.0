From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCHv2 1/4] panic: avoid deadlocks in re-entrant console
 drivers
Date: Thu, 25 Oct 2018 18:31:55 +0900
Message-ID: <20181025093155.GE20702@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181023110751.un2u67bc7dpo4ska@pathway.suse.cz>
 <20181023115433.GA10251@jagdpanzerIV>
 <20181023120441.GB10251@jagdpanzerIV>
 <20181023121057.GC10251@jagdpanzerIV>
 <20181025090603.7gkevv5l3zg7dj5e@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181025090603.7gkevv5l3zg7dj5e@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (10/25/18 11:06), Petr Mladek wrote:
> 
> IMHO, the custom s390 implementation can get removed.
> The generic code should do the same job these days.
> 

Yep.

> > And console_unblank() is not guaranteed to print anything (unlike
> > console_flush_on_panic(), but oops is not panic() yet, so we can't
> > replace it with flush_on_panic()) - console_sem can be locked, so
> > console_unblank() would do nothing.
> 
> I see. I missed that console_unblank() returns early when
> down_trylock_console_sem() fails.
> 
> I still would like to refactor the code somehow to avoid
> the bust_spinlocks(0)/bust_spinlocks(1) ping-pong.
> 
> It might make sense to call console_unblank() from
> console_flush_on_panic().
> 
> I wonder if it would make sense to call unblank_screen() in
> console_unblank()...

These are interesting thoughts.

I can add one more thing to the list.
bust_spinlock() is probably not doing enough. It says that it

	"clears any spinlocks which would prevent oops, die(), BUG()
	 and panic() information from reaching the user."

But this is, technically, not true. Because bust_spinlock() does not remove
console_sem out of sight. And we do have several spinlocks behind it. E.g.
semaphore's ->lock. Both down() and down_trylock() do
raw_spin_lock_irqsave(&sem->lock, flags), so if we got NMI panic while one
of the CPUs was under raw_spin_lock_irqsave(&sem->lock, flags) trying to
lock the console_sem then we are done. And IIRC we had exactly this type
of a bug report from LG 1 or 2 years ago - deadlock on sem->lock.

	-ss
