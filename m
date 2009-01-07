From: Christopher Gibson <chris@toftronix.com.au>
Subject: Re: [PATCH V2] serial: Add ioctl to enable auto rs485 mode with
	some Exar UARTs
Date: Thu, 08 Jan 2009 00:58:10 +1100
Message-ID: <1231336690.29906.48.camel@thetriton.toftronix.com.au>
References: <200901021726.09767.mfuchs@ma-fu.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from toftronix.com.au ([60.241.205.236]:51950 "EHLO
	thetriton.toftronix.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752510AbZAGNsY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Jan 2009 08:48:24 -0500
In-Reply-To: <200901021726.09767.mfuchs@ma-fu.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthias Fuchs <mfuchs@ma-fu.de>
Cc: linux-serial@vger.kernel.org

On Fri, 2009-01-02 at 17:26 +0100, Matthias Fuchs wrote:
> Some Exar UARTs support a auto rs485 mode. In this mode
> the UART's RTS# pin is activated during transmitting and
> can be used to enable a rs485 line driver.
 --->8----

> +
> +	case TIOCGRS485:
> +	{
> +		struct serial_rs485 rs485ctrl;

Should the TIOCGRS485 call set delay_rts_before_send structure element
to 0 to demonstrate that there is no delay ability?  memset(&rs485ctrl,
0, sizeof(struct serial_rs485)); missing?

> +
> +		if (port->type != PORT_16850)
> +			return -ENOTTY;
> +
> +		spin_lock_irqsave(&up->port.lock, flags);
> +		serial_outp(up, UART_LCR, 0xbf);
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

-- 
Christopher Gibson <chris@toftronix.com.au>

