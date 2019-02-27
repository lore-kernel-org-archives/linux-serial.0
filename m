From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v1 15/25] printk: print history for new consoles
Date: Wed, 27 Feb 2019 11:02:53 +0100
Message-ID: <874l8pft0y.fsf@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-16-john.ogness@linutronix.de>
        <20190226145837.wl54fr7rn2ii5oxc@pathway.suse.cz>
        <87o96yziau.fsf@linutronix.de>
        <20190227090249.fzigc7r237emlg6k@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190227090249.fzigc7r237emlg6k@pathway.suse.cz> (Petr Mladek's
        message of "Wed, 27 Feb 2019 10:02:49 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 2019-02-27, Petr Mladek <pmladek@suse.com> wrote:
> I mean that your patch does the reply on a very hidden location.

Right. I understand that and I agree.

> Regarding the per-console kthread. It would make sense if
> we stop handling all consoles synchronously. For example,
> when we push messages to fast consoles immediately and
> offload the work for slow consoles.

My per-console kthread suggestion relating to fast consoles is so that
some consoles (such as netconsole, which is quite fast) could drop less
messages than a slow console (such as uart).

> Anyway, we first need to make the offload reliable enough.
> It is not acceptable to always offload all messages.
> We have been there last few years. We must keep a high
> chance to see the messages. Any warning might be important
> when it causes the system to die. Nobody knows what message
> is such an important.

You seem to be missing the point of the series. It _is_ acceptable to
offload all messages because they are being offloaded to non-emergency
consoles. If messages are lost, it sucks (and the appropriate "dropped"
messages are sent), but it isn't critical. Once we can agree to this
point, printk becomes so much easier to work with.

Emergency consoles exist for handling important messages. They will not
drop messages. They are synchronous and immediate.

>> It is not necessary. It is desired. Why should _any_ task be punished
>> with console writing? That is what the printk kthread is for.
>
> I do not know about any acceptable solution without punishing
> the tasks. But we might find a better compromise between the
> punishment and reliability.

I do not want printk to compromise. That compromise is part of the
problem. Let's partition printk to important and non-important so that
we can optimize both. _That_ is the heart of this series.

John Ogness
