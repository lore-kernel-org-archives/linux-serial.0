From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Date: Sat, 23 Jun 2018 14:21:49 +0900
Message-ID: <20180623052149.GA402@tigerII.localdomain>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop>
 <20180619005308.GA405@jagdpanzerIV>
 <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
 <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
 <20180619223447.4369748b@vmware.local.home>
 <CA+55aFwpcbNO6FS4=O-BrsC4vMBaT3JeFG-_D9WtgmW+Dof3iA@mail.gmail.com>
 <20180622172100.2293b5e5@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180622172100.2293b5e5@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, SergeySenozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (06/22/18 17:21), Alan Cox wrote:
> On Wed, 20 Jun 2018 11:44:13 +0900
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Wed, Jun 20, 2018 at 11:34 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > Perhaps we should do an audit of the console drivers and remove all
> > > printk, pr_* , WARN*, BUG* from them.  
> > 
> > Only the actual _printing_ parts.
> 
> No because they are normally rather useful because that port isn't the
> console. If you trylock

trylock is boring, me wants printk_safe_mask everywhere :)

> Really that's all that you need - log the message to whichever console
> targets you can currently safely do so. If it's none well there was
> always the proposed morse code keyboard light driver 8)

Hm, just discard messages? With printk_safe_mask we keep everything
in a lockless per-CPU buffer, which we flush [per-CPU buffer -> printk logbuf]
from irq_work, so we can print it later.

	-ss
