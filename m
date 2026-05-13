Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7873EDAA3;
	Wed, 13 May 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668521; cv=none; b=neUQQ1iUY+zvr1k6lN4MF0pZBzqqYuQ7bLvmeRtbwL739dtiQ/c3ItC4Udv3P2Bocvyf2I6EZs+bV+tim6WYxx/HtXqFUF1Xx1ruqpw23rcTiAdwuZ9Toe5NWssU6QBgKJnwLt3GheyLzdX39sYI9exR02cfayeIB5lWjqAvDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668521; c=relaxed/simple;
	bh=vFc/0varpnBF15KLeuIScQbsvyHGDQlnFW3oq0QgzkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqqlcaH8T7A9QQU51GwUpB22q3g9AK5DaQXgQkMICAa28WFaa+c54EXDEyLeVttU0iO0M3OAAvp2Ge9GWI3eMs8ydDDBcjZ/wDEhrrnmrEre736HpdQpllFKFamRY9nBPm0+DL5H/cAsolH4bIL+sZFOxMQEvlhKTWdvSiyS7/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KwNSc5i8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KwNSc5i8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA88C2BCB8;
	Wed, 13 May 2026 10:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778668520;
	bh=vFc/0varpnBF15KLeuIScQbsvyHGDQlnFW3oq0QgzkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KwNSc5i8H0zhtr7etEdEyXLasBoIx+Uq4MNV+e75qi4pg9mZH1PsqkiQjXslXjV7d
	 Z6e2GQr/PDwrqybuwKn1IyJ1pNw+I1ERLODwBsqtDqgl3UX3HlsNeif4csjI9T3t0w
	 E9YsJIr1Vit1OYXgxXZpiJn0ls7N86tWA1Iie1Yc=
Date: Wed, 13 May 2026 12:11:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: liu.qingtao2@zte.com.cn
Cc: krzk@kernel.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marex@nabladev.com,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, rdunlap@infradead.org, geert+renesas@glider.be,
	quic_zongjian@quicinc.com, arturs.artamonovs@analog.com,
	robert.marko@sartura.hr, hvilleneuve@dimonoff.com,
	thierry.bultel.yh@bp.renesas.com, julianbraha@gmail.com,
	flavra@baylibre.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	liu.wenhong35@zte.com.cn, liu.fei16@zte.com.cn,
	dai.hualiang@zte.com.cn, deng.weixian@zte.com.cn,
	jia.yunxiang@zte.com.cn, he.yilin@zte.com.cn, bai.lu5@zte.com.cn,
	yang.susheng@zte.com.cn, shen.lin1@zte.com.cn, zuo.jiang@zte.com.cn,
	hu.shengming@zte.com.cn, gao.rui@zte.com.cn, tan.hu@zte.com.cn
Subject: Re: [PATCH v2 2/2] tty: serial: Add LRX UART driver
Message-ID: <2026051316-stellar-enunciate-e2f8@gregkh>
References: <202605130852.64D8qEux084060@mse-fl1.zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202605130852.64D8qEux084060@mse-fl1.zte.com.cn>

On Wed, May 13, 2026 at 04:46:57PM +0800, liu.qingtao2@zte.com.cn wrote:
> >From 9eba3be2e9b4d5c77956258e3c5db95049c3a895 Mon Sep 17 00:00:00 2001
> From: Wenhong Liu <liu.wenhong35@zte.com.cn>
> Date: Tue, 28 Apr 2026 22:30:40 +0800
> Subject: [PATCH v2 2/2] tty: serial: Add LRX UART driver
> 
> Add support for the ZTE LRX UART controller with the following features:
> - Support for FIFO mode (16-byte depth)
> - Baud rate configuration
> - Standard asynchronous communication formats:
> * Data bits: 5, 6, 7, 8, 9 bits
> * Parity: odd, even, fixed, none
> * Stop bits: 1 or 2 bits
> - Hardware flow control (RTS/CTS)
> - Multiple interrupt reporting mechanisms
> - DMA support for improved performance
> 
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602140029.NXkDToZ7-lkp@intel.com/
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602140108.kLMOYbwS-lkp@intel.com/

Why are these 4 lines here?  The kernel test robot found bugs in your
previous versions, so fix that, but no need to list that here, right?

> --- /dev/null
> +++ b/drivers/tty/serial/lrx_uart.c
> @@ -0,0 +1,2822 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  Serial Port driver for ZTE LRX
> + *
> + *  Copyright (c) 2025, ZTE Corporation. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/ioport.h>
> +#include <linux/init.h>
> +#include <linux/console.h>
> +#include <linux/platform_device.h>
> +#include <linux/sysrq.h>
> +#include <linux/device.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/slab.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/scatterlist.h>
> +#include <linux/delay.h>
> +#include <linux/types.h>
> +#include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/sizes.h>
> +#include <linux/io.h>
> +#include <linux/acpi.h>
> +
> +#define UART_NR			14

Why 14?  Why limit yourself at all?

> +
> +#define ISR_PASS_LIMIT		256
> +
> +#define LRX_UART_NAME		"lrx-uart"

KBUILD_MODNAME?

