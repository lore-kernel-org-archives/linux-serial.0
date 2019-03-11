From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [RFC PATCH v1 25/25] printk: remove unused code
Date: Mon, 11 Mar 2019 09:18:26 +0100
Message-ID: <20190311081826.k7ybxniveuqeaxzp@flow>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-26-john.ogness@linutronix.de>
 <20190308140229.xje5ay7w2qtlada5@flow>
 <20190311024600.GA25608@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311024600.GA25608@jagdpanzerIV>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 2019-03-11 11:46:00 [+0900], Sergey Senozhatsky wrote:
> On (03/08/19 15:02), Sebastian Andrzej Siewior wrote:
> > On 2019-02-12 15:30:03 [+0100], John Ogness wrote:
> > 
> > you removed the whole `irq_work' thing. You can also remove the include
> > for linux/irq_work.h.
> 
> It may be too early to remove the whole `irq_work' thing.
> printk()->call_console_driver() should take console_sem
> lock.

I would be _very_ glad to see that irq_work thingy gone. I just stumbled
upon this irq_work and cursed a little while doing other things.
Checking John's series and seeing that it was gone, was a relief.
Printing the whole thing in irq context does not look sane. printing the
import things right away and printing the remaining things later in
kthread looks good to me.

> 	-ss

Sebastian
