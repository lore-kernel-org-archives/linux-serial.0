From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/3] serial: sh-sci: Add OF support
Date: Mon, 04 Mar 2013 17:20:49 +0100
Message-ID: <5345836.ZO7uU35cQD@wuerfel>
References: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Bastian Hecht <hechtb@gmail.com>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Monday 04 March 2013 17:20:52 Bastian Hecht wrote:
> diff --git a/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
> new file mode 100644
> index 0000000..6ad1adf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
> @@ -0,0 +1,53 @@
> +* Renesas SH-Mobile Serial Communication Interface
> +
> +Required properties:
> +- compatible : Should be "renesas,sci-<port type>-uart", where <port type> may be
> +  SCI, SCIF, IRDA, SCIFA or SCIFB.

Why capital letters here? Maybe just list

	"renesas,sci-uart", "renesas,scif-uart", ...

> +- reg : Address and length of the register set for the device
> +- interrupts : Should contain the following IRQs: ERI, RXI, TXI and BRI.

You probably want to require the "interrupt-names" property as well
then.

> +- cell-index : The device id.
> +- renesas,scscr : Should contain a bitfield used by the Serial Control Register.
> +  b7 = SCSCR_TIE
> +  b6 = SCSCR_RIE
> +  b5 = SCSCR_TE
> +  b4 = SCSCR_RE
> +  b3 = SCSCR_REIE
> +  b2 = SCSCR_TOIE
> +  b1 = SCSCR_CKE1
> +  b0 = SCSCR_CKE0
> +- renesas,scbrr-algo-id : Algorithm ID for the Bit Rate Register
> +  1 = SCBRR_ALGO_1 ((clk + 16 * bps) / (16 * bps) - 1)
> +  2 = SCBRR_ALGO_2 ((clk + 16 * bps) / (32 * bps) - 1)
> +  3 = SCBRR_ALGO_3 (((clk * 2) + 16 * bps) / (16 * bps) - 1)
> +  4 = SCBRR_ALGO_4 (((clk * 2) + 16 * bps) / (32 * bps) - 1)
> +  5 = SCBRR_ALGO_5 (((clk * 1000 / 32) / bps) - 1)

Maybe replace this with a "clock-frequency" property? This may
be what the registers contain, but it is not very readable.

> +Optional properties:
> +- renesas,autoconf : Set if device is capable of auto configuration
> +- renesas,regtype : Overwrite the register layout. In most cases you can rely
> +  on auto-probing (omit this property or set to 0) but some legacy devices
> +  use a non-default register layout. Possible layouts are
> +  0 = SCIx_PROBE_REGTYPE (default)
> +  1 = SCIx_SCI_REGTYPE
> +  2 = SCIx_IRDA_REGTYPE
> +  3 = SCIx_SCIFA_REGTYPE
> +  4 = SCIx_SCIFB_REGTYPE
> +  5 = SCIx_SH2_SCIF_FIFODATA_REGTYPE
> +  6 = SCIx_SH3_SCIF_REGTYPE
> +  7 = SCIx_SH4_SCIF_REGTYPE
> +  8 = SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE
> +  9 = SCIx_SH4_SCIF_FIFODATA_REGTYPE
> + 10 = SCIx_SH7705_SCIF_REGTYPE

Why do you keep these separate from the "compatible" property?
By definition, the register layout is already determined by
"compatible".

> +#ifdef CONFIG_OF
> +static const struct of_device_id of_sci_match[] = {
> +	{ .compatible = "renesas,sci-SCI-uart",
> +		.data = (void *)PORT_SCI },
> +	{ .compatible = "renesas,sci-SCIF-uart",
> +		.data = (void *)PORT_SCIF },
> +	{ .compatible = "renesas,sci-IRDA-uart",
> +		.data = (void *)PORT_IRDA },
> +	{ .compatible = "renesas,sci-SCIFA-uart",
> +		.data = (void *)PORT_SCIFA },
> +	{ .compatible = "renesas,sci-SCIFB-uart",
> +		.data = (void *)PORT_SCIFB },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_sci_match);
> +
> +static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
> +								int *dev_id)
> +{
> +	struct plat_sci_port *p;
> +	struct device_node *np = pdev->dev.of_node;
> +	const struct of_device_id *match;
> +	struct resource *res;
> +	const __be32 *prop;
> +	int i, irq, val;
> +

You can remove the #ifdef by replacing it with 

	if (!IS_ENABLED(CONFIG_OF) || !np)
		return NULL;

here. This gives better compile time coverage and more readable code.

Otherwise looks very nice!

	Arnd
