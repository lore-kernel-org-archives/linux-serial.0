From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Thu, 07 Mar 2019 10:53:48 +0100
Message-ID: <87lg1rggcz.fsf@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190213025520.GA5803@jagdpanzerIV> <874l9721hf.fsf@linutronix.de>
        <20190304052335.GA6648@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190304052335.GA6648@jagdpanzerIV> (Sergey Senozhatsky's
        message of "Mon, 4 Mar 2019 14:23:35 +0900")
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 2019-03-04, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>>>> - A dedicated kernel thread is created for printing to all consoles
>>>>   in a fully preemptible context.
>>>
>>> How do you handle sysrq-<foo> printouts on systems which can't
>>> schedule printk-kthread?
>> 
>> If those sysrq printouts are at the emergency loglevel (which most
>> are), then they are printed immediately to the emergency
>> consoles. This has already proved useful for our own kernel debugging
>> work. For example, currently sysrq-z for very large traces result in
>> messages being dropped because of printk buffer overflows. But with
>> the emergency console we always see the full trace buffer.
>
> Are we sure that all systems will always have ->atomic console(-s)
> enabled? Is it possible to convert all console drivers to ->atomic?
> fbcon, for instance (with scrolling and font scaling, etc)?

No, I am not sure if we can convert all console drivers to atomic
consoles. But I think if we don't have to fear disturbing the system,
the possibilities for such an implementation are greater.

> If there are setups which can be fully !atomic (in terms of console
> output) then we, essentially, have a fully preemptible kthread printk
> implementation.

Correct. I've mentioned in another response[0] some ideas about what
could be done to aid this.

I understand that fully preemptible kthread printing is unacceptable for
you. Since all current console drivers are already irq safe, I'm
wondering if using irq_work to handle the emergency printing for console
drivers without write_atomic() would help. (If the printk caller is in a
context that write() supports, then write() could be called directly.)
This would also demand that the irq-safe requirements for write() are
not relaxed. The printk-kthread might still be faster than irq_work, but
it might increase reliability if an irq_work is triggered as an extra
precaution.

John Ogness

[0] https://lkml.kernel.org/r/87o96p9gtx.fsf@linutronix.de
