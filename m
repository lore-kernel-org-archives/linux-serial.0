From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCHv3] panic: avoid deadlocks in re-entrant console drivers
Date: Wed, 31 Oct 2018 13:27:36 +0100
Message-ID: <20181031122736.epbxu424l3xagge5@pathway.suse.cz>
References: <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181025101036.6823-1-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181025101036.6823-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu 2018-10-25 19:10:36, Sergey Senozhatsky wrote:
> >From printk()/serial console point of view panic() is special, because
> it may force CPU to re-enter printk() or/and serial console driver.
> Therefore, some of serial consoles drivers are re-entrant. E.g. 8250:
> 
> serial8250_console_write()
> {
>         if (port->sysrq)
>                 locked = 0;
>         else if (oops_in_progress)
>                 locked = spin_trylock_irqsave(&port->lock, flags);
>         else
>                 spin_lock_irqsave(&port->lock, flags);
> 	...
> }
> 
> panic() does set oops_in_progress via bust_spinlocks(1), so in theory
> we should be able to re-enter serial console driver from panic():
> 
> 	CPU0
> 	<NMI>
> 	uart_console_write()
> 	serial8250_console_write()		// if (oops_in_progress)
> 						//    spin_trylock_irqsave()
> 	call_console_drivers()
> 	console_unlock()
> 	console_flush_on_panic()
> 	bust_spinlocks(1)			// oops_in_progress++
> 	panic()
> 	<NMI/>
> 	spin_lock_irqsave(&port->lock, flags)   // spin_lock_irqsave()
> 	serial8250_console_write()
> 	call_console_drivers()
> 	console_unlock()
> 	printk()
> 	...
> 
> However, this does not happen and we deadlock in serial console on
> port->lock spinlock. And the problem is that console_flush_on_panic()
> called after bust_spinlocks(0):
> 
> void panic(const char *fmt, ...)
> {
>         bust_spinlocks(1);
> ...
>         bust_spinlocks(0);
>         console_flush_on_panic();
> ...
> }
> 
> bust_spinlocks(0) decrements oops_in_progress, so oops_in_progress
> can go back to zero. Thus even re-entrant console drivers will simply
> spin on port->lock spinlock. Given that port->lock may already be
> locked either by a stopped CPU, or by the very same CPU we execute
> panic() on (for instance, NMI panic() on printing CPU) the system
> deadlocks and does not reboot.
> 
> Fix this by removing bust_spinlocks(0), so oops_in_progress is always
> set in panic() now and, thus, re-entrant console drivers will trylock
> the port->lock instead of spinning on it forever, when we call them
> from console_flush_on_panic().
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

The patch makes sense to me. The locks should stay busted also for
console_flush_on_panic().

With the added #include <linux/vt_kern.h>:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
