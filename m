From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 09/14] tty/serial/amba-pl011: Implement clear_irqs
 callback
Date: Mon, 10 Sep 2012 12:17:02 +0100
Message-ID: <20120910121702.550b8a90@pyramind.ukuu.org.uk>
References: <20120910040802.GA1261@lizard>
	<20120910041404.GI29537@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:51459 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757285Ab2IJLMk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Sep 2012 07:12:40 -0400
In-Reply-To: <20120910041404.GI29537@lizard>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Colin Cross <ccross@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org

On Sun, 9 Sep 2012 21:14:04 -0700
Anton Vorontsov <anton.vorontsov@linaro.org> wrote:

> It's all pretty straightforward, except for TXIM interrupt. The interrupt
> has meaning "ready to transmit", so it's almost always raised, and the
> only way to silence it is to mask it. But that's OK, ops->start_tx will
> unmask it.
> 
> Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 88e2df2..7522d97 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1308,6 +1308,18 @@ static void pl011_put_poll_char(struct uart_port *port,
>  	writew(ch, uap->port.membase + UART01x_DR);
>  }
>  
> +static void pl011_clear_irqs(struct uart_port *port)
> +{
> +	struct uart_amba_port *uap = (struct uart_amba_port *)port;
> +	unsigned char __iomem *regs = uap->port.membase;
> +
> +	writew(readw(regs + UART011_MIS), regs + UART011_ICR);
> +	/*
> +	 * There is no way to clear TXIM, this is "ready to transmit IRQ", so
> +	 * we simply mask it. ops->start_tx will unmask it.
> +	 */

Not if you race here with the transmit start it won't.
