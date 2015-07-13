From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/7] tty: core: Add tty_debug() for printk(KERN_DEBUG)
 messages
Date: Sun, 12 Jul 2015 20:47:18 -0700
Message-ID: <1436759238.2711.86.camel@perches.com>
References: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
	 <1436755753-7746-3-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436755753-7746-3-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, 2015-07-12 at 22:49 -0400, Peter Hurley wrote:
> Introduce tty_debug() macro to output uniform debug information for
> tty core debug messages (function name and tty name).
[]
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
[]
> @@ -768,7 +768,7 @@ static void do_tty_hangup(struct work_struct *work)
>  void tty_hangup(struct tty_struct *tty)
>  {
>  #ifdef TTY_DEBUG_HANGUP
> -	printk(KERN_DEBUG "%s hangup...\n", tty_name(tty));
> +	tty_debug(tty, "\n");

Why drop the "hangup..." ?

> diff --git a/include/linux/tty.h b/include/linux/tty.h
[]
> +#define tty_debug(tty, f, args...)					\
> +	do {								\
> +		printk(KERN_DEBUG "%s: %s: " f, __func__,		\
> +		       tty_name(tty), ##args);				\
> +	} while (0)

Single statement macros don't need do {} while (0)

#define fmt, ... 
using fmt, ##__VA_ARGS__

is more common.
