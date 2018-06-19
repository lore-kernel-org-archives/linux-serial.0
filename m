From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Date: Tue, 19 Jun 2018 17:59:33 +0900
Message-ID: <20180619085933.GA2631@jagdpanzerIV>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop>
 <20180619005308.GA405@jagdpanzerIV>
 <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (06/19/18 10:30), Petr Mladek wrote:
> It is re-entrant via printk(). I mean that any printk() called inside
> the locked sections might cause recursion if the same lock is needed
> also by con->write() callbacks.

Perhaps Alan meant that we cannot return back to tty once we passed
the control from tty to printk -> uart serial console. So tty is
probably (but I didn't check) not re-entrant, but uart definitely is
re-entrant: IRQ -> uart console -> tty -> printk -> uart console.

The patch set attempts to address several issues, and re-entrant uart
is just one of them.

[..]
> This patchset forces safe context around TTY and UART locks.

Right.

> In fact, the deferred context would be enough to prevent
> all the mentioned deadlocks.

Agree.
But we can leave it as a printk_safe implementation detail and
change it later, outside of this patch, to avoid further confusion.

> IMHO, the only question is if people might get familiar with
> yet another spin_lock API.

Right. That's why I thought about renaming uart_port and tty_port
->lock to ->____lock. So the naming will suggest [hopefully] that
those locks are not meant to be used directly [anymore] and instead
people should use uart_port_lock/tty_port_lock API.

	-ss
