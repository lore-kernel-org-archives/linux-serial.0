From: Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH] USB: pl2303: fixed handling of CS5 setting
Date: Mon, 4 Nov 2013 20:13:55 +0100
Message-ID: <20131104191355.GB15921@localhost>
References: <5277EA2B.1020806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:59890 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab3KDTOB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Nov 2013 14:14:01 -0500
Content-Disposition: inline
In-Reply-To: <5277EA2B.1020806@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Colin Leitner <colin.leitner@googlemail.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Johan Hovold <jhovold@gmail.com>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

On Mon, Nov 04, 2013 at 07:40:43PM +0100, Colin Leitner wrote:
> This patch fixes the CS5 setting on the PL2303 USB-to-serial devices. CS5 has a
> value of 0 and the CSIZE setting has been skipped altogether by the enclosing
> if. Tested on 3.11.6 and the scope shows the correct output after the fix has
> been applied.
> 
> Tagged to be added to stable, because it fixes a user visible driver bug and is
> simple enough to backport easily.

Thanks! Now it applies cleanly to v3.12.

Greg, can you pick this one up for v3.13-rc? The fix could be backported
to all stable trees as the bug has been there since pre-git times.

> Cc: stable@vger.kernel.org
> Signed-off-by: Colin Leitner <colin.leitner@gmail.com>

Signed-off-by: Johan Hovold <jhovold@gmail.com>

> ---
>  drivers/usb/serial/pl2303.c |   30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
> index 1e6de4c..1e3318d 100644
> --- a/drivers/usb/serial/pl2303.c
> +++ b/drivers/usb/serial/pl2303.c
> @@ -361,23 +361,21 @@ static void pl2303_set_termios(struct tty_struct *tty,
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
>  	/* For reference buf[0]:buf[3] baud rate value */
>  	pl2303_encode_baudrate(tty, port, &buf[0]);
> -- 
> 1.7.10.4
