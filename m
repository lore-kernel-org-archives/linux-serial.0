From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 04/05] serial: sh-sci: Add SCIFA/SCIFB CTS/RTS pin setup
Date: Mon, 05 Jan 2015 09:46:20 +0200
Message-ID: <1784675.cFO7ikSQzd@avalon>
References: <20141217125236.14480.78833.sendpatchset@w520> <20141217125315.14480.15475.sendpatchset@w520>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20141217125315.14480.15475.sendpatchset@w520>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Magnus,

Thank you for the patch.

On Wednesday 17 December 2014 21:53:15 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Add SCIFA/SCIFB pin setup code for CTS/RTS pins to handle
> both cases of hardware flow control enabled or disabled.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  drivers/tty/serial/sh-sci.c |   60 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/serial_sci.h  |    2 +
>  2 files changed, 61 insertions(+), 1 deletion(-)
> 
> --- 0006/drivers/tty/serial/sh-sci.c
> +++ work/drivers/tty/serial/sh-sci.c	2014-12-16 16:10:18.000000000 +0900
> @@ -168,6 +168,8 @@ static struct plat_sci_reg sci_regmap[SC
>  		[SCSPTR]	= sci_reg_invalid,
>  		[SCLSR]		= sci_reg_invalid,
>  		[HSSRR]		= sci_reg_invalid,
> +		[SCPCR]		= sci_reg_invalid,
> +		[SCPDR]		= sci_reg_invalid,
>  	},
> 
>  	/*
> @@ -188,6 +190,8 @@ static struct plat_sci_reg sci_regmap[SC
>  		[SCSPTR]	= sci_reg_invalid,
>  		[SCLSR]		= sci_reg_invalid,
>  		[HSSRR]		= sci_reg_invalid,
> +		[SCPCR]		= sci_reg_invalid,
> +		[SCPDR]		= sci_reg_invalid,
>  	},
> 
>  	/*
> @@ -207,6 +211,8 @@ static struct plat_sci_reg sci_regmap[SC
>  		[SCSPTR]	= sci_reg_invalid,
>  		[SCLSR]		= sci_reg_invalid,
>  		[HSSRR]		= sci_reg_invalid,
> +		[SCPCR]		= { 0x30, 16 },
> +		[SCPDR]		= { 0x34, 16 },
>  	},
> 
>  	/*
> @@ -226,6 +232,8 @@ static struct plat_sci_reg sci_regmap[SC
>  		[SCSPTR]	= sci_reg_invalid,
>  		[SCLSR]		= sci_reg_invalid,
>  		[HSSRR]		= sci_reg_invalid,
> +		[SCPCR]		= { 0x30, 16 },
> +		[SCPDR]		= { 0x34, 16 },
>  	},
> 
>  	/*
> @@ -246,6 +254,8 @@ static struct plat_sci_reg sci_regmap[SC
>  		[SCSPTR]	= { 0x20, 16 },
>  		[SCLSR]		= { 0x24, 16 },
>  		[HSSRR]		= sci_reg_invalid,
> +		[SCPCR]		= sci_reg_invalid,
> +		[SCPDR]		= sci_reg_invalid,
>  	},
> 
>  	/*
> @@ -265,6 +275,8 @@ static struct plat_sci_reg sci_regmap[SC
>  		[SCSPTR]	= sci_reg_invalid,
>  		[SCLSR]		= sci_reg_invalid,
>  		[HSSRR]		= sci_reg_invalid,
> +		[SCPCR]		= sci_reg_invalid,
> +		[SCPDR]		= sci_reg_invalid,
>  	},
> 
>  	/*
> @@ -284,6 +296,8 @@ static struct plat_sci_reg sci_regmap[SC
>  		[SCSPTR]	= { 0x20, 16 },
>  		[SCLSR]		= { 0x24, 16 },
>  		[HSSRR]		= sci_reg_invalid,
> +		[SCPCR]		= sci_reg_invalid,
> +		[SCPDR]		= sci_reg_invalid,
>  	},
> 
>  	/*
> @@ -303,6 +317,8 @@ static struct plat_sci_reg sci_regmap[SC
>  		[SCSPTR]	= { 0x20, 16 },
>  		[SCLSR]		= { 0x24, 16 },
>  		[HSSRR]		= { 0x40, 16 },
> +		[SCPCR]		= sci_reg_invalid,
> +		[SCPDR]		= sci_reg_invalid,
>  	},
> 
>  	/*
> @@ -323,6 +339,8 @@ static struct plat_sci_reg sci_regmap[SC
>  		[SCSPTR]	= sci_reg_invalid,
>  		[SCLSR]		= { 0x24, 16 },
>  		[HSSRR]		= sci_reg_invalid,
> +		[SCPCR]		= sci_reg_invalid,
> +		[SCPDR]		= sci_reg_invalid,
>  	},
> 
>  	/*
> @@ -343,6 +361,8 @@ static struct plat_sci_reg sci_regmap[SC
>  		[SCSPTR]	= { 0x24, 16 },
>  		[SCLSR]		= { 0x28, 16 },
>  		[HSSRR]		= sci_reg_invalid,
> +		[SCPCR]		= sci_reg_invalid,
> +		[SCPDR]		= sci_reg_invalid,
>  	},
> 
>  	/*
> @@ -363,6 +383,8 @@ static struct plat_sci_reg sci_regmap[SC
>  		[SCSPTR]	= sci_reg_invalid,
>  		[SCLSR]		= sci_reg_invalid,
>  		[HSSRR]		= sci_reg_invalid,
> +		[SCPCR]		= sci_reg_invalid,
> +		[SCPDR]		= sci_reg_invalid,
>  	},
>  };
> 
> @@ -542,6 +564,34 @@ static void sci_init_pins_default(struct
>  	serial_port_out(port, SCSPTR, status); /* Set RTS = 1 */
>  }
> 
> +static void sci_init_pins_scifab(struct uart_port *port, bool
> hwflow_enabled)
> +{
> +	unsigned short control, data;
> +
> +	/* SCIFA/SCIFB CTS/RTS pin configuration depends on user space.
> +	 *
> +	 * In case of CTS - (SCPDR.CTSD is always accessible):
> +	 * - Hardware flow control enabled: "CTS pin function"
> +	 * - Hardware flow control disabled: "Input port"
> +	 *
> +	 * In case of RTS:
> +	 * - Hardware flow control enabled: "RTS pin function"
> +	 * - Hardware flow control disabled: "Output port" with value 1
> +	 */
> +	control = serial_port_in(port, SCPCR);
> +	data = serial_port_in(port, SCPDR);
> +
> +	if (hwflow_enabled) {
> +		control &= ~(BIT(4) | BIT(3));
> +	} else {
> +		control |= BIT(4) | BIT(3);

Could you please define SCPCR_RTSC and SCPCR_CTSC macros to replace BIT(3) and 
BIT(4) ?

> +		data |= BIT(4);

And SCPDR_RTSD here ?

> +	}
> +
> +	serial_port_out(port, SCPDR, data);
> +	serial_port_out(port, SCPCR, control);
> +}
> +
>  static void sci_init_pins(struct uart_port *port, unsigned int cflag)
>  {
>  	struct sci_port *s = to_sci_port(port);
> @@ -568,7 +618,15 @@ static void sci_init_pins(struct uart_po
>  	if (!(s->cfg->capabilities & SCIx_HAVE_RTSCTS))
>  		return;
> 
> -	sci_init_pins_default(port, hwflow_enabled);
> +	switch (s->cfg->type) {
> +	case PORT_SCIFA:
> +	case PORT_SCIFB:
> +		sci_init_pins_scifab(port, hwflow_enabled);
> +		break;
> +	default:
> +		sci_init_pins_default(port, hwflow_enabled);
> +	}
> +
>  }
> 
>  static int sci_txfill(struct uart_port *port)
> --- 0006/include/linux/serial_sci.h
> +++ work/include/linux/serial_sci.h	2014-12-16 16:10:18.000000000 +0900
> @@ -102,6 +102,8 @@ enum {
>  	SCRFDR,				/* Receive FIFO Data Count Register */
>  	SCSPTR,				/* Serial Port Register */
>  	HSSRR,				/* Sampling Rate Register */
> +	SCPCR,				/* Serial Port Control Register */
> +	SCPDR,				/* Serial Port Data Register */
> 
>  	SCIx_NR_REGS,
>  };

-- 
Regards,

Laurent Pinchart

