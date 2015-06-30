From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/9] arm: twr-k70f120m: clock driver for Kinetis SoC
Date: Tue, 30 Jun 2015 22:36:38 +0200
Message-ID: <28154735.0HeJqZBqop@wuerfel>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl> <1435667250-28299-4-git-send-email-pawelo@king.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435667250-28299-4-git-send-email-pawelo@king.net.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Osmialowski <pawelo@king.net.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Slaby <jslaby@suse.cz>, Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Sergei Poselenov <sposelenov@emcraft.com>, Paul Bolle <pebolle@tiscali.nl>, Jingchang Lu <jingchang.lu@freescale.com>, Yuri Tikhonov <yur@emcraft.com>Rob
List-Id: linux-serial@vger.kernel.org

On Tuesday 30 June 2015 14:27:24 Paul Osmialowski wrote:
> Based on K70P256M150SF3RM.pdf K70 Sub-Family Reference Manual, Rev. 3.
> 
> Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>
> ---
>  .../devicetree/bindings/clock/kinetis-clock.txt    |  63 +++
>  arch/arm/boot/dts/kinetis.dtsi                     |  36 ++
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/clk-kinetis.c                          | 463 +++++++++++++++++++++
>  4 files changed, 563 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/kinetis-clock.txt
>  create mode 100644 drivers/clk/clk-kinetis.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/kinetis-clock.txt b/Documentation/devicetree/bindings/clock/kinetis-clock.txt
> new file mode 100644
> index 0000000..63af6a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/kinetis-clock.txt
> @@ -0,0 +1,63 @@
> +* Clock bindings for Freescale Kinetis SoC
> +
> +Required properties:
> +- compatible: Should be "fsl,kinetis-cmu".
> +- reg: Two address ranges, one for the Clock Genetator register set,
> +	one for System Integration Module register set.
> +- Set of clock devices: one fixed-rate-root, fixed-rate clocks and clock-gates.
> +
> +For clock-gate addresses see K70 Sub-Family Reference Manual, Rev. 3 pg. 341
> +and later. Notice that addresses are zero-based, so SIM_SCGC1 has address 0,
> +SIM_SCGC2 has address 1 and so on. The second address component is the bit
> +index.

Please document the sub-nodes that are allowed, and the format
of the clock specifiers.

> +
> +Example:
> +
> +cmu@40064000 {
> +	compatible = "fsl,kinetis-cmu";
> +	reg = <0x40064000 0x14>, <0x40047000 0x1100>;
> +
> +	mcg_outclk: fixed-rate-root@mcgout {
> +		device_type = "mcgout";
> +		#clock-cells = <0>;
> +	};
> +
> +	mcg_cclk: fixed-rate@cclk {

'@' is a reserved character here that is used before the address
of the device, so this has to be a hexadecimal number without leading
'0x', and it should match the 'reg' property of the device.

> +		device_type = "cclk";
> +		#clock-cells = <0>;
> +		clocks = <&mcg_outclk>;
> +	};

The device_type property here is not a standard identifier,
and you don't list it as an optional or mandatory property.

Please remove it and instead use the compatible property, the
name or the address.

	Arnd
