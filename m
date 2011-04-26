From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V3] tty/serial: add support for Xilinx PS UART
Date: Tue, 26 Apr 2011 20:58:09 +0100
Message-ID: <20110426205809.39a96279@lxorguk.ukuu.org.uk>
References: <b33c1d76-c704-4b84-965b-97bc7e14f390@VA3EHSMHS030.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35298 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754905Ab1DZT5R (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Apr 2011 15:57:17 -0400
In-Reply-To: <b33c1d76-c704-4b84-965b-97bc7e14f390@VA3EHSMHS030.ehs.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Linn <john.linn@xilinx.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, michal.simek@petalogix.com, joe@perches.com, grant.likely@secretlab.ca, greg@kroah.com

O
> +	if (percent_err >= 3)
> +		dev_err(port->dev, "Error too large, baud rate not set\n");

So in this cause baud isn't the one the user asked. Also the user can
make it spew errors by continually generating wrong rates.

If the error is large go for the nearest you can and return it. The core
tty code will do all the rest including reporting to the user they didn't
get their wishes.

> +	else {
> +		/* Set the values for the new baud rate */
> +		xuartps_writel(brgr_val, XUARTPS_BAUDGEN_OFFSET);
> +		xuartps_writel(brdiv_val, XUARTPS_BAUDDIV_OFFSET);

and in this it may not be exact.

I suspect this routine needs to return the actual baud rate (or maybe
baudrate/error code)


> +	/* Min baud rate = 6bps and Max Baud Rate is 10Mbps for 100Mhz clk */
> +	baud = uart_get_baud_rate(port, termios, old, 0, 10000000);
> +	xuartps_set_baud_rate(port, baud);
> +	if (tty_termios_baud_rate(termios))
> +		tty_termios_encode_baud_rate(termios, baud, baud);

and this should do something like

	baud = xuartps_set_baud_rate(port baud);

> +
> +	/*
> +	 * Update the per-port timeout.
> +	 */
> +	uart_update_timeout(port, termios->c_cflag, baud);

[which would also fix this timeout!]

Otherwise looks ready to merge
