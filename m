From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: Re: [PATCH 10/14] ARM: lpc32xx: clean up header files
Date: Tue, 6 Aug 2019 16:16:10 -0400
Message-ID: <CA+rxa6pJkoccxJkS1Y7nQHiZHiNq5D+KM7+xS37vZa3dTCF31w@mail.gmail.com>
References: <20190731195713.3150463-1-arnd@arndb.de> <20190731195713.3150463-11-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731195713.3150463-11-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Guenter Roeck <linux@roeck-us.net>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-serial@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Linux
List-Id: linux-serial@vger.kernel.org

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

On Wed, Jul 31, 2019 at 4:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> All device drivers have stopped relying on mach/*.h headers,
> so move the remaining headers into arch/arm/mach-lpc32xx/lpc32xx.h
> to prepare for multiplatform builds.
>
> The mach/entry-macro.S file has been unused for a long time now
> and can simply get removed.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-lpc32xx/common.c                |  3 +-
>  .../mach-lpc32xx/include/mach/entry-macro.S   | 28 -------------------
>  arch/arm/mach-lpc32xx/include/mach/hardware.h | 25 -----------------
>  .../mach-lpc32xx/include/mach/uncompress.h    |  4 +--
>  .../{include/mach/platform.h => lpc32xx.h}    | 18 ++++++++++--
>  arch/arm/mach-lpc32xx/pm.c                    |  3 +-
>  arch/arm/mach-lpc32xx/serial.c                |  3 +-
>  arch/arm/mach-lpc32xx/suspend.S               |  3 +-
>  8 files changed, 21 insertions(+), 66 deletions(-)
>  delete mode 100644 arch/arm/mach-lpc32xx/include/mach/entry-macro.S
>  delete mode 100644 arch/arm/mach-lpc32xx/include/mach/hardware.h
>  rename arch/arm/mach-lpc32xx/{include/mach/platform.h => lpc32xx.h} (98%)
>
> diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
> index a475339333c1..304ea61a0716 100644
> --- a/arch/arm/mach-lpc32xx/common.c
> +++ b/arch/arm/mach-lpc32xx/common.c
> @@ -13,8 +13,7 @@
>  #include <asm/mach/map.h>
>  #include <asm/system_info.h>
>
> -#include <mach/hardware.h>
> -#include <mach/platform.h>
> +#include "lpc32xx.h"
>  #include "common.h"
>
>  /*
> diff --git a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
> deleted file mode 100644
> index eec0f5f7e722..000000000000
> --- a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * arch/arm/mach-lpc32xx/include/mach/entry-macro.S
> - *
> - * Author: Kevin Wells <kevin.wells@nxp.com>
> - *
> - * Copyright (C) 2010 NXP Semiconductors
> - */
> -
> -#include <mach/hardware.h>
> -#include <mach/platform.h>
> -
> -#define LPC32XX_INTC_MASKED_STATUS_OFS 0x8
> -
> -       .macro  get_irqnr_preamble, base, tmp
> -       ldr     \base, =IO_ADDRESS(LPC32XX_MIC_BASE)
> -       .endm
> -
> -/*
> - * Return IRQ number in irqnr. Also return processor Z flag status in CPSR
> - * as set if an interrupt is pending.
> - */
> -       .macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> -       ldr     \irqstat, [\base, #LPC32XX_INTC_MASKED_STATUS_OFS]
> -       clz     \irqnr, \irqstat
> -       rsb     \irqnr, \irqnr, #31
> -       teq     \irqstat, #0
> -       .endm
> diff --git a/arch/arm/mach-lpc32xx/include/mach/hardware.h b/arch/arm/mach-lpc32xx/include/mach/hardware.h
> deleted file mode 100644
> index 4866f096ffce..000000000000
> --- a/arch/arm/mach-lpc32xx/include/mach/hardware.h
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * arch/arm/mach-lpc32xx/include/mach/hardware.h
> - *
> - * Copyright (c) 2005 MontaVista Software, Inc. <source@mvista.com>
> - */
> -
> -#ifndef __ASM_ARCH_HARDWARE_H
> -#define __ASM_ARCH_HARDWARE_H
> -
> -/*
> - * Start of virtual addresses for IO devices
> - */
> -#define IO_BASE                0xF0000000
> -
> -/*
> - * This macro relies on fact that for all HW i/o addresses bits 20-23 are 0
> - */
> -#define IO_ADDRESS(x)  IOMEM(((((x) & 0xff000000) >> 4) | ((x) & 0xfffff)) |\
> -                        IO_BASE)
> -
> -#define io_p2v(x)      ((void __iomem *) (unsigned long) IO_ADDRESS(x))
> -#define io_v2p(x)      ((((x) & 0x0ff00000) << 4) | ((x) & 0x000fffff))
> -
> -#endif
> diff --git a/arch/arm/mach-lpc32xx/include/mach/uncompress.h b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
> index a568812a0b91..74b7aa0da0e4 100644
> --- a/arch/arm/mach-lpc32xx/include/mach/uncompress.h
> +++ b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
> @@ -12,15 +12,13 @@
>
>  #include <linux/io.h>
>
> -#include <mach/hardware.h>
> -#include <mach/platform.h>
> -
>  /*
>   * Uncompress output is hardcoded to standard UART 5
>   */
>
>  #define UART_FIFO_CTL_TX_RESET (1 << 2)
>  #define UART_STATUS_TX_MT      (1 << 6)
> +#define LPC32XX_UART5_BASE     0x40090000
>
>  #define _UARTREG(x)            (void __iomem *)(LPC32XX_UART5_BASE + (x))
>
> diff --git a/arch/arm/mach-lpc32xx/include/mach/platform.h b/arch/arm/mach-lpc32xx/lpc32xx.h
> similarity index 98%
> rename from arch/arm/mach-lpc32xx/include/mach/platform.h
> rename to arch/arm/mach-lpc32xx/lpc32xx.h
> index 1c53790444fc..5eeb884a1993 100644
> --- a/arch/arm/mach-lpc32xx/include/mach/platform.h
> +++ b/arch/arm/mach-lpc32xx/lpc32xx.h
> @@ -7,8 +7,8 @@
>   * Copyright (C) 2010 NXP Semiconductors
>   */
>
> -#ifndef __ASM_ARCH_PLATFORM_H
> -#define __ASM_ARCH_PLATFORM_H
> +#ifndef __ARM_LPC32XX_H
> +#define __ARM_LPC32XX_H
>
>  #define _SBF(f, v)                             ((v) << (f))
>  #define _BIT(n)                                        _SBF(n, 1)
> @@ -700,4 +700,18 @@
>  #define LPC32XX_USB_OTG_DEV_CLOCK_ON   _BIT(1)
>  #define LPC32XX_USB_OTG_HOST_CLOCK_ON  _BIT(0)
>
> +/*
> + * Start of virtual addresses for IO devices
> + */
> +#define IO_BASE                0xF0000000
> +
> +/*
> + * This macro relies on fact that for all HW i/o addresses bits 20-23 are 0
> + */
> +#define IO_ADDRESS(x)  IOMEM(((((x) & 0xff000000) >> 4) | ((x) & 0xfffff)) |\
> +                        IO_BASE)
> +
> +#define io_p2v(x)      ((void __iomem *) (unsigned long) IO_ADDRESS(x))
> +#define io_v2p(x)      ((((x) & 0x0ff00000) << 4) | ((x) & 0x000fffff))
> +
>  #endif
> diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
> index 32bca351a73b..b27fa1b9f56c 100644
> --- a/arch/arm/mach-lpc32xx/pm.c
> +++ b/arch/arm/mach-lpc32xx/pm.c
> @@ -70,8 +70,7 @@
>
>  #include <asm/cacheflush.h>
>
> -#include <mach/hardware.h>
> -#include <mach/platform.h>
> +#include "lpc32xx.h"
>  #include "common.h"
>
>  #define TEMP_IRAM_AREA  IO_ADDRESS(LPC32XX_IRAM_BASE)
> diff --git a/arch/arm/mach-lpc32xx/serial.c b/arch/arm/mach-lpc32xx/serial.c
> index cfb35e5691cd..3e765c4bf986 100644
> --- a/arch/arm/mach-lpc32xx/serial.c
> +++ b/arch/arm/mach-lpc32xx/serial.c
> @@ -16,8 +16,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>
> -#include <mach/hardware.h>
> -#include <mach/platform.h>
> +#include "lpc32xx.h"
>  #include "common.h"
>
>  #define LPC32XX_SUART_FIFO_SIZE        64
> diff --git a/arch/arm/mach-lpc32xx/suspend.S b/arch/arm/mach-lpc32xx/suspend.S
> index 374f9f07fe48..3f0a8282ef6f 100644
> --- a/arch/arm/mach-lpc32xx/suspend.S
> +++ b/arch/arm/mach-lpc32xx/suspend.S
> @@ -11,8 +11,7 @@
>   */
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
> -#include <mach/platform.h>
> -#include <mach/hardware.h>
> +#include "lpc32xx.h"
>
>  /* Using named register defines makes the code easier to follow */
>  #define WORK1_REG                      r0
> --
> 2.20.0
>
