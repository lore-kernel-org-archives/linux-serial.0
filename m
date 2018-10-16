From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Date: Tue, 16 Oct 2018 14:17:52 +0200
Message-ID: <20181016121752.GA2537@hirez.programming.kicks-ass.net>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016114006.6q5atyaitapcwbud@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181016114006.6q5atyaitapcwbud@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 16, 2018 at 01:40:06PM +0200, Petr Mladek wrote:
> On Tue 2018-10-16 09:27:19, Peter Zijlstra wrote:

> > Instead of this tinkering around the edges, why don't you make the main
> > logbuf a lockless ringbuffer and then delegate the actual printing of
> > that buffer to a kthread, except for earlycon, which can do synchronous
> > output.
> 
> In fact, there is no problem with printk log buffer. This patchset
> tries to avoid deadlock caused by console-specific locks
> used by console->write() methods.
> 
> By other words, we neither need printk_safe or lockless log buffer
> to fix this prolem. Instead, we need either printk_deferred context
> or lockless consoles.

If you have a lockless buffer and a trailing printk thread, that's
deferred.

And earlycon _should_ be lockless (yes, I know, some suck)

But if you do this deferred nonsense that's currently in printk, then
you risk never seeing the message -- the same problem I have with the
whole printk_safe thing too.

Printing _after_ the fact is horrible for robustness.
