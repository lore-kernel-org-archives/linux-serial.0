From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 3/6] serial: 8250_omap: Add support for AM654 UART
 controller
Date: Tue, 12 Jun 2018 15:06:41 -0600
Message-ID: <20180612210640.GA20728@rob-hp-laptop>
References: <20180605060125.9518-1-nm@ti.com>
 <20180605060125.9518-4-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180605060125.9518-4-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>, Tero Kristo <t-kristo@ti.com>, Russell King <linux@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 05, 2018 at 01:01:22AM -0500, Nishanth Menon wrote:
> AM654 uses a UART controller that is compatible (partially) with
> existing 8250 UART, however, has a few differences with respect to DMA
> support and control paths. Introduce a base definition that allows us
> to build up the differences in follow on patches.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
>  drivers/tty/serial/8250/8250_omap.c                      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
> index 4b0f05adb228..c35d5ece1156 100644
> --- a/Documentation/devicetree/bindings/serial/omap_serial.txt
> +++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
> @@ -1,6 +1,7 @@
>  OMAP UART controller
>  
>  Required properties:
> +- compatible : should be "ti,am654-uart" for AM654 controllers

Not compatible with any existing TI 8250 UARTs?

>  - compatible : should be "ti,omap2-uart" for OMAP2 controllers
>  - compatible : should be "ti,omap3-uart" for OMAP3 controllers
>  - compatible : should be "ti,omap4-uart" for OMAP4 controllers
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 1b337fee07ed..a019286f8bb6 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1115,6 +1115,7 @@ static const u8 am3352_habit = OMAP_DMA_TX_KICK | UART_ERRATA_CLOCK_DISABLE;
>  static const u8 dra742_habit = UART_ERRATA_CLOCK_DISABLE;
>  
>  static const struct of_device_id omap8250_dt_ids[] = {
> +	{ .compatible = "ti,am654-uart" },
>  	{ .compatible = "ti,omap2-uart" },
>  	{ .compatible = "ti,omap3-uart" },
>  	{ .compatible = "ti,omap4-uart", .data = &omap4_habit, },
> -- 
> 2.15.1
> 
