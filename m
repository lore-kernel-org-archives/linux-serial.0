From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Wed, 13 Feb 2019 15:15:42 +0100
Message-ID: <878syj22r5.fsf@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190213014141.GB8097@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213014141.GB8097@jagdpanzerIV> (Sergey Senozhatsky's
        message of "Wed, 13 Feb 2019 10:41:41 +0900")
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 2019-02-13, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>> - console_flush_on_panic() currently is a NOP. It is pretty clear how
>>   this could be implemented if atomic_write was available. But if no
>>   such console is registered, it is not clear what should be done. Is
>>   this function really even needed?
>
> If you now rely on a fully preemptible printk kthread to flush
> pending logbuf messages, then console_flush_on_panic() is your
> only chance to see those pending logbuf messages on the serial
> console when the system dies.

Anything critical would have already been immediately print to the
emergency consoles. And if an emergency console was available,
console_flush_on_panic() could be a special case where _all_ unseen
messages (regardless of importance) are printed to the emergency
console.

> Non-atomic consoles should become atomic once you call bust_spinlocks(1),
> this is what we currently have:
>
> 	panic()
> 	bust_spinlocks(1)                       // sets oops_in_progress
> 	console_flush_on_panic()
> 	 call_console_drivers()
> 	  -> serial_driver_write()
> 	      if (oops_in_progress)
> 	        locked = spin_trylock_irqsave(&port->lock);
> 	      uart_console_write();
> 	      if (locked)
> 	        spin_unlock_irqrestore(&port->lock);

I don't like bust_spinlocks() because drivers end up implementing
oops_in_progress with exactly that... ignoring their own locks. I prefer
consoles are provided with a locking mechanism that they can use to
support a separate NMI-safe write function. My series introduces
console_atomic_lock() for exactly this purpose.

But this doesn't help here. Here we are talking about a crashing system
that does _not_ have an emergency console. And in this case I would say
messages would be lost (just like they are now if all you have is a vt
console and it was busy).

I suppose we could keep the current bust_spinlocks() stuff for the
special case that there are no emergency consoles available. It's better
than nothing, but also not really reliable. Preferrably we figure out
how to implement write_atomic for all console drivers.

John Ogness
