Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D979C157472;
	Sun,  5 Jan 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736092807; cv=none; b=TftzSECoow0Vqj9/bB4M+tVt0TiRwm8YUCME1KguR9THKN8wS7I30ZlxTnDcPYrqmF180KTr/RsK/MRMmis5FClB9/eYACLi4x1qGuCNQSsiCe2if9MrQfeu45pW8jBFPsaRX/N/zHtWubLSLNvjcG7TjJATi3YEtXONAkEZflA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736092807; c=relaxed/simple;
	bh=qC6XET5/p5usRbFsvTNr+zQwFOBiEiI3+Amf513yB2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrBoXEfbu9mTFjoDCCH/ubC0AG7N2SJZwb/+H7N/XEd3mo6nJVczhFQuqRAO/KqNz+CT2yMcPzC6HfSwvZqJkvSHXpCX/TONGcrOMtJDg36Zdr19Mll7J8c/+Zf8BxyEo1Sf5e4//JoZcQeB9bxmMCCNyXPMPrSUeD+PEdRejcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wjXun6cP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wjXun6cP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE76CC4CED0;
	Sun,  5 Jan 2025 16:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736092805;
	bh=qC6XET5/p5usRbFsvTNr+zQwFOBiEiI3+Amf513yB2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wjXun6cPneDx1cN5xxLLyrnPBbkW60qFrwbc9FnshQX8JbFG9suGwxmYVPSv5Uxvb
	 EhTomNpQYl3f3d6eZ1NoCem7TiOenhvsiqA/zJ5sm4j5DfMBnCdGcBtlyDHpMGQfi5
	 QgS5UqSVL/tHnbbjqKEYSYuHELGqjMOkmQ2JM0L0=
Date: Sun, 5 Jan 2025 16:59:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	ansuelsmth@gmail.com, lorenzo@kernel.org
Subject: Re: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
Message-ID: <2025010500-subscript-expectant-144a@gregkh>
References: <20250105131147.2290237-1-benjamin.larsson@genexis.eu>
 <20250105131147.2290237-3-benjamin.larsson@genexis.eu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250105131147.2290237-3-benjamin.larsson@genexis.eu>

On Sun, Jan 05, 2025 at 02:11:47PM +0100, Benjamin Larsson wrote:
> Support for Airoha AN7581 SoC UART and HSUART baud rate
> calculation routine.
> 
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> ---
>  drivers/tty/serial/8250/8250_airoha.c | 85 +++++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_of.c     |  2 +
>  drivers/tty/serial/8250/8250_port.c   | 26 ++++++++
>  drivers/tty/serial/8250/Kconfig       | 10 ++++
>  drivers/tty/serial/8250/Makefile      |  1 +
>  include/linux/serial_8250.h           |  1 +
>  include/uapi/linux/serial_core.h      |  6 ++
>  include/uapi/linux/serial_reg.h       |  9 +++
>  8 files changed, 140 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_airoha.c
> 
> diff --git a/drivers/tty/serial/8250/8250_airoha.c b/drivers/tty/serial/8250/8250_airoha.c
> new file mode 100644
> index 000000000000..c57789dcc174
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_airoha.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0+

Do you really mean "+" here?  Sorry, I have to ask.

