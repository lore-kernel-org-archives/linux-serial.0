From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 15/25] printk: print history for new consoles
Date: Wed, 27 Feb 2019 14:12:53 +0100
Message-ID: <20190227131253.kdfmz4gmrufusihu@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-16-john.ogness@linutronix.de>
 <20190226145837.wl54fr7rn2ii5oxc@pathway.suse.cz>
 <87o96yziau.fsf@linutronix.de>
 <20190227090249.fzigc7r237emlg6k@pathway.suse.cz>
 <874l8pft0y.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874l8pft0y.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed 2019-02-27 11:02:53, John Ogness wrote:
> On 2019-02-27, Petr Mladek <pmladek@suse.com> wrote:
> > I mean that your patch does the reply on a very hidden location.
> 
> Right. I understand that and I agree.
> 
> > Regarding the per-console kthread. It would make sense if
> > we stop handling all consoles synchronously. For example,
> > when we push messages to fast consoles immediately and
> > offload the work for slow consoles.
> 
> My per-console kthread suggestion relating to fast consoles is so that
> some consoles (such as netconsole, which is quite fast) could drop less
> messages than a slow console (such as uart).

OK, it was not clear from the context.


> > Anyway, we first need to make the offload reliable enough.
> > It is not acceptable to always offload all messages.
> > We have been there last few years. We must keep a high
> > chance to see the messages. Any warning might be important
> > when it causes the system to die. Nobody knows what message
> > is such an important.
> 
> You seem to be missing the point of the series. It _is_ acceptable to
> offload all messages because they are being offloaded to non-emergency
> consoles. If messages are lost, it sucks (and the appropriate "dropped"
> messages are sent), but it isn't critical. Once we can agree to this
> point, printk becomes so much easier to work with.
> 
> Emergency consoles exist for handling important messages. They will not
> drop messages. They are synchronous and immediate.

We might start thinking about this only when the most common consoles
support the emergency mode. This patchset implemented it only
for serial consoles that are often very slow. It is contradicting
the above statement about fast consoles.

Also the emergency messages from different CPUs are synchronized.
This slows down all affected CPUs. They are serialized and blocked
by the speed of the consoles. It was the reason to handle all pending
messages only by the current owner. I am sure that it would cause
regressions.

Not to say that the synchronization is done using an unfair lock.
One CPU can simply get starved by others for non-predictable time.
This is why ticket spinlocks were invented.

You might argue that the amount of emergency messages should
be small but see below.


> >> It is not necessary. It is desired. Why should _any_ task be punished
> >> with console writing? That is what the printk kthread is for.
> >
> > I do not know about any acceptable solution without punishing
> > the tasks. But we might find a better compromise between the
> > punishment and reliability.
> 
> I do not want printk to compromise. That compromise is part of the
> problem. Let's partition printk to important and non-important so that
> we can optimize both. _That_ is the heart of this series.

No, this is just another compromise. Let's look at it from another
side.

The important and non-important messages already existed. The split
was done by console_loglevel. The emergency level just adds one
more category (show, show later, ignore). It allows more fine
grained setting but it does not remove the compromise.

People would still need to choose which messages should be seen
reliably and which might get lost. And the problem will be still
the same. The more messages will be printed reliably the more
delayed might get printk() callers. It might prevent softlockups
but only at the cost that all parallel writers are blocked by
waiting for the console.

Also note that printk configuration already is too complicated.
See the four numbers in /proc/sys/kernel/printk. Many people
would have troubles to set them reasonably even with description.
Fifth number would only make it worse.


And it is even more complicated because people are inconsistent
with using the log levels, see
https://lkml.kernel.org/r/20180619115726.3098-1-hdegoede@redhat.com
It is a lost fight. People always need to see messages from
the code that they work on. If we make it harder to see
some levels, people will just start using levels that are
not filtered.


This is why I suggest to split the work on the ring buffer
and consoles. The new ring buffer might be a clear win.
While the console handling is really complicated. But
I still think that we might and should do better even
in the consoles.

Best Regards,
Petr
