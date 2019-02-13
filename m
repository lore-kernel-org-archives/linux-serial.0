From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Wed, 13 Feb 2019 10:41:41 +0900
Message-ID: <20190213014141.GB8097@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (02/12/19 15:29), John Ogness wrote:
> - console_flush_on_panic() currently is a NOP. It is pretty clear how
>   this could be implemented if atomic_write was available. But if no
>   such console is registered, it is not clear what should be done. Is
>   this function really even needed?

If you now rely on a fully preemptible printk kthread to flush
pending logbuf messages, then console_flush_on_panic() is your
only chance to see those pending logbuf messages on the serial
console when the system dies.

Non-atomic consoles should become atomic once you call bust_spinlocks(1),
this is what we currently have:

	panic()
	bust_spinlocks(1)                       // sets oops_in_progress
	console_flush_on_panic()
	 call_console_drivers()
	  -> serial_driver_write()
	      if (oops_in_progress)
	        locked = spin_trylock_irqsave(&port->lock);
	      uart_console_write();
	      if (locked)
	        spin_unlock_irqrestore(&port->lock);

	-ss
