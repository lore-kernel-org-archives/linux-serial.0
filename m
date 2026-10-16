Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9B83CB56E;
	Fri, 16 Oct 2026 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159848; cv=none; b=lSdl7/U3aUMrnN5Ib9BCxfST/ayQ0VSk2XJWFR6DCKil0PO+PSRifYgQBAG98M4NR4b6jWl5QUxrUvfHbUQQygEGTsGw3dB4yQ9i79GhGLMmcEHahfyYIFliNNiuv7KahpYSK114HBS2Lsa1XcEGeJSE6jRzFLzC1KtOTg0rdzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159848; c=relaxed/simple;
	bh=qsrP6+nqOoihEdMQS3E/O5ne68RR0xvgHVkKjTKK4Ww=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P5bPNKH3WMPwXSNALBnJPVjgrQENnCP6Vz5WCIELHbLKyhKsE6fVH1bx0preh5MSgzh7KBxjYDu0Huyrqe3woKa9YdIfeD4Pgnm8iZgkRYUHpUlxLA+//2SietCEOCSIB31458TD41+mW48jhlgw8L5HnvnIxyYHHK7ZydEqaBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=z5Bxu7si; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="z5Bxu7si"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=v9swT4sUtIA6jutXhZAgfW4/nQZjIXOTSKbi86UKenE=; b=z5Bxu7sisz8DNc8TAmmUsLWt46
	ZDfQBEtFbaYvW1JTEwt1L/gKPju/dsOGX9QZVoebsvObuFcM39CQye9fNbjTghU6SJHfyBZhB4uIi
	12vrwXqsM9MHyb6LgiO/+aOH7hjDgByyIJxFyS3wDC9ZjAf9wWNyKcuiUfw5/gTsFVNo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xHidj-000000005PO-1E1P;
	Fri, 16 Oct 2026 10:10:30 -0400
Date: Fri, 16 Oct 2026 10:10:28 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 (The Capable Hub) <u.kleine-koenig@baylibre.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] tty: serial: remove hub6 multiport support
Message-Id: <20261016101028.ebeb7a50fa5a6cc11558f8d8@hugovil.com>
In-Reply-To: <20261016130328.1037616-1-arnd@kernel.org>
References: <20261016130328.1037616-1-arnd@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Arnd,

