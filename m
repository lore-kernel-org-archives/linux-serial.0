From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Thu, 14 Mar 2019 10:14:34 +0100
Message-ID: <20190314091434.ci26htgagjx6mk4k@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213025520.GA5803@jagdpanzerIV>
 <874l9721hf.fsf@linutronix.de>
 <20190304052335.GA6648@jagdpanzerIV>
 <87lg1rggcz.fsf@linutronix.de>
 <20190311105411.GA368@jagdpanzerIV>
 <20190312123857.juatd6fwtfmqajze@pathway.suse.cz>
 <874l8815uc.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874l8815uc.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sebastian Siewior <bigeasy@linutronix.de>
List-Id: linux-serial@vger.kernel.org

On Tue 2019-03-12 16:15:55, John Ogness wrote:
> On 2019-03-12, Petr Mladek <pmladek@suse.com> wrote:
> > On Tue 2019-03-12 09:17:49, John Ogness wrote:
> >> The current printk implementation is handling all console printing as
> >> best effort. Trying hard enough to dramatically affect the system, but
> >> not trying hard enough to guarantee success.
> >
> > I agree that direct output is more reliable. It might be very useful
> > for debugging some types of problems. The question is if it is worth
> > the cost (code complexity, serializing CPUs == slowing down the
> > entire system).
> >
> > But it is is possible that a reasonable offloading (in the direction
> > of last Sergey's approach) might be a better deal.
> >
> >
> > I suggest the following way forward (separate patchsets):
> >
> >     1. Replace log buffer (least controversial thing)
> 
> Yes. I will post a series that only implements the ringbuffer using your
> simplified API. That will be enough to remove printk_safe and actually
> does most of the work of updating devkmsg, kmsg_dump, and syslog.

Great. I just wonder if it is going to be fully lockless or
still using the prb_lock. I could understand the a fully lockless
solution will be much more complicated. But I think that it would
make a lot of things easier in the long run. Especially it might
help to avoid the big-kernel-lock-like approach.


> >     2. Reliable offload to kthread (would be useful anyway)
> 
> Yes. I would like to implement per-console kthreads for this series. I
> think the advantages are obvious. For PREEMPT_RT the offloading will
> need to be always active. (PREEMPT_RT cannot call the console->write()
> from atomic contexts.) But I think this would be acceptable at first. It
> would certainly be better than what PREEMPT_RT is doing now.

I would personally start with one kthread. I am afraid that
the discussion about it will be complicated enough. We could
always make it more complicated later.

I understand the immediate offloading might be necessary for
PREEMPT_RT. But a more conservative approach is needed for
non-rt kernels.

Well, if there won't be a big difference in the complexity
between one and more threads then we could mix it. But
I personally see this a two steps that are better be done
separately.


> >     3. Atomic consoles (a lot of tricky code, might not be
> > 		worth the effort)
> 
> I think this will be necessary. PREEMPT_RT cannot support reliable
> emergency console messages without it. And for kernel developers this is
> also very helpful. People like PeterZ are using their own patches
> because the mainline kernel is not providing this functionality.
> 
> The decision about _when_ to use it is still in the air. But I guess
> we'll worry about that when we get that far. There's enough to do until
> then.

I am sure that there are situations where the direct output
to atomic consoles would help with debugging. PeteZ and Steven
are using their own patches for a reason.

Let's see how the code is complicated and how many consoles
might get supported a reasonable way.


Anyway, it will be a long run. I am personally curious where
this will end :-)

Best Regards,
Petr
