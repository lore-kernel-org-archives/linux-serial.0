From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC][PATCHv2 1/4] panic: avoid deadlocks in re-entrant console
 drivers
Date: Thu, 25 Oct 2018 10:29:47 +0200
Message-ID: <20181025082947.gznv5roj3zxzlw3t@pathway.suse.cz>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181023110751.un2u67bc7dpo4ska@pathway.suse.cz>
 <20181023115433.GA10251@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181023115433.GA10251@jagdpanzerIV>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue 2018-10-23 20:54:33, Sergey Senozhatsky wrote:
> On (10/23/18 13:07), Petr Mladek wrote:
> > Though this looks a bit weird.
> > 
> > I have just realized that console_unblank() is called by
> > bust_spinlocks(0) and does basically the same as
> > console_flush_on_panic(). Also it does not make much
> > sense wake_up_klogd() there. Finally, it seems to be
> > too late to disable lockdep there.
> 
> So I did look at what lib/bust_spinlocks.c does; and I agree that waking
> up klogd makes little sense, on the other hand it just sets per-cpu
> pending bit, so not a big deal. console_unlock() should do there the
> same thing as console_flush_on_panic().

Yes, klogd is not a big deal. I just think that the bust_spinlocks()
ping-pong would just confuse the code. It might be better to keep
the spinlocks busted and make sure that we do not cause regressions
by not calling bust_spinlocks(0).

It tried to solve this by calling the important actions from
bust_spinlocks(0) directly in panic(). I wanted to omit anything
that does not make sense in panic().


> >  void __attribute__((weak)) bust_spinlocks(int yes)
> >  {
> >  	if (yes) {
> > +		/*
> > +		 * Some locks might get ignored in the Oops situation
> > +		 * to get an important work done. Locks debug should
> > +		 * be disabled to avoid reporting bad unlock balance.
> > +		 */
> > +		debug_locks_off();
> >  		++oops_in_progress;
> 
> Hmm, I don't think I've seen any reports because of this. From printk/console
> POV the locks which are not taken under oops_in_progress are not released.

Fair enough. Let's keep debug_locks_off() in panic().

Best Regards,
Petr
