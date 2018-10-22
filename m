From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Date: Mon, 22 Oct 2018 16:30:29 +0200
Message-ID: <20181022143029.i4jc5vjq4t3tagb3@pathway.suse.cz>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016114006.6q5atyaitapcwbud@pathway.suse.cz>
 <20181016121752.GA2537@hirez.programming.kicks-ass.net>
 <20181017105015.udzegzfh7cxgatso@pathway.suse.cz>
 <20181017140044.GK3121@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181017140044.GK3121@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, john.ogness@linutronix.de
List-Id: linux-serial@vger.kernel.org

On Wed 2018-10-17 16:00:44, Peter Zijlstra wrote:
> On Wed, Oct 17, 2018 at 12:50:15PM +0200, Petr Mladek wrote:
> > Also note that by deferred printk I mean deferring the console
> > handling! IMHO, there are _no more problems_ with storing
> > the messages into the buffer if we accept that the current
> > very limited use of printk_safe per-cpu buffers is easier
> > than any complicated generic lockless buffer.
> 
> They hide messages. The whole two radically different printk paths is
> also quite horrible.

I agree that having everything in one buffer with unified
and safe access from any context would be a great win.


> And lockless buffers aren't all _that_ complicated, esp. not when
> performance isn't the top priority.
>
> And earlycon is mostly usable, esp. the serial ones. Those, when
> configured, should synchronously print along. The current design
> also makes that difficult.
>
> A wee little like so; typed in a hurry, never been near a compiler.

Thanks a lot for the code. I still need to find time to better
understand it. Anyway, it looks worth considering.

Best Regards,
Petr
