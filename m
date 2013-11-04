From: Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH] USB: pl2303: fixed handling of CS5 setting
Date: Mon, 4 Nov 2013 11:13:56 +0100
Message-ID: <20131104101356.GA15921@localhost>
References: <5276C9AE.1050702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:56413 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab3KDKOE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Nov 2013 05:14:04 -0500
Content-Disposition: inline
In-Reply-To: <5276C9AE.1050702@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Colin Leitner <colin.leitner@googlemail.com>
Cc: gregkh@linuxfoundation.org, Johan Hovold <jhovold@gmail.com>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

On Sun, Nov 03, 2013 at 11:09:50PM +0100, Colin Leitner wrote:
> This patch fixes the CS5 setting on the PL2303 USB-to-serial devices. CS5 has a
> value of 0 and the CSIZE setting has been skipped altogether by the enclosing
> if. Tested on 3.11.6 and the scope shows the correct output after the fix has
> been applied.
> 
> Tagged to be added to stable, because it fixes a user visible driver bug and is
> simple enough to backport easily.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Colin Leitner <colin.leitner@gmail.com>

Looks good now, but I'm afraid it doesn't apply to v3.12. There were
some last minute reverts in v3.12 which could possibly explain that.

Care to rebase against v3.12 and send a v2 (v3?)?

Thanks,
Johan

> ---
>  drivers/usb/serial/pl2303.c |   30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
> index bedf8e4..fd86357 100644
> --- a/drivers/usb/serial/pl2303.c
> +++ b/drivers/usb/serial/pl2303.c
> @@ -522,23 +522,21 @@ static void pl2303_set_termios(struct tty_struct *tty,
>  			    0, 0, buf, 7, 100);
>  	dev_dbg(&port->dev, "0xa1:0x21:0:0  %d - %7ph\n", i, buf);
> 
> -	if (C_CSIZE(tty)) {
> -		switch (C_CSIZE(tty)) {
> -		case CS5:
> -			buf[6] = 5;
> -			break;
> -		case CS6:
> -			buf[6] = 6;
> -			break;
> -		case CS7:
> -			buf[6] = 7;
> -			break;
> -		default:
> -		case CS8:
> -			buf[6] = 8;
> -		}
> -		dev_dbg(&port->dev, "data bits = %d\n", buf[6]);
> +	switch (C_CSIZE(tty)) {
> +	case CS5:
> +		buf[6] = 5;
> +		break;
> +	case CS6:
> +		buf[6] = 6;
> +		break;
> +	case CS7:
> +		buf[6] = 7;
> +		break;
> +	default:
> +	case CS8:
> +		buf[6] = 8;
>  	}
> +	dev_dbg(&port->dev, "data bits = %d\n", buf[6]);
> 
>  	/* For reference:   buf[0]:buf[3] baud rate value */
>  	pl2303_encode_baudrate(tty, port, spriv->type, buf);
> -- 
> 1.7.10.4
