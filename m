From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 7/9] arm: twr-k70f120m: use Freescale eDMA driver with Kinetis SoC
Date: Tue, 30 Jun 2015 22:49:11 +0200
Message-ID: <1650263.FfdEQKm1Bu@wuerfel>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl> <1435667250-28299-8-git-send-email-pawelo@king.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1435667250-28299-8-git-send-email-pawelo@king.net.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Osmialowski <pawelo@king.net.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Slaby <jslaby@suse.cz>, Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Sergei Poselenov <sposelenov@emcraft.com>, Paul Bolle <pebolle@tiscali.nl>, Jingchang Lu <jingchang.lu@freescale.com>, Yuri Tikhonov <yur@emcraft.com>Rob
List-Id: linux-serial@vger.kernel.org

On Tuesday 30 June 2015 14:27:28 Paul Osmialowski wrote:
> Note that <mach/memory.h> is needed (which is denoted by
> CONFIG_NEED_MACH_MEMORY_H) as it provides macros required for proper
> operation of DMA allocation functions.

You can't do this, it breaks compilation when multiple platforms
are enabled.

> Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>
> ---
>  arch/arm/Kconfig                            |  4 ++
>  arch/arm/boot/dts/kinetis.dtsi              | 34 ++++++++++++++++
>  arch/arm/mach-kinetis/include/mach/memory.h | 61 +++++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
>  create mode 100644 arch/arm/mach-kinetis/include/mach/memory.h
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index b21592b..8ccffee 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -971,6 +971,10 @@ config ARCH_KINETIS
>  	select CLKSRC_KINETIS
>  	select PINCTRL
>  	select PINCTRL_KINETIS
> +	select DMADEVICES
> +	select FSL_EDMA
> +	select DMA_OF
> +	select NEED_MACH_MEMORY_H

I think DMA_OF is implied by dmaengine support in combination with CONFIG_OF

> +
> +#ifndef _MACH_KINETIS_MEMORY_H
> +#define _MACH_KINETIS_MEMORY_H
> +
> +#ifndef __ASSEMBLY__
> +
> +/*
> + * On Kinetis K70, consistent DMA memory resides in a special
> + * DDRAM alias region (non-cacheable DDRAM at 0x80000000).
> + *
> + */
> +#define KINETIS_PHYS_DMA_OFFSET UL(0x80000000)
> +
> +/*
> + * Mask of the field used to distinguish DDRAM aliases
> + */
> +#define KINETIS_DRAM_ALIAS_MASK UL(0xf8000000)

This should be expressed using the 'dma-ranges' properties in the
bus nodes above any DMA master, the normal DMA mapping code will
then do the right thing.

	Arnd
