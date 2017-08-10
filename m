From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: serial: Add MediaTek BTIF controller
 bindings
Date: Thu, 10 Aug 2017 11:27:52 -0500
Message-ID: <20170810162752.2xncymekrhu544g7@rob-hp-laptop>
References: <cover.1501692369.git.sean.wang@mediatek.com>
 <6b2ad0dc976259563562e7ab23abdacf68c94aa5.1501692369.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6b2ad0dc976259563562e7ab23abdacf68c94aa5.1501692369.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, andriy.shevchenko@linux.intel.com, jan.kiszka@siemens.com, heikki.krogerus@linux.intel.com, hpeter@gmail.com, vigneshr@ti.com, matthias.bgg@gmail.com, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 03, 2017 at 01:05:22AM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Document the devicetree bindings for MediaTek BTIF controller
> which could be found on MT7622 and MT7623 SoC.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../devicetree/bindings/serial/mtk-btif.txt        | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/mtk-btif.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/mtk-btif.txt b/Documentation/devicetree/bindings/serial/mtk-btif.txt
> new file mode 100644
> index 0000000..80c1f5a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/mtk-btif.txt
> @@ -0,0 +1,26 @@
> +Device-Tree bindings for MediaTek BTIF controller found on those
> +MediaTek SoCs with Bluetooth feature
> +
> +Required properties:
> +- compatible: Should be one of:
> +	- "mediatek,mt7622-btif" : for MT7622 SoC
> +	- "mediatek,mt7623-btif" : for MT7623 SoC
> +- reg: The base address of the BTIF register bank;
> +- interrupts: A single interrupt specifier;
> +- clocks: list of clock specifiers, corresponding to
> +	  entries in clock-names property;
> +- clock-names: should contain "main" entries.
> +
> +Optional properties:
> +- mediatek,loopback: Boolean; if defined, indicates that BTIF controller
> +	running on the loopback mode.

I don't think this belongs in DT, but should be a module param or sysfs 
control.

> +
> +Example:
> +
> +	btif: btif@1100c000 {

bluetooth@...

> +		compatible = "mediatek,mt7623-btif";
> +		reg = <0 0x1100c000 0 0x1000>;
> +		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&pericfg CLK_PERI_BTIF>;
> +		clock-names = "main";
> +	};
> -- 
> 2.7.4
> 
