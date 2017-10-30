From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 16/16] arm64: dts: marvell: armada-3720-espressobin: fill UART nodes
Date: Mon, 30 Oct 2017 16:46:13 +0100
Message-ID: <87fua01vwa.fsf@free-electrons.com>
References: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
        <20171013090200.31034-17-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171013090200.31034-17-miquel.raynal@free-electrons.com>
        (Miquel Raynal's message of "Fri, 13 Oct 2017 11:02:00 +0200")
Sender: linux-gpio-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jiri Slaby <jslaby@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Miquel,
 
 On ven., oct. 13 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> Fill ESPRESSObin uart0 node with pinctrl information like in the
> Armada-3720-DB device tree (which uses the same node).
>
> Also explain how to enable the second UART port available on the
> headers. This second port is not enabled by default because both
> headers are dedicated to expose general purpose pins and remapping
> some of them to use the second UART would break existing users.
>
> Suggested-by: László ÁSHIN <laszlo@ashin.hu>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>
> Changes since v1: comment about UART1 node.
>
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> index 2ce52ba74f73..bdfb5553ddb5 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> @@ -98,9 +98,21 @@
>  
>  /* Exported on the micro USB connector J5 through an FTDI */
>  &uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>;
>  	status = "okay";
>  };
>  
> +/*
> + * Connector J17 and J18 expose a number of different features. Some pins are
> + * multiplexed. This is the case for instance for the following features:
> + * - UART1 (pin 24 = RX, pin 26 = TX). See armada-3720-db.dts for an example of
> + *   how to enable it. Beware that the signals are 1.8V TTL.
> + * - I2C
> + * - SPI
> + * - MMC
> + */
> +
>  /* J7 */
>  &usb3 {
>  	status = "okay";
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