> +
> +/*
> + * Airoha UART driver.
> + *
> + * Copyright (c) 2025 Genexis Sweden AB
> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/serial_8250.h>
> +#include <linux/serial_reg.h>
> +#include <linux/console.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +
> +#include "8250.h"
> +
> +/* The Airoha UART is 16550-compatible except for the baud rate calculation.
> + *
> + * crystal_clock = 20 MHz
> + * xindiv_clock = crystal_clock / clock_div
> + * (x/y) = XYD, 32 bit register with 16 bits of x and then 16 bits of y
> + * clock_div = XINCLK_DIVCNT (default set to 10 (0x4)),
> + *           - 3 bit register [ 1, 2, 4, 8, 10, 12, 16, 20 ]
> + *
> + * baud_rate = ((xindiv_clock) * (x/y)) / ([BRDH,BRDL] * 16)
> + *
> + * XYD_y seems to need to be larger then XYD_x for proper waveform generation.
> + * Setting [BRDH,BRDL] to [0,1] and XYD_y to 65000 give even values
> + * for usual baud rates.
> + *
> + * Selecting divider needs to fulfill
> + * 1.8432 MHz <= xindiv_clk <= APB clock / 2
> + * The clocks are unknown but a divider of value 1 did not result in a valid
> + * waveform.
> + *
> + */
> +
> +#define CLOCK_DIV_TAB_ELEMS 3
> +#define XYD_Y 65000
> +#define XINDIV_CLOCK 20000000
> +#define UART_BRDL_20M 0x01
> +#define UART_BRDH_20M 0x00
> +static int clock_div_tab[] = { 10, 4, 2};
> +static int clock_div_reg[] = {  4, 2, 1};
> +
> +int airoha8250_set_baud_rate(struct uart_port *port,
> +			     unsigned int baud, unsigned int hs)

What is "hs"?

> +{
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	unsigned int xyd_x, nom, denom;
> +
> +	int i;
> +	/* set DLAB to access the baud rate divider registers (BRDH, BRDL) */


Didn't checkpatch complain about this?  You don't need a blank line
before the "int i;", but rather after it.

> +	serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);
> +	/* set baud rate calculation defaults */
> +	/* set BRDIV ([BRDH,BRDL]) to 1 */
> +	serial_port_out(port, UART_BRDL, UART_BRDL_20M);
> +	serial_port_out(port, UART_BRDH, UART_BRDH_20M);
> +	/* calculate XYD_x and XINCLKDR register
> +	 * for the HSUART xyd_x needs to be scale by a factor of 2
> +	 */
> +	for (i = 0 ; i < CLOCK_DIV_TAB_ELEMS ; i++) {
> +		denom = (XINDIV_CLOCK/40) / clock_div_tab[i];
> +		nom = (baud * (XYD_Y/40));
> +		xyd_x = ((nom/denom) << 4) >> hs;
> +		if (xyd_x < XYD_Y)
> +			break;
> +	}
> +	serial_port_out(port, UART_XINCLKDR, clock_div_reg[i]);
> +	serial_port_out(port, UART_XYD, (xyd_x<<16) | XYD_Y);
> +	/* unset DLAB */
> +	serial_port_out(port, UART_LCR, up->lcr);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(airoha8250_set_baud_rate);
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index 64aed7efc569..5315bc1bc06d 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -341,6 +341,8 @@ static const struct of_device_id of_platform_serial_table[] = {
>  	{ .compatible = "ti,da830-uart", .data = (void *)PORT_DA830, },
>  	{ .compatible = "nuvoton,wpcm450-uart", .data = (void *)PORT_NPCM, },
>  	{ .compatible = "nuvoton,npcm750-uart", .data = (void *)PORT_NPCM, },
> +	{ .compatible = "airoha,airoha-uart", .data = (void *)PORT_AIROHA, },
> +	{ .compatible = "airoha,airoha-hsuart", .data = (void *)PORT_AIROHA_HS, },
>  	{ /* end of list */ },
>  };
>  MODULE_DEVICE_TABLE(of, of_platform_serial_table);
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 1ea52fce9bf1..00163a3d35cd 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -319,6 +319,22 @@ static const struct serial8250_config uart_config[] = {
>  		.rxtrig_bytes	= {1, 8, 16, 30},
>  		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
>  	},
> +	[PORT_AIROHA] = {
> +		.name		= "Airoha UART",
> +		.fifo_size	= 8,
> +		.tx_loadsz	= 1,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 | UART_FCR_CLEAR_RCVR,
> +		.rxtrig_bytes	= {1, 4},
> +		.flags		= UART_CAP_FIFO,
> +	},
> +	[PORT_AIROHA_HS] = {
> +		.name		= "Airoha HSUART",
> +		.fifo_size	= 128,
> +		.tx_loadsz	= 128,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 | UART_FCR_CLEAR_RCVR,
> +		.rxtrig_bytes	= {1, 4},
> +		.flags		= UART_CAP_FIFO,
> +	},
>  };
>  
>  /* Uart divisor latch read */
> @@ -2847,6 +2863,16 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
>  
>  	serial8250_set_divisor(port, baud, quot, frac);
>  
> +
> +	/*
> +	 * Airoha SoCs have custom registers for baud rate settings
> +	 */
> +#ifdef CONFIG_SERIAL_8250_AIROHA

