From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Date: Wed, 17 Oct 2018 22:36:38 +0900
Message-ID: <20181017133638.GA426@tigerII.localdomain>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016122734.GA1259@jagdpanzerIV>
 <20181016125415.GA3121@hirez.programming.kicks-ass.net>
 <20181017043251.GC1068@jagdpanzerIV>
 <20181017075728.GF3121@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181017075728.GF3121@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (10/17/18 09:57), Peter Zijlstra wrote:
> On Wed, Oct 17, 2018 at 01:32:51PM +0900, Sergey Senozhatsky wrote:
> > This probably will be a bit more hairy. logbuf is written to by many
> > sources and is read from by many sides, including user-space [both read()
> > and write()]. So we will need more flags/magic around memcpy(). A simple,
> > "grab the logbuf entry, set the proper offset to point to the next available
> > logbuf record and then do memcpy()" won't suffice. We need a flag for
> > "memcpy() complete, we can read this entry". Otherwise:
> 
> Sure, but lockless buffers mostly have reserve and commit stages anyway.
> Exactly to avoid that problem.

Right. So it should be a lockless ringbuffer supporting multiple
parallel readers and multiple parallel writers from multiple contexts
(task, sortirq, irq, NMI); with sane wrap around, etc. And we probably
need to somehow keep the existing format of logbuf entries to avoid
breakages in crash tool, and so on. It will take a lot of time, I'm
afraid.

> > All right. OK. So we are on the same page here:
> 
> > - Have more opinions on this. People please speak out.
> > - Have clear "let's do it" from Cc-ed people.
> > 
> > 
> > If we are really doing this, then let's split it and have
> > incremental changes. Namely, what I suggest is:
> 
> I'd start by replacing logbuf with the lockless buffer and ripping out
> the current nmi/safe/etc.. bollocks.
> 
> There is absolutely no point what so ever in doing anything until that
> is sorted.

Peter, you have your point, however, I think I have a slightly different
priority list. On the top of my list - deadlocks in printk(). That's the
whole reason I sent this series. Deadlocks are real. We have real reports;
in the best case in form of lockdep splats; in the worst case - nothing,
simply because the system deadlocks in printk(), and even more - printk()
can deadlock in panic(). So addressing deadlocks in printk() will fix a
rather big, real problem. Then we can have fun with the rest of the things
you have mentioned. What do you think?

	-ss
