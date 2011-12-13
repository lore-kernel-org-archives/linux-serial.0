From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/2 v2] serial: bfin-uart: Enable hardware automatic CTS
 only when CTS pin is available.
Date: Mon, 12 Dec 2011 16:03:02 -0800
Message-ID: <20111213000302.GA18722@kroah.com>
References: <1323673191-9210-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33318 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753546Ab1LMADO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Dec 2011 19:03:14 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 311DE217FC
	for <linux-serial@vger.kernel.org>; Mon, 12 Dec 2011 19:03:14 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1323673191-9210-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

On Mon, Dec 12, 2011 at 02:59:50PM +0800, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
>  drivers/tty/serial/bfin_uart.c |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
> index abac237..a6c1c08 100644
> --- a/drivers/tty/serial/bfin_uart.c
> +++ b/drivers/tty/serial/bfin_uart.c
> @@ -726,16 +726,17 @@ static int bfin_serial_startup(struct uart_port *port)
>  	}
>  #endif
>  #ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
> -	if (uart->cts_pin >= 0 && request_irq(uart->status_irq,
> -		bfin_serial_mctrl_cts_int,
> -		0, "BFIN_UART_MODEM_STATUS", uart)) {
> -		uart->cts_pin = -1;
> -		pr_info("Unable to attach BlackFin UART Modem Status interrupt.\n");
> -	}
> +	if (uart->cts_pin >= 0) {
> +		if (request_irq(uart->status_irq, bfin_serial_mctrl_cts_int,
> +			IRQF_DISABLED, "BFIN_UART_MODEM_STATUS", uart)) {
> +			uart->cts_pin = -1;
> +			pr_info("Unable to attach BlackFin UART Modem Status interrupt.\n");

Please use dev_info() here instead, that properly identifies the exact
device you are having problems with.

thanks,

greg k-h
