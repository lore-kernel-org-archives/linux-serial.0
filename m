From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Date: Wed, 6 Mar 2019 16:57:01 +0100
Message-ID: <20190306155701.wc22i2no5swdcids@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
 <20190304073856.GA552@jagdpanzerIV>
 <20190304100044.GC21004@jagdpanzerIV>
 <20190304110703.GA960@tigerII.localdomain>
 <87o96p9gtx.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87o96p9gtx.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue 2019-03-05 22:00:58, John Ogness wrote:
> Hi Sergey,
> 
> Thanks for your feedback.
> 
> I am responding to this comment ahead of your previous comments because
> it really cuts at the heart of the proposed design. After addressing
> this point it will make it easier for me to respond to your other
> comments.
> 
> NOTE: This is a lengthy response.
> 
> On 2019-03-04, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> >> But in general, channels which depend on preemptible printk will
> >> become totally useless in some cases.
> >
> > Which brings me to a question - what are those messages/channels? Not
> > important enough to be printed on consoles immediately, yet important
> > enough to pass the suppress_message_printing() check.
> 
> I would like to clarify that message supression (i.e. console loglevel)
> is a method of reducing what is printed. It does nothing to address the
> issues related to console printing. My proposal focusses on addressing
> the issues related to console printing.
> 
> Console printing is a convenient feature to allow a kernel to
> communicate information to a user without any reliance on
> userspace. IMHO there are 2 categories of messages that the kernel will
> communicate. The first is informational (usb events, wireless and
> ethernet connectivity, filesystem events, etc.). Since this category of
> messages occurs during normal runtime, we should expect that it does not
> cause adverse effects to the rest of the system (such as latencies and
> non-deterministic behavior).
>
> The second category is for emergency situations, where the kernel needs
> to report something unusual (panic, BUG, WARN, etc.). In some of these
> situations, it may be the last thing the kernel ever does. We should
> expect this category to focus on getting the message out as reliably as
> possible. Even if it means disturbing the system with large latencies.
> 
> _Both_ categories are important for the user, but their requirements are
> different:
> 
>    informational: non-disturbing
>    emergency:     reliable

Isn't this already handled by the console_level?

The informational messages can be reliably read via syslog, /dev/kmsg.
They are related to the normal works when the system works well.

The emergency messages (errors, warnings) are printed in emergency
situations. They are printed as reliably as possible to the console
because the userspace might not be reliable enough.


That said, the "atomic" consoles brings new possibilities
and might be very useful in some scenarios. Also a more grained
prioritization might be helpful.

But each solution might just bring new problems. For example,
the atomic consoles are still serialized between CPUs. It might
slow down the entire system and not only on task. If it gets
blocked for some reasons (nobody is perfect) it would block
all the other serialized CPUs as well.

In each case, we really need to be careful about the complexity.
printk() is already complex enough. It might be acceptable if
it makes the design cleaner and less tangled. printk() would
deserve a redesign.

Best Regards,
Petr
