From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] serial: imx: enable the clocks only when the uart is
	used
Date: Mon, 3 Jun 2013 10:50:14 +0100
Message-ID: <20130603095014.GJ18614@n2100.arm.linux.org.uk>
References: <1370245331-12501-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33925 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523Ab3FCJuv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Jun 2013 05:50:51 -0400
Content-Disposition: inline
In-Reply-To: <1370245331-12501-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Mon, Jun 03, 2013 at 03:42:11PM +0800, Huang Shijie wrote:
> Current code opens the clocks when the uart driver is probed.
> This will wastes some power if several uarts are enabled, but not really
> used.
> 
> So close these clocks for uart, and enable the clocks only when
> the uart is used.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  drivers/tty/serial/imx.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 72bc1db..5705fc8 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -699,6 +699,9 @@ static int imx_startup(struct uart_port *port)
>  	int retval;
>  	unsigned long flags, temp;
>  
> +	clk_prepare_enable(sport->clk_per);
> +	clk_prepare_enable(sport->clk_ipg);

You should check the return value.  I've a good mind to mark these
functions with __must_check...
