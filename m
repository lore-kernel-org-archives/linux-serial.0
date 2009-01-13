From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: pnx8xxx_uart: Fix break signal handling
Date: Tue, 13 Jan 2009 12:11:35 +0000
Message-ID: <20090113121135.5565b302@lxorguk.ukuu.org.uk>
References: <200901131109.n0DB9DRJ010712@pc67243907.ddns.nl-htc01.nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56007 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757396AbZAMMLS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Jan 2009 07:11:18 -0500
In-Reply-To: <200901131109.n0DB9DRJ010712@pc67243907.ddns.nl-htc01.nxp.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Jonker M.D.S.X." <nlv14114@e3.nl-htc01.nxp.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.d.s.x.jonker@gmail.com

On Tue, 13 Jan 2009 12:09:13 +0100
"Jonker M.D.S.X." <nlv14114@e3.nl-htc01.nxp.com> wrote:

> From: Mischa Jonker <mischa.jonker@nxp.com>
> 
> When a break signal is detected, the next character should be ignored.
> This was not implemented correctly for the pnx8xxx_uart driver.
> 
> Signed-off-by: Mischa Jonker <mischa.jonker@nxp.com>
> ---
> 
> diff --git a/drivers/serial/pnx8xxx_uart.c b/drivers/serial/pnx8xxx_uart.c
> index 22e30d2..1bb8f1b 100644
> --- a/drivers/serial/pnx8xxx_uart.c
> +++ b/drivers/serial/pnx8xxx_uart.c
> @@ -187,7 +187,7 @@ static void pnx8xxx_rx_chars(struct pnx8xxx_port *sport)
>  	status = FIFO_TO_SM(serial_in(sport, PNX8XXX_FIFO)) |
>  		 ISTAT_TO_SM(serial_in(sport, PNX8XXX_ISTAT));
>  	while (status & FIFO_TO_SM(PNX8XXX_UART_FIFO_RXFIFO)) {
> -		ch = serial_in(sport, PNX8XXX_FIFO);
> +		ch = serial_in(sport, PNX8XXX_FIFO) & 0xff;

This appears to be unrelated.
