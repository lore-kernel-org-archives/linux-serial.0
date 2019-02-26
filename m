From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 16/25] printk: implement CON_PRINTBUFFER
Date: Tue, 26 Feb 2019 16:38:14 +0100
Message-ID: <20190226153814.cem5lxr7sla2ihb5@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-17-john.ogness@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-17-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue 2019-02-12 15:29:54, John Ogness wrote:
> If the CON_PRINTBUFFER flag is not set, do not replay the history
> for that console.

This patch fixes a regression caused by previous patches.
We need to do it a way that does not cause the regression
and do not break bisection.

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 6c875abd7b17..b97d4195b09a 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1596,8 +1592,12 @@ static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
>  		if (!(con->flags & CON_ENABLED))
>  			continue;
>  		if (!con->wrote_history) {
> -			printk_write_history(con, seq);
> -			continue;
> +			if (con->flags & CON_PRINTBUFFER) {
> +				printk_write_history(con, seq);
> +				continue;
> +			}
> +			con->wrote_history = 1;

I have just got an idea that we do not need a new flag.
We could clear CON_PRINTBUFFER bit instead.

Best Regards,
Petr
