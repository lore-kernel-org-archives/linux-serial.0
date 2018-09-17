From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH 1/2] Revert "serial: sh-sci: Remove SCIx_RZ_SCIFA_REGTYPE"
Date: Mon, 17 Sep 2018 17:10:51 +0000
Message-ID: <TY1PR01MB1562D098E006C2BE93EB6E648A1E0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20180830125404.21192-1-geert+renesas@glider.be>
 <20180830125404.21192-2-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830125404.21192-2-geert+renesas@glider.be>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <uli+renesas@fpond.eu>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thursday, August 30, 2018, Geert Uytterhoeven wrote:
> This reverts commit 7acece71a517cad83a0842a94d94c13f271b680c.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


Acked-by: Chris Brandt <chris.brandt@renesas.com>



> ---
>  drivers/tty/serial/sh-sci.c | 31 +++++++++++++++++++++++++++++++
>  include/linux/serial_sci.h  |  1 +
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index ac4424bf6b136cc4..5d42c9a63001575a 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -291,6 +291,33 @@ static const struct sci_port_params
> sci_port_params[SCIx_NR_REGTYPES] =3D {
>  		.error_clear =3D SCIF_ERROR_CLEAR,
>  	},
>=20
> +	/*
> +	 * The "SCIFA" that is in RZ/T and RZ/A2.
> +	 * It looks like a normal SCIF with FIFO data, but with a
> +	 * compressed address space. Also, the break out of interrupts
> +	 * are different: ERI/BRI, RXI, TXI, TEI, DRI.
> +	 */
> +	[SCIx_RZ_SCIFA_REGTYPE] =3D {
> +		.regs =3D {
> +			[SCSMR]		=3D { 0x00, 16 },
> +			[SCBRR]		=3D { 0x02,  8 },
> +			[SCSCR]		=3D { 0x04, 16 },
> +			[SCxTDR]	=3D { 0x06,  8 },
> +			[SCxSR]		=3D { 0x08, 16 },
> +			[SCxRDR]	=3D { 0x0A,  8 },
> +			[SCFCR]		=3D { 0x0C, 16 },
> +			[SCFDR]		=3D { 0x0E, 16 },
> +			[SCSPTR]	=3D { 0x10, 16 },
> +			[SCLSR]		=3D { 0x12, 16 },
> +		},
> +		.fifosize =3D 16,
> +		.overrun_reg =3D SCLSR,
> +		.overrun_mask =3D SCLSR_ORER,
> +		.sampling_rate_mask =3D SCI_SR(32),
> +		.error_mask =3D SCIF_DEFAULT_ERROR_MASK,
> +		.error_clear =3D SCIF_ERROR_CLEAR,
> +	},
> +
>  	/*
>  	 * Common SH-3 SCIF definitions.
>  	 */
> @@ -3110,6 +3137,10 @@ static const struct of_device_id of_sci_match[] =
=3D
> {
>  		.compatible =3D "renesas,scif-r7s72100",
>  		.data =3D SCI_OF_DATA(PORT_SCIF,
> SCIx_SH2_SCIF_FIFODATA_REGTYPE),
>  	},
> +	{
> +		.compatible =3D "renesas,scif-r7s9210",
> +		.data =3D SCI_OF_DATA(PORT_SCIF, SCIx_RZ_SCIFA_REGTYPE),
> +	},
>  	/* Family-specific types */
>  	{
>  		.compatible =3D "renesas,rcar-gen1-scif",
> diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
> index c0e795d95477daea..1c89611e0e0634ae 100644
> --- a/include/linux/serial_sci.h
> +++ b/include/linux/serial_sci.h
> @@ -36,6 +36,7 @@ enum {
>  	SCIx_SH4_SCIF_FIFODATA_REGTYPE,
>  	SCIx_SH7705_SCIF_REGTYPE,
>  	SCIx_HSCIF_REGTYPE,
> +	SCIx_RZ_SCIFA_REGTYPE,
>=20
>  	SCIx_NR_REGTYPES,
>  };
> --
> 2.17.1
