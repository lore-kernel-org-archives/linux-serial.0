From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCHv2 1/4] panic: avoid deadlocks in re-entrant console
 drivers
Date: Tue, 23 Oct 2018 21:04:41 +0900
Message-ID: <20181023120441.GB10251@jagdpanzerIV>
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
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (10/23/18 20:54), Sergey Senozhatsky wrote:
> So I did look at what lib/bust_spinlocks.c does; and I agree that waking
> up klogd makes little sense, on the other hand it just sets per-cpu
> pending bit, so not a big deal. console_unlock() should do there the
> same thing as console_flush_on_panic(). Yes. However, a bit of a bigger
> argument:
>    __attribute__((weak)) suggests that bust_spinlocks() is arch-dependent
>    and it's up to arch to do some extra stuff there [if needed]. So that's
>    why I decided to keep bust_spinlocks(0) in panic() and, thus, call into
>    arch-specific code (or common bust_spinlocks); then bump oops_in_progress
>    so serial consoles become re-entrant and finally call
>    console_flush_on_panic().

Seems that s390 is the only arch which defines its own bust_spinlocks().
Not sure why... Just to play games with console_loglevel?

---

void bust_spinlocks(int yes)
{
	if (yes) {
		oops_in_progress = 1;
	} else {
		int loglevel_save = console_loglevel;
		console_unblank();
		oops_in_progress = 0;
		/*
		 * OK, the message is on the console.  Now we call printk()
		 * without oops_in_progress set so that printk will give klogd
		 * a poke.  Hold onto your hats...
		 */
		console_loglevel = 15;
		printk(" ");
		console_loglevel = loglevel_save;
	}
}

---

The "printk(" "); without oops_in_progress" part is a bit worrisome.
This thing technically can deadlock. Unless s390 has no NMI panic().

	-ss
