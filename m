From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 14/25] serial: sh-sci: Add BRG register definitions
Date: Thu, 19 Nov 2015 22:45:31 +0200
Message-ID: <1866546.6tqcoO3C0e@avalon>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be> <1447958344-836-15-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447958344-836-15-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thursday 19 November 2015 19:38:53 Geert Uytterhoeven wrote:
> Add register definitions for the Baud Rate Generator for External Clock
> (BRG), as found in some SCIF and in HSCIF, including a new regtype for
> the "SH-4(A)"-derived SCIF variant with BRG.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/sh-sci.c | 46 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/tty/serial/sh-sci.h |  5 +++++
>  include/linux/serial_sci.h  |  1 +
>  3 files changed, 52 insertions(+)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index d82735dd62ae38d8..76738c9918885764 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -161,6 +161,8 @@ static const struct plat_sci_reg
> sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = { [HSSRR]		= 
sci_reg_invalid,
>  		[SCPCR]		= sci_reg_invalid,
>  		[SCPDR]		= sci_reg_invalid,
> +		[SCDL]		= sci_reg_invalid,
> +		[SCCKS]		= sci_reg_invalid,
>  	},
> 
>  	/*
> @@ -183,6 +185,8 @@ static const struct plat_sci_reg
> sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = { [HSSRR]		= 
sci_reg_invalid,
>  		[SCPCR]		= sci_reg_invalid,
>  		[SCPDR]		= sci_reg_invalid,
> +		[SCDL]		= sci_reg_invalid,
> +		[SCCKS]		= sci_reg_invalid,
>  	},
> 
>  	/*
> @@ -204,6 +208,8 @@ static const struct plat_sci_reg
> sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = { [HSSRR]		= 
sci_reg_invalid,
>  		[SCPCR]		= { 0x30, 16 },
>  		[SCPDR]		= { 0x34, 16 },
> +		[SCDL]		= sci_reg_invalid,
> +		[SCCKS]		= sci_reg_invalid,
>  	},
> 
>  	/*
> @@ -225,6 +231,8 @@ static const struct plat_sci_reg
> sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = { [HSSRR]		= 
sci_reg_invalid,
>  		[SCPCR]		= { 0x30, 16 },
>  		[SCPDR]		= { 0x34, 16 },
> +		[SCDL]		= sci_reg_invalid,
> +		[SCCKS]		= sci_reg_invalid,
>  	},
> 
>  	/*
> @@ -247,6 +255,8 @@ static const struct plat_sci_reg
> sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = { [HSSRR]		= 
sci_reg_invalid,
>  		[SCPCR]		= sci_reg_invalid,
>  		[SCPDR]		= sci_reg_invalid,
> +		[SCDL]		= sci_reg_invalid,
> +		[SCCKS]		= sci_reg_invalid,
>  	},
> 
>  	/*
> @@ -268,6 +278,8 @@ static const struct plat_sci_reg
> sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = { [HSSRR]		= 
sci_reg_invalid,
>  		[SCPCR]		= sci_reg_invalid,
>  		[SCPDR]		= sci_reg_invalid,
> +		[SCDL]		= sci_reg_invalid,
> +		[SCCKS]		= sci_reg_invalid,
>  	},
> 
>  	/*
> @@ -289,6 +301,32 @@ static const struct plat_sci_reg
> sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = { [HSSRR]		= 
sci_reg_invalid,
>  		[SCPCR]		= sci_reg_invalid,
>  		[SCPDR]		= sci_reg_invalid,
> +		[SCDL]		= sci_reg_invalid,
> +		[SCCKS]		= sci_reg_invalid,
> +	},
> +
> +	/*
> +	 * Common SCIF definitions for ports with a Baud Rate Generator for
> +	 * External Clock (BRG).
> +	 */
> +	[SCIx_SH4_SCIF_BRG_REGTYPE] = {
> +		[SCSMR]		= { 0x00, 16 },
> +		[SCBRR]		= { 0x04,  8 },
> +		[SCSCR]		= { 0x08, 16 },
> +		[SCxTDR]	= { 0x0c,  8 },
> +		[SCxSR]		= { 0x10, 16 },
> +		[SCxRDR]	= { 0x14,  8 },
> +		[SCFCR]		= { 0x18, 16 },
> +		[SCFDR]		= { 0x1c, 16 },
> +		[SCTFDR]	= sci_reg_invalid,
> +		[SCRFDR]	= sci_reg_invalid,
> +		[SCSPTR]	= { 0x20, 16 },
> +		[SCLSR]		= { 0x24, 16 },
> +		[HSSRR]		= sci_reg_invalid,
> +		[SCPCR]		= sci_reg_invalid,
> +		[SCPDR]		= sci_reg_invalid,
> +		[SCDL]		= { 0x30, 16 },
> +		[SCCKS]		= { 0x34, 16 },
>  	},
> 
>  	/*
> @@ -310,6 +348,8 @@ static const struct plat_sci_reg
> sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = { [HSSRR]		= { 0x40, 16 },
>  		[SCPCR]		= sci_reg_invalid,
>  		[SCPDR]		= sci_reg_invalid,
> +		[SCDL]		= { 0x30, 16 },
> +		[SCCKS]		= { 0x34, 16 },
>  	},
> 
>  	/*
> @@ -332,6 +372,8 @@ static const struct plat_sci_reg
> sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = { [HSSRR]		= 
sci_reg_invalid,
>  		[SCPCR]		= sci_reg_invalid,
>  		[SCPDR]		= sci_reg_invalid,
> +		[SCDL]		= sci_reg_invalid,
> +		[SCCKS]		= sci_reg_invalid,
>  	},
> 
>  	/*
> @@ -354,6 +396,8 @@ static const struct plat_sci_reg
> sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = { [HSSRR]		= 
sci_reg_invalid,
>  		[SCPCR]		= sci_reg_invalid,
>  		[SCPDR]		= sci_reg_invalid,
> +		[SCDL]		= sci_reg_invalid,
> +		[SCCKS]		= sci_reg_invalid,
>  	},
> 
>  	/*
> @@ -376,6 +420,8 @@ static const struct plat_sci_reg
> sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = { [HSSRR]		= 
sci_reg_invalid,
>  		[SCPCR]		= sci_reg_invalid,
>  		[SCPDR]		= sci_reg_invalid,
> +		[SCDL]		= sci_reg_invalid,
> +		[SCCKS]		= sci_reg_invalid,
>  	},
>  };
> 
> diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
> index bf69bbdcc1f9aa39..54994f0bfafdbe12 100644
> --- a/drivers/tty/serial/sh-sci.h
> +++ b/drivers/tty/serial/sh-sci.h
> @@ -27,6 +27,8 @@ enum {
>  	HSSRR,				/* Sampling Rate Register */
>  	SCPCR,				/* Serial Port Control Register */
>  	SCPDR,				/* Serial Port Data Register */
> +	SCDL,				/* BRG Frequency Division Register */
> +	SCCKS,				/* BRG Clock Select Register */
> 
>  	SCIx_NR_REGS,
>  };
> @@ -109,6 +111,9 @@ enum {
>  #define SCPDR_RTSD	BIT(4)	/* Serial Port RTS Output Pin Data */
>  #define SCPDR_CTSD	BIT(3)	/* Serial Port CTS Input Pin Data */
> 
> +/* BRG Clock Select Register (Some SCIF and HSCIF) */
> +#define SCCKS_CKS	BIT(15)	/* Select SCK (1) or SC_CLK (0) */

This is slightly confusing. SC_CLK is defined as the external clock selectable 
between the bus clock and SCIF_CLK. The CKS bit selects the output of the baud 
rate generator for external clock as being the divided SC_CLK or the undivided 
(H)SCK. The comment, and I know it comes from the datasheet, seems to imply 
that the bit selects the input of the BRG-EC. Speaking of which it would be 
good to have a comment somewhere in the code to explain that we have two 
chained BRGs.

> +#define SCCKS_XIN	BIT(14)	/* SC_CLK uses bus clock (1) or SCIF_CLK (0) 
*/
> 
>  #define SCxSR_TEND(port)	(((port)->type == PORT_SCI) ? SCI_TEND   :
> SCIF_TEND) #define SCxSR_RDxF(port)	(((port)->type == PORT_SCI) ? 
SCI_RDRF 
>  : SCIF_RDF) diff --git a/include/linux/serial_sci.h
> b/include/linux/serial_sci.h index 7c536ac5be05d3aa..9f2bfd0557429ac3
> 100644
> --- a/include/linux/serial_sci.h
> +++ b/include/linux/serial_sci.h
> @@ -32,6 +32,7 @@ enum {
>  	SCIx_SH2_SCIF_FIFODATA_REGTYPE,
>  	SCIx_SH3_SCIF_REGTYPE,
>  	SCIx_SH4_SCIF_REGTYPE,
> +	SCIx_SH4_SCIF_BRG_REGTYPE,
>  	SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
>  	SCIx_SH4_SCIF_FIFODATA_REGTYPE,
>  	SCIx_SH7705_SCIF_REGTYPE,

-- 
Regards,

Laurent Pinchart
