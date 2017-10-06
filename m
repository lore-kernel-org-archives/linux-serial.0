From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 01/16] dt-bindings: mvebu-uart: update documentation with extended UART
Date: Fri, 06 Oct 2017 14:17:28 +0200
Message-ID: <87376wh3mv.fsf@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
        <20171006101344.15590-2-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171006101344.15590-2-miquel.raynal@free-electrons.com> (Miquel
        Raynal's message of "Fri, 6 Oct 2017 12:13:29 +0200")
Sender: linux-gpio-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jiri Slaby <jslaby@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Miquel,
 
 On ven., oct. 06 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> Update the Device Tree binding documentation for the Marvell EBU UART,
> in order to allow describing the extended UART IP block, in addition to
> the already supported standard UART IP. This requires adding a new
> compatible string, the introduction of a clocks property, and extensions
> to the interrupts property.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory

> ---
>  .../devicetree/bindings/serial/mvebu-uart.txt      | 49 +++++++++++++++++++---
>  1 file changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/mvebu-uart.txt b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
> index d37fabe17bd1..3df3a3fab4bb 100644
> --- a/Documentation/devicetree/bindings/serial/mvebu-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
> @@ -1,13 +1,52 @@
> -* Marvell UART : Non standard UART used in some of Marvell EBU SoCs (e.g., Armada-3700)
> +* Marvell UART : Non standard UART used in some of Marvell EBU SoCs
> +                 e.g., Armada-3700.
>  
>  Required properties:
> -- compatible: "marvell,armada-3700-uart"
> +- compatible:
> +    - "marvell,armada-3700-uart" for the standard variant of the UART
> +      (32 bytes FIFO, no DMA, level interrupts, 8-bit access to the
> +      FIFO, baudrate limited to 230400).
> +    - "marvell,armada-3700-uart-ext" for the extended variant of the
> +      UART (128 bytes FIFO, DMA, front interrupts, 8-bit or 32-bit
> +      accesses to the FIFO, baudrate unlimited by the dividers).
>  - reg: offset and length of the register set for the device.
> -- interrupts: device interrupt
> +- clocks: UART reference clock used to derive the baudrate (only
> +      mandatory with "marvell,armada-3700-uart-ext" compatible).
> +- interrupts:
> +    - Must contain three elements for the standard variant of the IP
> +      (marvell,armada-3700-uart): "uart-sum", "uart-tx" and "uart-rx",
> +      respectively the UART sum interrupt, the UART TX interrupt and
> +      UART RX interrupt. A corresponding interrupt-names property must
> +      be defined.
> +    - Must contain two elements for the extended variant of the IP
> +      (marvell,armada-3700-uart-ext): "uart-tx" and "uart-rx",
> +      respectively the UART TX interrupt and the UART RX interrupt. A
> +      corresponding interrupts-names property must be defined.
> +    - For backward compatibility reasons, a single element interrupts
> +      property is also supported for the standard variant of the IP,
> +      containing only the UART sum interrupt. This form is deprecated
> +      and should no longer be used.
>  
>  Example:
> -	serial@12000 {
> +	uart0: serial@12000 {
>  		compatible = "marvell,armada-3700-uart";
>  		reg = <0x12000 0x200>;
> -		interrupts = <43>;
> +		clocks = <&xtalclk>;
> +		interrupts =
> +		<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "uart-sum", "uart-tx", "uart-rx";
> +		status = "disabled";
> +	};
> +
> +	uart1: serial@12200 {
> +		compatible = "marvell,armada-3700-uart-ext";
> +		reg = <0x12200 0x30>;
> +		clocks = <&xtalclk>;
> +		interrupts =
> +		<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
> +		<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "uart-tx", "uart-rx";
> +		status = "disabled";
>  	};
> -- 
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
