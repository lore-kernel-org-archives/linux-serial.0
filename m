From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: possible deadlock in console_unlock
Date: Thu, 7 Jun 2018 23:03:19 +0900
Message-ID: <20180607140319.GB398@tigerII.localdomain>
References: <00000000000087008b056df8fbb3@google.com>
 <20180607051019.GA10406@jagdpanzerIV>
 <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
 <6cc6d5c1-fc01-efab-86b8-eb072607680c@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6cc6d5c1-fc01-efab-86b8-eb072607680c@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, syzkaller-bugs@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-serial@vger.kernel.org

On (06/07/18 20:40), Tetsuo Handa wrote:
> >> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> >> index c996b6859c5e..71958ef6a831 100644
> >> --- a/drivers/tty/tty_buffer.c
> >> +++ b/drivers/tty/tty_buffer.c
> >> @@ -167,7 +167,8 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
> >>  	   have queued and recycle that ? */
> >>  	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
> >>  		return NULL;
> >> -	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
> >> +	p = kmalloc(sizeof(struct tty_buffer) + 2 * size,
> >> +			GFP_ATOMIC | __GFP_NOWARN);
> >>  	if (p == NULL)
> >>  		return NULL;
> >>
> >> ---
> > 
> > This looks like the most simple solution for this particular problem.
> > I am just afraid that there are many other locations like this.
> > 
> I haven't tried the reproducer with that change. But isn't __GFP_NOWARN
> ignored by fail_dump() (and thus printk() from fault injection still occurs)?

Thanks for the info. Need to check it [I didn't know that GFP_NOWARN
meant GFP_WARN_ME_SOMETIMES]. If this is the case then we have just one
option left - printk_safe contexts for TTY/UART locks.

	-ss
