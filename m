From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Date: Tue, 12 Mar 2019 18:58:56 +0900
Message-ID: <20190312095856.GA426@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
 <20190304073856.GA552@jagdpanzerIV>
 <20190304100044.GC21004@jagdpanzerIV>
 <20190304110703.GA960@tigerII.localdomain>
 <87o96p9gtx.fsf@linutronix.de>
 <20190307051530.GC4893@jagdpanzerIV>
 <87va0pznsq.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87va0pznsq.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On (03/11/19 11:51), John Ogness wrote:
> > In new printk design the tasks are still affected by printing floods.
> > Tasks have to line up and (busy) wait for each other, regardless of
> > contexts.
> 
> They only line up and busy wait is to add the informational message to
> the ring buffer. The current printk implementation is the same in this
> respect. And as you've noted, the logbuf spinlock is not a source of
> latencies.

I was talking about prb_lock().

> > When I do ./a.out --loglevel=X  I have a clear understanding that
> > all messages which fall into [critical, X] range will be in the logs,
> > because I told that application that those messages are important to
> > me right now. And it used to be the same with the kernel loglevel.
> 
> The loglevel is not related to logging. It specifies the amount of
> console printing. But I will assume you are referring to creating log
> files by having an external device store the console printing.

Right. E.g. screenlog.0

> > But now the kernel will do its own thing:
> >
> >   - what the kernel considers important will go into the logs
> >   - what the kernel doesn't consider important _maybe_ will end up
> >     in the logs (preemptible printk kthread). And this is where
> >     loglevel now. After the _maybe_ part.
> 
> "what the kernel considers" is a configuration option of the
> administrator. The administrator can increase the verbocity of the
> console (loglevel) without having negative effects on the system
> itself. Also, if the system were to suddenly crash, those crash messages
> shouldn't be in jeopardy just because the verbocity of the console was
> turned up.

Right. I'm not very sure about yet another knob which everyone
should figure out. I guess I won't be surprised to find out that
people set it to loglevel value.

	-ss
