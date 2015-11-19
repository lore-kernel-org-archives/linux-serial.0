From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 17/25] serial: sh-sci: Correct SCIF type on R-Car for BRG
Date: Thu, 19 Nov 2015 22:55:22 +0200
Message-ID: <1764695.P2DCFfYC1V@avalon>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be> <1447958344-836-18-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447958344-836-18-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thursday 19 November 2015 19:38:56 Geert Uytterhoeven wrote:
> The "renesas,scif" compatible value is currently used for the SCIF
> variant in all Renesas SoCs of the R-Car family.  However, the variant
> used in the R-Car family is not the common "SH-4(A)" variant, but a
> derivative with added "Baud Rate Generator for External Clock" (BRG),
> which is also present in sh7734.

Time to introduce a "renesas,scif-rcar" compatible string ? ;-)

As the only DT-enabled platform to have a different SCIF type is r7s72100 we 
could also consider just switching the regtype to SCIx_SH4_SCIF_BRG_REGTYPE 
for the generic "renesas,scif" entry as it's listed after the "renesas,scif-
r7s72100" entry. That might cause an issue if we want to enable DT on arch/sh 
though, but even if that happens due to the J-Core processors I'd be surprised 
to see the old Renesas SH platforms being moved to DT.

> Use the (already documented) SoC-specific SCIF compatible values for all
> supported R-Car Gen1, Gen2, and Gen3 SoCs to differentiate.  The
> "renesas,scif" compatible value can still be used as a common
> denominator for SCIF variants with the "SH-4(A)" register layout (i.e.
> ignoring the "Serial Extension Mode Register" (SCEMR) and the new
> BRG-specific registers).
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/sh-sci.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index b0127f38af744fcf..726c96d5a511c222 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2605,6 +2605,30 @@ static const struct of_device_id of_sci_match[] = {
>  	{
>  		.compatible = "renesas,scif-r7s72100",
>  		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH2_SCIF_FIFODATA_REGTYPE),
> +	}, {
> +		.compatible = "renesas,scif-r8a7778",
> +		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
> +	}, {
> +		.compatible = "renesas,scif-r8a7779",
> +		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
> +	}, {
> +		.compatible = "renesas,scif-r8a7790",
> +		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
> +	}, {
> +		.compatible = "renesas,scif-r8a7791",
> +		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
> +	}, {
> +		.compatible = "renesas,scif-r8a7792",
> +		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
> +	}, {
> +		.compatible = "renesas,scif-r8a7793",
> +		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
> +	}, {
> +		.compatible = "renesas,scif-r8a7794",
> +		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
> +	}, {
> +		.compatible = "renesas,scif-r8a7795",
> +		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
>  	},
>  	/* Generic types */
>  	{

-- 
Regards,

Laurent Pinchart