On Fri, 16 Oct 2026 14:59:47 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> hub6 support was added in linux-0.99 and the hardware was already old at
> the time, being discontinued in 1990. The code for it has always been a
> mess since it adds another dimension to the I/O addressing in the driver
> that has leaked into many individual files.
> 
> Hugo and Uwe have attempted several times this year alone to isolate
> the hub6 handling into the 8250_hub6.c file, but I feel that none of
> this has been a real improvement over the original standalone loadable
> module support.
> 
> Any machine that would have used this ISA card in practice is likely
> 30 to 40 years old, and with i486 support now removed, it is clearly
> safe to just kill this all off. The only bit that has to remain
> is the ioctl interface, to ensure the serial_struct field is always
> zero.
> 
> Link: https://mirrors.nycbug.org/pub/The_Unix_Archive/Unix_Usenet/comp.unix.sysv386/1990-December/007174.html
> Fixes: a300273c458c ("serial: 8250: hub6: Add cleanup code")
> Fixes: c526404a4a92 ("serial: 8250: Fix corner case for port matching")
> Fixes: 7ab80d1e7243 ("serial: 8250: fix compile error with hub6_match_port() when compiled as a module")
> Fixes: da7b5fd4e17f ("serial: 8250_hub6: add missing include for hub6_match_port()")
> Fixes: 3d406299d882 ("serial: 8250_hub6: add hub6_match_port()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/8250/8250.h          | 15 -------
>  drivers/tty/serial/8250/8250_core.c     |  2 -
>  drivers/tty/serial/8250/8250_hub6.c     | 60 -------------------------
>  drivers/tty/serial/8250/8250_platform.c | 11 +----
>  drivers/tty/serial/8250/8250_port.c     | 23 ----------
>  drivers/tty/serial/8250/Kconfig         | 15 ++-----
>  drivers/tty/serial/8250/Makefile        |  1 -
>  drivers/tty/serial/atmel_serial.c       |  2 -
>  drivers/tty/serial/fsl_lpuart.c         |  2 -
>  drivers/tty/serial/imx.c                |  2 -
>  drivers/tty/serial/mpc52xx_uart.c       |  3 +-
>  drivers/tty/serial/sa1100.c             |  2 -
>  drivers/tty/serial/serial_core.c        | 18 +++-----
>  drivers/tty/serial/sunsu.c              |  9 ----
>  drivers/tty/serial/xilinx_uartps.c      |  2 -
>  include/linux/serial_8250.h             |  2 -
>  include/linux/serial_core.h             |  2 -
>  17 files changed, 12 insertions(+), 159 deletions(-)
>  delete mode 100644 drivers/tty/serial/8250/8250_hub6.c
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 21ed9c41b751..75afeb8c0cef 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -323,14 +323,6 @@ static inline int serial8250_pnp_init(void) { return 0; }
>  static inline void serial8250_pnp_exit(void) { }
>  #endif
>  
> -#ifdef CONFIG_SERIAL_8250_HUB6
> -int serial8250_hub6_init(void);
> -void serial8250_hub6_exit(void);
> -#else
> -static inline int serial8250_hub6_init(void) { return 0; }
> -static inline void serial8250_hub6_exit(void) { }
> -#endif
> -
>  #ifdef CONFIG_SERIAL_8250_RSA
>  void univ8250_rsa_support(struct uart_ops *ops, const struct uart_ops *core_ops);
>  void rsa_enable(struct uart_8250_port *up);
> @@ -351,13 +343,6 @@ int fintek_8250_probe(struct uart_8250_port *uart);
>  static inline int fintek_8250_probe(struct uart_8250_port *uart) { return 0; }
>  #endif
>  
> -#if IS_ENABLED(CONFIG_SERIAL_8250_HUB6)
> -bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2);
> -#else
> -static inline bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
> -{ return false; }
> -#endif
> -
>  #ifdef CONFIG_ARCH_OMAP1
>  #include <linux/soc/ti/omap1-soc.h>
>  static inline int is_omap1_8250(struct uart_8250_port *pt)
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 42319843cb5b..96c99f0ae683 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -686,8 +686,6 @@ static bool serial8250_match_port(const struct uart_port *port1,
>  		return false;
>  	else if (port1->iotype == UPIO_PORT)
>  		return port1->iobase == port2->iobase;
> -	else if (port1->iotype == UPIO_HUB6)
> -		return hub6_match_port(port1, port2);
>  	else if (uart_iotype_mmio(port1->iotype))
>  		return port1->mapbase == port2->mapbase;
>  	else
> diff --git a/drivers/tty/serial/8250/8250_hub6.c b/drivers/tty/serial/8250/8250_hub6.c
> deleted file mode 100644
> index 848d9723ac56..000000000000
> --- a/drivers/tty/serial/8250/8250_hub6.c
> +++ /dev/null
> @@ -1,60 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  Copyright (C) 2005 Russell King.
> - *  Data taken from include/asm-i386/serial.h
> - */
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/serial_8250.h>
> -
> -#include "8250.h"
> -
> -#define HUB6(card, port)						\
> -	{								\
> -		.iobase		= 0x302,				\
> -		.irq		= 3,					\
> -		.uartclk	= 1843200,				\
> -		.iotype		= UPIO_HUB6,				\
> -		.flags		= UPF_BOOT_AUTOCONF,			\
> -		.hub6		= (card) << 6 | (port) << 3 | 1,	\
> -	}
> -
> -static struct plat_serial8250_port hub6_data[] = {
> -	HUB6(0, 0),
> -	HUB6(0, 1),
> -	HUB6(0, 2),
> -	HUB6(0, 3),
> -	HUB6(0, 4),
> -	HUB6(0, 5),
> -	HUB6(1, 0),
> -	HUB6(1, 1),
> -	HUB6(1, 2),
> -	HUB6(1, 3),
> -	HUB6(1, 4),
> -	HUB6(1, 5),
> -	{ },
> -};
> -
> -static struct platform_device hub6_device = {
> -	.name			= "serial8250",
> -	.id			= PLAT8250_DEV_HUB6,
> -	.dev			= {
> -		.platform_data	= hub6_data,
> -	},
> -};
> -
> -bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
> -{
> -	return port1->iobase == port2->iobase && port1->hub6 == port2->hub6;
> -}
> -EXPORT_SYMBOL_GPL(hub6_match_port);
> -
> -int __init serial8250_hub6_init(void)
> -{
> -	return platform_device_register(&hub6_device);
> -}
> -
> -void serial8250_hub6_exit(void)
> -{
> -	platform_device_unregister(&hub6_device);
> -}
> diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
> index 7ce7ad295fae..8aa769085bfa 100644
> --- a/drivers/tty/serial/8250/8250_platform.c
> +++ b/drivers/tty/serial/8250/8250_platform.c
> @@ -86,7 +86,6 @@ static void __init __serial8250_isa_init_ports(void)
>  		port->irqflags = 0;
>  		port->uartclk  = old_serial_port[i].baud_base * 16;
>  		port->flags    = old_serial_port[i].flags;
> -		port->hub6     = 0;
>  		port->membase  = old_serial_port[i].iomem_base;
>  		port->iotype   = old_serial_port[i].io_type;
>  		port->regshift = old_serial_port[i].iomem_reg_shift;
> @@ -169,7 +168,6 @@ static int serial8250_probe_platform(struct platform_device *dev, struct plat_se
>  		uart->port.flags		= p->flags;
>  		uart->port.mapbase	= p->mapbase;
>  		uart->port.mapsize	= p->mapsize;
> -		uart->port.hub6		= p->hub6;
>  		uart->port.has_sysrq	= p->has_sysrq;
>  		uart->port.private_data	= p->private_data;
>  		uart->port.type		= p->type;
> @@ -317,14 +315,10 @@ static int __init serial8250_init(void)
>  	if (ret)
>  		goto unreg_uart_drv;
>  
> -	ret = serial8250_hub6_init();
> -	if (ret)
> -		goto unreg_pnp;
> -
>  	serial8250_isa_devs = platform_device_alloc("serial8250", PLAT8250_DEV_LEGACY);
>  	if (!serial8250_isa_devs) {
>  		ret = -ENOMEM;
> -		goto unreg_hub6;
> +		goto unreg_pnp;
>  	}
>  
>  	ret = platform_device_add(serial8250_isa_devs);
> @@ -340,8 +334,6 @@ static int __init serial8250_init(void)
>  	platform_device_del(serial8250_isa_devs);
>  put_dev:
>  	platform_device_put(serial8250_isa_devs);
> -unreg_hub6:
> -	serial8250_hub6_exit();
>  unreg_pnp:
>  	serial8250_pnp_exit();
>  unreg_uart_drv:
> @@ -369,7 +361,6 @@ static void __exit serial8250_exit(void)
>  	platform_driver_unregister(&serial8250_isa_driver);
>  	platform_device_unregister(isa_dev);
>  
> -	serial8250_hub6_exit();
>  	serial8250_pnp_exit();
>  
>  #ifdef CONFIG_SPARC
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 36b2b0a2c05c..3593e7209879 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -354,22 +354,6 @@ static void default_serial_dl_write(struct uart_8250_port *up, u32 value)
>  	serial_out(up, UART_DLM, value >> 8 & 0xff);
>  }
>  
> -#ifdef CONFIG_HAS_IOPORT
> -static u32 hub6_serial_in(struct uart_port *p, unsigned int offset)
> -{
> -	offset = offset << p->regshift;
> -	outb(p->hub6 - 1 + offset, p->iobase);
> -	return inb(p->iobase + 1);
> -}
> -
> -static void hub6_serial_out(struct uart_port *p, unsigned int offset, u32 value)
> -{
> -	offset = offset << p->regshift;
> -	outb(p->hub6 - 1 + offset, p->iobase);
> -	outb(value, p->iobase + 1);
> -}
> -#endif /* CONFIG_HAS_IOPORT */
> -
>  static u32 mem_serial_in(struct uart_port *p, unsigned int offset)
>  {
>  	offset = offset << p->regshift;
> @@ -450,13 +434,6 @@ static void set_io_from_upio(struct uart_port *p)
>  	up->dl_write = default_serial_dl_write;
>  
>  	switch (p->iotype) {
> -#ifdef CONFIG_HAS_IOPORT
> -	case UPIO_HUB6:
> -		p->serial_in = hub6_serial_in;
> -		p->serial_out = hub6_serial_out;
> -		break;
> -#endif
> -
>  	case UPIO_MEM:
>  		p->serial_in = mem_serial_in;
>  		p->serial_out = mem_serial_out;
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 82e761b8298a..9917b7e1bb26 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -208,9 +208,9 @@ config SERIAL_8250_EXTENDED
>  	depends on SERIAL_8250
>  	help
>  	  If you wish to use any non-standard features of the standard "dumb"
> -	  driver, say Y here. This includes HUB6 support, shared serial
> -	  interrupts, special multiport support, support for more than the
> -	  four COM 1/2/3/4 boards, etc.
> +	  driver, say Y here. This includes shared serial interrupts, special
> +	  multiport support, support for more than the four COM 1/2/3/4 boards,
> +	  etc.
>  
>  	  Note that the answer to this question won't directly affect the
>  	  kernel: saying N will just cause the configurator to skip all
> @@ -303,15 +303,6 @@ config SERIAL_8250_EXAR_ST16C554
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called 8250_exar_st16c554.
>  
> -config SERIAL_8250_HUB6
> -	bool "Support Hub6 cards"
> -	depends on SERIAL_8250_MANY_PORTS && ISA
> -	help
> -	  Say Y here if you have a HUB6 serial board.
> -
> -	  To compile this driver as a module, choose M here: the module
> -	  will be called 8250_hub6.
> -
>  config SERIAL_8250_PCI1XXXX
>  	tristate "Microchip 8250 based serial port"
>  	depends on SERIAL_8250 && PCI
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index 5ff2ba414e13..d241ce486953 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -7,7 +7,6 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o
>  8250-y					:= 8250_core.o
>  8250-y					+= 8250_platform.o
>  8250-$(CONFIG_SERIAL_8250_PNP)		+= 8250_pnp.o
> -8250-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
>  
>  obj-$(CONFIG_SERIAL_8250)		+= 8250_base.o
>  8250_base-y				:= 8250_port.o
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index c3880259e3bc..9c40ccee0c82 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2448,8 +2448,6 @@ static int atmel_verify_port(struct uart_port *port, struct serial_struct *ser)
>  		ret = -EINVAL;
>  	if (port->iobase != ser->port)
>  		ret = -EINVAL;
> -	if (ser->hub6 != 0)
> -		ret = -EINVAL;
>  	return ret;
>  }
>  
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index c8575c965203..6e1248840022 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2432,8 +2432,6 @@ static int lpuart_verify_port(struct uart_port *port, struct serial_struct *ser)
>  		ret = -EINVAL;
>  	if (port->iobase != ser->port)
>  		ret = -EINVAL;
> -	if (ser->hub6 != 0)
> -		ret = -EINVAL;
>  	return ret;
>  }
>  
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 986fefb45c63..d89be62e3852 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1936,8 +1936,6 @@ imx_uart_verify_port(struct uart_port *port, struct serial_struct *ser)
>  		ret = -EINVAL;
>  	if (port->iobase != ser->port)
>  		ret = -EINVAL;
> -	if (ser->hub6 != 0)
> -		ret = -EINVAL;
>  	return ret;
>  }
>  
> diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
> index 472ec39caf27..240009333fb5 100644
> --- a/drivers/tty/serial/mpc52xx_uart.c
> +++ b/drivers/tty/serial/mpc52xx_uart.c
> @@ -1339,8 +1339,7 @@ mpc52xx_uart_verify_port(struct uart_port *port, struct serial_struct *ser)
>  	if ((ser->irq != port->irq) ||
>  	    (ser->io_type != UPIO_MEM) ||
>  	    (ser->baud_base != port->uartclk)  ||
> -	    (ser->iomem_base != (void *)port->mapbase) ||
> -	    (ser->hub6 != 0))
> +	    (ser->iomem_base != (void *)port->mapbase))
>  		return -EINVAL;
>  
>  	return 0;
> diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
> index 72b1bb76415c..ee5f3960d1e4 100644
> --- a/drivers/tty/serial/sa1100.c
> +++ b/drivers/tty/serial/sa1100.c
> @@ -556,8 +556,6 @@ sa1100_verify_port(struct uart_port *port, struct serial_struct *ser)
>  		ret = -EINVAL;
>  	if (sport->port.iobase != ser->port)
>  		ret = -EINVAL;
> -	if (ser->hub6 != 0)
> -		ret = -EINVAL;
>  	return ret;
>  }
>  
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 9eea8d1a0e8a..15d8c3ed6edc 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -812,7 +812,7 @@ static int uart_get_info(struct tty_port *port, struct serial_struct *retinfo)
>  				ASYNC_CLOSING_WAIT_NONE :
>  				jiffies_to_msecs(port->closing_wait) / 10;
>  	retinfo->custom_divisor  = uport->custom_divisor;
> -	retinfo->hub6	    = uport->hub6;
> +	retinfo->hub6		 = 0;
>  	retinfo->io_type         = uport->iotype;
>  	retinfo->iomem_reg_shift = uport->regshift;
>  	retinfo->iomem_base      = (void *)(unsigned long)uport->mapbase;
> @@ -834,13 +834,12 @@ static int uart_change_port(struct uart_port *uport,
>  			    unsigned long new_port)
>  {
>  	unsigned long old_iobase, old_mapbase;
> -	unsigned int old_type, old_iotype, old_hub6, old_shift;
> +	unsigned int old_type, old_iotype, old_shift;
>  	int retval;
>  
>  	old_iobase = uport->iobase;
>  	old_mapbase = uport->mapbase;
>  	old_type = uport->type;
> -	old_hub6 = uport->hub6;
>  	old_iotype = uport->iotype;
>  	old_shift = uport->regshift;
>  
> @@ -849,7 +848,6 @@ static int uart_change_port(struct uart_port *uport,
>  
>  	uport->iobase = new_port;
>  	uport->type = new_info->type;
> -	uport->hub6 = new_info->hub6;
>  	uport->iotype = new_info->io_type;
>  	uport->regshift = new_info->iomem_reg_shift;
>  	uport->mapbase = (unsigned long)new_info->iomem_base;
> @@ -867,7 +865,6 @@ static int uart_change_port(struct uart_port *uport,
>  	 */
>  	uport->iobase = old_iobase;
>  	uport->type = old_type;
> -	uport->hub6 = old_hub6;
>  	uport->iotype = old_iotype;
>  	uport->regshift = old_shift;
>  	uport->mapbase = old_mapbase;
> @@ -924,7 +921,6 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
>  	change_port = !(uport->flags & UPF_FIXED_PORT)
>  		&& (new_port != uport->iobase ||
>  		    (unsigned long)new_info->iomem_base != uport->mapbase ||
> -		    new_info->hub6 != uport->hub6 ||
>  		    new_info->io_type != uport->iotype ||
>  		    new_info->iomem_reg_shift != uport->regshift ||
>  		    new_info->type != uport->type);
> @@ -954,6 +950,10 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
>  		goto check_and_exit;
>  	}
>  
> +	/* hub6 is no longer support */

s/support/supported

> +        if (new_info->hub6 != 0)
> +                return -EINVAL;
> +
>  	if (change_irq || change_port) {
>  		retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
>  		if (retval)
> @@ -2010,7 +2010,6 @@ bool uart_iotype_io(enum uart_iotype iotype)
>  {
>  	switch (iotype) {
>  	case UPIO_PORT:
> -	case UPIO_HUB6:
>  		return true;
>  	default:
>  		return false;
> @@ -2538,10 +2537,7 @@ void uart_get_ioinfos(struct uart_port *port, char *buf, size_t size)
>  	if (uart_iotype_mmio(port->iotype)) {
>  		scnprintf(buf, size, " MMIO%s:%pa", uart_get_mmio_width(port), &port->mapbase);
>  	} else if (uart_iotype_io(port->iotype)) {
> -		if (port->iotype == UPIO_PORT)
> -			scnprintf(buf, size, " I/O:0x%lx", port->iobase);
> -		else if (port->iotype == UPIO_HUB6)
> -			scnprintf(buf, size, " I/O:0x%lx, offset 0x%x", port->iobase, port->hub6);
> +		scnprintf(buf, size, " I/O:0x%lx", port->iobase);
>  	}
>  }
>  EXPORT_SYMBOL(uart_get_ioinfos);
> diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
> index 4ff3e5c41dab..f43b802add12 100644
> --- a/drivers/tty/serial/sunsu.c
> +++ b/drivers/tty/serial/sunsu.c
> @@ -106,10 +106,6 @@ static unsigned int serial_in(struct uart_sunsu_port *up, int offset)
>  	offset <<= up->port.regshift;
>  
>  	switch (up->port.iotype) {
> -	case UPIO_HUB6:
> -		outb(up->port.hub6 - 1 + offset, up->port.iobase);
> -		return inb(up->port.iobase + 1);
> -
>  	case UPIO_MEM:
>  		return readb(up->port.membase + offset);
>  
> @@ -136,11 +132,6 @@ static void serial_out(struct uart_sunsu_port *up, int offset, int value)
>  	offset <<= up->port.regshift;
>  
>  	switch (up->port.iotype) {
> -	case UPIO_HUB6:
> -		outb(up->port.hub6 - 1 + offset, up->port.iobase);
> -		outb(value, up->port.iobase + 1);
> -		break;
> -
>  	case UPIO_MEM:
>  		writeb(value, up->port.membase + offset);
>  		break;
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index a072b75dbaf2..4066cc99fe1a 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1079,8 +1079,6 @@ static int cdns_uart_verify_port(struct uart_port *port,
>  		return -EINVAL;
>  	if (port->iobase != ser->port)
>  		return -EINVAL;
> -	if (ser->hub6 != 0)
> -		return -EINVAL;
>  	return 0;
>  }
>  
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index d91c0477be9d..d55bce4d4709 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -41,7 +41,6 @@ struct plat_serial8250_port {
>  	void            *private_data;
>  	unsigned char	regshift;	/* register shift */
>  	unsigned char	iotype;		/* UPIO_* */
> -	unsigned char	hub6;
>  	unsigned char	has_sysrq;	/* supports magic SysRq */
>  	unsigned int	type;		/* If UPF_FIXED_TYPE */
>  	upf_t		flags;		/* UPF_* flags */
> @@ -75,7 +74,6 @@ enum {
>  	PLAT8250_DEV_ACCENT,
>  	PLAT8250_DEV_BOCA,
>  	PLAT8250_DEV_EXAR_ST16C554,
> -	PLAT8250_DEV_HUB6,
>  	PLAT8250_DEV_AU1X00,
>  	PLAT8250_DEV_SM501,
>  };
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 4eeb8253752a..ca8d009e5c36 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -430,7 +430,6 @@ typedef unsigned int __bitwise upstat_t;
>  enum uart_iotype {
>  	UPIO_UNKNOWN	= -1,
>  	UPIO_PORT	= SERIAL_IO_PORT,	/* 8b I/O port access */
> -	UPIO_HUB6	= SERIAL_IO_HUB6,	/* Hub6 ISA card */
>  	UPIO_MEM	= SERIAL_IO_MEM,	/* driver-specific */
>  	UPIO_MEM32	= SERIAL_IO_MEM32,	/* 32b little endian */
>  	UPIO_AU		= SERIAL_IO_AU,		/* Au1x00 and RT288x type IO */
> @@ -590,7 +589,6 @@ struct uart_port {
>  	unsigned char		has_sysrq;
>  	unsigned char		sysrq_seq;		/* index in sysrq_toggle_seq */
>  
> -	unsigned char		hub6;			/* this should be in the 8250 driver */
>  	unsigned char		suspended;
>  	unsigned char		console_reinit;
>  	const char		*name;			/* port name */
> -- 
> 2.53.0
> 
> 
> 


-- 
Hugo Villeneuve
