From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Mon, 11 Mar 2019 19:54:11 +0900
Message-ID: <20190311105411.GA368@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213025520.GA5803@jagdpanzerIV>
 <874l9721hf.fsf@linutronix.de>
 <20190304052335.GA6648@jagdpanzerIV>
 <87lg1rggcz.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87lg1rggcz.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (03/07/19 10:53), John Ogness wrote:
[..]
> 
> No, I am not sure if we can convert all console drivers to atomic
> consoles. But I think if we don't have to fear disturbing the system,
> the possibilities for such an implementation are greater.

> > If there are setups which can be fully !atomic (in terms of console
> > output) then we, essentially, have a fully preemptible kthread printk
> > implementation.
> 
> Correct. I've mentioned in another response[0] some ideas about what
> could be done to aid this.
> 
> I understand that fully preemptible kthread printing is unacceptable for
> you.

Well, it's not like it's unacceptable for me. It's just we've been
there, we had preemptible printk(); and people were not happy with
it. Just to demonstrate that I'm not making this up:

> > From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>:
> > [..]
> >
> > Using a reproducer [..] you will find that calling cond_resched()
> > (from console_unlock() from printk()) can cause a delay of nearly
> > one minute, and it can cause a delay of nearly 5 minutes to complete
> > one out_of_memory() call.

preemptible printk() and printk() do opposite things.

I can't really say that I care for fbcon; but fully preemptible
netcon is going to hurt.

> Since all current console drivers are already irq safe, I'm
> wondering if using irq_work to handle the emergency printing for console
> drivers without write_atomic() would help. (If the printk caller is in a
> context that write() supports, then write() could be called directly.)
> This would also demand that the irq-safe requirements for write() are
> not relaxed. The printk-kthread might still be faster than irq_work, but
> it might increase reliability if an irq_work is triggered as an extra
> precaution.

Hmm. OK. So one of the things with printk is that it's fully sequential.
We call console drivers one by one. Slow consoles can affect what appears
on the fast consoles; fast console have no impact on slow ones.

	call_console_drivers()
		for_each_console(c)
			c->write(c, text, text_len);

So a list of (slow_serial serial netcon) console drivers is a camel train;
fast netcon is not fast anymore, and slow consoles sometimes are the reason
we have dropped messages. And if we drop messages we drop them for all
consoles, including fast netcon. Turning that sequential pipline into a
bunch of per-console kthreads/irq and letting fast consoles to be fast is
not a completely bad thing. Let's think more about this, I'd like to read
more opinions.

	-ss
