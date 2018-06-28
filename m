From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Date: Thu, 28 Jun 2018 11:55:12 +0900
Message-ID: <20180628025512.GF481@jagdpanzerIV>
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
To: Linus Torvalds <torvalds@linux-foundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, SergeySenozhatsky <sergey.senozhatsky@gmail.com>
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

Linus, Alan, Steven,
are you on board with the patch set?
What shall I do to improve it?

PRINTK_SAFE_CONTEXT_MASK is what we answer nowadays when someone says
"printk causes deadlocks". We really can't remove all printk-s that can
cause uart->...->printk->uart recursion, and the only other option is to
use spin_trylock on uart_port->lock in every driver and discard con->write()
if we see that we have re-entered uart. I'd rather use per-CPU printk_safe
buffer in this case.

	-ss
