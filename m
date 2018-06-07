From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: possible deadlock in console_unlock
Date: Thu, 7 Jun 2018 23:01:00 +0900
Message-ID: <20180607140100.GA398@tigerII.localdomain>
References: <00000000000087008b056df8fbb3@google.com>
 <20180607051019.GA10406@jagdpanzerIV>
 <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, syzkaller-bugs@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-serial@vger.kernel.org

On (06/07/18 13:00), Petr Mladek wrote:
> > IOW
> > 
> >     tty ioctl
> >     tty_port->lock		IRQ
> >     printk			uart_port->lock
> >     console_owner
> >     uart_port->lock		tty_port->rlock
> 
> Great analyze!

Thanks!

> I am just afraid that there are many other locations like this.

Yep, agree. That's why I suggested the printk_safe context for
most critically important locks.

> > Another way could be - switch to printk_safe mode around that
> > kmalloc():
> > 
> > 	__printk_safe_enter();
> > 	kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
> > 	__printk_safe_exit();
> > 
> > Or, may be, we even can switch to printk_safe mode every time we grab
> > tty_port lock.
>  
> > Perhaps something like this should be done for uart_port->lock
> > as well. Because, technically, we can have the following
> 
> Yeah, we would need this basically around any lock that can be taken
> from console write() callbacks. Well, this would be needed even
> around locks that might be in a chain with a lock used in these
> callbacks (as shown by this report).

Yep. So the plan for now is to wrap the tty_port->lock. Pretty much
an automatic conversion.

Then to convert [may be some for now on] uart_port->lock. Once again,
pretty much can be done a script.

Afterwards just sit down and be humbl^W^W wait for new reports. Then
move those newly discovered unsafe locks under printk_safe context.

Basically, the same macros as we use for logbuf lock in printk.c

A bit of a lazy approach. Can't think of anything better.

I think it's finally the time to start dealing with these
"external" locks, it's been a while.

> BTW: printk_safe context might be too strict. In fact,
> printk_deferred() would be enough. We might think about
> introducing also printk_deferred context.

Could be.
The good thing about printk_safe is that printk_safe sections can nest.
I suspect there might be locks/printk_safe sections nesting at some
point. In any case, switching to a new flavor of printk_safe will be
pretty easy - just replace printk_safe_enter() with printk_foo_enter()
and the same for printk_save_exit().

I'll wait for some time, to see what people will say.
I guess we also need to check if Linus is OK with the proposed solution.

	-ss
