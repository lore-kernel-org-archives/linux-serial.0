From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Date: Wed, 17 Oct 2018 12:50:15 +0200
Message-ID: <20181017105015.udzegzfh7cxgatso@pathway.suse.cz>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016114006.6q5atyaitapcwbud@pathway.suse.cz>
 <20181016121752.GA2537@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181016121752.GA2537@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue 2018-10-16 14:17:52, Peter Zijlstra wrote:
> On Tue, Oct 16, 2018 at 01:40:06PM +0200, Petr Mladek wrote:
> > On Tue 2018-10-16 09:27:19, Peter Zijlstra wrote:
> 
> > > Instead of this tinkering around the edges, why don't you make the main
> > > logbuf a lockless ringbuffer and then delegate the actual printing of
> > > that buffer to a kthread, except for earlycon, which can do synchronous
> > > output.
> > 
> > In fact, there is no problem with printk log buffer. This patchset
> > tries to avoid deadlock caused by console-specific locks
> > used by console->write() methods.
> > 
> > By other words, we neither need printk_safe or lockless log buffer
> > to fix this prolem. Instead, we need either printk_deferred context
> > or lockless consoles.
> 
> If you have a lockless buffer and a trailing printk thread, that's
> deferred.
> 
> And earlycon _should_ be lockless (yes, I know, some suck)
> 
> But if you do this deferred nonsense that's currently in printk, then
> you risk never seeing the message -- the same problem I have with the
> whole printk_safe thing too.

What do you mean with printing the message, please? Storing it
into a buffer or showing on console?

I guess that it is storing because you suggest handling
the console by a printk kthread.

Now, please, what is your vision of the lock less buffer?
Would it be similar with the one used by ftrace?

The current implementation of the lockless buffer is very tricky
and supports only one reader. It will be even bigger maze
of code when we add such a support.

Also the messages are spread in many page-size buffers that
are linked in a per-cpu lists. The page used by the reader
is put outside the list. This all makes it very hard to
reconstruct the log. AFAIK, people use ftrace_dump_on_oops
even with a crashdump because nobody improved crash
to extract the messages from the complicated lockless
buffer for years.

IMHO, the current printk buffer is much more easy from
this point of view. It is one global buffer plus
two per-cpu buffers that are mostly empty.


I still think that the buffer is the minor problem these
days. The big problem are consoles and I do not see
how any lockless buffer could help with it.

Also note that by deferred printk I mean deferring the console
handling! IMHO, there are _no more problems_ with storing
the messages into the buffer if we accept that the current
very limited use of printk_safe per-cpu buffers is easier
than any complicated generic lockless buffer.

Best Regards,
Petr
