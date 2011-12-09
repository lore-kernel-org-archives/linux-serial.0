From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH RESEND 6/8] serial: 8250: update rs485 flags with
 polarity settings
Date: Fri, 9 Dec 2011 19:13:39 +0000
Message-ID: <20111209191339.0d9c3dd5@pyramind.ukuu.org.uk>
References: <1323450440-414-1-git-send-email-w.sang@pengutronix.de>
	<1323450440-414-7-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36288 "EHLO
	pyramind.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752153Ab1LITNK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Dec 2011 14:13:10 -0500
In-Reply-To: <1323450440-414-7-git-send-email-w.sang@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Claudio Scordino <claudio@evidence.eu.com>

On Fri,  9 Dec 2011 18:07:18 +0100
Wolfram Sang <w.sang@pengutronix.de> wrote:

> Report the only mode we can support with the 16C850.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/tty/serial/8250.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
> index 28b3608..8cf6d76 100644
> --- a/drivers/tty/serial/8250.c
> +++ b/drivers/tty/serial/8250.c
> @@ -2750,6 +2750,9 @@ static int serial8250_ioctl_port(struct uart_port *port,
>  		serial_outp(up, UART_LCR, lcr);
>  		spin_unlock_irqrestore(&up->port.lock, flags);
>  
> +		/* only mode supported by the 16C850 */
> +		rs485ctrl.flags &= ~SER_RS485_RTS_ON_SEND;
> +		rs485ctrl.flags |= SER_RS485_RTS_AFTER_SEND;
>  		up->rs485_flags = rs485ctrl.flags;

Chip specific stuff all wants to be in a port method so while #3 sorts
out much of #2 this goes back to wanting port-> methods and flags to
avoid assumptions about chip types in the core bits.

#7 really makes the point why it is needed.

So pardon the confused series of review comments but I think the summary
is port->ops for RS485 stuff please.

