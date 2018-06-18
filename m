From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Date: Mon, 18 Jun 2018 14:38:18 +0100
Message-ID: <20180618143818.50b2f2f9@alans-desktop>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

> It doesn't come as a surprise that recursive printk() calls are not the
> only way for us to deadlock in printk() and we still have a whole bunch
> of other printk() deadlock scenarios. For instance, those that involve
> TTY port->lock spin_lock and UART port->lock spin_lock.

The tty layer code there is not re-entrant. Nor is it supposed to be

> So the idea of this patch set is to take tty_port->lock and
> uart_port->lock from printk_safe context and to eliminate some
> of non-recursive printk() deadlocks - the ones that don't start
> in printk(), but involve console related locks and thus eventually
> deadlock us in printk(). For this purpose the patch set introduces
> several helper macros:

I don't see how this helps - if you recurse into the uart code you are
still hitting the paths that are unsafe when re-entered. All you've done
is messed up a pile of locking code on critical performance paths.

As it stands I think it's a bad idea.

> Of course, TTY and UART port spin_locks are not the only locks that
> we can deadlock on. So this patch set does not address all deadlock
> scenarios, it just makes a small step forward.
> 
> Any opinions?

The cure is worse than the disease.

The only case that's worth looking at is the direct polled console code
paths. The moment you touch the other layers you add essentially never
needed code to hot paths.

Given printk nowdays is already somewhat unreliable with all the perf
related changes, and we have other good debug tools I think it would be
far cleaner to have some kind of


	if (spin_trylock(...)) {
		console_defer(buffer);
		return;
	}

helper layer in the printk/console logic, at least for the non panic/oops
cases.

Alan
