From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCHv2 1/4] panic: avoid deadlocks in re-entrant console
 drivers
Date: Thu, 25 Oct 2018 18:05:39 +0900
Message-ID: <20181025090539.GD20702@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181023110751.un2u67bc7dpo4ska@pathway.suse.cz>
 <20181023115433.GA10251@jagdpanzerIV>
 <20181025082947.gznv5roj3zxzlw3t@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181025082947.gznv5roj3zxzlw3t@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (10/25/18 10:29), Petr Mladek wrote:
> 
> Yes, klogd is not a big deal. I just think that the bust_spinlocks()
> ping-pong would just confuse the code.

I agree; that's why I put some comments there.

> It might be better to keep the spinlocks busted and make sure that we do
> not cause regressions by not calling bust_spinlocks(0).

Sure, I understand. One reason to keep bust_spinlocks(0) there was "invoke
arch-specific bust_spinlocks(0), which might do something that common
bust_spinlocks() wouldn't do". Without going into details if any arch actually
does anything "special" in bust_spinlocks(0). Another reason was - this patch
looks like a -stable material to me; especially given that we have panic()
deadlock reports now. So I wanted to have a one liner which will not change
things for arch-s that re-define bust_spinlocks() and, at the same time,
fix the deadlock. Other than that I'm all for keeping spinlocks busted all
the time and just doing:

---
#ifdef CONFIG_VT
		unblank_screen();
#endif
		console_unblank();
---

in panic().

BTW, speaking of s390 bust_spinlocks(). It seems that starting from 4.21
all arch-s will use common bust_spinlocks() [1].

[..]
> > Hmm, I don't think I've seen any reports because of this. From printk/console
> > POV the locks which are not taken under oops_in_progress are not released.
> 
> Fair enough. Let's keep debug_locks_off() in panic().

Agreed.

[1] lkml.kernel.org/r/20181025081108.GB26561@osiris

	-ss
