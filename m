From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Wed, 13 Feb 2019 23:20:08 +0100
Message-ID: <87lg2js547.fsf@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <6f965383270d45d6ac26529fec5ad470@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6f965383270d45d6ac26529fec5ad470@AcuMS.aculab.com> (David
        Laight's message of "Wed, 13 Feb 2019 16:54:15 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 2019-02-13, David Laight <David.Laight@ACULAB.COM> wrote:
> ...
>> - A dedicated kernel thread is created for printing to all consoles in
>>   a fully preemptible context.
>> 
>> - A new (optional) console operation "write_atomic" is introduced that
>>   console drivers may implement. This function must be NMI-safe. An
>>   implementation for the 8250 UART driver is provided.
>> 
>> - The concept of "emergency messages" is introduced that allows
>>   important messages (based on a new emergency loglevel threshold) to
>>   be immediately written to any consoles supporting write_atomic,
>>   regardless of the context.
> ...
>
> Does this address my usual 'gripe' that the output is written to the
> console by syslogd and not by the kernel itself?

If I understand it correctly, your usual 'gripe' is aimed at
distributions that are turning off the kernel writing directly to the
console. I don't see how that is a kernel issue.

> When you are trying to find out where the system is completely
> deadlocking you need the 'old fashioned' completely synchronous kernel
> printf().

Emergency messages will give you that. They differ from the current
implementation by changing printk to have the caller print only _their_
message directly without concern for past unseen non-emergency messages
or which context they are in.

John Ogness
