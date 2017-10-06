From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 14/16] arm64: dts: marvell: armada-37xx: add second UART port
Date: Fri, 06 Oct 2017 14:49:55 +0200
Message-ID: <87o9pke8zw.fsf@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
        <20171006101344.15590-15-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171006101344.15590-15-miquel.raynal@free-electrons.com>
        (Miquel Raynal's message of "Fri, 6 Oct 2017 12:13:42 +0200")
Sender: linux-gpio-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jiri Slaby <jslaby@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Wilson Ding <dingwei@marvell.com>
List-Id: linux-serial@vger.kernel.org

Hi Miquel,
 
 On ven., oct. 06 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> Add a node in Armada 37xx DTSI file for the second UART, with a
> different compatible due to its extended IP which has some
> differences with the first UART already in place.
>
> Make use of this commit to also fully describe the first port and
> use the same clear and named interrupt bindings for both ports.
>
> The standard UART (UART0) uses level-interrupts while the extended
> UART (UART1) uses edge-triggered interrupts.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index a36d667f770e..72b68f23c001 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -55,6 +55,7 @@
>  
>  	aliases {
>  		serial0 = &uart0;
> +		serial1 = &uart1;
>  	};
>  
>  	cpus {
> @@ -136,7 +137,22 @@
>  				compatible = "marvell,armada-3700-uart";
>  				reg = <0x12000 0x200>;
>  				clocks = <&xtalclk>;
> -				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupts =
> +				<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names = "uart-sum", "uart-tx", "uart-rx";
> +				status = "disabled";
> +			};
> +
> +			uart1: serial@12200 {
> +				compatible = "marvell,armada-3700-uart-ext";
> +				reg = <0x12200 0x30>;
> +				clocks = <&xtalclk>;
> +				interrupts =
> +				<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
> +				interrupt-names = "uart-tx", "uart-rx";
>  				status = "disabled";
>  			};
>  
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
