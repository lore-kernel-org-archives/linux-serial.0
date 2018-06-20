From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Date: Wed, 20 Jun 2018 13:28:47 +0900
Message-ID: <20180620042847.GH650@jagdpanzerIV>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop>
 <20180619005308.GA405@jagdpanzerIV>
 <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
 <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
 <20180620025050.GE650@jagdpanzerIV>
 <CA+55aFzC5=awDhzOy9u_2FNaQmRprUTxj_KV2xO+GnpNAFg8MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFzC5=awDhzOy9u_2FNaQmRprUTxj_KV2xO+GnpNAFg8MQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, SergeySenozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (06/20/18 12:38), Linus Torvalds wrote:
> On Wed, Jun 20, 2018 at 11:50 AM Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> >
> > It's not UART on its own that immediately calls into printk(), that would
> > be trivial to fix, it's all those subsystems that serial console driver
> > can call into.
> 
> We already have the whole PRINTK_SAFE_CONTEXT_MASK model that only
> adds it to a secondary buffer if you get recursion.  Why isn't that
> triggering? That's the whole point of it.

This is exactly what I'm doing in my patch set.
PRINTK_SAFE_CONTEXT_MASK so far worked *one* way only: when we start
from printk.c

IOW:

      printk -> printk_safe_mask -> vsprinf -> printk

But we also can have printk-related deadlocks the *other* way
around. For instance:

      uart -> printk -> uart

printk_safe_mask is not triggering there because we don't use
printk_safe in uart / tty yet. And this is what I do in my
patch set - extend printk_safe usage.

The patch set does not add any _new_ locks or locking rules.
It just replaces the existing

		spin_lock(a)
with
		prinkt_safe_enter();
		spin_lock(a)

and
		spin_unlock(a)
with
		spin_unlock(a)
		printk_safe_exit();

and that's it.

So now we use printk_safe mechanism to avoid another bunch of
deadlock scenarious: which don't start from printk, but from
parts of the kernel which printk eventually calls.

	-ss
