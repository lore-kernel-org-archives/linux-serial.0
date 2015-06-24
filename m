From: Paul Osmialowski <pawelo@king.net.pl>
Subject: Re: [PATCH 5/9] arm: twr-k70f120m: basic support for Kinetis
 TWR-K70F120M
Date: Wed, 24 Jun 2015 06:42:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1506240627020.24366@localhost.localdomain>
References: <1435094387-20146-1-git-send-email-pawelo@king.net.pl> <1435094387-20146-6-git-send-email-pawelo@king.net.pl> <3935594.UmXqE2ND2k@wuerfel>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3935594.UmXqE2ND2k@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Osmialowski <pawelo@king.net.pl>, Andrew Morton <akpm@linux-foundation.org>, Anson Huang <b20788@freescale.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Frank Li <Frank.Li@freescale.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingchang Lu <jingchang.lu@freescale.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, Kumar Gala <galak@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <damm+renesas@opensource.se>, Michael Turquette <mturquette@baylibre.com>, Nathan Lynch <nathan_lynch@mentor.com>, Nic
List-Id: linux-serial@vger.kernel.org

Hi Arnd,

Thanks for all of your input. Your comments will all be considered during 
my works on the second iteration of this patchset.

On Wed, 24 Jun 2015, Arnd Bergmann wrote:

