From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Tue, 12 Mar 2019 13:38:57 +0100
Message-ID: <20190312123857.juatd6fwtfmqajze@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213025520.GA5803@jagdpanzerIV>
 <874l9721hf.fsf@linutronix.de>
 <20190304052335.GA6648@jagdpanzerIV>
 <87lg1rggcz.fsf@linutronix.de>
 <20190311105411.GA368@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311105411.GA368@jagdpanzerIV>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Mon 2019-03-11 19:54:11, Sergey Senozhatsky wrote:
> On (03/07/19 10:53), John Ogness wrote:
> > Since all current console drivers are already irq safe, I'm
> > wondering if using irq_work to handle the emergency printing for console
> > drivers without write_atomic() would help. (If the printk caller is in a
> > context that write() supports, then write() could be called directly.)
> > This would also demand that the irq-safe requirements for write() are
> > not relaxed. The printk-kthread might still be faster than irq_work, but
> > it might increase reliability if an irq_work is triggered as an extra
> > precaution.
> 
> Hmm. OK. So one of the things with printk is that it's fully sequential.
> We call console drivers one by one. Slow consoles can affect what appears
> on the fast consoles; fast console have no impact on slow ones.
> 
> 	call_console_drivers()
> 		for_each_console(c)
> 			c->write(c, text, text_len);
> 
> So a list of (slow_serial serial netcon) console drivers is a camel train;
> fast netcon is not fast anymore, and slow consoles sometimes are the reason
> we have dropped messages. And if we drop messages we drop them for all
> consoles, including fast netcon. Turning that sequential pipline into a
> bunch of per-console kthreads/irq and letting fast consoles to be fast is
> not a completely bad thing. Let's think more about this, I'd like to read
> more opinions.

Per-console kthread sounds interesting but there is the problem with
reliability. I mean that kthread need not get scheduled.

Some of these problems might get solved by the per-console loglevel
patchset.

Sigh, any feature might be useful in some situation. But we always
have to consider the cost and the gain. I wonder how common is
to actively use two consoles at the same time and what would
be the motivation.

Best Regards,
Petr
