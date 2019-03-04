From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Mon, 4 Mar 2019 14:23:35 +0900
Message-ID: <20190304052335.GA6648@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213025520.GA5803@jagdpanzerIV>
 <874l9721hf.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874l9721hf.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (02/13/19 15:43), John Ogness wrote:
> On 2019-02-13, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> >> - A dedicated kernel thread is created for printing to all consoles in
> >>   a fully preemptible context.
> >
> > How do you handle sysrq-<foo> printouts on systems which can't
> > schedule printk-kthread?
> 
> If those sysrq printouts are at the emergency loglevel (which most are),
> then they are printed immediately to the emergency consoles. This has
> already proved useful for our own kernel debugging work. For example,
> currently sysrq-z for very large traces result in messages being dropped
> because of printk buffer overflows. But with the emergency console we
> always see the full trace buffer.

Are we sure that all systems will always have ->atomic console(-s)
enabled? Is it possible to convert all console drivers to ->atomic?
fbcon, for instance (with scrolling and font scaling, etc)? If there
are setups which can be fully !atomic (in terms of console output)
then we, essentially, have a fully preemptible kthread printk
implementation.

> Because you have already done so much work and experimentation with
> printk-kthreads, I feel like many of your comments are related to your
> kthread work in this area. Really the big design change I make with my
> printk-kthread is that it is only for non-critical messages. For
> anything critical, users should rely on an emergency console.

Fair point. Well maybe my printk-kthread comments are not utterly
unreasonable, but who knows :)

	-ss
