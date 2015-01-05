From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 01/05] serial: sh-sci: Break out default CTS/RTS pin setup
Date: Mon, 05 Jan 2015 10:25:56 +0200
Message-ID: <2156158.vJVakP2u8e@avalon>
References: <20141217125236.14480.78833.sendpatchset@w520> <20141217125246.14480.41876.sendpatchset@w520>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20141217125246.14480.41876.sendpatchset@w520>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Magnus,

Thank you for the patch.

On Wednesday 17 December 2014 21:52:46 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Break out CTS/RTS pin setup for the default case. We only
> care about those pins in case SCIx_HAVE_RTSCTS is set.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  drivers/tty/serial/sh-sci.c |   45 +++++++++++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 14 deletions(-)
> 
> --- 0001/drivers/tty/serial/sh-sci.c
> +++ work/drivers/tty/serial/sh-sci.c	2014-12-16 14:40:31.000000000 +0900
> @@ -509,10 +509,29 @@ static void sci_poll_put_char(struct uar
>  }
>  #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE */
> 
> -static void sci_init_pins(struct uart_port *port, unsigned int cflag)
> +static void sci_init_pins_default(struct uart_port *port, bool
> hwflow_enabled) {

What would you think about renaming the function to sci_init_ctsrts_default ? 
I find having both sci_init_pins and sci_init_pins_default a bit confusing.

>  	struct sci_port *s = to_sci_port(port);
>  	struct plat_sci_reg *reg = sci_regmap[s->cfg->regtype] + SCSPTR;
> +	unsigned short status;
> +
> +	/* If no SCSPTR register exists then skip. Same if hardware flow
> +	 * control has been enabled, in such case SCFCR.MCE will be set
> +	 * and the SCSPTR configuration is assumed to be overridden.
> +	 */
> +	if (!reg->size || hwflow_enabled)
> +		return;
> +
> +	status = serial_port_in(port, SCSPTR);
> +	status &= ~SCSPTR_CTSIO;
> +	status |= SCSPTR_RTSIO;
> +	serial_port_out(port, SCSPTR, status); /* Set RTS = 1 */
> +}
> +
> +static void sci_init_pins(struct uart_port *port, unsigned int cflag)
> +{
> +	struct sci_port *s = to_sci_port(port);
> +	bool hwflow_enabled = cflag & CRTSCTS;
> 
>  	/*
>  	 * Use port-specific handler if provided.
> @@ -522,22 +541,20 @@ static void sci_init_pins(struct uart_po
>  		return;
>  	}
> 
> -	/*
> -	 * For the generic path SCSPTR is necessary. Bail out if that's
> -	 * unavailable, too.
> +	/* SCIF hardware with RTS/CTS support needs special setup below.
> +	 *
> +	 * Please note that if RTS/CTS is available for the hardware
> +	 * platform depends on the particular SCIF channel on a certain
> +	 * SoC, and how this channel has been hooked up on the actual board.

How do you plan to convey that information to the driver in the DT case ? If 
I'm not mistaken the SCIx_HAVE_RTSCTS flag is only set through platform data 
at the moment. Do you have a list of which SCIF channels support RTS/CTS on 
which SoC ?

> +	 *
> +	 * If the RTS/CTS signals will be used or not depends on what user
> +	 * space requests. In case RTS/CTS is available but not requested
> +	 * by user space we still need to configure the pins somehow.
>  	 */
> -	if (!reg->size)
> +	if (!(s->cfg->capabilities & SCIx_HAVE_RTSCTS))
>  		return;
> 
> -	if ((s->cfg->capabilities & SCIx_HAVE_RTSCTS) &&
> -	    ((!(cflag & CRTSCTS)))) {
> -		unsigned short status;
> -
> -		status = serial_port_in(port, SCSPTR);
> -		status &= ~SCSPTR_CTSIO;
> -		status |= SCSPTR_RTSIO;
> -		serial_port_out(port, SCSPTR, status); /* Set RTS = 1 */
> -	}
> +	sci_init_pins_default(port, hwflow_enabled);
>  }
> 
>  static int sci_txfill(struct uart_port *port)

-- 
Regards,

Laurent Pinchart

