From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 15/25] printk: print history for new consoles
Date: Mon, 4 Mar 2019 18:24:44 +0900
Message-ID: <20190304092444.GA21004@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-16-john.ogness@linutronix.de>
 <20190226145837.wl54fr7rn2ii5oxc@pathway.suse.cz>
 <87o96yziau.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87o96yziau.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (02/26/19 16:22), John Ogness wrote:
> > This looks like an alien. The code is supposed to write one message
> > from the given buffer. And some huge job is well hidden there.
> 
> This is a very simple implementation of a printk kthread. It probably
> makes more sense to have a printk kthread per console. That would allow
> fast consoles to not be penalized by slow consoles. Due to the
> per-console seq tracking, the code would already support it.

I believe we discussed "polling consoles" several times.

printk-kthread is one way to implement polling. Another one might
already be implemented in, probably, all serial drivers and we just
need to extend it a bit - polling from console's IRQ handler.

Serial drivers poll UART xmit buffer and print (usually) up to
`count' bytes:

	static irqreturn_t foo_irq_handler(int irq, void *id)
	{
		int count = 512;

		[...]
		while (count > 0 && !uart_circ_empty(xmit)) {
			wr_regb(port, TX, xmit->buf[xmit->tail]);
			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
			count--;
		}
		[...]

		return IRQ_HANDLED;
	}

So we can also grub NUM (e.g. max 64 entries) pending logbuf messages
and print them from device's isr.

	-ss