Please don't put #ifdef in .c files, are you sure this is needed this
way?  Why not do it the other way around like other uart types do it?

> +	if (port->type == PORT_AIROHA)
> +		airoha8250_set_baud_rate(port, baud, 0);
> +	if (port->type == PORT_AIROHA_HS)
> +		airoha8250_set_baud_rate(port, baud, 1);
> +#endif
>  	/*
>  	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
>  	 * is written without DLAB set, this mode will be disabled.
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 55d26d16df9b..97fe6ea9393d 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -356,6 +356,16 @@ config SERIAL_8250_ACORN
>  	  system, say Y to this option.  The driver can handle 1, 2, or 3 port
>  	  cards.  If unsure, say N.
>  
> +config SERIAL_8250_AIROHA
> +	tristate "Airoha UART support"
> +	depends on (ARCH_AIROHA || COMPILE_TEST) && OF && SERIAL_8250
> +	help
> +	  Selecting this option enables an Airoha SoC specific baud rate
> +	  calculation routine on an otherwise 16550 compatible UART hardware.
> +
> +	  If you have an Airoha based board and want to use the serial port,
> +	  say Y to this option. If unsure, say N.

module name?


> +
>  config SERIAL_8250_BCM2835AUX
>  	tristate "BCM2835 auxiliar mini UART support"
>  	depends on ARCH_BCM2835 || COMPILE_TEST
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index 1516de629b61..b7f07d5c4cca 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_SERIAL_8250_CONSOLE)	+= 8250_early.o
>  
>  obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
>  obj-$(CONFIG_SERIAL_8250_ACORN)		+= 8250_acorn.o
> +obj-$(CONFIG_SERIAL_8250_AIROHA)	+= 8250_airoha.o
>  obj-$(CONFIG_SERIAL_8250_ASPEED_VUART)	+= 8250_aspeed_vuart.o
>  obj-$(CONFIG_SERIAL_8250_BCM2835AUX)	+= 8250_bcm2835aux.o
>  obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index e0717c8393d7..33e7e1922149 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -195,6 +195,7 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
>  void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
>  			       unsigned int quot);
>  int fsl8250_handle_irq(struct uart_port *port);
> +int airoha8250_set_baud_rate(struct uart_port *port, unsigned int baud, unsigned int hs);

Why is this here?

>  int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
>  u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
>  void serial8250_read_char(struct uart_8250_port *up, u16 lsr);
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 9c007a106330..c71fb338accb 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -231,6 +231,12 @@
>  /* Sunplus UART */
>  #define PORT_SUNPLUS	123
>  
> +/* Airoha UART */
> +#define PORT_AIROHA	124
> +
> +/* Airoha HSUART */
> +#define PORT_AIROHA_HS	125

Do you REALLY need these port definitions in userspace?  If so, what is
going to use them there?


> +
>  /* Generic type identifier for ports which type is not important to userspace. */
>  #define PORT_GENERIC	(-1)
>  
> diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
> index 9c987b04e2d0..72a71e171602 100644
> --- a/include/uapi/linux/serial_reg.h
> +++ b/include/uapi/linux/serial_reg.h
> @@ -383,5 +383,14 @@
>  #define UART_ALTR_EN_TXFIFO_LW	0x01	/* Enable the TX FIFO Low Watermark */
>  #define UART_ALTR_TX_LOW	0x41	/* Tx FIFO Low Watermark */
>  
> +/*
> + * These are definitions for the Airoha UART
> + * Normalized because of 32 bit registers.
> + */
> +#define UART_BRDL		0
> +#define UART_BRDH		1
> +#define UART_XINCLKDR		10
> +#define UART_XYD		11

Why does the define not have your uart type in it?  And what is
userspace going to do with these values?  Why do they need to be in this
file?

thanks,

greg k-h
