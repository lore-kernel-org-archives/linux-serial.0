From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v1 20/25] serial: 8250: implement write_atomic
Date: Wed, 27 Feb 2019 11:32:05 +0100
Message-ID: <87zhqhed3u.fsf@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-21-john.ogness@linutronix.de>
        <20190227094655.ecdwhsc2bf5spkqx@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190227094655.ecdwhsc2bf5spkqx@pathway.suse.cz> (Petr Mladek's
        message of "Wed, 27 Feb 2019 10:46:55 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 2019-02-27, Petr Mladek <pmladek@suse.com> wrote:
>> Implement a non-sleeping NMI-safe write_atomic console function in
>> order to support emergency printk messages.
>
> It uses console_atomic_lock() added in 18th patch. That one uses
> prb_lock() added by 2nd patch.
>
> Now, prb_lock() allows recursion on the same CPU. But it still needs
> to wait until it is released on another CPU.
>
> [...]
>
> OK, it would be safe when prb_lock() is the only lock taken
> in the NMI handler.

Which is the case. As I wrote to you already [0], NMI contexts are
_never_ allowed to do things that rely on waiting forever for other
CPUs. I could not find any instances where that is the
case. nmi_cpu_backtrace() used to do this, but it does not anymore.

> But printk() should not make such limitation
> to the rest of the system.

That is something we have to decide. It is the one factor that makes
prb_lock() feel a hell of a lot like BKL.

> Not to say, that we would most
> likely need to add a lock back into nmi_cpu_backtrace()
> to keep the output sane.

No. That is why CPU-IDs were added to the output. It is quite sane and
easy to read.

> Peter Zijlstra several times talked about fully lockless
> consoles. He is using the early console for debugging, see
> the patchset
> https://lkml.kernel.org/r/20170928121823.430053219@infradead.org

That is an interesting thread to quote. In that thread Peter actually
wrote the exact implementation of prb_lock() as the method to
synchronize access to the serial console.

> I am not sure if it is always possible. I personally see
> the following way:
>
>    1. Make the printk ring buffer fully lockless. Then we reduce
>       the problem only to console locking. And we could
>       have a per-console-driver lock (no the big lock like
>       prb_lock()).

A fully lockless ring buffer is an option. But as you said, it only
reduces the window, which is why I decided it is not so important (at
least for now). Creating a per-console-driver lock would probably be a
good idea anyway as long as we can guarantee the ordering (which
shouldn't be a problem as long as emergency console ordering remains
fixed and emergency writers always follow that ordering).

>    2. I am afraid that we need to add some locking between CPUs
>       to avoid mixing characters from directly printed messages.

That is exactly what console_atomic_lock() (actually prb_lock) is!

John Ogness

[0] https://lkml.kernel.org/r/87pnrvs707.fsf@linutronix.de
