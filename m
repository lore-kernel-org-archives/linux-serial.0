From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port locks
Date: Wed, 20 Jun 2018 11:01:49 +0900
Message-ID: <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop> <20180619005308.GA405@jagdpanzerIV> <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, SergeySenozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 19, 2018 at 5:30 PM Petr Mladek <pmladek@suse.com> wrote:
>
> To make it clear. This patch set adds yet another spin_lock API.
> It behaves exactly as spin_lock_irqsafe()/spin_unlock_irqrestore()
> but in addition it sets printk_context.
>
> This patchset forces safe context around TTY and UART locks.
> In fact, the deferred context would be enough to prevent
> all the mentioned deadlocks.

Please stop this garbage.

The rule is simple: DO NOT DO THAT THEN.

Don't make recursive locks. Don't make random complexity.  Just stop
doing the thing that hurts.

There is no valid reason why an UART driver should do a printk() of
any sort inside the critical region where the console is locked.

Just remove those printk's, don't add new crazy locking.

If you had a spinlock that deadlocked because it was inside an already
spinlocked region, you'd say "that's buggy".

This is the exact same issue. We don't work around buggy garbage. We
fix the bug - by removing the problematic printk.

           Linus
