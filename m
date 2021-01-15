Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33BCC433DB
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jan 2021 06:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65ED623436
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jan 2021 06:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbhAOGll (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Jan 2021 01:41:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbhAOGlk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Jan 2021 01:41:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38ACD233EE;
        Fri, 15 Jan 2021 06:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610692858;
        bh=9MERbhiReJBiRm8kfaQDVqQgy0Sf7NtH2rIqHqX2Wrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RrhYkrx3pshSjD+TCbFp2pJ4H5PJlVZcjQ0icHqoiMlCDS+ZZauGwyb7QGzhNOf3d
         mxL7hhA+XGvp4ouDwC0fpbaZuwC+pps8FPICuGP4yeGHpxz0NMyvpvcemTraJXqtep
         C0ETmU/yIhx42WJPS8WaXTMHsghOSbv2yZVEaolM=
Date:   Fri, 15 Jan 2021 07:40:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc:     linux-serial@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Jason Li <jason.li@cortina-access.com>
Subject: Re: [PATCH 1/2] tty: serial: Add UART driver for Cortina-Access
 CAxxxx SoCs
Message-ID: <YAE4+BNIk7Yu4V35@kroah.com>
References: <1610673113-14503-1-git-send-email-alex.nemirovsky@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610673113-14503-1-git-send-email-alex.nemirovsky@cortina-access.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 14, 2021 at 05:11:52PM -0800, Alex Nemirovsky wrote:
> From: Jason Li <jason.li@cortina-access.com>
> 
> 	This driver supports Cortina Access UART IP integrated
> 	in most all CAXXXX line of SoCs. Earlycom is also supported.

Why is this indented?

> 
> Signed-off-by: Jason Li <jason.li@cortina-access.com>
> Reviewed-by: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
> ---
>  .../bindings/serial/cortina-access,serial.yaml     | Bin 0 -> 836 bytes

A binary .yaml file isn't able to be reviewed :(


>  .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
>  MAINTAINERS                                        |   6 +
>  drivers/tty/serial/Kconfig                         |  22 +
>  drivers/tty/serial/Makefile                        |   1 +
>  drivers/tty/serial/serial_cortina-access.c         | 746 +++++++++++++++++++++
>  include/uapi/linux/serial_core.h                   |   3 +
>  7 files changed, 780 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/cortina-access,serial.yaml
>  create mode 100644 drivers/tty/serial/serial_cortina-access.c
> 
> diff --git a/Documentation/devicetree/bindings/serial/cortina-access,serial.yaml b/Documentation/devicetree/bindings/serial/cortina-access,serial.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..c4b734d5d36537cf81e895789a83d15536a26461
> GIT binary patch
> literal 836
> zcmZ`%!E)0u5an8Z#ZFs#svIZnp*W?}kakitW(Y}P=*gqXn^aV`g`_aa0RPTPP6;sO
> z;F0w9?bF*QAHaNi^_dq+V&jnK6*gWi6xs|X(}E9@l(&uE!221znP2e%A8WC4$X?!!
> z-WAYK28?sg4po)GgZC!u^(y>EV%{PqtzGt<e85_`o<pmI?#b4A)d()6MCXn>G}(w+
> zAF#uY`#+@`z2HxBq=VZw=9Sl&!FVe@iqi0LG`j`aHr}>cqh+iXs`2!pbr}QT@K(6C
> zfkMIgm#|B;y8PQ-BHQ|cF=JbUWE*22VMcg$Pgjx(ge#oSXnAHZMhuI~j#!Iz?y+_m
> z^aD<2(At&pQ5E2yved17d@8Bt&(2ul3yWV@*vL(EQK6Go8L!$VgM0zTqNAt8>KHmD
> zLgEw~P!80xq5P_Zu^^&o+a<D_jYN5{9@m}Kc<clj!?mc5?o#3KBl-|p35O28$5Y6s
> zd*T#c!_i7upAKW?=P+ad5TPtCmy6Sr!K?n+88z>9e^Kc-2B~wu6WJfKy`9B?Kbv}>
> zk#(w{r;x6H%Z9^AdO_9QK!G&L$K`yQ!ztvm59RIM^tvprKV28)O+L8^^lgGfJrd@=
> OG*Ukj9PHB=FW4_G6a{kt
> 
> literal 0
> HcmV?d00001

That's a bit hard to read, right?

> +config SERIAL_CORTINA_ACCESS
> +	bool "Cortina-Access serial port support"
> +	select SERIAL_CORE
> +	help
> +	  This driver is for Cortina-Access SoC's UART. If you have a machine
> +	  based on the Cortina-Access SoC and wish to use the serial
> +	  port,
> +	  say 'Y' here.
> +	  Otherwise, say 'N'.

No module support?  Why not?

> +
> +config SERIAL_CORTINA_ACCESS_CONSOLE
> +	bool "Console on Cortina-ACCESS serial port"
> +	depends on SERIAL_CORTINA_ACCESS
> +	select SERIAL_CORE_CONSOLE
> +	select SERIAL_EARLYCON
> +	default y

default y is only if the machine will not boot without it.

> +	help
> +	  Say 'Y' here if you wish to use Cortina-Access UART as the system
> +	  console. The system console is the device which receives all
> +	  kernel messages and warnings and which allows logins in single
> +	  user mode.
> +
>  endmenu
>  
>  config SERIAL_MCTRL_GPIO
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index b85d53f..3e9f211 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -90,6 +90,7 @@ obj-$(CONFIG_SERIAL_RDA)	+= rda-uart.o
>  obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
>  obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
>  obj-$(CONFIG_SERIAL_LITEUART) += liteuart.o
> +obj-$(CONFIG_SERIAL_CORTINA_ACCESS)	+= serial_cortina-access.o
>  
>  # GPIOLIB helpers for modem control lines
>  obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
> diff --git a/drivers/tty/serial/serial_cortina-access.c b/drivers/tty/serial/serial_cortina-access.c
> new file mode 100644
> index 00000000..4498fc4
> --- /dev/null
> +++ b/drivers/tty/serial/serial_cortina-access.c
> @@ -0,0 +1,746 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  UART driver for Cortina-Access Soc platform
> + *  Copyright (C) 2021 Cortina-Access Inc.
> + */
> +#include <linux/module.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/serial.h>
> +#include <linux/sysrq.h>
> +#include <linux/console.h>
> +#include <linux/serial_core.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +/***************************************
> + *	UART Related registers
> + ****************************************/
> +/* register definitions */
> +#define	CFG			0x00
> +#define	FC			0x04
> +#define	RX_SAMPLE		0x08
> +#define	RT_TUNE			0x0C
> +#define	TX_DAT			0x10
> +#define	RX_DAT			0x14
> +#define	INFO			0x18
> +#define	IE			0x1C
> +#define	INT			0x24
> +#define	STATUS			0x2C
> +
> +/* CFG */
> +#define	CFG_STOP_2BIT		BIT(2)
> +#define	CFG_PARITY_EVEN	BIT(3)
> +#define	CFG_PARITY_EN		BIT(4)
> +#define	CFG_TX_EN		BIT(5)
> +#define	CFG_RX_EN		BIT(6)
> +#define	CFG_UART_EN		BIT(7)
> +#define	CFG_BAUD_SART_SHIFT	8
> +
> +/* INFO */
> +#define	INFO_TX_EMPTY		BIT(3)
> +#define	INFO_TX_FULL		BIT(2)
> +#define	INFO_RX_EMPTY		BIT(1)
> +#define	INFO_RX_FULL		BIT(0)
> +
> +/* Interrupt */
> +#define	RX_BREAK		BIT(7)
> +#define	RX_FIFO_NONEMPTYE	BIT(6)
> +#define	TX_FIFO_EMPTYE		BIT(5)
> +#define	RX_FIFO_UNDERRUNE	BIT(4)
> +#define	RX_FIFO_OVERRUNE	BIT(3)
> +#define	RX_PARITY_ERRE		BIT(2)
> +#define	RX_STOP_ERRE		BIT(1)
> +#define	TX_FIFO_OVERRUNE	BIT(0)
> +
> +#define UART_NR 4
> +struct cortina_uart_port {
> +	struct uart_port uart;
> +	char name[16];
> +	char has_bi;
> +	unsigned int may_wakeup;
> +};
> +
> +static struct cortina_uart_port *cortina_uart_ports[UART_NR] = { 0 };

Why a static list?

> +
> +/* Forward decl.s */

No need for the odd comment, right?

> +static irqreturn_t cortina_uart_interrupt(int irq, void *dev_id);
> +
> +/* uart_ops functions */
> +static unsigned int cortina_uart_tx_empty(struct uart_port *port)
> +{
> +	/* Return 0 on FIXO condition, TIOCSER_TEMT otherwise */
> +	return (readl(port->membase + INFO) & INFO_TX_EMPTY) ? TIOCSER_TEMT : 0;
> +}
> +
> +static void cortina_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +	/* None of these signals exist. */

If they do not exist, why have the callback?

> +}
> +
> +static unsigned int cortina_uart_get_mctrl(struct uart_port *port)
> +{
> +	/* Unimplemented signals asserted, per Documentation/serial/driver */
> +	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> +}
> +
> +static void cortina_uart_stop_tx(struct uart_port *port)
> +{
> +	/* Turn off Tx interrupts. The port lock is held at this point */
> +	unsigned int reg_v;
> +
> +	reg_v = readl(port->membase + IE);
> +	writel(reg_v & ~TX_FIFO_EMPTYE, port->membase + IE);
> +}
> +
> +static inline void cortina_transmit_buffer(struct uart_port *port)
> +{
> +	struct circ_buf *xmit = &port->state->xmit;
> +
> +	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +		cortina_uart_stop_tx(port);
> +		return;
> +	}
> +
> +	while (!(readl(port->membase + INFO) & INFO_TX_FULL)) {
> +		/* send xmit->buf[xmit->tail] out the port here */
> +		writel(xmit->buf[xmit->tail], port->membase + TX_DAT);
> +		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> +		port->icount.tx++;
> +		if (uart_circ_empty(xmit))
> +			break;

Busy looping with no way to exit isn't a good idea.

> +	}
> +
> +	if (uart_circ_empty(xmit))
> +		cortina_uart_stop_tx(port);
> +}
> +
> +static void cortina_uart_start_tx(struct uart_port *port)
> +{
> +	/* Turn on Tx interrupts. The port lock is held at this point */
> +	unsigned int reg_v;
> +
> +	reg_v = readl(port->membase + IE);
> +	writel((reg_v | TX_FIFO_EMPTYE), port->membase + IE);
> +
> +	reg_v = readl(port->membase + CFG);
> +	writel(reg_v | CFG_TX_EN, port->membase + CFG);
> +
> +	if (readl(port->membase + INFO) & INFO_TX_EMPTY)
> +		cortina_transmit_buffer(port);
> +}
> +
> +static void cortina_uart_stop_rx(struct uart_port *port)
> +{
> +	/* Turn off Rx interrupts. The port lock is held at this point */
> +	unsigned int reg_v;
> +
> +	reg_v = readl(port->membase + IE);
> +	writel(reg_v & ~RX_FIFO_NONEMPTYE, port->membase + IE);
> +}
> +
> +static void cortina_uart_enable_ms(struct uart_port *port)
> +{
> +	/* Nope, you really can't hope to attach a modem to this */
> +}
> +
> +/* FIXME no such utility found in cortina hardware */
> +static void cortina_uart_break_ctl(struct uart_port *port, int ctl)
> +{
> +	/* NA */

If it's not needed, then do not provide a function for it at all.

> +}
> +
> +static int cortina_uart_startup(struct uart_port *port)
> +{
> +	unsigned int reg_v;
> +	int retval;
> +	unsigned long flags;
> +
> +	/* Disable interrupt */
> +	writel(0, port->membase + IE);
> +
> +	retval =
> +	    request_irq(port->irq, cortina_uart_interrupt, 0, "cortina_uart",
> +			port);
> +	if (retval)
> +		return retval;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	reg_v = readl(port->membase + CFG);
> +	reg_v |= (CFG_UART_EN | CFG_TX_EN | CFG_RX_EN | 0x3 /* 8-bits data */);
> +	writel(reg_v, port->membase + CFG);
> +	reg_v = readl(port->membase + IE);
> +	writel(reg_v | RX_FIFO_NONEMPTYE | TX_FIFO_EMPTYE, port->membase + IE);
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +	return 0;
> +}
> +
> +static void cortina_uart_shutdown(struct uart_port *port)
> +{
> +	cortina_uart_stop_tx(port);
> +	cortina_uart_stop_rx(port);
> +	free_irq(port->irq, port);
> +}
> +
> +static void cortina_uart_set_termios(struct uart_port *port,
> +				     struct ktermios *termios,
> +				     struct ktermios *old)
> +{
> +	unsigned long flags;
> +	int baud;
> +	unsigned int reg_v, sample_freq = 0;
> +
> +	baud = uart_get_baud_rate(port, termios, old, 0, 230400);
> +	reg_v = readl(port->membase + CFG);
> +	/* mask off the baud settings */
> +	reg_v &= 0xff;
> +	reg_v |= (port->uartclk / baud) << CFG_BAUD_SART_SHIFT;
> +
> +	/* Sampling rate should be half of baud count */
> +	sample_freq = (reg_v >> CFG_BAUD_SART_SHIFT) / 2;
> +
> +	/* See include/uapi/asm-generic/termbits.h for CSIZE definition */
> +	/* mask off the data width */
> +	reg_v &= 0xfffffffc;
> +	switch (termios->c_cflag & CSIZE) {
> +	case CS5:
> +		reg_v |= 0x0;
> +		break;
> +	case CS6:
> +		reg_v |= 0x1;
> +		break;
> +	case CS7:
> +		reg_v |= 0x2;
> +		break;
> +	case CS8:
> +	default:
> +		reg_v |= 0x3;
> +		break;
> +	}
> +
> +	/* mask off Stop bits */
> +	reg_v &= ~(CFG_STOP_2BIT);
> +	if (termios->c_cflag & CSTOPB)
> +		reg_v |= CFG_STOP_2BIT;
> +
> +	/* Parity */
> +	reg_v &= ~(CFG_PARITY_EN);
> +	reg_v |= CFG_PARITY_EVEN;
> +	if (termios->c_cflag & PARENB) {
> +		reg_v |= CFG_PARITY_EN;
> +		if (termios->c_cflag & PARODD)
> +			reg_v &= ~(CFG_PARITY_EVEN);
> +	}
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	writel(reg_v, port->membase + CFG);
> +	writel(sample_freq, port->membase + RX_SAMPLE);
> +	spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static const char *cortina_uart_type(struct uart_port *port)
> +{
> +	if (port->type != PORT_CORTINA_ACCESS)
> +		return NULL;
> +
> +	return container_of(port, struct cortina_uart_port, uart)->name;
> +}
> +
> +static void cortina_uart_release_port(struct uart_port *port)
> +{
> +	/* Easy enough */

Are you sure?

> +}
> +
> +static int cortina_uart_request_port(struct uart_port *port)
> +{
> +	return 0;
> +}
> +
> +static void cortina_uart_config_port(struct uart_port *port, int flags)
> +{
> +	if (flags & UART_CONFIG_TYPE)
> +		port->type = PORT_CORTINA_ACCESS;
> +}
> +
> +static int cortina_uart_verify_port(struct uart_port *port,
> +				    struct serial_struct *ser)
> +{
> +	if (ser->type != PORT_UNKNOWN && ser->type != PORT_CORTINA_ACCESS)
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +#ifdef CONFIG_CONSOLE_POLL
> +static int cortina_poll_get_char(struct uart_port *port)
> +{
> +	unsigned int rx;
> +
> +	while (readl(port->membase + INFO) & INFO_RX_EMPTY)
> +		;

Again, busy loops are bad.

> +	rx = readl(port->membase + RX_DAT);
> +
> +	return rx;
> +}
> +
> +static void cortina_poll_put_char(struct uart_port *port, unsigned char c)
> +{
> +	unsigned int ie = readl(port->membase + IE);
> +
> +	/* Disable interrupts */
> +	writel(0, port->membase + IE);
> +	while (!(readl(port->membase + INFO) & INFO_TX_EMPTY))
> +		;
> +
> +	writel(c, port->membase + TX_DAT);
> +	while (!(readl(port->membase + INFO) & INFO_TX_EMPTY))
> +		;

Hopefully the hardware never breaks :(


> +
> +	/* Enable interrupt */
> +	writel(ie, port->membase + IE);
> +}
> +
> +#endif
> +
> +static const struct uart_ops cortina_uart_ops = {
> +	.tx_empty = cortina_uart_tx_empty,
> +	.set_mctrl = cortina_uart_set_mctrl,
> +	.get_mctrl = cortina_uart_get_mctrl,
> +	.stop_tx = cortina_uart_stop_tx,
> +	.start_tx = cortina_uart_start_tx,
> +	.stop_rx = cortina_uart_stop_rx,
> +	.enable_ms = cortina_uart_enable_ms,
> +	.break_ctl = cortina_uart_break_ctl,
> +	.startup = cortina_uart_startup,
> +	.shutdown = cortina_uart_shutdown,
> +	.set_termios = cortina_uart_set_termios,
> +	.type = cortina_uart_type,
> +	.release_port = cortina_uart_release_port,
> +	.request_port = cortina_uart_request_port,
> +	.config_port = cortina_uart_config_port,
> +	.verify_port = cortina_uart_verify_port,
> +#ifdef CONFIG_CONSOLE_POLL
> +	.poll_get_char = cortina_poll_get_char,
> +	.poll_put_char = cortina_poll_put_char,
> +#endif
> +};
> +
> +static inline void cortina_uart_interrupt_rx_chars(struct uart_port *port,
> +						   unsigned long status)
> +{
> +	struct tty_port *ttyport = &port->state->port;
> +	unsigned int ch;
> +	unsigned int rx, flg;
> +
> +	rx = readl(port->membase + INFO);
> +	if (INFO_RX_EMPTY & rx)
> +		return;
> +
> +	if (status & RX_FIFO_OVERRUNE)
> +		port->icount.overrun++;
> +
> +	/* Read the character while FIFO is not empty */
> +	do {
> +		flg = TTY_NORMAL;
> +		port->icount.rx++;
> +		ch = readl(port->membase + RX_DAT);
> +		if (status & RX_PARITY_ERRE) {
> +			port->icount.parity++;
> +			flg = TTY_PARITY;
> +		}
> +
> +		if (cortina_uart_ports[port->line]->has_bi) {
> +			/* If BI supported ? */
> +			if (status & RX_BREAK) {
> +				port->icount.brk++;
> +				if (uart_handle_break(port))
> +					goto ignore;
> +			}
> +		} else {
> +			/* Treat stop err as BI */
> +			if (status & RX_STOP_ERRE) {
> +				port->icount.brk++;
> +				if (uart_handle_break(port))
> +					goto ignore;
> +			}
> +		}
> +		if (!(ch & 0x100)) /* RX char is not valid */
> +			goto ignore;
> +
> +		if (uart_handle_sysrq_char(port, (unsigned char)ch))
> +			goto ignore;
> +
> +		tty_insert_flip_char(ttyport, ch, flg);
> + ignore:
> +		rx = readl(port->membase + INFO);
> +	} while (!(INFO_RX_EMPTY & rx));
> +
> +	spin_unlock(&port->lock);
> +	tty_flip_buffer_push(ttyport);
> +	spin_lock(&port->lock);
> +}
> +
> +static inline void cortina_uart_interrupt_tx_chars(struct uart_port *port)
> +{
> +	struct circ_buf *xmit = &port->state->xmit;
> +
> +	/* Process out of band chars */
> +	if (port->x_char) {
> +		/* Send next char */
> +		writel(port->x_char, port->membase + TX_DAT);
> +		goto done;
> +	}
> +
> +	/* Nothing to do ? */
> +	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +		cortina_uart_stop_tx(port);
> +		goto done;
> +	}
> +
> +	cortina_transmit_buffer(port);
> +
> +	/* Wake up */
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);
> +
> +	/* Maybe we're done after all */
> +	if (uart_circ_empty(xmit))
> +		cortina_uart_stop_tx(port);
> +
> +	/* Ack the interrupt */

You didn't ack anything.

> + done:
> +	return;
> +}
> +
> +irqreturn_t cortina_uart_interrupt(int irq, void *dev_id)
> +{
> +	struct uart_port *port = (struct uart_port *)dev_id;
> +	unsigned int irq_status;
> +
> +	spin_lock(&port->lock);
> +
> +	/* Clear interrupt! */
> +	irq_status = readl(port->membase + INT);
> +	writel(irq_status, port->membase + INT);
> +
> +	/* Process any Rx chars first */
> +	cortina_uart_interrupt_rx_chars(port, irq_status);
> +	/* Then use any Tx space */
> +	cortina_uart_interrupt_tx_chars(port);
> +
> +	spin_unlock(&port->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +void cortina_console_write(struct console *co, const char *s,
> +			   unsigned int count)
> +{
> +	struct uart_port *port = &cortina_uart_ports[co->index]->uart;
> +	unsigned int i, previous;
> +	unsigned long flags;
> +	int locked;
> +
> +	local_irq_save(flags);
> +	if (port->sysrq) {
> +		locked = 0;
> +	} else if (oops_in_progress) {
> +		locked = spin_trylock(&port->lock);
> +	} else {
> +		spin_lock(&port->lock);
> +		locked = 1;
> +	}
> +
> +	/* Save current state */
> +	previous = readl(port->membase + IE);
> +	/* Disable Tx interrupts so this all goes out in one go */
> +	cortina_uart_stop_tx(port);
> +
> +	/* Write all the chars */
> +	for (i = 0; i < count; i++) {
> +		/* Wait the TX buffer to be empty, which can't take forever */
> +		while (!(readl(port->membase + INFO) & INFO_TX_EMPTY))
> +			cpu_relax();
> +
> +		/* Send the char */
> +		writel(*s, port->membase + TX_DAT);
> +
> +		/* CR/LF stuff */
> +		if (*s++ == '\n') {
> +			/* Wait the TX buffer to be empty */
> +			while (!(readl(port->membase + INFO) & INFO_TX_EMPTY))
> +				cpu_relax();
> +			writel('\r', port->membase + TX_DAT);
> +		}
> +	}
> +
> +	writel(previous, port->membase + IE);	/* Put it all back */
> +
> +	if (locked)
> +		spin_unlock(&port->lock);
> +	local_irq_restore(flags);
> +}
> +
> +static int __init cortina_console_setup(struct console *co, char *options)
> +{
> +	struct uart_port *port;
> +	int baud = 115200;
> +	int bits = 8;
> +	int parity = 'n';
> +	int flow = 'n';
> +
> +	if (co->index < 0 || co->index >= UART_NR)
> +		return -ENODEV;
> +
> +	if (!cortina_uart_ports[co->index])
> +		return -ENODEV;
> +
> +	port = &cortina_uart_ports[co->index]->uart;
> +
> +	/* This isn't going to do much, but it might change the baud rate. */
> +	if (options)
> +		uart_parse_options(options, &baud, &parity, &bits, &flow);
> +
> +	return uart_set_options(port, co, baud, parity, bits, flow);
> +}
> +
> +static struct uart_driver cortina_uart_driver;	/* Forward decl. */
> +
> +static struct console cortina_console = {
> +	.name = "ttyS",
> +	.write = cortina_console_write,
> +	.device = uart_console_device,
> +	.setup = cortina_console_setup,
> +	.flags = CON_PRINTBUFFER,
> +	.index = -1,		/* Only possible option. */
> +	.data = &cortina_uart_driver,
> +};
> +
> +/* Support EARLYCON */
> +static void cortina_putc(struct uart_port *port, int c)
> +{
> +	while (!(readl(port->membase + INFO) & INFO_TX_EMPTY))
> +		udelay(10);

Again, no way to exit?

thanks,

greg k-h
