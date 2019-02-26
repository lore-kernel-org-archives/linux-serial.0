From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 13/25] printk: track seq per console
Date: Tue, 26 Feb 2019 14:11:08 +0100
Message-ID: <20190226131108.rr5komehfqitg6di@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-14-john.ogness@linutronix.de>
 <20190225145954.62zl3tndmo2t372h@pathway.suse.cz>
 <87lg230whd.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87lg230whd.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue 2019-02-26 09:45:02, John Ogness wrote:
> On 2019-02-25, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index ece54c24ea0d..ebd9aac06323 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -1504,6 +1514,19 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
> >>  		if (!cpu_online(raw_smp_processor_id()) &&
> >>  		    !(con->flags & CON_ANYTIME))
> >>  			continue;
> >> +		if (con->printk_seq >= seq)
> >> +			continue;
> >> +
> >> +		con->printk_seq++;
> >> +		if (con->printk_seq < seq) {
> >> +			print_console_dropped(con, seq - con->printk_seq);
> >> +			con->printk_seq = seq;
> >
> > It would be great to print this message only when the real one
> > is not superseded.
> 
> You mean if there was some function to check if "seq" is the newest
> entry. And only in that situation would any dropped information be
> presented?

Not newest but not suppressed.

Example: Only every 10th message is important enough to reach
        console (see suppress_message_printing).

Instead of seeing:

message 10
message 20
7 messages dropped
20 another messages dropped because of printing the warning
20 another messages dropped because of printing the warning
20 another messages dropped because of printing the warning
message 100

see something like:

message 10
message 20
13 messages dropped
message 40
13 messages dropped
message 60
13 messages dropped
message 80
message 90
message100

The original code would print only warnings because the important
lines are lost when printing the warnings.

A better code would show more messages because the warning
is printed when a visible message is already buffered.

You might wonder why there are only 13 messages dropped in
the new state. It is because the other 6 messages are
quickly read and suspended (filtered out). They are
skipped by intention.

I hope that it will be more clear with the patch that I have
just sent, see
https://lkml.kernel.org/r/20190226124945.7078-1-pmladek@suse.com

Best Regards,
Petr
