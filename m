From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5] serial: sh-sci: Add OF support - incremental
Date: Tue, 5 Mar 2013 19:28:50 +0000
Message-ID: <201303051928.50331.arnd@arndb.de>
References: <1362490239-17848-1-git-send-email-hechtb+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1362490239-17848-1-git-send-email-hechtb+renesas@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tuesday 05 March 2013, Bastian Hecht wrote:
> This is an incremental patch to the "[PATCH v4 1/3] serial: sh-sci: Add
> OF support" implementing suggestions from Arnd.
> 
> - The compatible pattern has been reworked to include devices with
>   legacy register sets.
> - DT property interrupt-names added
> - Renamed renesas,scbrr-algo-id into renesas,clock-algorithm
> - Replaced #ifdef CONFIG_OF with
>   +       if (!IS_ENABLED(CONFIG_OF) || !np)
>   +                               return NULL;
> 
> I opted to show the changes in an incremental patch as it may be easier
> to follow the changes and as Paul has the v3 already in his repo.

Ok, makes sense.

> -	sci@0xe6c50000 {
> -		compatible = "renesas,sci-SCIFA-uart";
> +	sci@e6c50000 {
> +		compatible = "renesas,sci-scifa-serial";

As mentioned, I meant the name to be changed, not the compatible value.

> +	{ .compatible = "renesas,sci-sci-serial",
> +		.data = (void *)SCIx_SCI_REGTYPE },
> +	{ .compatible = "renesas,sci-scif-serial",
> +		.data = (void *)SCIx_SH4_SCIF_REGTYPE, },
> +	{ .compatible = "renesas,sci-irda-serial",
> +		.data = (void *)SCIx_IRDA_REGTYPE },
> +	{ .compatible = "renesas,sci-scifa-serial",
> +		.data = (void *)SCIx_SCIFA_REGTYPE },
> +	{ .compatible = "renesas,sci-scifb-serial",
> +		.data = (void *)SCIx_SCIFB_REGTYPE },
> +	{ .compatible = "renesas,sci-sh2_scif_fifodata-serial",
> +		.data = (void *)SCIx_SH2_SCIF_FIFODATA_REGTYPE },
> +	{ .compatible = "renesas,sci-sh3_scif-serial",
> +		.data = (void *)SCIx_SH3_SCIF_REGTYPE },
> +	{ .compatible = "renesas,sci-sh4_scif-serial",
> +		.data = (void *)SCIx_SH4_SCIF_REGTYPE },
> +	{ .compatible = "renesas,sci-sh4_scif_no_scsptr-serial",
> +		.data = (void *)SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE },
> +	{ .compatible = "renesas,sci-sh4_scif_fifodata-serial",
> +		.data = (void *)SCIx_SH4_SCIF_FIFODATA_REGTYPE },
> +	{ .compatible = "renesas,sci-sh7705_scif-serial",
> +		.data = (void *)SCIx_SH7705_SCIF_REGTYPE },
>  	{},

Ah nice, it's not even more complex than before.

Looks good,

Acked-by: Arnd Bergmann <arnd@arndb.de>
