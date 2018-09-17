From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH 2/2] Revert "serial: sh-sci: Allow for compressed SCIF
 address"
Date: Mon, 17 Sep 2018 17:11:11 +0000
Message-ID: <TY1PR01MB1562A5E7FA583A7B3AE16FC68A1E0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20180830125404.21192-1-geert+renesas@glider.be>
 <20180830125404.21192-3-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830125404.21192-3-geert+renesas@glider.be>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <uli+renesas@fpond.eu>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thursday, August 30, 2018, Geert Uytterhoeven wrote:
> This reverts commit 2d4dd0da45401c7ae7332b4d1eb7bbb1348edde9.
>=20
> This broke earlycon on all Renesas ARM platforms using a SCIF port for
> the
> serial console (R-Car, RZ/A1, RZ/G1, RZ/G2 SoCs), due to an incorrect
> value
> of port->regshift.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Chris Brandt <chris.brandt@renesas.com>


> ---
>  drivers/tty/serial/sh-sci.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 5d42c9a63001575a..ab3f6e91853da3c2 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -346,15 +346,15 @@ static const struct sci_port_params
> sci_port_params[SCIx_NR_REGTYPES] =3D {
>  	[SCIx_SH4_SCIF_REGTYPE] =3D {
>  		.regs =3D {
>  			[SCSMR]		=3D { 0x00, 16 },
> -			[SCBRR]		=3D { 0x02,  8 },
> -			[SCSCR]		=3D { 0x04, 16 },
> -			[SCxTDR]	=3D { 0x06,  8 },
> -			[SCxSR]		=3D { 0x08, 16 },
> -			[SCxRDR]	=3D { 0x0a,  8 },
> -			[SCFCR]		=3D { 0x0c, 16 },
> -			[SCFDR]		=3D { 0x0e, 16 },
> -			[SCSPTR]	=3D { 0x10, 16 },
> -			[SCLSR]		=3D { 0x12, 16 },
> +			[SCBRR]		=3D { 0x04,  8 },
> +			[SCSCR]		=3D { 0x08, 16 },
> +			[SCxTDR]	=3D { 0x0c,  8 },
> +			[SCxSR]		=3D { 0x10, 16 },
> +			[SCxRDR]	=3D { 0x14,  8 },
> +			[SCFCR]		=3D { 0x18, 16 },
> +			[SCFDR]		=3D { 0x1c, 16 },
> +			[SCSPTR]	=3D { 0x20, 16 },
> +			[SCLSR]		=3D { 0x24, 16 },
>  		},
>  		.fifosize =3D 16,
>  		.overrun_reg =3D SCLSR,
> @@ -2837,7 +2837,7 @@ static int sci_init_single(struct platform_device
> *dev,
>  {
>  	struct uart_port *port =3D &sci_port->port;
>  	const struct resource *res;
> -	unsigned int i, regtype;
> +	unsigned int i;
>  	int ret;
>=20
>  	sci_port->cfg	=3D p;
> @@ -2874,7 +2874,6 @@ static int sci_init_single(struct platform_device
> *dev,
>  	if (unlikely(sci_port->params =3D=3D NULL))
>  		return -EINVAL;
>=20
> -	regtype =3D sci_port->params - sci_port_params;
>  	switch (p->type) {
>  	case PORT_SCIFB:
>  		sci_port->rx_trigger =3D 48;
> @@ -2929,10 +2928,6 @@ static int sci_init_single(struct platform_device
> *dev,
>  			port->regshift =3D 1;
>  	}
>=20
> -	if (regtype =3D=3D SCIx_SH4_SCIF_REGTYPE)
> -		if (sci_port->reg_size >=3D 0x20)
> -			port->regshift =3D 1;
> -
>  	/*
>  	 * The UART port needs an IRQ value, so we peg this to the RX IRQ
>  	 * for the multi-IRQ ports, which is where we are primarily
> --
> 2.17.1
