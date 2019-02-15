From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v1 04/25] printk-rb: add writer interface
Date: Fri, 15 Feb 2019 02:19:50 +0100
Message-ID: <87a7ixq24p.fsf@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-5-john.ogness@linutronix.de>
        <20190214151650.5y337yy2jnnztsc6@pathway.suse.cz>
        <87ef8aosby.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87ef8aosby.fsf@linutronix.de> (John Ogness's message of "Fri, 15
        Feb 2019 00:36:49 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 2019-02-15, John Ogness <john.ogness@linutronix.de> wrote:
> prb_commit() does not actually care what is in the handle. It is going
> to commit everything up to the reserve.

After thinking about what I wrote here, I realized that the struct
prb_handle has no purpose in this ringbuffer implementation. We really
could simplify the writer interface to:

    char *prb_reserve(struct printk_ringbuffer *rb, unsigned int size);

    void prb_commit(struct printk_ringbuffer *rb);

That probably feels really strange because the writer doesn't specify
_what_ to commit. But this ringbuffer implementation doesn't need to
know that.

The only reason I can think of for having a handle is if there should be
any statistics, debugging, or sanity checking added. (For example if a
writer tried to commit something it did not reserve.)

John Ogness
