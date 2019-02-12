From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Date: Wed, 13 Feb 2019 00:47:36 +0900
Message-ID: <20190212154736.GA3160@tigerII.localdomain>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-9-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (02/12/19 15:29), John Ogness wrote:
[..]
> +static int printk_kthread_func(void *data)
> +{
> +	struct prb_iterator iter;
> +	struct printk_log *msg;
> +	size_t ext_len;
> +	char *ext_text;
> +	u64 master_seq;
> +	size_t len;
> +	char *text;
> +	char *buf;
> +	int ret;
> +
> +	ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
> +	text = kmalloc(PRINTK_SPRINT_MAX, GFP_KERNEL);
> +	buf = kmalloc(PRINTK_RECORD_MAX, GFP_KERNEL);
> +	if (!ext_text || !text || !buf)
> +		return -1;
> +
> +	prb_iter_init(&iter, &printk_rb, NULL);
> +
> +	/* the printk kthread never exits */
> +	for (;;) {
> +		ret = prb_iter_wait_next(&iter, buf,
> +					 PRINTK_RECORD_MAX, &master_seq);
> +		if (ret == -ERESTARTSYS) {
> +			continue;
> +		} else if (ret < 0) {
> +			/* iterator invalid, start over */
> +			prb_iter_init(&iter, &printk_rb, NULL);
> +			continue;
> +		}
> +
> +		msg = (struct printk_log *)buf;
> +		format_text(msg, master_seq, ext_text, &ext_len, text,
> +			    &len, printk_time);
> +
> +		console_lock();
> +		if (len > 0 || ext_len > 0) {
> +			call_console_drivers(ext_text, ext_len, text, len);
> +			boot_delay_msec(msg->level);
> +			printk_delay();
> +		}
> +		console_unlock();
> +	}

One thing that I have learned is that preemptible printk does not work
as expected; it wants to be 'atomic' and just stay busy as long as it can.
We tried preemptible printk at Samsung and the result was just bad:
   preempted printk kthread + slow serial console = lots of lost messages

We also had preemptile printk in the upstream kernel and reverted the
patch (see fd5f7cde1b85d4c8e09); same reasons - we had reports that
preemptible printk could "stall" for minutes.

	-ss
