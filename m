From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCHv2 1/4] panic: avoid deadlocks in re-entrant console
 drivers
Date: Tue, 23 Oct 2018 20:54:33 +0900
Message-ID: <20181023115433.GA10251@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181023110751.un2u67bc7dpo4ska@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181023110751.un2u67bc7dpo4ska@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (10/23/18 13:07), Petr Mladek wrote:
> Though this looks a bit weird.
> 
> I have just realized that console_unblank() is called by
> bust_spinlocks(0) and does basically the same as
> console_flush_on_panic(). Also it does not make much
> sense wake_up_klogd() there. Finally, it seems to be
> too late to disable lockdep there.

Thanks for taking a look.
As of "weird" part I have some explanations:

> @@ -233,17 +233,14 @@ void panic(const char *fmt, ...)
>  	if (_crash_kexec_post_notifiers)
>  		__crash_kexec(NULL);
>  
> -	bust_spinlocks(0);
> -
[..]
> -	debug_locks_off();
> +#ifdef CONFIG_VT
> +	unblank_screen();
> +#endif
>  	console_flush_on_panic();
>  
>  	if (!panic_blink)


So I did look at what lib/bust_spinlocks.c does; and I agree that waking
up klogd makes little sense, on the other hand it just sets per-cpu
pending bit, so not a big deal. console_unlock() should do there the
same thing as console_flush_on_panic(). Yes. However, a bit of a bigger
argument:
   __attribute__((weak)) suggests that bust_spinlocks() is arch-dependent
   and it's up to arch to do some extra stuff there [if needed]. So that's
   why I decided to keep bust_spinlocks(0) in panic() and, thus, call into
   arch-specific code (or common bust_spinlocks); then bump oops_in_progress
   so serial consoles become re-entrant and finally call
   console_flush_on_panic().

>  void __attribute__((weak)) bust_spinlocks(int yes)
>  {
>  	if (yes) {
> +		/*
> +		 * Some locks might get ignored in the Oops situation
> +		 * to get an important work done. Locks debug should
> +		 * be disabled to avoid reporting bad unlock balance.
> +		 */
> +		debug_locks_off();
>  		++oops_in_progress;

Hmm, I don't think I've seen any reports because of this. From printk/console
POV the locks which are not taken under oops_in_progress are not released.

Wrt to uart port we usually have "bool locked" flag and unlock
port->lock only if we locked it:

{
	if (oops_in_progress)
		locked = spin_trylock_irqsave(&port->lock, flags);

	...

	if (locked)
		spin_unlock_irqrestore(&port->lock, flags);
}

Wrt to console_sem we have

{
	if (oops_in_progress)
		if (!down_trylock_console_sem() != 0)
			return;
	...
	console_unlock();
}

So the locks that we care about in this particular patch (console sem
and port->lock) probably should not see any locking imbalance.

If you have strong opinion then we can have debug_locks_off() change
as part of this patch. But maybe I'd prefer to have it as a separate
patch. What do you think?

	-ss
