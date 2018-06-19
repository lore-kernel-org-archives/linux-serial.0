From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Date: Tue, 19 Jun 2018 09:53:08 +0900
Message-ID: <20180619005308.GA405@jagdpanzerIV>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180618143818.50b2f2f9@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

Thanks for taking a look!

On (06/18/18 14:38), Alan Cox wrote:
> > It doesn't come as a surprise that recursive printk() calls are not the
> > only way for us to deadlock in printk() and we still have a whole bunch
> > of other printk() deadlock scenarios. For instance, those that involve
> > TTY port->lock spin_lock and UART port->lock spin_lock.
> 
> The tty layer code there is not re-entrant. Nor is it supposed to be

Could be.

But at least we have circular locking dependency in tty,
see [1] for more details:

  tty_port->lock  => uart_port->lock

   CPU0
   tty
    spin_lock(&tty_port->lock)
     printk()
      call_console_drivers()
       foo_console_write()
        spin_lock(&uart_port->lock)

Whereas we normally have

  uart_port->lock => tty_port->lock

   CPU1
   IRQ
    foo_console_handle_IRQ()
     spin_lock(&uart_port->lock)
      tty
       spin_lock(&tty_port->lock)


If we switch to printk_safe when we take tty_port->lock then we
remove the printk->uart_port chain from the picture.

> > So the idea of this patch set is to take tty_port->lock and
> > uart_port->lock from printk_safe context and to eliminate some
> > of non-recursive printk() deadlocks - the ones that don't start
> > in printk(), but involve console related locks and thus eventually
> > deadlock us in printk(). For this purpose the patch set introduces
> > several helper macros:
> 
> I don't see how this helps - if you recurse into the uart code you are
> still hitting the paths that are unsafe when re-entered. All you've done
> is messed up a pile of locking code on critical performance paths.
> 
> As it stands I think it's a bad idea.

The only new thing is that we inc/dec per-CPU printk context
variable when we lock/unlock tty/uart port lock:

	printk_safe_enter() -> this_cpu_inc(printk_context);
	printk_safe_exit() -> this_cpu_dec(printk_context);

How does this help? Suppose we have the following

       IRQ
       foo_console_handle_IRQ()
        spin_lock(&uart_port->lock)
         uart_write_wakeup()
          tty_port_tty_wakeup()
           tty_port_default_wakeup()
            printk()
             call_console_drivers()
              foo_console_write()
               spin_lock(&uart_port->lock)  << deadlock

If we take uart_port lock from printk_safe context, we remove the
   printk->call_console_drivers->foo_console_write->spin_lock
chain. Because printk() output will endup in a per-CPU buffer,
which will be flushed later from irq_work. So the whole thing
becomes:

       IRQ
       foo_console_handle_IRQ()
        printk_safe_enter()
        spin_lock(&uart_port->lock)
         uart_write_wakeup()
          tty_port_tty_wakeup()
           tty_port_default_wakeup()
            printk()                           << we don't re-enter foo_console_driver
                                               << from printk() anymore
             printk_safe_log_store()
              irq_work_queue
        spin_unlock(&uart_port->lock)
        printk_safe_exit()
       iret

       #flush per-CPU buffer
       IRQ
        printk_safe_flush_buffer()
         vprintk_deferred()

> > Of course, TTY and UART port spin_locks are not the only locks that
> > we can deadlock on. So this patch set does not address all deadlock
> > scenarios, it just makes a small step forward.
> > 
> > Any opinions?
> 
> The cure is worse than the disease.

Because of this_cpu_inc(printk_context) / this_cpu_dec(printk_context)?
May be. That's why I put RFC :)

> The only case that's worth looking at is the direct polled console code
> paths. The moment you touch the other layers you add essentially never
> needed code to hot paths.
> 
> Given printk nowdays is already somewhat unreliable with all the perf
> related changes, and we have other good debug tools I think it would be
> far cleaner to have some kind of
> 
> 
> 	if (spin_trylock(...)) {
> 		console_defer(buffer);
> 		return;
> 	}
> 
> helper layer in the printk/console logic, at least for the non panic/oops
> cases.

spin_trylock() in every ->foo_console_write() callback?
This still will not address the reported deadlock [1].

[1] lkml.kernel.org/r/000000000000d557e7056e1c7a01@google.com

	-ss
