From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 1/4] printk: Introduce per-console loglevel setting
Date: Fri, 8 Mar 2019 12:10:32 +0900
Message-ID: <20190308031032.GA30056@jagdpanzerIV>
References: <cover.1551486732.git.calvinowens@fb.com>
 <06cd267ef5439a9391368423b608959f5f1b1a63.1551486732.git.calvinowens@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <06cd267ef5439a9391368423b608959f5f1b1a63.1551486732.git.calvinowens@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Calvin Owens <calvinowens@fb.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On (03/01/19 16:48), Calvin Owens wrote:
[..]
>  		msg = log_from_idx(console_idx);
> -		if (suppress_message_printing(msg->level)) {
> -			/*
> -			 * Skip record we have buffered and already printed
> -			 * directly to the console when we received it, and
> -			 * record that has level above the console loglevel.
> -			 */
> -			console_idx = log_next(console_idx);
> -			console_seq++;
> -			goto skip;
> -		}
>  
>  		/* Output to all consoles once old messages replayed. */
>  		if (unlikely(exclusive_console &&
> @@ -2405,7 +2402,7 @@ void console_unlock(void)
>  		console_lock_spinning_enable();
>  
>  		stop_critical_timings();	/* don't trace print latency */
> -		call_console_drivers(ext_text, ext_len, text, len);
> +		call_console_drivers(ext_text, ext_len, text, len, msg->level);
>  		start_critical_timings();

So it seems that now we always format the text and ext message (if
needed) and only then check if there is at least one console we can
print that message on.

Can we iterate the consoles first and check if msg is worth
the effort (per console suppress_message_printing()) and only
if it is do all the formatting and call console drivers?

	-ss
