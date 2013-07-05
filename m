From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4] tty: serial: add Freescale lpuart driver support
Date: Fri, 5 Jul 2013 17:14:51 +0800
Message-ID: <20130705091449.GA20040@S2101-09.ap.freescale.net>
References: <1369733161-19168-1-git-send-email-b35083@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:51711
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757172Ab3GEJOS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Jul 2013 05:14:18 -0400
Content-Disposition: inline
In-Reply-To: <1369733161-19168-1-git-send-email-b35083@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingchang Lu <b35083@freescale.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, s.hauer@pengutronix.de

Jingchang,

On Tue, May 28, 2013 at 05:26:01PM +0800, Jingchang Lu wrote:
> +static void lpuart_setup_watermark(struct lpuart_port *sport)
> +{
> +	unsigned char val, old_cr2, cr2;
> +
> +	/* set receiver/transmitter trigger level. */
> +	old_cr2 = cr2 = readb(sport->port.membase + UARTCR2);
> +	cr2 &= ~(UARTCR2_TIE | UARTCR2_TCIE | UARTCR2_TE |
> +			UARTCR2_RIE | UARTCR2_RE);
> +	writeb(cr2, sport->port.membase + UARTCR2);
> +
> +	writeb(2, sport->port.membase + UARTTWFIFO);
> +	writeb(1, sport->port.membase + UARTRWFIFO);
> +
> +	/* determine FIFO size and enable */
> +	val = readb(sport->port.membase + UARTPFIFO);
> +
> +	sport->tx_fifo_size = 0x1 << (((val >> UARTPFIFO_TXSIZE_OFF) &
> +		UARTPFIFO_FIFOSIZE_MASK) + 1);
> +
> +	sport->rx_fifo_size = 0x1 << (((val >> UARTPFIFO_RXSIZE_OFF) &
> +		UARTPFIFO_FIFOSIZE_MASK) + 1);
> +
> +	writeb(val | UARTPFIFO_TXFE | UARTPFIFO_RXFE,
> +			sport->port.membase + UARTPFIFO);
> +
> +	/* Flush the Tx and Rx FIFO to a known state */
> +	writeb(UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH,
> +			sport->port.membase + UARTCFIFO);
> +
> +	/* restore CR2 */
> +	writeb(old_cr2, sport->port.membase + UARTCR2);

I just noticed that you dropped this CR2 restore since v5 of the patch.
I have a patch enabling low-level debug support for Vybrid.  It works
with v4 of your patch but has problem with the v5.  The console stops
working as below.

Serial: IMX driver
serial: Freescale lpuart driver
40028000.serial: ttyLP1 at MMIO 0x40028000 (irq = 94) is a FSL_LPUART
console [ttyLP1] enabled, bootconsole disabled

If I have above CR2 restore code added back.  The low-level debug
support will just work fine with console.

Is it an accident you removed the code?

Shawn

> +
> +}

