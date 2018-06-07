From: Petr Mladek <pmladek@suse.com>
Subject: Re: possible deadlock in console_unlock
Date: Thu, 7 Jun 2018 13:00:34 +0200
Message-ID: <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
References: <00000000000087008b056df8fbb3@google.com>
 <20180607051019.GA10406@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180607051019.GA10406@jagdpanzerIV>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, syzkaller-bugs@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-serial@vger.kernel.org

On Thu 2018-06-07 14:10:19, Sergey Senozhatsky wrote:
> Cc-ing more people
> Link: lkml.kernel.org/r/00000000000087008b056df8fbb3@google.com
> 
> On (06/06/18 06:17), syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    af6c5d5e01ad Merge branch 'for-4.18' of git://git.kernel.o..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=173d93ef800000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=12ff770540994680
> > dashboard link: https://syzkaller.appspot.com/bug?extid=43e93968b964e369db0b
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > userspace arch: i386
> > syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=16e00bb7800000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com
> 
> IOW
> 
>     tty ioctl
>     tty_port->lock		IRQ
>     printk			uart_port->lock
>     console_owner
>     uart_port->lock		tty_port->rlock

Great analyze!


> The simplest thing to do [not necessarily the right one, tho]
> would be to break the IOCTL ==> tty_port->lock ==> printk ==> uart_port->lock
> chain.
> 
> E.g. by adding __GFP_NOWARN
> 
> ---
> 
>  drivers/tty/tty_buffer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index c996b6859c5e..71958ef6a831 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -167,7 +167,8 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
>  	   have queued and recycle that ? */
>  	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
>  		return NULL;
> -	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
> +	p = kmalloc(sizeof(struct tty_buffer) + 2 * size,
> +			GFP_ATOMIC | __GFP_NOWARN);
>  	if (p == NULL)
>  		return NULL;
> 
> ---

This looks like the most simple solution for this particular problem.
I am just afraid that there are many other locations like this.


> Another way could be - switch to printk_safe mode around that
> kmalloc():
> 
> 	__printk_safe_enter();
> 	kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
> 	__printk_safe_exit();
> 
> Or, may be, we even can switch to printk_safe mode every time we grab
> tty_port lock.
 
> Perhaps something like this should be done for uart_port->lock
> as well. Because, technically, we can have the following

Yeah, we would need this basically around any lock that can be taken
from console write() callbacks. Well, this would be needed even
around locks that might be in a chain with a lock used in these
callbacks (as shown by this report).

BTW: printk_safe context might be too strict. In fact,
printk_deferred() would be enough. We might think about
introducing also printk_deferred context.

Best Regards,
Petr
