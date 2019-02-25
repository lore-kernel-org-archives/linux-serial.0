From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 13/25] printk: track seq per console
Date: Mon, 25 Feb 2019 15:59:54 +0100
Message-ID: <20190225145954.62zl3tndmo2t372h@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-14-john.ogness@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-14-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue 2019-02-12 15:29:51, John Ogness wrote:
> Allow each console to track which seq record was last printed. This
> simplifies identifying dropped records.

I would like to see a better justification here. And I think
that it is part of this patchset.

One reason is to implement console reply a cleaner way.
Another reason is  to allows calling lockless consoles
directly in emergency situations.

Both reasons are independent on the log buffer implementation.
Therefore I suggest to move it into another patchset.


> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ece54c24ea0d..ebd9aac06323 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1504,6 +1514,19 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
>  		if (!cpu_online(raw_smp_processor_id()) &&
>  		    !(con->flags & CON_ANYTIME))
>  			continue;
> +		if (con->printk_seq >= seq)
> +			continue;
> +
> +		con->printk_seq++;
> +		if (con->printk_seq < seq) {
> +			print_console_dropped(con, seq - con->printk_seq);
> +			con->printk_seq = seq;

It would be great to print this message only when the real one
is not superseded.

The suppressed messages can be proceed quickly. They allow consoles
to catch up with the message producers. But if the spend time
with printing the warning, we just risk loosing more messages
again and again.

Heh, there is a bug in the current code. The warning is not
printed when the currently proceed message is superseded.
I am going to prepare a patch for this.

Best Regards,
Petr
