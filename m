From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] max3100 driver
Date: Sat, 20 Sep 2008 15:11:49 +0100
Message-ID: <20080920151149.21dbad1d@lxorguk.ukuu.org.uk>
References: <1221895208650-git-send-email-chripell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36098 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754402AbYITOL4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 20 Sep 2008 10:11:56 -0400
In-Reply-To: <1221895208650-git-send-email-chripell@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Christian Pellegrin <chripell@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Christian Pellegrin <chripell@fsfe.org>

> +#define MAX3100_MAJOR 204
> +#define MAX3100_MINOR 128
> +/* 4 MAX3100s should be enough for everyone */
> +#define MAX_MAX3100 4

These need to be officially allocated if you need constant numbers

> +static int max3100_sr(struct max3100_port_s *s, u16 tx, u16 *rx)
> +{
> +	struct spi_message message;
> +	struct spi_transfer tran;
> +	u16 etx, erx;
> +	int status;
> +
> +	etx = htons(tx);

Use cpu_to_le/be or le/be_to_cpu functions, these make the intended
endianness clear.

> +	*rx = ntohs(erx);

Ditto

> +		if (rxchars > 0)
> +			tty_flip_buffer_push(s->port.info->port.tty);
> +		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)

If there has been a hangup the port.tty will be NULL...

> +static void
> +max3100_set_termios(struct uart_port *port, struct ktermios *termios,
> +		   struct ktermios *old)
> +{
> +	struct max3100_port_s *s = container_of(port,
> +						struct max3100_port_s,

> +	if (!old || (termios->c_cflag != old->c_cflag)) {

This optimisation is wrong and not worth doing anyway

> +		i = cflag & CBAUD;
> +		switch (i) {

Use tty_get_baud_rate() to get the actual baud rate requested which is an
arbitary value.

> +		default:
> +			param_new = 1;
> +			dev_warn(&s->spi->dev, "invalid baudrate\n");

Shouldn't warn on these, just be sure to use tty_encode_baud_rate to pass
back the actual rate the user ends up with.

> +		if (termios->c_iflag & IGNPAR)
> +			s->port.ignore_status_mask |=
> +				MAX3100_STATUS_PE | MAX3100_STATUS_FE |
> +				MAX3100_STATUS_OE;

Bits you don't support should also be cleared in the tty->termios struct
(eg markspace you don't seem to do)


> +	max3100s[i] = kzalloc(sizeof(struct max3100_port_s), GFP_KERNEL);
> +	if (!max3100s[i]) {
> +		dev_warn(&spi->dev,
> +			 "kmalloc for max3100 structure %d failed!\n", i);

Does this not then need to unregister the driver ?



Looks basically sound to me - just some minor cleanups needed.

Alan
