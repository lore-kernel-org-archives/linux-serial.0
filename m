From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 4/9] arm: twr-k70f120m: timer driver for Kinetis SoC
Date: Tue, 30 Jun 2015 22:43:52 +0200
Message-ID: <2939807.q7WvOoYzDX@wuerfel>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl> <1435667250-28299-5-git-send-email-pawelo@king.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435667250-28299-5-git-send-email-pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Paul Osmialowski <pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sergei Poselenov <sposelenov-qv+LCo8X3VpBDgjK7y7TUQ@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Jingchang Lu <jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Yuri Tikhonov <yur-qv+LCo8X3VpBDgjK7y7TUQ@public.gmane.org>Rob
List-Id: linux-serial@vger.kernel.org

On Tuesday 30 June 2015 14:27:25 Paul Osmialowski wrote:

> +Example:
> +
> +aliases {
> +	pit0 = &pit0;
> +	pit1 = &pit1;
> +	pit2 = &pit2;
> +	pit3 = &pit3;
> +};
> +
> +pit@40037000 {
> +	compatible = "fsl,kinetis-pit-timer";
> +	reg = <0x40037000 0x100>;
> +	clocks = <&mcg_pclk_gate 5 23>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges;

All the subnodes seem to fall inside of the device's own register
area, so I think it would be nicer to use a specific 'ranges'
property that only translates the registers in question.

>  / {
> +	aliases {
> +		pit0 = &pit0;
> +		pit1 = &pit1;
> +		pit2 = &pit2;
> +		pit3 = &pit3;
> +	};
> +
>  	soc {
> +		pit@40037000 {
> +			compatible = "fsl,kinetis-pit-timer";
> +			reg = <0x40037000 0x100>;
> +			clocks = <&mcg_pclk_gate 5 23>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			pit0: timer@40037100 {
> +				reg = <0x40037100 0x10>;
> +				interrupts = <68>;
> +				status = "disabled";
> +			};

I don't think it's necessary to have both an alias
and a label here. What do you use the alias for?

> +
> +#define KINETIS_PITMCR_PTR(base, reg) \
> +	(&(((struct kinetis_pit_mcr_regs *)(base))->reg))
> +#define KINETIS_PITMCR_RD(be, base, reg) \
> +		((be) ? ioread32be(KINETIS_PITMCR_PTR(base, reg)) \
> +		      : ioread32(KINETIS_PITMCR_PTR(base, reg)))
> +#define KINETIS_PITMCR_WR(be, base, reg, val) do { \
> +		if (be) \
> +			iowrite32be((val), KINETIS_PITMCR_PTR(base, reg)); \
> +		else \
> +			iowrite32((val), KINETIS_PITMCR_PTR(base, reg)); \
> +	} while (0)

These should really be written as inline functions. Can you
explain why you need to deal with a big-endian version of this
hardware? Can you configure the endianess of this register block
and just set it to one of the two at boot time?

> +#define KINETIS_PIT_PTR(base, reg) \
> +	(&(((struct kinetis_pit_channel_regs *)(base))->reg))
> +#define KINETIS_PIT_RD(be, base, reg) \
> +		((be) ? ioread32be(KINETIS_PIT_PTR(base, reg)) \
> +		      : ioread32(KINETIS_PIT_PTR(base, reg)))
> +#define KINETIS_PIT_WR(be, base, reg, val) do { \
> +		if (be) \
> +			iowrite32be((val), KINETIS_PIT_PTR(base, reg)); \
> +		else \
> +			iowrite32((val), KINETIS_PIT_PTR(base, reg)); \
> +	} while (0)
> +#define KINETIS_PIT_SET(be, base, reg, mask) \
> +		KINETIS_PIT_WR(be, base, reg, \
> +			KINETIS_PIT_RD(be, base, reg) | (mask))
> +#define KINETIS_PIT_RESET(be, base, reg, mask) \
> +		KINETIS_PIT_WR(be, base, reg, \
> +			KINETIS_PIT_RD(be, base, reg) & (~(mask)))


Functions again. Also, just pass a pointer to your own data structure
into the function, instead of the 'be' and 'base' values.

The 'set' and 'reset' functions look like they need a spinlock
to avoid races.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
