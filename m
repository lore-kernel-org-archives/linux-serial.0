From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: mediatek: add UART dts for mt8127 and mt8135
Date: Fri, 2 Jan 2015 11:23:36 +0100
Message-ID: <CABuKBeJ-bBiJSbh9jKH1+T2MhKCjxnkryStrhG_kFX7HuBnevQ@mail.gmail.com>
References: <1413983529-21887-1-git-send-email-eddie.huang@mediatek.com>
	<1413983529-21887-3-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413983529-21887-3-git-send-email-eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?B?WUggQ2hlbiAo6Zmz5pix6LGqKQ==?= <yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, HC Yen <hc.yen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Nathan Chung <nathan.chung-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

2014-10-22 15:12 GMT+02:00 Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>:
> This add dts support for mt8127 and mt8135 SOC UART
>
> Signed-off-by: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  arch/arm/boot/dts/mt8127.dtsi | 34 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/mt8135.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+)
>
> diff --git a/arch/arm/boot/dts/mt8127.dtsi b/arch/arm/boot/dts/mt8127.dtsi
> index 25c9f69..249c218 100644
> --- a/arch/arm/boot/dts/mt8127.dtsi
> +++ b/arch/arm/boot/dts/mt8127.dtsi
> @@ -64,6 +64,12 @@
>                         clock-frequency = <32000>;
>                         #clock-cells = <0>;
>                 };
> +
> +               uart_clk: dummy26m {
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <26000000>;
> +                       #clock-cells = <0>;
> +                };
>         };
>
>         soc {
> @@ -89,5 +95,33 @@
>                               <0 0x10214000 0 0x2000>,
>                               <0 0x10216000 0 0x2000>;
>                 };
> +
> +               uart0: serial@11006000 {
> +                       compatible = "mediatek,mt8127-uart","mediatek,mt6577-uart";
> +                       reg = <0 0x11002000 0 0x400>;
> +                       interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&uart_clk>;
> +               };
> +
> +               uart1: serial@11007000 {
> +                       compatible = "mediatek,mt8127-uart","mediatek,mt6577-uart";
> +                       reg = <0 0x11003000 0 0x400>;
> +                       interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&uart_clk>;
> +               };
> +
> +               uart2: serial@11008000 {
> +                       compatible = "mediatek,mt8127-uart","mediatek,mt6577-uart";
> +                       reg = <0 0x11004000 0 0x400>;
> +                       interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&uart_clk>;
> +               };
> +
> +               uart3: serial@11009000 {
> +                       compatible = "mediatek,mt8127-uart","mediatek,mt6577-uart";
> +                       reg = <0 0x11005000 0 0x400>;
> +                       interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&uart_clk>;
> +               };
>         };
>  };
> diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
> index 90a56ad..683b761 100644
> --- a/arch/arm/boot/dts/mt8135.dtsi
> +++ b/arch/arm/boot/dts/mt8135.dtsi
> @@ -86,6 +86,13 @@
>                         clock-frequency = <32000>;
>                         #clock-cells = <0>;
>                 };
> +
> +               uart_clk: dummy26m {
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <26000000>;
> +                       #clock-cells = <0>;
> +               };
> +
>         };
>
>         soc {
> @@ -111,5 +118,34 @@
>                               <0 0x10214000 0 0x2000>,
>                               <0 0x10216000 0 0x2000>;
>                 };
> +
> +               uart0: serial@11006000 {
> +                       compatible = "mediatek,mt8135-uart","mediatek,mt6577-uart";
> +                       reg = <0 0x11006000 0 0x400>;
> +                       interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&uart_clk>;
> +               };
> +
> +               uart1: serial@11007000 {
> +                       compatible = "mediatek,mt8135-uart","mediatek,mt6577-uart";
> +                       reg = <0 0x11007000 0 0x400>;
> +                       interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&uart_clk>;
> +               };
> +
> +               uart2: serial@11008000 {
> +                       compatible = "mediatek,mt8135-uart","mediatek,mt6577-uart";
> +                       reg = <0 0x11008000 0 0x400>;
> +                       interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&uart_clk>;
> +               };
> +
> +               uart3: serial@11009000 {
> +                       compatible = "mediatek,mt8135-uart","mediatek,mt6577-uart";
> +                       reg = <0 0x11009000 0 0x400>;
> +                       interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&uart_clk>;
> +               };
> +
>         };
>  };
> --
> 1.8.1.1.dirty
>

Applied to v3.20-next/dts, thanks.

-- 
motzblog.wordpress.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
