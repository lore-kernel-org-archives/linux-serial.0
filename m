From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: possible deadlock in console_unlock
Date: Fri, 15 Jun 2018 17:38:04 +0900
Message-ID: <20180615083804.GB8964@jagdpanzerIV>
References: <00000000000087008b056df8fbb3@google.com>
 <20180607051019.GA10406@jagdpanzerIV>
 <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
 <20180607140100.GA398@tigerII.localdomain>
 <20180608081855.ctqakvwmg27aydby@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180608081855.ctqakvwmg27aydby@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-serial@vger.kernel.org

On (06/08/18 10:18), Petr Mladek wrote:
[..]
> > Could be.
> > The good thing about printk_safe is that printk_safe sections can nest.
> > I suspect there might be locks/printk_safe sections nesting at some
> > point. In any case, switching to a new flavor of printk_safe will be
> > pretty easy - just replace printk_safe_enter() with printk_foo_enter()
> > and the same for printk_save_exit().
> 
> We could allow nesting. It is just a matter of how many bits we
> reserve for it in printk_context variable.
[..]
> In each case, I would like to keep the printk_safe context usage
> at minimum. It has its own problems caused by limited per-cpu buffers
> and the need to flush them.

May be. Every new printk_safe flavour comes with increasing memory
usage. We already have a bunch of pages pinned [and mostly unused]
to every CPU for printk_nmi and printk_safe. I'm a little unsure if
we have enough reasons to pin yet another bunch of pages to every
CPU. After all printk_safe is not used very commonly, so all in all
I think we should be fine with printk_safe buffers for the time being.
We always can introduce new printk_safe mode later.

> It is basically needed only to prevent deadlocks related to logbuf_lock.

I wouldn't say that we need printk_safe for logbuf_lock only.
printk_safe helps us to avoid deadlocks on:

- logbuf_lock spin_lock
- console_sem ->lock spin_lock
- console_owner spin_lock
- scheduler ->pi_lock spin_lock
- and probably something else.

	-ss
