From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 15/25] printk: print history for new consoles
Date: Tue, 26 Feb 2019 15:58:37 +0100
Message-ID: <20190226145837.wl54fr7rn2ii5oxc@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-16-john.ogness@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-16-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue 2019-02-12 15:29:53, John Ogness wrote:
> When new consoles register, they currently print how many messages
> they have missed. However, many (or all) of those messages may still
> be in the ring buffer. Add functionality to print as much of the
> history as available. This is a clean replacement of the old
> exclusive console hack.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 897219f34cab..6c875abd7b17 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1506,6 +1506,77 @@ static void format_text(struct printk_log *msg, u64 seq,
>  	}
>  }
>  
> +static void printk_write_history(struct console *con, u64 master_seq)
> +{
> +	struct prb_iterator iter;
> +	bool time = printk_time;
> +	static char *ext_text;
> +	static char *text;
> +	static char *buf;
> +	u64 seq;
> +
> +	ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
> +	text = kmalloc(PRINTK_SPRINT_MAX, GFP_KERNEL);
> +	buf = kmalloc(PRINTK_RECORD_MAX, GFP_KERNEL);
> +	if (!ext_text || !text || !buf)
> +		return;

We need to free buffers that were successfully allocated.

> +	if (!(con->flags & CON_ENABLED))
> +		goto out;
> +
> +	if (!con->write)
> +		goto out;
> +
> +	if (!cpu_online(raw_smp_processor_id()) &&
> +	    !(con->flags & CON_ANYTIME))
> +		goto out;
> +
> +	prb_iter_init(&iter, &printk_rb, NULL);
> +
> +	for (;;) {
> +		struct printk_log *msg;
> +		size_t ext_len;
> +		size_t len;
> +		int ret;
> +
> +		ret = prb_iter_next(&iter, buf, PRINTK_RECORD_MAX, &seq);
> +		if (ret == 0) {
> +			break;
> +		} else if (ret < 0) {
> +			prb_iter_init(&iter, &printk_rb, NULL);
> +			continue;
> +		}
> +
> +		if (seq > master_seq)
> +			break;
> +
> +		con->printk_seq++;
> +		if (con->printk_seq < seq) {
> +			print_console_dropped(con, seq - con->printk_seq);
> +			con->printk_seq = seq;
> +		}
> +
> +		msg = (struct printk_log *)buf;
> +		format_text(msg, master_seq, ext_text, &ext_len, text,
> +			    &len, time);
> +
> +		if (len == 0 && ext_len == 0)
> +			continue;
> +
> +		if (con->flags & CON_EXTENDED)
> +			con->write(con, ext_text, ext_len);
> +		else
> +			con->write(con, text, len);
> +
> +		printk_delay(msg->level);

Hmm, this duplicates a lot of code from call_console_drivers() and
maybe also from printk_kthread_func(). It is error prone. People
will forget to update this function when working on the main one.

We need to put the shared parts into separate functions.
For example, the per-console code might be moved to
call_console_write(struct console *con, ...). Then
call_console_drivers() might look like:

static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
				 const char *text, size_t len, int level)
{
	struct console *con;

	trace_console_rcuidle(text, len);

	if (!console_drivers)
		return;

	for_each_console(con) {
		call_console_write(con, seq, ext_text, ext_len,
				   text, len, level);
	}
}

And you could call call_console_write() for the particular console
from printk_write_history().

> +	}
> +out:
> +	con->wrote_history = 1;
> +	kfree(ext_text);
> +	kfree(text);
> +	kfree(buf);
> +}
> +
>  /*
>   * Call the console drivers, asking them to write out
>   * log_buf[start] to log_buf[end - 1].
> @@ -1524,6 +1595,10 @@ static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
>  	for_each_console(con) {
>  		if (!(con->flags & CON_ENABLED))
>  			continue;
> +		if (!con->wrote_history) {
> +			printk_write_history(con, seq);

This looks like an alien. The code is supposed to write one message
from the given buffer. And some huge job is well hidden there.

In addition, the code is actually recursive. It will become
clear when it is deduplicated as suggested above. We should
avoid it when it is not necessary. Note that recursive code
is always more prone to mistakes and it is harder to think of.

I guess that the motivation is to do everything from the printk
kthread. Is it really necessary? register_console() takes
console_lock(). It has to be sleepable context by definition.

Anyway, the new console is added under console_lock().
Any new console_lock owner could always check which new
consoles need to replay the log before it starts processing
new messages.

Best Regards,
Petr
