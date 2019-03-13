From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Wed, 13 Mar 2019 11:00:02 +0900
Message-ID: <20190313020002.GA783@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213025520.GA5803@jagdpanzerIV>
 <874l9721hf.fsf@linutronix.de>
 <20190304052335.GA6648@jagdpanzerIV>
 <87lg1rggcz.fsf@linutronix.de>
 <20190311105411.GA368@jagdpanzerIV>
 <20190312123857.juatd6fwtfmqajze@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190312123857.juatd6fwtfmqajze@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (03/12/19 13:38), Petr Mladek wrote:
> > Hmm. OK. So one of the things with printk is that it's fully sequential.
> > We call console drivers one by one. Slow consoles can affect what appears
> > on the fast consoles; fast console have no impact on slow ones.
> > 
> > 	call_console_drivers()
> > 		for_each_console(c)
> > 			c->write(c, text, text_len);
> > 
> > So a list of (slow_serial serial netcon) console drivers is a camel train;
> > fast netcon is not fast anymore, and slow consoles sometimes are the reason
> > we have dropped messages. And if we drop messages we drop them for all
> > consoles, including fast netcon. Turning that sequential pipline into a
> > bunch of per-console kthreads/irq and letting fast consoles to be fast is
> > not a completely bad thing. Let's think more about this, I'd like to read
> > more opinions.
> 
> Per-console kthread sounds interesting but there is the problem with
> reliability. I mean that kthread need not get scheduled.

Correct, it has to get scheduled. From that point of view IRQ offloading
looks better - either to irq_work (like John suggested) or to serial
drivers' irq handler (poll uart xmit + logbuf).

kthread offloading is not super reliable. That's why I played tricks
with CPU affinity - scheduler sometimes schedule printk_kthread on the
same CPU which spins in console_unlock() loop printing the messages, so
printk_kthread offloading never happens. It was first discovered by Jan
Kara (back in the days of async-printk patch set). I think at some point
Jan's async-printk patch set had two printk kthreads.

We also had some concerns regarding offloading on UP systems.

> Some of these problems might get solved by the per-console loglevel
> patchset.

Yes, some.

> Sigh, any feature might be useful in some situation. But we always
> have to consider the cost and the gain. I wonder how common is
> to actively use two consoles at the same time and what would
> be the motivation.

Facebook fleet for example. The motivation is - to have a fancy fast
console that does things which simple serial consoles cannot do and
a slow serial console, which is sometimes more reliable, as last resort.
Fancy stuff usually means dependencies - net, mm, etc. So when fancy
console stop working, slow serial console still does.

	-ss
