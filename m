From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCHv2 3/4] serial: introduce uart_port locking helpers
Date: Sat, 8 Dec 2018 12:12:49 +0900
Message-ID: <20181208031249.GA443@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-4-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181016050428.17966-4-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org, Daniel Wang <wonderfly@google.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (10/16/18 14:04), Sergey Senozhatsky wrote:
[..]
> - The first entry point is console ->write() callback, which we call
>   from printk(). A possible deadlock scenario there is:
> 
>   CPU0
> 	<NMI>
> 	spin_lock_irqsave(&port->lock, flags)      << deadlock
> 	serial_foo_write()
> 	call_console_drivers()
> 	console_unlock()
> 	console_flush_on_panic()
> 	panic()
> 	<NMI/>
> 	spin_lock_irqsave(&port->lock, flags)
> 	serial_foo_write()
> 	call_console_drivers()
> 	console_unlock()
> 	printk()
> 	...

[..]
> - The rest (of entry points) requires a bit different handling.
>   Let's take a look at the following backtrace:
> 
>   	CPU0
> 	<IRQ>
> 	spin_lock_irqsave(&port->lock, flags)      << deadlock
> 	serial_foo_write()
> 	call_console_drivers()
> 	console_unlock()
> 	printk()
> 	__queue_work()
> 	tty_flip_buffer_push()
> 	spin_lock_irqsave(&port->lock, flags)
> 	serial_foo_handle_IRQ()
> 	<IRQ/>
>
>   Serial drivers invoke tons of core kernel functions - WQ, MM, etc. All
>   of which may printk() in various cases. So we can't really just
>   "remove those printk-s". The simples way to address this seems to be
>   PRINTK_SAFE_CONTEXT_MASK.

serial/UART and printk guys, sorry to bother you, do you hate this
idea of removing console_driver->CORE KERNEL->printk->console_driver
deadlock path? Or is there any chance we can move forward?

	-ss
