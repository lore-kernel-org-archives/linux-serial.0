Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763AEC433ED
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 09:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39BE3613DC
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 09:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhEJJsR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 May 2021 05:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230093AbhEJJsP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 May 2021 05:48:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35184610CC;
        Mon, 10 May 2021 09:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620640031;
        bh=vbT0CJnb5jNv7EzhGN3Xiroc5UAq23c1lIkvSnH7RQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cONtVYMmyv72CFAhbmElAAmIO+U9/ctxFfSFMHhT2OjPIol7wuKIcBxPm4r7fOU3k
         LXK84Skdi17mEuhgv3VIIpvDckaYhXD4Kwbh/rTq6DPDuIZiiXWSlIr0dti1kCXYgy
         EdfYVFmN/Sz8xblgGx99xkgPbM0HFU3u37ozi4bBkCKyZ63wv1Y3tW4hRbXXqzsK2i
         mvzgC58iLMvBc2rRk9mwtslf4Z3skQH91LWho1SmDq1ka0kKf1Tw0RVFqAb7JXheOA
         ewKeKel2DeNFTY0+RbuQgcIpmoydF8DQgzi7950VqXf4FCo1xAuzVm1oJ91LO8AJEo
         fJHEzEX2MtGmw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lg2VO-00025q-A8; Mon, 10 May 2021 11:47:14 +0200
Date:   Mon, 10 May 2021 11:47:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 34/35] tty: make tty_get_byte_size available
Message-ID: <YJkBIm4IiaZSrSPw@hovoldconsulting.com>
References: <20210505091928.22010-35-jslaby@suse.cz>
 <20210510070054.5397-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510070054.5397-1-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 10, 2021 at 09:00:54AM +0200, Jiri Slaby wrote:
> Many tty drivers contain code to compute bits count depending on termios
> cflags. So extract this code from serial core to a separate tty helper
> function called tty_get_byte_size.
> 
> In the next patch, call to this new function will replace many copies of
> this code.
> 
> [v2] simplified the code flow as suggested by Joe and Andy
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Joe Perches <joe@perches.com>
> ---
>  drivers/tty/serial/serial_core.c | 30 +++--------------------
>  drivers/tty/tty_ioctl.c          | 42 ++++++++++++++++++++++++++++++++
>  include/linux/tty.h              |  2 ++
>  3 files changed, 47 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index d29329eb52f4..b3fc2b02a705 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -334,39 +334,15 @@ void
>  uart_update_timeout(struct uart_port *port, unsigned int cflag,
>  		    unsigned int baud)
>  {
> -	unsigned int bits;
> +	unsigned int size;
>  
> -	/* byte size and parity */
> -	switch (cflag & CSIZE) {
> -	case CS5:
> -		bits = 7;
> -		break;
> -	case CS6:
> -		bits = 8;
> -		break;
> -	case CS7:
> -		bits = 9;
> -		break;
> -	default:
> -		bits = 10;
> -		break; /* CS8 */
> -	}
> -
> -	if (cflag & CSTOPB)
> -		bits++;
> -	if (cflag & PARENB)
> -		bits++;
> -
> -	/*
> -	 * The total number of bits to be transmitted in the fifo.
> -	 */
> -	bits = bits * port->fifosize;
> +	size = tty_get_byte_size(cflag, true) * port->fifosize;
>
>  	/*
>  	 * Figure the timeout to send the above number of bits.
>  	 * Add .02 seconds of slop
>  	 */
> -	port->timeout = (HZ * bits) / baud + HZ/50;
> +	port->timeout = (HZ * size) / baud + HZ/50;
>  }
>  
>  EXPORT_SYMBOL(uart_update_timeout);
> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> index aa9ecc8be990..13acc3decd87 100644
> --- a/drivers/tty/tty_ioctl.c
> +++ b/drivers/tty/tty_ioctl.c
> @@ -300,6 +300,48 @@ int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
>  }
>  EXPORT_SYMBOL(tty_termios_hw_change);
>  
> +/**
> + *	tty_get_byte_size	-	get size of a byte
> + *	@cflag: termios cflag value
> + *	@account_flags: account for start and stop bits, second stop bit (if
> + *			set), and parity (if set)
> + *
> + *	Get the size of a byte in bits depending on @cflag. Depending on
> + *	@account_flags parameter, the result also accounts start and stop bits,
> + *	the second stop bit, and parity bit.
> + */
> +unsigned char tty_get_byte_size(unsigned int cflag, bool account_flags)
> +{
> +	unsigned char bits;
> +
> +	switch (cflag & CSIZE) {
> +	case CS5:
> +		bits = 5;
> +		break;
> +	case CS6:
> +		bits = 6;
> +		break;
> +	case CS7:
> +		bits = 7;
> +		break;
> +	case CS8:
> +	default:
> +		bits = 8;
> +		break;
> +	}
> +
> +	if (!account_flags)
> +		return bits;
> +
> +	if (cflag & CSTOPB)
> +		bits++;
> +	if (cflag & PARENB)
> +		bits++;
> +
> +	return bits + 2;
> +}
> +EXPORT_SYMBOL_GPL(tty_get_byte_size);

This should really be two functions rather than passing a bool argument.

I think naming them

	tty_get_word_size()

and

	tty_get_frame_size()

would be much more clear than than "byte size" + flag.

I realise that the serial-driver interface only uses a cflag argument,
but I think we should consider passing a pointer to the termios
structure instead.

Johan
