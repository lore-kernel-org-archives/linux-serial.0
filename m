From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RFC PATCH v1 00/25] printk: new implementation
Date: Wed, 13 Feb 2019 16:54:15 +0000
Message-ID: <6f965383270d45d6ac26529fec5ad470@AcuMS.aculab.com>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'John Ogness' <john.ogness@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

From: John Ogness
> Sent: 12 February 2019 14:30
...
> - A dedicated kernel thread is created for printing to all consoles in
>   a fully preemptible context.
> 
> - A new (optional) console operation "write_atomic" is introduced that
>   console drivers may implement. This function must be NMI-safe. An
>   implementation for the 8250 UART driver is provided.
> 
> - The concept of "emergency messages" is introduced that allows
>   important messages (based on a new emergency loglevel threshold) to
>   be immediately written to any consoles supporting write_atomic,
>   regardless of the context.
...

Does this address my usual 'gripe' that the output is written to the console
by syslogd and not by the kernel itself?
When you are trying to find out where the system is completely deadlocking
you need the 'old fashioned' completely synchronous kernel printf().

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
