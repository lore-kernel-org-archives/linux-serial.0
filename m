From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH V2] serial: Add ioctl to enable auto rs485 mode with some Exar UARTs
Date: Wed, 7 Jan 2009 11:35:09 +0100
Message-ID: <200901071135.10030.laurentp@cse-semaphore.com>
References: <200901021726.09767.mfuchs@ma-fu.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:21842 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751178AbZAGKfP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Jan 2009 05:35:15 -0500
In-Reply-To: <200901021726.09767.mfuchs@ma-fu.de>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthias Fuchs <mfuchs@ma-fu.de>
Cc: linux-serial@vger.kernel.org

Hi Mathias,

On Friday 02 January 2009 17:26:09 Matthias Fuchs wrote:
> Some Exar UARTs support a auto rs485 mode. In this mode
> the UART's RTS# pin is activated during transmitting and
> can be used to enable a rs485 line driver. This has nothing
> to do with attempts to do this by manually by asserting/
> deasserting handshake lines.

I've tested your patch and it mostly works. See comments inline.

> Signed-off-by: Matthias Fuchs <mfuchs@ma-fu.de>
> ---
>  drivers/serial/8250.c      |   64
> ++++++++++++++++++++++++++++++++++++++++++++ include/linux/serial_reg.h |  
>  1 +
>  2 files changed, 65 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index 303272a..4b89f8a 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -2511,6 +2511,69 @@ serial8250_type(struct uart_port *port)
>  	return uart_config[type].name;
>  }
>
> +static int
> +serial8250_ioctl_port(struct uart_port *port, unsigned int cmd, unsigned
> long arg) +{
> +	struct uart_8250_port *up = (struct uart_8250_port *)port;
> +	unsigned long flags;
> +
> +	switch (cmd) {
> +	case TIOCSRS485:
> +	{
> +		struct serial_rs485 rs485ctrl;
> +		unsigned char fctr;
> +
> +		if (port->type != PORT_16850)
> +			return -ENOTTY;
> +
> +		if (copy_from_user(&rs485ctrl,
> +				   (struct serial_rs485 *)arg,
> +				   sizeof(rs485ctrl)))
> +			return -EFAULT;
> +
> +		spin_lock_irqsave(&up->port.lock, flags);
> +		serial_outp(up, UART_LCR, 0xbf);

You need to save the current LCR and restore it when you're done.

> +		fctr = serial_inp(up, UART_FCTR);
> +		if (rs485ctrl.flags & SER_RS485_ENABLED)
> +			fctr |= UART_FCTR_RS485;
> +		else
> +			fctr &= ~UART_FCTR_RS485;
> +		serial_outp(up, UART_FCTR, fctr);
> +		serial_outp(up, UART_LCR, 0);
> +		spin_unlock_irqrestore(&up->port.lock, flags);
> +		return 0;
> +	}
> +
> +	case TIOCGRS485:
> +	{
> +		struct serial_rs485 rs485ctrl;
> +
> +		if (port->type != PORT_16850)
> +			return -ENOTTY;
> +
> +		spin_lock_irqsave(&up->port.lock, flags);
> +		serial_outp(up, UART_LCR, 0xbf);

Same here.

> +		if (serial_inp(up, UART_FCTR) & UART_FCTR_RS485)
> +			rs485ctrl.flags = SER_RS485_ENABLED;
> +		else
> +			rs485ctrl.flags = 0;
> +		serial_outp(up, UART_LCR, 0);
> +		spin_unlock_irqrestore(&up->port.lock, flags);
> +
> +		if (copy_to_user((struct serial_rs485 *)arg,
> +				 &rs485ctrl,
> +				 sizeof(rs485ctrl)))
> +			return -EFAULT;
> +		return 0;
> +	}
> +
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct uart_ops serial8250_pops = {
>  	.tx_empty	= serial8250_tx_empty,
>  	.set_mctrl	= serial8250_set_mctrl,

Best regards,

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
