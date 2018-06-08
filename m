From: Petr Mladek <pmladek@suse.com>
Subject: Re: possible deadlock in console_unlock
Date: Fri, 8 Jun 2018 10:18:55 +0200
Message-ID: <20180608081855.ctqakvwmg27aydby@pathway.suse.cz>
References: <00000000000087008b056df8fbb3@google.com>
 <20180607051019.GA10406@jagdpanzerIV>
 <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
 <20180607140100.GA398@tigerII.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180607140100.GA398@tigerII.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-serial@vger.kernel.org

On Thu 2018-06-07 23:01:00, Sergey Senozhatsky wrote:
> On (06/07/18 13:00), Petr Mladek wrote:
> > > Another way could be - switch to printk_safe mode around that
> > > kmalloc():
> > > 
> > > 	__printk_safe_enter();
> > > 	kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
> > > 	__printk_safe_exit();
> > > 
> > > Or, may be, we even can switch to printk_safe mode every time we grab
> > > tty_port lock.
> >  
> > > Perhaps something like this should be done for uart_port->lock
> > > as well. Because, technically, we can have the following
> > 
> > Yeah, we would need this basically around any lock that can be taken
> > from console write() callbacks. Well, this would be needed even
> > around locks that might be in a chain with a lock used in these
> > callbacks (as shown by this report).
> 
> Yep. So the plan for now is to wrap the tty_port->lock. Pretty much
> an automatic conversion.
> 
> Then to convert [may be some for now on] uart_port->lock. Once again,
> pretty much can be done a script.
> 
> Afterwards just sit down and be humbl^W^W wait for new reports. Then
> move those newly discovered unsafe locks under printk_safe context.
> 
> Basically, the same macros as we use for logbuf lock in printk.c
> 
> A bit of a lazy approach. Can't think of anything better.

Same here.

> I think it's finally the time to start dealing with these
> "external" locks, it's been a while.
> 
> > BTW: printk_safe context might be too strict. In fact,
> > printk_deferred() would be enough. We might think about
> > introducing also printk_deferred context.
> 
> Could be.
> The good thing about printk_safe is that printk_safe sections can nest.
> I suspect there might be locks/printk_safe sections nesting at some
> point. In any case, switching to a new flavor of printk_safe will be
> pretty easy - just replace printk_safe_enter() with printk_foo_enter()
> and the same for printk_save_exit().

We could allow nesting. It is just a matter of how many bits we
reserve for it in printk_context variable.

In each case, I would like to keep the printk_safe context usage
at minimum. It has its own problems caused by limited per-cpu buffers
and the need to flush them. It is basically needed only to prevent
deadlocks related to logbuf_lock.

Best Regards,
Petr
