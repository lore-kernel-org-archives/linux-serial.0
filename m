Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84514C433EF
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 07:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613CA610A2
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 07:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhKAH6u (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Nov 2021 03:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229882AbhKAH6t (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Nov 2021 03:58:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5954060F46;
        Mon,  1 Nov 2021 07:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635753376;
        bh=pwR3oOkcYz7F5mzOp03+f7Iy2yi03VPZJAt9b9hI2Mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o59HYykfzg1HJqz3e+R4bHmT4a5b0Gi9lbAl2oyH+II+7FAxyZJEujoqjr7CMcZ0J
         xO7UW8RF5u/wMFFBnTC7hDrsSzN4JgddR2toyYgXGZOcd+2SZ3KrZyOcKBTqYpgVi7
         +OJaV2ZdvQl/QemXZXiYFCP0RLfW03Bkrpy9zZ8E=
Date:   Mon, 1 Nov 2021 08:56:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "hammer.hsieh" <hammerh0314@gmail.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de, tony.huang@sunplus.com,
        wells.lu@sunplus.com, "hammer.hsieh" <hammer.hsieh@sunplus.com>
Subject: Re: [PATCH 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Message-ID: <YX+dntBNCENwyIZx@kroah.com>
References: <1635752903-14968-1-git-send-email-hammer.hsieh@sunplus.com>
 <1635752903-14968-3-git-send-email-hammer.hsieh@sunplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635752903-14968-3-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 01, 2021 at 03:48:23PM +0800, hammer.hsieh wrote:
> Add Sunplus SoC UART Driver
> 
> Signed-off-by: hammer.hsieh <hammer.hsieh@sunplus.com>

I doubt you sign your name with a "." in it, right?

Also this address does not match your From: address.  Please fix this up
when resending this.

> ---
>  MAINTAINERS                       |    2 +
>  drivers/tty/serial/Kconfig        |   23 +
>  drivers/tty/serial/Makefile       |    1 +
>  drivers/tty/serial/sunplus-uart.c | 1848 +++++++++++++++++++++++++++++++++++++
>  include/soc/sunplus/sp_uart.h     |  158 ++++
>  5 files changed, 2032 insertions(+)
>  create mode 100644 drivers/tty/serial/sunplus-uart.c
>  create mode 100644 include/soc/sunplus/sp_uart.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f863e97..0176026 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17949,6 +17949,8 @@ SUNPLUS UART DRIVER
>  M:	Hammer Hsieh <hammer.hsieh@sunplus.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/serial/sunplus,uart.yaml
> +F:	drivers/tty/serial/sunplus-uart.c
> +F:	include/soc/sunplus/sp-uart.h
>  
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 131a6a5..319f5db 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1561,6 +1561,29 @@ config SERIAL_LITEUART_CONSOLE
>  	  and warnings and which allows logins in single user mode).
>  	  Otherwise, say 'N'.
>  
> +config SERIAL_SUNPLUS
> +	bool "Sunplus UART support"
> +	depends on OF
> +	select SERIAL_CORE
> +	help
> +	  Select this option if you would like to use Sunplus serial port on
> +	  Sunplus SoC SP7021.
> +	  If you enable this option, Sunplus serial ports in the system will
> +	  be registered as ttySx.
> +
> +config SERIAL_SUNPLUS_CONSOLE
> +	bool "Console on Sunplus UART"
> +	depends on SERIAL_SUNPLUS
> +	select SERIAL_CORE_CONSOLE
> +	select SERIAL_EARLYCON
> +	help
> +	  Select this option if you would like to use a Sunplus UART as the
> +	  system console.
> +	  Even if you say Y here, the currently visible virtual console
> +	  (/dev/tty0) will still be used as the system console by default, but
> +	  you can alter that using a kernel command line option such as
> +	  "console=ttySx".
> +
>  endmenu
>  
>  config SERIAL_MCTRL_GPIO
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index 7da0856..61cc8de 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_SERIAL_RDA)	+= rda-uart.o
>  obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
>  obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
>  obj-$(CONFIG_SERIAL_LITEUART) += liteuart.o
> +obj-$(CONFIG_SERIAL_SUNPLUS)	+= sunplus-uart.o
>  
>  # GPIOLIB helpers for modem control lines
>  obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
> diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
> new file mode 100644
> index 0000000..d1524dc
> --- /dev/null
> +++ b/drivers/tty/serial/sunplus-uart.c
> @@ -0,0 +1,1848 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

I have to ask,. but are you sure about this license that it needs to be
"-or-later"?

> +/*
> + * Sunplus SoC UART driver
> + *
> + * Author: Hammer Hsieh <hammer.hsieh@sunplus.com>
> + * Tony Huang <tony.huang@sunplus.com>
> + * Wells Lu <wells.lu@sunplus.com>
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/console.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/of_platform.h>
> +#include <asm/irq.h>
> +#if defined(CONFIG_MAGIC_SYSRQ)
> +#define SUPPORT_SYSRQ
> +#include <linux/sysrq.h>
> +#endif
> +#include <linux/serial_core.h>
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +#include <linux/io.h>
> +#include <linux/dma-mapping.h>
> +#include <soc/sunplus/sp_uart.h>
> +
> +#ifdef CONFIG_PM_RUNTIME_UART
> +#include <linux/pm_runtime.h>
> +#endif

Why the #ifdef in the .c file?

> +
> +#include <linux/gpio.h>

GPIO in a serial driver?

> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <dt-bindings/clock/sp-sp7021.h>
> +#include <dt-bindings/pinctrl/sppctl-sp7021.h>
> +#include <linux/delay.h>
> +#include <linux/hrtimer.h>

Please put the linux/ includes above the dt-bindings ones.

> +
> +#define DEVICE_NAME				"ttyS"
> +#define SP_UART_MAJOR			TTY_MAJOR

Why is this driver allowed to be named the same as the other serial
drivers?  What happens when you plug in a 8250 card to this device?

> +#define SP_UART_MINOR_START		64

Why here?

> +
> +#define NUM_UART		6	/* serial0,  ... */
> +#define NUM_UARTDMARX	2	/* serial10, ... */
> +#define NUM_UARTDMATX	2	/* serial20, ... */

Why are these hard codeded?

> +
> +#define ID_BASE_DMARX	10
> +#define ID_BASE_DMATX	20
> +
> +#define IS_UARTDMARX_ID(X) \
> +	(((X) >= (ID_BASE_DMARX)) && ((X) < (ID_BASE_DMARX + NUM_UARTDMARX)))
> +#define IS_UARTDMATX_ID(X) \
> +	(((X) >= (ID_BASE_DMATX)) && ((X) < (ID_BASE_DMATX + NUM_UARTDMATX)))
> +
> +//#define TTYS_KDBG_INFO
> +#define TTYS_KDBG_ERR
> +//#define TTYS_GPIO

Why is this commented out?

Why is this defined at all?

> +
> +#ifdef TTYS_KDBG_INFO
> +#define DBG_INFO(fmt, args ...)	pr_info("K_TTYS: " fmt, ## args)
> +#else
> +#define DBG_INFO(fmt, args ...)
> +#endif
> +#ifdef TTYS_KDBG_ERR
> +#define DBG_ERR(fmt, args ...)	pr_err("K_TTYS: " fmt, ## args)
> +#else
> +#define DBG_ERR(fmt, args ...)
> +#endif

No, please use dev_info(), dev_err() and dev_dbg() only.  Do not create
your own logging macros for a single driver, use the ones the kernel
gives you.

> +
> +#define SP_UART_CREAD_DISABLED		(1 << 16)
> +
> +#define UARXDMA_BUF_SZ			PAGE_SIZE
> +#define MAX_SZ_RXDMA_ISR		(1 << 9)
> +#define UATXDMA_BUF_SZ			PAGE_SIZE
> +
> +#define CLK_HIGH_UART			202500000
> +#define UART_RATIO				232
> +
> +#if defined(CONFIG_SP_MON)

What sets this?

I've stopped reviewing here.

thanks,

greg k-h
