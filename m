From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Date: Thu, 7 Mar 2019 14:15:30 +0900
Message-ID: <20190307051530.GC4893@jagdpanzerIV>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi John,

On (03/05/19 22:00), John Ogness wrote:
> Hi Sergey,
> 
[..]
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

That's one way of looking at this. And it's reasonable.

Another way could be:
 - anything that passes the loglevel check (suppress_message_printing())
   is considered to be important

 - anything else is just "noise" which should be suppressed. This
   is what loglevel and suppress_message_printing() are for - to tell
   the kernel what we want and what we don't want to be on the consoles.

> But what if can't be implemented? vt console, for example? Yes, the vt
> console would be tricky. It doesn't even support the current
> bust_spinlocks/oops_in_progress. But since the emergency category has a
> clear requirement (reliability)

"Reliability" - yes; the existence of emergency messages - no.

  "to report something unusual (panic, BUG, WARN, etc.). In some of
   these situations, it may be the last thing the kernel ever does."

But so may be the "informational" message. For example, not all ARCHs
sport NMI to detect and warn about a lockup/deadlock somewhere in usb
or wifi. The "informational" can be the last thing the kernel has to
say.

> The current printk implementation will do a better job of getting the
> informational messages out, but at an enormous cost to all the tasks
> on the system (including the realtime tasks). I am proposing a printk
> implementation where the tasks are not affected by console printing
> floods.

In new printk design the tasks are still affected by printing floods.
Tasks have to line up and (busy) wait for each other, regardless of
contexts.

One of the late patch sets which I had (I never ever published it) was
a different kind of printk-kthread offloading. The idea was that whatever
should be printed (suppress_message_printing()) should be printed. We
obviously can't loop in console_unlock() for ever and there is only one
way to figure out if we can print out more messages, that's why printk
became RCU stall detector and watchdog aware; and printk would break
out and wake up printk_kthread if it sees that watchdog is about to get
angry on that particular CPU. printk_kthread would run with preemption
disabled and do the same thing: if it spent watchdog_threshold / 2
printing - breakout, enable local IRQ, cond_resched(). IOW watchdogs
determine how much time we can spend on printing.

[..]
> I want messages of the information category to cause no disturbance to
> the system. Give the kernel the freedom to communicate to users without
> destroying its own performance. This can only be achieved if the
> messages are printed from a _fully_ preemptible context.
[..]
> And I want messages of the emergency category to be as reliable as
> possible, regardless of the costs to the system. Give the kernel a
> clear mechanism to _reliably_ communicate critical information.
> Such messages should never appear on a correctly functioning system.

I don't really understand the role of loglevel anymore.

When I do ./a.out --loglevel=X  I have a clear understanding that
all messages which fall into [critical, X] range will be in the logs,
because I told that application that those messages are important to
me right now. And it used to be the same with the kernel loglevel.
But now the kernel will do its own thing:

  - what the kernel considers important will go into the logs
  - what the kernel doesn't consider important _maybe_ will end up
    in the logs (preemptible printk kthread). And this is where
    loglevel now. After the _maybe_ part.

If I'm not mistaken, Tetsuo reported that on a box under heavy OOM
pressure he saw preemptible printk dragging 5 minutes behind the
logbuf head. Preemptible printk is good for nothing. It's beyond
useless, it's something else.

	-ss