> +#define LRX_UART_TTY_PREFIX	"ttyLRX"

Why are you using a new name and not the existing ones?  Why is this not
just a variant of the existing 8250 serial driver?  Surely this is not a
totally new UART that looks nothing like that one, right?

> +/* There is by now at least one vendor with differing details, so handle it */

So a new UART already has conflicting implementations?  How can that
happen?

> +/* Deals with DMA transactions */
> +
> +struct lrx_uart_dmabuf {
> +	dma_addr_t		dma;
> +	size_t			len;
> +	char			*buf;

u8?

> +/*
> + * We wrap our port structure around the generic uart_port.
> + */
> +struct lrx_uart_port {
> +	struct uart_port	port;
> +	const u16		*reg_offset;
> +	struct clk		*clk;
> +	const struct vendor_data *vendor;
> +	unsigned int		im;		/* interrupt mask */
> +	unsigned int		old_status;
> +	unsigned int		fifosize;	/* vendor-specific */
> +	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
> +	char			type[16];
> +	bool			rs485_tx_started;
> +	unsigned int		rs485_tx_drain_interval; /* usecs */
> +#ifdef CONFIG_DMA_ENGINE

Why would this UART not use the DMA engine?  When would that ever be
disabled?

> +/*
> + * Reads up to 256 characters from the FIFO or until it&apos;s empty and

This implies that some tool wrote this code.  Please always properly
document that and where it copied the information from in order to write
this code.

> +/*
> + * All the DMA operation mode stuff goes inside this ifdef.
> + * This assumes that you have a generic DMA device interface,
> + * no custom DMA interfaces are supported.
> + */
> +#ifdef CONFIG_DMA_ENGINE
> +
> +#define LRX_UART_DMA_BUFFER_SIZE PAGE_SIZE

Why not just use PAGE_SIZE?  And how do you know the dma buffer is the
same size always?  When using 16k pages, the hardware knows this?

> +/*
> + * Try to refill the TX DMA buffer.
> + * Locking: called with port lock held and IRQs disabled.
> + * Returns:
> + *   1 if we queued up a TX DMA buffer.
> + *   0 if we didn&apos;t want to handle this by DMA

Again, fix your tooling :(

> +/*
> + * Flush the transmit buffer.
> + * Locking: called with port lock held and IRQs disabled.
> + */
> +static void lrx_uart_dma_flush_buffer(struct uart_port *port)
> +__releases(&sup->port.lock)
> +__acquires(&sup->port.lock)

Ok, but:

> +{
> +	struct lrx_uart_port *sup =
> +	    container_of(port, struct lrx_uart_port, port);
> +
> +	if (!sup->using_tx_dma)
> +		return;
> +
> +	dmaengine_terminate_async(sup->dmatx.chan);
> +
> +	if (sup->dmatx.queued) {
> +		dma_unmap_single(sup->dmatx.chan->device->dev, sup->dmatx.dma,
> +				 sup->dmatx.len, DMA_TO_DEVICE);
> +		sup->dmatx.queued = false;
> +		sup->dmacr &= ~UARTFCCR_TXDMAE;
> +		lrx_uart_write(sup->dmacr, sup, REG_FCCR);
> +	}
> +}

I don't see those locks being touched, where did that happen?

> +static irqreturn_t lrx_uart_int(int irq, void *dev_id)
> +{
> +	struct lrx_uart_port *sup = dev_id;
> +	unsigned int status, pass_counter = ISR_PASS_LIMIT;
> +	int handled = 0;

bool?

> +static int lrx_uart_hwinit(struct uart_port *port)
> +{
> +	struct lrx_uart_port *sup =
> +	    container_of(port, struct lrx_uart_port, port);

You do this "container_of()" everywhere, why not write a simple macro
for it to make it more obvious like to_lxr_uart_port()?

And why not use container_of_const()?

> +static int lrx_uart_allocate_irq(struct lrx_uart_port *sup)
> +{
> +	lrx_uart_write(sup->im, sup, REG_IMSC);
> +
> +	return request_irq(sup->port.irq, lrx_uart_int, IRQF_SHARED, "lrx-uart", sup);

You had a driver name way above, why not use that instead of this string
here?

> +	/* Set baud rate */
> +	lrx_uart_write(quot & 0x3f, sup, REG_FD);
> +	lrx_uart_write(quot >> 6, sup, REG_IND);
> +
> +	/*
> +	 * ----------v----------v----------v----------v-----
> +	 * NOTE: REG_FRCR MUST BE WRITTEN AFTER REG_FD & REG_IND.
> +	 * ----------^----------^----------^----------^-----
> +	 */

Why the odd comment style?

> +	lrx_uart_write(frcr, sup, REG_FRCR);
> +
> +	lrx_uart_write(fccr, sup, REG_FCCR);

Why the blank line between these?

> +static struct lrx_uart_port *lrx_uart_console_ports[UART_NR];

Why isn't this a dynamic list?

> +/*
> + * While this can be a module, if builtin it&apos;s most likely the console
> + * So let&apos;s leave module_exit but move module_init to an earlier place

Again, your tooling is broken :(

thanks,

greg k-h
