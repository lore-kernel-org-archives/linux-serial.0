From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 25/25] printk: remove unused code
Date: Tue, 12 Mar 2019 10:38:05 +0100
Message-ID: <20190312093805.x6psdruanocuckun@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-26-john.ogness@linutronix.de>
 <20190308140229.xje5ay7w2qtlada5@flow>
 <20190311024600.GA25608@jagdpanzerIV>
 <20190311081826.k7ybxniveuqeaxzp@flow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311081826.k7ybxniveuqeaxzp@flow>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Mon 2019-03-11 09:18:26, Sebastian Andrzej Siewior wrote:
> On 2019-03-11 11:46:00 [+0900], Sergey Senozhatsky wrote:
> > On (03/08/19 15:02), Sebastian Andrzej Siewior wrote:
> > > On 2019-02-12 15:30:03 [+0100], John Ogness wrote:
> > > 
> > > you removed the whole `irq_work' thing. You can also remove the include
> > > for linux/irq_work.h.
> > 
> > It may be too early to remove the whole `irq_work' thing.
> > printk()->call_console_driver() should take console_sem
> > lock.
> 
> I would be _very_ glad to see that irq_work thingy gone. I just stumbled
> upon this irq_work and cursed a little while doing other things.

Have you seen stalls causes by the irq work? Or was it just
glancing over the printk code?


> Checking John's series and seeing that it was gone, was a relief.
> Printing the whole thing in irq context does not look sane. printing the
> import things right away and printing the remaining things later in
> kthread looks good to me.

The irq_work was originally added to handle messages from the
scheduler by printk_deferred(). It was later used also to
handle messages from NMI and printk recursion.

It means that the use is pretty limited. It is more reliable
than a kthread, especially when the scheduler is reporting
problems. IMHO, it is a reasonable solution as long
as the amount of messages is low.

The real time kernel is another story but it has special
handling in many other situations.

That said, the kthread might still make sense as a fallback.
It would be nice to have a hard limit for handling messages
in irq context.

Best Regards,
Petr
