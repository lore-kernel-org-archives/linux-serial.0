From: Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: [PATCH 2/8] serial: 8250: Add ioctl to enable auto rs485 mode
 with some Exar UARTs
Date: Thu, 17 Nov 2011 10:40:14 +0100
Message-ID: <4EC4D67E.1050102@evidence.eu.com>
References: <1321460685-15753-1-git-send-email-w.sang@pengutronix.de> <1321460685-15753-3-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1321460685-15753-3-git-send-email-w.sang@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Juergen Beisert <jbe@pengutronix.de>, Matthias Fuchs <mfuchs@ma-fu.de>
List-Id: linux-serial@vger.kernel.org

Hi Wolfram,

Il 16/11/2011 17:24, Wolfram Sang ha scritto:
> From: Matthias Fuchs<mfuchs@ma-fu.de>
> 
> Some Exar UARTs support an auto rs485 mode. In this mode
> the UART's RTS# pin is activated during transmitting and
> can be used to enable a rs485 line driver. This has nothing
> to do with attempts to do this by manually asserting/
> deasserting handshake lines in software.
> 
> Signed-off-by: Matthias Fuchs<mfuchs@ma-fu.de>
> 
> [wsa] Replaced 0xbf with define, saved some line-breaks.
> 
> Signed-off-by: Wolfram Sang<w.sang@pengutronix.de>
> ---
>   drivers/tty/serial/8250.c  |   68 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/serial_reg.h |    1 +
>   2 files changed, 69 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
> index f8f2320..920b4df 100644
> --- a/drivers/tty/serial/8250.c
> +++ b/drivers/tty/serial/8250.c
> @@ -38,6 +38,7 @@
>   #include<linux/nmi.h>
>   #include<linux/mutex.h>
>   #include<linux/slab.h>
> +#include<linux/uaccess.h>
> 
>   #include<asm/io.h>
>   #include<asm/irq.h>
> @@ -2698,6 +2699,72 @@ serial8250_type(struct uart_port *port)
>   	return uart_config[type].name;
>   }
> 
> +static int serial8250_ioctl_port(struct uart_port *port,
> +		      unsigned int cmd, unsigned long arg)
> +{
> +	struct uart_8250_port *up = (struct uart_8250_port *)port;
> +	unsigned long flags;
> +
> +	switch (cmd) {
> +	case TIOCSRS485:
> +	{
> +		struct serial_rs485 rs485ctrl;
> +		unsigned char fctr, lcr;
> +
> +		if (port->type != PORT_16850)
> +			return -ENOTTY;
> +
> +		if (copy_from_user(&rs485ctrl, (struct serial_rs485 *)arg,
> +				   sizeof(rs485ctrl)))
> +			return -EFAULT;
> +
> +		spin_lock_irqsave(&up->port.lock, flags);
> +		lcr = serial_inp(up, UART_LCR);
> +		serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_B);
> +		fctr = serial_inp(up, UART_FCTR);
> +		if (rs485ctrl.flags&  SER_RS485_ENABLED)
> +			fctr |= UART_FCTR_RS485;
> +		else
> +			fctr&= ~UART_FCTR_RS485;
> +		serial_outp(up, UART_FCTR, fctr);
> +		serial_outp(up, UART_LCR, lcr);
> +		spin_unlock_irqrestore(&up->port.lock, flags);
> +		return 0;
> +	}
> +
> +	case TIOCGRS485:
> +	{
> +		struct serial_rs485 rs485ctrl;
> +		unsigned char lcr;
> +
> +		if (port->type != PORT_16850)
> +			return -ENOTTY;
> +
> +		memset(&rs485ctrl, 0, sizeof(rs485ctrl));
> +
> +		spin_lock_irqsave(&up->port.lock, flags);
> +		lcr = serial_inp(up, UART_LCR);
> +		serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_B);
> +		if (serial_inp(up, UART_FCTR)&  UART_FCTR_RS485)
> +			rs485ctrl.flags = SER_RS485_ENABLED;
> +		else
> +			rs485ctrl.flags = 0;

This else branch may be removed, since the structure has been already memsetted to 0.

	Claudio
