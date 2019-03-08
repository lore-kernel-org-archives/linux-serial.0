From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v1 20/25] serial: 8250: implement write_atomic
Date: Fri, 08 Mar 2019 05:05:12 +0100
Message-ID: <87a7i6ovt3.fsf@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-21-john.ogness@linutronix.de>
        <20190227094655.ecdwhsc2bf5spkqx@pathway.suse.cz>
        <87zhqhed3u.fsf@linutronix.de>
        <20190227135504.gqtcsdwpy4rd7xvs@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190227135504.gqtcsdwpy4rd7xvs@pathway.suse.cz> (Petr Mladek's
        message of "Wed, 27 Feb 2019 14:55:04 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 2019-02-27, Petr Mladek <pmladek@suse.com> wrote:
>>>> Implement a non-sleeping NMI-safe write_atomic console function in
>>>> order to support emergency printk messages.
>>>
>>> OK, it would be safe when prb_lock() is the only lock taken
>>> in the NMI handler.
>> 
>> Which is the case. As I wrote to you already [0], NMI contexts are
>> _never_ allowed to do things that rely on waiting forever for other
>> CPUs.
>
> Who says _never_? I agree that it is not reasonable. But the
> history shows that it happens.

Right, which is why it would need to become policy.

The emergency messages (aka write_atomic) introduce a new requirement to
the kernel because this callback must be callable from any context. The
console drivers must have some way of synchronizing. The CPU-reentrant
spin lock is the only solution I am aware of.

> In principle, there is nothing wrong in using spinlock in NMI
> when it is used only in NMI.

The CPU-reentrant spin lock _will_ be used in NMI context and
potentially could be used from any line of NMI code (if, for example, a
panic is triggered). The problem is when you have 2 different spin locks
in NMI context and their ordering cannot be guaranteed. And since I am
introducing an implicit spin lock that potentially could be locked from
any line of code, any explicit use of a spin lock in NMI could would
really be adding a 2nd spin lock and thus deadlock potential.

If the ringbuffer was fully lockless, we should be able to have
per-console CPU-reentrant spin locks as long as the ordering is
preserved, which I expect shouldn't be a problem. If any NMI context
needed a spin lock for its own purposes, it would need to use the
CPU-reentrant spin lock of the first console so as to preserve the
ordering in case of a panic.

>>>    2. I am afraid that we need to add some locking between CPUs
>>>       to avoid mixing characters from directly printed messages.
>> 
>> That is exactly what console_atomic_lock() (actually prb_lock) is!
>
> Sure. But it should not be a common lock for the ring buffer and
> all consoles.

As long as the ring buffer requires a CPU-reentrant spin lock, I expect
that it _must_ be a common lock for all. Consider the situation that the
ring buffer writer code causes a panic. I think it is beneficial if at
least 1 level of printk recursion is supported so that even these
backtraces make it out on the emergency consoles.

If the ring buffer becomes fully lockless, then we could move to
per-console CPU-reentrant spin locks.

John Ogness
