From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] serial: rp2: New driver for Comtrol RocketPort 2
 cards
Date: Fri, 28 Dec 2012 10:56:52 +0000
Message-ID: <20121228105652.5cd35ef2@pyramind.ukuu.org.uk>
References: <c141e9cf9329550e53d18c9a8a2c6246@localhost>
	<10876da5ca515a76207af4fe303f1e43@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60850 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120Ab2L1Ku4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Dec 2012 05:50:56 -0500
In-Reply-To: <10876da5ca515a76207af4fe303f1e43@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org

>  - Systems that have a combination of RocketPort 1 + RocketPort 2 cards
>    (the PCI ID table in rocket.c actually matches anything with Comtrol's
>    vendor ID)

In which case that will need updating to only include the identifiers for
the original rocket port, or ensuring that if it sees an rp2 it returns
an error on the probe so the other probe occurs. The first is probably
preferable as it avoids an un-needed driver load.


> +static const u8 rp2_ucode[] = {
> +	0xF6, 0x8B, 0xE2, 0x86, 0x30, 0x40, 0x66, 0x19, 0x0A, 0x31, 0x40, 0x67,
> +	0x19, 0x0A, 0x86, 0x01, 0x40, 0x11, 0x19, 0x0A, 0x00, 0x40, 0x13, 0x19,
> +	0x0A, 0xFA, 0x83, 0x01, 0x0A, 0x00, 0x0A, 0x41, 0xFF, 0x89, 0xC2, 0x66,
> +	0x86, 0x81, 0x91, 0x40, 0x65, 0x8E, 0x89, 0xC2, 0x66, 0x86, 0x81, 0x88,
> +	0x40, 0x65, 0x85, 0x84, 0x00, 0x82, 0x0A, 0x08, 0x0A, 0x0A, 0x0A, 0x0A,
> +	0x0A, 0x08, 0x0A,
> +};

If that is firmware so is actually code executed by the hardware on the
RocketPort 2 then it should be dynamically loaded with request_firmware.
That is preferred as it avoids some potential licence funnies with GPLv2


> +static void rp2_rx_chars(struct rp2_uart_port *up)
> +{
> +	u16 bytes = readw(up->base + RP2_RX_FIFO_COUNT);
> +	struct tty_struct *tty = up->port.state->port.tty;

You need to take a reference here and allow for tty being NULL so

	tty = tty_port_tty_get(&up->port.state->port);

	if (tty) 

> +	tty_flip_buffer_push(tty);

tty_kref_put()

(you may need to flush the bytes to clear the interrupt in the tty == NULL
case). This allows for a parallel close/hangup clearing the tty and
ensures the tty itself won't be deleted until your tty_kref_put

> +static inline void rp2_flush_fifos(struct rp2_uart_port *up)
> +{
> +	rp2_rmw_set(up, RP2_UART_CTL,
> +		    RP2_UART_CTL_FLUSH_RX_m | RP2_UART_CTL_FLUSH_TX_m);
> +	udelay(10);
> +	rp2_rmw_clr(up, RP2_UART_CTL,
> +		    RP2_UART_CTL_FLUSH_RX_m | RP2_UART_CTL_FLUSH_TX_m);
> +}

This looks wrong. A writel can be posted by the PCI bridge. That means it
may occur after the udelay(10) finishes. However it cannot pass another
read to the same device.

You probably want

	rp2_rmw_set(....)
	readl(some harmless register)
	udelay(10);
	rpm2_rmw_clr(....)


> +static void rp2_reset_asic(struct rp2_card *card, unsigned int asic_id)
> +{
> +	void __iomem *base = card->bar1 + RP2_ASIC_OFFSET(asic_id);
> +	u32 clk_cfg;
> +
> +	writew(1, base + RP2_GLOBAL_CMD);
> +	msleep(100);
> +	writel(0, base + RP2_CLK_PRESCALER);

Same problem here


> +static void rp2_init_port(struct rp2_uart_port *up)
> +{
> +	int i;
> +
> +	writel(RP2_UART_CTL_RESET_CH_m, up->base + RP2_UART_CTL);
> +	udelay(1);
> +
> +	writel(0, up->base + RP2_TXRX_CTL);
> +	writel(0, up->base + RP2_UART_CTL);
> +	udelay(1);

And probably here

Alan
