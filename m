From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Date: Wed, 20 Jun 2018 11:50:50 +0900
Message-ID: <20180620025050.GE650@jagdpanzerIV>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop>
 <20180619005308.GA405@jagdpanzerIV>
 <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
 <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, SergeySenozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (06/20/18 11:01), Linus Torvalds wrote:
> On Tue, Jun 19, 2018 at 5:30 PM Petr Mladek <pmladek@suse.com> wrote:
> >
> > To make it clear. This patch set adds yet another spin_lock API.
> > It behaves exactly as spin_lock_irqsafe()/spin_unlock_irqrestore()
> > but in addition it sets printk_context.
> >
> > This patchset forces safe context around TTY and UART locks.
> > In fact, the deferred context would be enough to prevent
> > all the mentioned deadlocks.
> 
> Please stop this garbage.

I'm guessing the message was addressed to me, not to Petr.
Let me explain myself.

> The rule is simple: DO NOT DO THAT THEN.
>
> Don't make recursive locks. Don't make random complexity.  Just stop
> doing the thing that hurts.

We didn't add any of those recursive printk()-s. Those are the things
like kmalloc()/scheduler/etc which tty/etc invoke that hurt.

> There is no valid reason why an UART driver should do a printk() of
> any sort inside the critical region where the console is locked.

It's not UART on its own that immediately calls into printk(), that would
be trivial to fix, it's all those subsystems that serial console driver
can call into.

For instance, kernel/workqueue.c - it may WARN_ON/printk in various cases.
And those WARNs/printks are OK. Except for one thing: workqueue can be
called from a serial console driver, which suddenly will turn those
WARNs/printks into illegal ones, due to possible deadlocks. And serial
consoles can call into WQ. Not directly, but via tty code.

A random example:

s3c24xx_serial_rx_chars_dma()
 spin_lock_irqsave(&port->lock, flags);
  tty_flip_buffer_push()
   __queue_work()
 spin_unlock_irqrestore(&port->lock, flags);

Should for some reason WQ warn/printk, we are done, because we will
end up taking the same port->lock:

  __queue_work()
    printk()
     call_console_drivers()
      spin_lock_irqsave(&port->lock, flags);

IOW, there is this tricky "we were called from a serial driver" context,
which is hard to track, but printk_safe can help us in those cases. There
are other examples. WQ is not the only thing serial drivers can call into.
So that's why I sent the patch set.

	-ss