> On Tuesday 23 June 2015 23:19:43 Paul Osmialowski wrote:
>> @@ -1740,7 +1752,7 @@ source "mm/Kconfig"
>>  config FORCE_MAX_ZONEORDER
>>  	int "Maximum zone order" if ARCH_SHMOBILE_LEGACY
>>  	range 11 64 if ARCH_SHMOBILE_LEGACY
>> -	default "12" if SOC_AM33XX
>> +	default "12" if SOC_AM33XX || ARCH_KINETIS
>>  	default "9" if SA1111 || ARCH_EFM32
>>  	default "11"
>>  	help
>
> Put it in the defconfig?
>
>> +#
>> +
>> +obj-$(CONFIG_MACH_KINETIS)	+= kinetis_platform.o
>
> just use
>
> obj-y	+= kinetis.o
>
>> diff --git a/arch/arm/mach-kinetis/include/mach/idle.h b/arch/arm/mach-kinetis/include/mach/idle.h
>> new file mode 100644
>> index 0000000..0aafefd
>> --- /dev/null
>> +++ b/arch/arm/mach-kinetis/include/mach/idle.h
>
> No mach/*.h files please.
>
>> +/*
>> + * This Kinetis port assumes that the CPU works in little-endian mode.
>> + * Switching to big-endian will require different bit offsets in peripheral
>> + * devices' registers. Also, some bit groups may lay on byte edges, so issue
>> + * with big-endian cannot be fixed only by defining bit offsets differently
>> + * for the big-endian mode.
>> + */
>> +#ifndef __LITTLE_ENDIAN
>> +#error This Kinetis port assumes that the CPU works in little-endian mode
>> +#endif
>
> Fix the drivers instead?
>
>> +/*
>> + * Peripheral memory map
>> + */
>> +#define KINETIS_AIPS0PERIPH_BASE	0x40000000
>> +#define KINETIS_AIPS1PERIPH_BASE	0x40080000
>
> Move it into DT
>
>> +/*
>> + * System Integration Module (SIM) register map
>> + *
>> + * This map actually covers two hardware modules:
>> + *     1. SIM low-power logic, at 0x40047000
>> + *     2. System integration module (SIM), at 0x40048000
>> + */
>> +struct kinetis_sim_regs {
>> +	u32 sopt1;	/* System Options Register 1 */
>> +	u32 rsv0[1024];
>> +	u32 sopt2;	/* System Options Register 2 */
>> +	u32 rsv1;
>> +	u32 sopt4;	/* System Options Register 4 */
>> +	u32 sopt5;	/* System Options Register 5 */
>> +	u32 sopt6;	/* System Options Register 6 */
>> +	u32 sopt7;	/* System Options Register 7 */
>> +	u32 rsv2[2];
>> +	u32 sdid;	/* System Device Identification Register */
>> +	u32 scgc[KINETIS_SIM_CG_NUMREGS];	/* Clock Gating Regs 1...7 */
>> +	u32 clkdiv1;	/* System Clock Divider Register 1 */
>> +	u32 clkdiv2;	/* System Clock Divider Register 2 */
>> +	u32 fcfg1;	/* Flash Configuration Register 1 */
>> +	u32 fcfg2;	/* Flash Configuration Register 2 */
>> +	u32 uidh;	/* Unique Identification Register High */
>> +	u32 uidmh;	/* Unique Identification Register Mid-High */
>> +	u32 uidml;	/* Unique Identification Register Mid Low */
>> +	u32 uidl;	/* Unique Identification Register Low */
>> +	u32 clkdiv3;	/* System Clock Divider Register 3 */
>> +	u32 clkdiv4;	/* System Clock Divider Register 4 */
>> +	u32 mcr;	/* Misc Control Register */
>> +};
>
> Move it into the driver that uses these.
>
>> +/*
>> + * SIM registers base
>> + */
>> +#define KINETIS_SIM_BASE		(KINETIS_AIPS0PERIPH_BASE + 0x00047000)
>> +#define KINETIS_SIM_PTR(reg) \
>> +	(&(((struct kinetis_sim_regs *)(KINETIS_SIM_BASE))->reg))
>> +#define KINETIS_SIM_RD(reg) readl_relaxed(KINETIS_SIM_PTR(reg))
>> +#define KINETIS_SIM_WR(reg, val) writel_relaxed((val), KINETIS_SIM_PTR(reg))
>> +#define KINETIS_SIM_SET(reg, mask) \
>> +	KINETIS_SIM_WR(reg, (KINETIS_SIM_RD(reg)) | (mask))
>> +#define KINETIS_SIM_RESET(reg, mask) \
>> +	KINETIS_SIM_WR(reg, (KINETIS_SIM_RD(reg)) & (~(mask)))
>> +#define KINETIS_SIM_ISSET(reg, mask) \
>> +	(KINETIS_SIM_RD(reg) & (mask))
>> +
>> +/*
>> + * SIM registers
>> + */
>> +/*
>> + * System Options Register 2
>> + */
>> +/* USB HS clock source select */
>> +#define KINETIS_SIM_SOPT2_USBHSRC_BITS	2
>> +#define KINETIS_SIM_SOPT2_USBHSRC_MSK	(3 << KINETIS_SIM_SOPT2_USBHSRC_BITS)
>> +#define KINETIS_SIM_SOPT2_USBHSRC_PLL0	(1 << KINETIS_SIM_SOPT2_USBHSRC_BITS)
>> +#define KINETIS_SIM_SOPT2_USBHSRC_PLL1	(2 << KINETIS_SIM_SOPT2_USBHSRC_BITS)
>> +
>> +/* USB FS clock source select */
>> +#define KINETIS_SIM_SOPT2_USBFSRC_BITS	22
>> +#define KINETIS_SIM_SOPT2_USBFSRC_MSK	(3 << KINETIS_SIM_SOPT2_USBFSRC_BITS)
>> +#define KINETIS_SIM_SOPT2_USBFSRC_PLL0	(1 << KINETIS_SIM_SOPT2_USBFSRC_BITS)
>> +#define KINETIS_SIM_SOPT2_USBFSRC_PLL1	(2 << KINETIS_SIM_SOPT2_USBFSRC_BITS)
>> +#define KINETIS_SIM_SOPT2_USBF_CLKSEL	(1 << 18)
>> +
>
> remove all these here.
>
>> +/*
>> + * Map required regions.
>> + * This being the no-MMU Linux, I am not mapping anything
>> + * since all I/O registers are available at their physical addresses.
>> + */
>> +static void __init kinetis_map_io(void)
>> +{
>> +}
>
> Not needed, remove.
>
>> +/*
>> + * Freescale Kinetis platform initialization
>> + */
>> +static void __init kinetis_init(void)
>> +{
>> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>> +}
>
> same here.
>
>> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
>> index 2ed1b8a..1d05516 100644
>> --- a/arch/arm/tools/mach-types
>> +++ b/arch/arm/tools/mach-types
>> @@ -554,6 +554,7 @@ smdk4412		MACH_SMDK4412		SMDK4412		3765
>>  marzen			MACH_MARZEN		MARZEN			3790
>>  krome			MACH_KROME		KROME			3797
>>  armadillo800eva		MACH_ARMADILLO800EVA	ARMADILLO800EVA		3863
>> +kinetis			MACH_KINETIS		KINETIS			3896
>>  mx53_umobo		MACH_MX53_UMOBO		MX53_UMOBO		3927
>>  mt4			MACH_MT4		MT4			3981
>>  u8520			MACH_U8520		U8520			3990
>
> Unused, please remove.
>
> 	Arnd
>
