From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v1 20/25] serial: 8250: implement write_atomic
Date: Fri, 08 Mar 2019 05:17:36 +0100
Message-ID: <8736nyov8f.fsf@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-21-john.ogness@linutronix.de>
        <20190227094655.ecdwhsc2bf5spkqx@pathway.suse.cz>
        <87zhqhed3u.fsf@linutronix.de>
        <20190227135504.gqtcsdwpy4rd7xvs@pathway.suse.cz>
        <87a7i6ovt3.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87a7i6ovt3.fsf@linutronix.de> (John Ogness's message of "Fri, 08
        Mar 2019 05:05:12 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 2019-03-08, John Ogness <john.ogness@linutronix.de> wrote:
> If the ringbuffer was fully lockless, we should be able to have
> per-console CPU-reentrant spin locks as long as the ordering is
> preserved, which I expect shouldn't be a problem. If any NMI context
> needed a spin lock for its own purposes, it would need to use the
> CPU-reentrant spin lock of the first console so as to preserve the
> ordering in case of a panic.

This point is garbage. Sorry. I do not see how we could safely have
multiple CPU-reentrant spin locks. Example of a deadlock:

CPU0                  CPU1
printk                printk
  console2.lock         console1.lock
NMI                   NMI
  printk                printk
    console1.lock         console2.lock

>> ... it should not be a common lock for the ring buffer and all
>> consoles.
>
> If the ring buffer becomes fully lockless, then we could move to
> per-console CPU-reentrant spin locks.

A fully lockless ring buffer will reduce the scope of the one, global
CPU-reentrant spin lock. But I do not see how we can safely have
multiple of these. If it is part of printk, it is already implicitly on
every line of code.

John Ogness
