From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty: Added a CONFIG_TTY option to allow removal of TTY
Date: Tue, 21 Aug 2012 14:20:47 +0100
Message-ID: <20120821142047.777e4bb0@pyramind.ukuu.org.uk>
References: <1345499431-21658-1-git-send-email-jmillenbach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:55215 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab2HUNQP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Aug 2012 09:16:15 -0400
In-Reply-To: <1345499431-21658-1-git-send-email-jmillenbach@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Joe Millenbach <jmillenbach@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, team-fjord@googlegroups.com

> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -53,7 +53,7 @@ source "drivers/tty/serial/Kconfig"
>  
>  config TTY_PRINTK
>  	bool "TTY driver to output user messages via printk"
> -	depends on EXPERT
> +	depends on EXPERT && TTY


A lot of these could be done better with an if I think - notably the
serial one and perhaps some of the input ones if the tty users were
bunched together.


>  config MOUSE_PS2
>  	tristate "PS/2 mouse"
> +	depends on TTY

It shouldn't. It would be good to understand why this occurs.


> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 5dbb3cb..c1406e3 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -377,7 +377,12 @@ extern void tty_write_flush(struct tty_struct *);
>  
>  extern struct ktermios tty_std_termios;
>  
> +#ifdef CONFIG_TTY
>  extern void console_init(void);
> +#else
> +static inline void console_init(void)
> +{ }
> +#endif

Please can you bunch the whole lot up into one #if defined() / #else /
#endif

rather than lots.


Otherwise this looks very sensible to me.
