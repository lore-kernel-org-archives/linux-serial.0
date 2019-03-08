From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Fri, 8 Mar 2019 11:00:16 +0100
Message-ID: <20190308100016.d2v6avtotjo3eyxo@pathway.suse.cz>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu 2019-03-07 10:53:48, John Ogness wrote:
> On 2019-03-04, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> > If there are setups which can be fully !atomic (in terms of console
> > output) then we, essentially, have a fully preemptible kthread printk
> > implementation.
> 
> Correct. I've mentioned in another response[0] some ideas about what
> could be done to aid this.
> 
> I understand that fully preemptible kthread printing is unacceptable for
> you. Since all current console drivers are already irq safe, I'm
> wondering if using irq_work to handle the emergency printing for console
> drivers without write_atomic() would help. (If the printk caller is in a
> context that write() supports, then write() could be called directly.)
> This would also demand that the irq-safe requirements for write() are
> not relaxed. The printk-kthread might still be faster than irq_work, but
> it might increase reliability if an irq_work is triggered as an extra
> precaution.

It is getting more and more complicated. The messages would be pushed
directly, from irq, and kthread. It would depend how the code would
look like but I am not much optimistic.

Note that you could not pass any data to the irq_work handler.
It would need to iterate over the logbuffer and take care of
all non-handled emergency messages.

Anyway, we could solve this later. We need to keep the current
console_unlock() handling as a fallback until enough consoles
support the direct mode anyway.

Best Regards,
Petr
