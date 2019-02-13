From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v1 17/25] printk: add processor number to output
Date: Wed, 13 Feb 2019 23:29:29 +0100
Message-ID: <87r2cbqq46.fsf@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-18-john.ogness@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 2019-02-12, John Ogness <john.ogness@linutronix.de> wrote:
> It can be difficult to sort printk out if multiple processors are
> printing simultaneously. Add the processor number to the printk
> output to allow the messages to be sorted.

I just discovered Tetsuo's recently accepted work[0]. So obviously it
obsoletes this patch.

John Ogness

[0] http://lkml.kernel.org/r/1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
