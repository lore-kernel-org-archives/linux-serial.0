Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7374DC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 05:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B11661B4C
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 05:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhKSFWh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Nov 2021 00:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhKSFWg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Nov 2021 00:22:36 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751B3C061574;
        Thu, 18 Nov 2021 21:19:35 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso7911658pjb.0;
        Thu, 18 Nov 2021 21:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YMiURWmqTpU/U6o1VroYvaE7qRYENpzomqdg3i3Hsuo=;
        b=Bsl4Akj3dxE3l8I1UX9hYF6155HmEjeGAJDe/DYtveuT07Rn3GrSn8cZTTlqufRQTa
         aCbS5NaRhaAC1SKWpqtP5srM3KL1dEMCf8psD2jzQx4K/m6AcWkKBE3/ApKluZ0HKfC0
         HkFI7J/+OV4MgjUgBRmk7dRCThdLs9PETta6X1dfbMRqdn5UlVqlx2aGyzDLhf0HAKpq
         xqe0cPP2WkPDmoNLF00ZRiWsEjY0tEyYaCijr9AcmtO9T7cXQoN234dbgRyuWbRSTKb3
         01RcpMteNzjpQETDFSFyvl8HDWQrN6kyRuGsQeSxE6dRuGIcFla4+CqmDXovKpqDYDJy
         jv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YMiURWmqTpU/U6o1VroYvaE7qRYENpzomqdg3i3Hsuo=;
        b=JpZcNTx8RBgdzms4qJBNvDo6F+hSZYWi/2xEFvjRw+EYjNTuKx0cniUpO3lU1vKv4q
         gzQu5tKxXHbx2QlARxLCgBWKPx6YS0ckH2KAfz6JN5z6QiEWWT/qBwoWRCIp4l+Qs7yX
         /Xh2tFEMXmy1ScZi8ZVDZMLYRsUyP+jPuFPiR7iIbjcMVF4ufCB18GKKx3WvWfaMGNjT
         AJV+A/s7Qe2wlpTAtR1B7/q+8thdbnarlsPxnF4svIE0DkByq86cNZjkBvoC0GGPGRVT
         bE23dld/mYGusTrqlRAFdspLUl4Lnf+UUG1M/7WHE56BPtxMYLnEsTsbvzXCTrurXL6Z
         GTdQ==
X-Gm-Message-State: AOAM530r4LrII1fyo2+n8xYEqWvcdiNo6jvbkyEQoVmoi1blNVziA0PH
        zfzJW2WpHRqJ2CRzxnevKxaKFLFbhnud/Rj9
X-Google-Smtp-Source: ABdhPJx7mZLx00gNCZKndZv+Ya+ZyW0atWz3K6s4tsSepSTfmR1cC7ijNWvpRVigeX5oaRKUyur7vw==
X-Received: by 2002:a17:902:e890:b0:142:f3:7bf7 with SMTP id w16-20020a170902e89000b0014200f37bf7mr72293576plg.87.1637299174835;
        Thu, 18 Nov 2021 21:19:34 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id c2sm1332935pfv.112.2021.11.18.21.19.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Nov 2021 21:19:31 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
X-Google-Original-From: Hammer Hsieh <hammer.hsieh@sunplus.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: [PATCH v3 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Date:   Fri, 19 Nov 2021 13:19:23 +0800
Message-Id: <1637299163-6460-3-git-send-email-hammer.hsieh@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637299163-6460-1-git-send-email-hammer.hsieh@sunplus.com>
References: <1635752903-14968-1-git-send-email-hammer.hsieh@sunplus.com>
 <1637299163-6460-1-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add Sunplus SoC UART Driver

Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>
---
Changes in v3:
 - Addressed all comments from Andy Shevchenko and Philipp Zabel.

 MAINTAINERS                       |   2 +
 drivers/tty/serial/Kconfig        |  23 +
 drivers/tty/serial/Makefile       |   1 +
 drivers/tty/serial/sunplus-uart.c | 903 ++++++++++++++++++++++++++++++++++++++
 include/soc/sunplus/sp_uart.h     |  93 ++++
 5 files changed, 1022 insertions(+)
 create mode 100644 drivers/tty/serial/sunplus-uart.c
 create mode 100644 include/soc/sunplus/sp_uart.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f2ee40c..14790a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17949,6 +17949,8 @@ SUNPLUS UART DRIVER
 M:	Hammer Hsieh <hammer.hsieh@sunplus.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
+F:	drivers/tty/serial/sunplus-uart.c
+F:	include/soc/sunplus/sp-uart.h
 
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 131a6a5..319f5db 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1561,6 +1561,29 @@ config SERIAL_LITEUART_CONSOLE
 	  and warnings and which allows logins in single user mode).
 	  Otherwise, say 'N'.
 
+config SERIAL_SUNPLUS
+	bool "Sunplus UART support"
+	depends on OF
+	select SERIAL_CORE
+	help
+	  Select this option if you would like to use Sunplus serial port on
+	  Sunplus SoC SP7021.
+	  If you enable this option, Sunplus serial ports in the system will
+	  be registered as ttySx.
+
+config SERIAL_SUNPLUS_CONSOLE
+	bool "Console on Sunplus UART"
+	depends on SERIAL_SUNPLUS
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	help
+	  Select this option if you would like to use a Sunplus UART as the
+	  system console.
+	  Even if you say Y here, the currently visible virtual console
+	  (/dev/tty0) will still be used as the system console by default, but
+	  you can alter that using a kernel command line option such as
+	  "console=ttySx".
+
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 7da0856..61cc8de 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_SERIAL_RDA)	+= rda-uart.o
 obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
 obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
 obj-$(CONFIG_SERIAL_LITEUART) += liteuart.o
+obj-$(CONFIG_SERIAL_SUNPLUS)	+= sunplus-uart.o
 
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
new file mode 100644
index 0000000..b339772
--- /dev/null
+++ b/drivers/tty/serial/sunplus-uart.c
@@ -0,0 +1,903 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sunplus SoC UART driver
+ *
+ * Author: Hammer Hsieh <hammer.hsieh@sunplus.com>
+ * Tony Huang <tony.huang@sunplus.com>
+ * Wells Lu <wells.lu@sunplus.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/of_platform.h>
+#include <asm/irq.h>
+#include <linux/sysrq.h>
+#include <linux/serial_core.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+#include <soc/sunplus/sp_uart.h>
+
+#define UART_NR			5
+
+static struct uart_driver sunplus_uart_driver;
+
+struct sunplus_uart_port {
+	char name[16];
+	struct uart_port port;
+	struct clk *clk;
+	struct reset_control *rstc;
+};
+
+static inline struct sunplus_uart_port *to_sunplus_uart(struct uart_port *port)
+{
+	return container_of(port, struct sunplus_uart_port, port);
+}
+
+static inline void sp_uart_put_char(struct uart_port *port, unsigned int ch)
+{
+	writel(ch, port->membase + SP_UART_DATA);
+}
+
+static inline u32 sp_uart_line_status_tx_buf_not_full(struct uart_port *port)
+{
+	return ((readl(port->membase + SP_UART_LSR) & SP_UART_LSR_TX)
+		? SP_UART_LSR_TX_NOT_FULL : 0);
+}
+
+static unsigned int sunplus_tx_empty(struct uart_port *port)
+{
+	return ((readl(port->membase + SP_UART_LSR) & SP_UART_LSR_TXE)
+		? TIOCSER_TEMT : 0);
+}
+
+static void sunplus_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	unsigned int mcr = readl(port->membase + SP_UART_MCR);
+
+	if (mctrl & TIOCM_DTR)
+		mcr |= SP_UART_MCR_DTS;
+	else
+		mcr &= ~SP_UART_MCR_DTS;
+
+	if (mctrl & TIOCM_RTS)
+		mcr |= SP_UART_MCR_RTS;
+	else
+		mcr &= ~SP_UART_MCR_RTS;
+
+	if (mctrl & TIOCM_CAR)
+		mcr |= SP_UART_MCR_DCD;
+	else
+		mcr &= ~SP_UART_MCR_DCD;
+
+	if (mctrl & TIOCM_RI)
+		mcr |= SP_UART_MCR_RI;
+	else
+		mcr &= ~SP_UART_MCR_RI;
+
+	if (mctrl & TIOCM_LOOP)
+		mcr |= SP_UART_MCR_LB;
+	else
+		mcr &= ~SP_UART_MCR_LB;
+
+	writel(mcr, port->membase + SP_UART_MCR);
+
+}
+
+static unsigned int sunplus_get_mctrl(struct uart_port *port)
+{
+	unsigned int ret, mcr;
+
+	mcr = readl(port->membase + SP_UART_MCR);
+
+	if (mcr & SP_UART_MCR_DTS)
+		ret |= TIOCM_DTR;
+
+	if (mcr & SP_UART_MCR_RTS)
+		ret |= TIOCM_RTS;
+
+	if (mcr & SP_UART_MCR_DCD)
+		ret |= TIOCM_CAR;
+
+	if (mcr & SP_UART_MCR_RI)
+		ret |= TIOCM_RI;
+
+	if (mcr & SP_UART_MCR_LB)
+		ret |= TIOCM_LOOP;
+
+	if (mcr & SP_UART_MCR_AC)
+		ret |= TIOCM_CTS;
+
+	return ret;
+}
+
+static void sunplus_stop_tx(struct uart_port *port)
+{
+	unsigned int isc;
+
+	isc = readl(port->membase + SP_UART_ISC);
+	isc &= ~SP_UART_ISC_TXM;
+	writel(isc, port->membase + SP_UART_ISC);
+}
+
+static void sunplus_start_tx(struct uart_port *port)
+{
+	unsigned int isc;
+
+	isc = readl(port->membase + SP_UART_ISC);
+	isc |= SP_UART_ISC_TXM;
+	writel(isc, port->membase + SP_UART_ISC);
+}
+
+static void sunplus_stop_rx(struct uart_port *port)
+{
+	unsigned int isc;
+
+	isc = readl(port->membase + SP_UART_ISC);
+	isc &= ~SP_UART_ISC_RXM;
+	writel(isc, port->membase + SP_UART_ISC);
+}
+
+static void sunplus_enable_ms(struct uart_port *port)
+{
+	/* Do nothing */
+}
+
+static void sunplus_break_ctl(struct uart_port *port, int ctl)
+{
+	unsigned long flags;
+	unsigned int lcr;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	lcr = readl(port->membase + SP_UART_LCR);
+
+	if (ctl != 0)
+		lcr |= SP_UART_LCR_BC;	/* start break */
+	else
+		lcr &= ~SP_UART_LCR_BC;	/* stop break */
+
+	writel(lcr, port->membase + SP_UART_LCR);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void transmit_chars(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->state->xmit;
+
+	if (port->x_char) {
+		sp_uart_put_char(port, port->x_char);
+		port->icount.tx++;
+		port->x_char = 0;
+		return;
+	}
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		sunplus_stop_tx(port);
+		return;
+	}
+
+	do {
+		sp_uart_put_char(port, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+
+		if (uart_circ_empty(xmit))
+			break;
+	} while (sp_uart_line_status_tx_buf_not_full(port));
+
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (uart_circ_empty(xmit))
+		sunplus_stop_tx(port);
+}
+
+/* called by ISR */
+static void receive_chars(struct uart_port *port)
+{
+	struct tty_struct *tty = port->state->port.tty;
+	unsigned int lsr = readl(port->membase + SP_UART_LSR);
+	unsigned int ch, flag;
+
+	do {
+		ch = readl(port->membase + SP_UART_DATA);
+
+		flag = TTY_NORMAL;
+		port->icount.rx++;
+
+		if (unlikely(lsr & SP_UART_LSR_BRK_ERROR_BITS)) {
+			if (port->cons == NULL)
+				dev_err(port->dev, "UART%d, SP_UART_LSR_BRK_ERROR_BITS, lsr = 0x%08X\n",
+					port->line, lsr);
+
+			if (lsr & SP_UART_LSR_BC) {
+				lsr &= ~(SP_UART_LSR_FE | SP_UART_LSR_PE);
+				port->icount.brk++;
+				if (uart_handle_break(port))
+					goto ignore_char;
+			} else if (lsr & SP_UART_LSR_PE) {
+				if (port->cons == NULL)
+					dev_err(port->dev, "UART%d, SP_UART_LSR_PE\n", port->line);
+				port->icount.parity++;
+			} else if (lsr & SP_UART_LSR_FE) {
+				if (port->cons == NULL)
+					dev_err(port->dev, "UART%d, SP_UART_LSR_FE\n", port->line);
+				port->icount.frame++;
+			}
+			if (lsr & SP_UART_LSR_OE) {
+				if (port->cons == NULL)
+					dev_err(port->dev, "UART%d, SP_UART_LSR_OE\n", port->line);
+				port->icount.overrun++;
+			}
+
+			/*
+			 * Mask off conditions which should be ignored.
+			 */
+
+			/* lsr &= port->read_status_mask; */
+
+			if (lsr & SP_UART_LSR_BC)
+				flag = TTY_BREAK;
+			else if (lsr & SP_UART_LSR_PE)
+				flag = TTY_PARITY;
+			else if (lsr & SP_UART_LSR_FE)
+				flag = TTY_FRAME;
+		}
+
+		if (port->ignore_status_mask & SP_UART_CREAD_DISABLED)
+			goto ignore_char;
+
+		if (uart_handle_sysrq_char(port, ch))
+			goto ignore_char;
+
+		uart_insert_char(port, lsr, SP_UART_LSR_OE, ch, flag);
+
+ignore_char:
+		lsr = readl(port->membase + SP_UART_LSR);
+	} while (lsr & SP_UART_LSR_RX);
+
+	if (tty) {
+		spin_unlock(&port->lock);
+		tty_flip_buffer_push(tty->port);
+		spin_lock(&port->lock);
+	}
+}
+
+static irqreturn_t sunplus_uart_irq(int irq, void *args)
+{
+	struct uart_port *port = (struct uart_port *)args;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (readl(port->membase + SP_UART_ISC) & SP_UART_ISC_RX)
+		receive_chars(port);
+
+	if (readl(port->membase + SP_UART_ISC) & SP_UART_ISC_TX)
+		transmit_chars(port);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static int sunplus_startup(struct uart_port *port)
+{
+	struct sunplus_uart_port *sup = to_sunplus_uart(port);
+	u32 interrupt_en;
+	int ret;
+
+#ifdef CONFIG_PM_RUNTIME_UART
+	if (port->line > 0) {
+		ret = pm_runtime_get_sync(port->dev);
+		if (ret < 0)
+			goto out;
+	}
+#endif
+
+	ret = request_irq(port->irq, sunplus_uart_irq, 0, sup->name, port);
+	if (ret)
+		return ret;
+
+	/*
+	 * don't need to use spin_lock_irqsave() because interrupts
+	 * are globally disabled
+	 */
+	spin_lock_irq(&port->lock);
+
+	/* SP_UART_ISC_TXM is enabled in .start_tx() */
+	interrupt_en |= SP_UART_ISC_RXM;
+
+	writel(interrupt_en, port->membase + SP_UART_ISC);
+
+	spin_unlock_irq(&port->lock);
+
+#ifdef CONFIG_PM_RUNTIME_UART
+	if (port->line > 0)
+		pm_runtime_put(port->dev);
+
+	return 0;
+
+out:
+	if (port->line > 0) {
+		pm_runtime_mark_last_busy(port->dev);
+		pm_runtime_put_autosuspend(port->dev);
+	}
+#endif
+	return 0;
+
+}
+
+static void sunplus_shutdown(struct uart_port *port)
+{
+	unsigned int mcr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	writel(0, port->membase + SP_UART_ISC);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	free_irq(port->irq, port);
+
+	/* Disable flow control of Tx, so that queued data can be sent out
+	 * There is no way for s/w to let h/w abort in the middle of
+	 * transaction.
+	 * Don't reset module except it's in idle state. Otherwise, it might
+	 * cause bus to hang.
+	 */
+	mcr = readl(port->membase + SP_UART_MCR);
+	mcr &= ~SP_UART_MCR_AC;
+	writel(mcr, port->membase + SP_UART_MCR);
+
+}
+
+static void sunplus_set_termios(struct uart_port *port,
+	struct ktermios *termios, struct ktermios *oldtermios)
+{
+	u32 clk, ext, div, div_l, div_h, baud;
+	u32 lcr, mcr;
+	unsigned long flags;
+
+	clk = port->uartclk;
+
+	baud = uart_get_baud_rate(port, termios, oldtermios, 0, port->uartclk / 16);
+
+	/*
+	 * Send all data in Tx FIFO before changing clock source,
+	 * it should be UART0 only
+	 */
+	while (!(readl(port->membase + SP_UART_LSR) & SP_UART_LSR_TXE))
+		;
+
+	clk += baud >> 1;
+	div = clk / baud;
+	ext = div & 0x0F;
+	div = (div >> 4) - 1;
+	div_l = (div & 0xFF) | (ext << 12);
+	div_h = div >> 8;
+
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		lcr = SP_UART_LCR_WL5;
+		break;
+	case CS6:
+		lcr = SP_UART_LCR_WL6;
+		break;
+	case CS7:
+		lcr = SP_UART_LCR_WL7;
+		break;
+	default:	/* CS8 */
+		lcr = SP_UART_LCR_WL8;
+		break;
+	}
+
+	if (termios->c_cflag & CSTOPB)
+		lcr |= SP_UART_LCR_ST;
+
+	if (termios->c_cflag & PARENB) {
+		lcr |= SP_UART_LCR_PE;
+
+		if (!(termios->c_cflag & PARODD))
+			lcr |= SP_UART_LCR_PR;
+	}
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	port->read_status_mask = 0;
+	if (termios->c_iflag & INPCK)
+		port->read_status_mask |= SP_UART_LSR_PE | SP_UART_LSR_FE;
+
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		port->read_status_mask |= SP_UART_LSR_BC;
+
+	/*
+	 * Characters to ignore
+	 */
+	port->ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		port->ignore_status_mask |= SP_UART_LSR_FE | SP_UART_LSR_PE;
+
+	if (termios->c_iflag & IGNBRK) {
+		port->ignore_status_mask |= SP_UART_LSR_BC;
+
+		if (termios->c_iflag & IGNPAR)
+			port->ignore_status_mask |= SP_UART_LSR_OE;
+	}
+
+	/*
+	 * Ignore all characters if CREAD is not set.
+	 */
+	if ((termios->c_cflag & CREAD) == 0) {
+		port->ignore_status_mask |= SP_UART_CREAD_DISABLED;
+		/* flush rx data FIFO */
+		writel(0, port->membase + SP_UART_RX_RESIDUE);
+	}
+
+	mcr = readl(port->membase + SP_UART_MCR);
+
+	if (termios->c_cflag & CRTSCTS)
+		mcr |= (SP_UART_MCR_AC | SP_UART_MCR_AR);
+	else
+		mcr &= ~(SP_UART_MCR_AC | SP_UART_MCR_AR);
+
+	writel(mcr, port->membase + SP_UART_MCR);
+
+	/* do not set these in emulation */
+	writel(div_h, port->membase + SP_UART_DIV_H);
+	writel(div_l, port->membase + SP_UART_DIV_L);
+	writel(lcr, port->membase + SP_UART_LCR);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void sunplus_set_ldisc(struct uart_port *port,
+				       struct ktermios *termios)
+{
+	int new = termios->c_line;
+
+	if (new == N_PPS) {
+		port->flags |= UPF_HARDPPS_CD;
+		sunplus_enable_ms(port);
+	} else {
+		port->flags &= ~UPF_HARDPPS_CD;
+	}
+}
+
+static const char *sunplus_type(struct uart_port *port)
+{
+	struct sunplus_uart_port *sup = to_sunplus_uart(port);
+
+	return sup->name;
+}
+
+static void sunplus_release_port(struct uart_port *port)
+{
+}
+
+static int sunplus_request_port(struct uart_port *port)
+{
+	return 0;
+}
+
+static void sunplus_config_port(struct uart_port *port, int type)
+{
+	if (type & UART_CONFIG_TYPE) {
+		port->type = PORT_SUNPLUS;
+		sunplus_request_port(port);
+	}
+}
+
+static int sunplus_verify_port(struct uart_port *port, struct serial_struct *serial)
+{
+	return -EINVAL;
+}
+
+#ifdef CONFIG_CONSOLE_POLL
+static int sunplus_poll_init(struct uart_port *port)
+{
+	return 0;
+}
+
+static void sunplus_poll_put_char(struct uart_port *port, unsigned char data)
+{
+	wait_for_xmitr(port);
+	sp_uart_put_char(port, data);
+}
+
+static int sunplus_poll_get_char(struct uart_port *port)
+{
+	unsigned int lsr;
+
+	do {
+		lsr = readl(port->membase + SP_UART_LSR);
+	} while (!(lsr & SP_UART_LSR_RX));
+
+	return readl(port->membase + SP_UART_DATA);
+}
+#endif /* CONFIG_CONSOLE_POLL */
+
+static const struct uart_ops sunplus_uart_ops = {
+	.tx_empty		= sunplus_tx_empty,
+	.set_mctrl		= sunplus_set_mctrl,
+	.get_mctrl		= sunplus_get_mctrl,
+	.stop_tx		= sunplus_stop_tx,
+	.start_tx		= sunplus_start_tx,
+	.stop_rx		= sunplus_stop_rx,
+	.enable_ms		= sunplus_enable_ms,
+	.break_ctl		= sunplus_break_ctl,
+	.startup		= sunplus_startup,
+	.shutdown		= sunplus_shutdown,
+	.set_termios	= sunplus_set_termios,
+	.set_ldisc		= sunplus_set_ldisc,
+	.type			= sunplus_type,
+	.release_port	= sunplus_release_port,
+	.request_port	= sunplus_request_port,
+	.config_port	= sunplus_config_port,
+	.verify_port	= sunplus_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_init		= sunplus_poll_init,
+	.poll_put_char	= sunplus_poll_put_char,
+	.poll_get_char	= sunplus_poll_get_char,
+#endif /* CONFIG_CONSOLE_POLL */
+};
+
+#ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
+struct sunplus_uart_port *sunplus_console_ports[UART_NR];
+
+static inline void wait_for_xmitr(struct uart_port *port)
+{
+	while (1) {
+		if (sp_uart_line_status_tx_buf_not_full(port))
+			break;
+	}
+}
+
+static void sunplus_uart_console_putchar(struct uart_port *port, int ch)
+{
+	wait_for_xmitr(port);
+	sp_uart_put_char(port, ch);
+}
+
+static void sunplus_uart_console_write(struct console *co,
+	const char *s, unsigned int count)
+{
+	unsigned long flags;
+	int locked = 1;
+
+	local_irq_save(flags);
+
+	if (sunplus_console_ports[co->index]->port.sysrq)
+		locked = 0;
+	else if (oops_in_progress)
+		locked = spin_trylock(&sunplus_console_ports[co->index]->port.lock);
+	else
+		spin_lock(&sunplus_console_ports[co->index]->port.lock);
+
+	uart_console_write(&sunplus_console_ports[co->index]->port,
+		s, count, sunplus_uart_console_putchar);
+
+	if (locked)
+		spin_unlock(&sunplus_console_ports[co->index]->port.lock);
+
+	local_irq_restore(flags);
+}
+
+static int __init sunplus_uart_console_setup(struct console *co, char *options)
+{
+	struct sunplus_uart_port *sup;
+	int baud = 115200;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	if ((co->index >= UART_NR) || (co->index < 0))
+		return -EINVAL;
+
+	sup = sunplus_console_ports[co->index];
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(&sup->port, co, baud, parity, bits, flow);
+}
+
+static struct console sunplus_uart_console = {
+	.name		= "ttyS",
+	.write		= sunplus_uart_console_write,
+	.device		= uart_console_device,
+	.setup		= sunplus_uart_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &sunplus_uart_driver
+};
+#endif
+
+static struct uart_driver sunplus_uart_driver = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "Sunplus_UART",
+	.dev_name	= "ttyS",
+	.major		= TTY_MAJOR,
+	.minor		= 64,
+	.nr			= UART_NR,
+	.cons		= NULL,
+};
+
+static int sunplus_uart_probe(struct platform_device *pdev)
+{
+	struct sunplus_uart_port *sup;
+	struct resource *res_mem;
+	struct uart_port *port;
+	int ret, irq;
+
+	if (pdev->dev.of_node) {
+		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
+		if (pdev->id < 0)
+			pdev->id = of_alias_get_id(pdev->dev.of_node, "uart");
+	}
+
+	if (pdev->id < 0 || pdev->id >= UART_NR)
+		return -EINVAL;
+
+	sup = devm_kzalloc(&pdev->dev, sizeof(struct sunplus_uart_port),
+			  GFP_KERNEL);
+	if (!sup)
+		return -ENOMEM;
+
+	sup->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(sup->clk)) {
+		dev_err(&pdev->dev, "unable to get UART clock\n");
+		return PTR_ERR(sup->clk);
+	}
+
+	sup->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(sup->rstc))
+		return PTR_ERR(sup->rstc);
+
+	port = &sup->port;
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res_mem)
+		return -ENODEV;
+
+	port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
+	if (IS_ERR(port->membase))
+		return PTR_ERR(port->membase);
+
+	ret = clk_prepare_enable(sup->clk);
+	if (ret)
+		return ret;
+
+	port->uartclk = clk_get_rate(sup->clk);
+	if (!port->uartclk) {
+		ret = -EINVAL;
+		goto err_disable_clk;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -ENODEV;
+
+	port->mapbase = res_mem->start;
+	port->line = pdev->id;
+	port->irq = irq;
+	port->dev = &pdev->dev;
+	port->iotype = UPIO_MEM;
+	port->ops = &sunplus_uart_ops;
+	port->flags = UPF_BOOT_AUTOCONF;
+	port->fifosize = 128;
+
+	ret = reset_control_deassert(sup->rstc);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
+	if (pdev->id == 0)
+		port->cons = &sunplus_uart_console;
+	sunplus_console_ports[sup->port.line] = sup;
+#endif
+
+	port->private_data = container_of(&sup->port,
+		struct sunplus_uart_port, port);
+
+	sprintf(sup->name, "sp_uart%d", pdev->id);
+
+	ret = uart_add_one_port(&sunplus_uart_driver, &sup->port);
+	if (ret)
+		goto err_disable_clk;
+
+	platform_set_drvdata(pdev, sup);
+
+#ifdef CONFIG_PM_RUNTIME_UART
+	if (pdev->id != 0) {
+		pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
+		pm_runtime_use_autosuspend(&pdev->dev);
+		pm_runtime_set_active(&pdev->dev);
+		pm_runtime_enable(&pdev->dev);
+	}
+#endif
+	return 0;
+
+err_disable_clk:
+	clk_disable_unprepare(sup->clk);
+	return ret;
+
+}
+
+static int sunplus_uart_remove(struct platform_device *pdev)
+{
+	struct sunplus_uart_port *sup;
+
+	sup = platform_get_drvdata(pdev);
+#ifdef CONFIG_PM_RUNTIME_UART
+	if (pdev->id != 0) {
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
+	}
+#endif
+	uart_remove_one_port(&sunplus_uart_driver, &sup->port);
+
+	if (pdev->id < UART_NR) {
+		clk_disable_unprepare(sup->clk);
+		reset_control_assert(sup->rstc);
+	}
+
+	return 0;
+}
+
+static int sunplus_uart_suspend(struct platform_device *pdev,
+	pm_message_t state)
+{
+	struct sunplus_uart_port *sup;
+
+	sup = platform_get_drvdata(pdev);
+
+	/* Don't suspend uart0 for cmd line usage */
+	if ((pdev->id < UART_NR) && (pdev->id > 0))
+		reset_control_assert(sup->rstc);
+
+	return 0;
+}
+
+static int sunplus_uart_resume(struct platform_device *pdev)
+{
+	struct sunplus_uart_port *sup;
+
+	sup = platform_get_drvdata(pdev);
+
+	if (pdev->id < UART_NR) {
+		clk_prepare_enable(sup->clk);
+		reset_control_deassert(sup->rstc);
+	}
+	return 0;
+}
+
+#ifdef CONFIG_PM_RUNTIME_UART
+static int sunplus_uart_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sunplus_uart_port *sup;
+
+	sup = platform_get_drvdata(pdev);
+
+	/* Don't suspend uart0 for cmd line usage */
+	if ((pdev->id < UART_NR) && (pdev->id > 0))
+		reset_control_assert(sup->rstc);
+
+	return 0;
+}
+
+static int sunplus_uart_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sunplus_uart_port *sup;
+
+	sup = platform_get_drvdata(pdev);
+
+	if (pdev->id < UART_NR) {
+		clk_prepare_enable(sup->clk);
+		reset_control_deassert(sup->rstc);
+	}
+
+	return 0;
+}
+static const struct dev_pm_ops sp7021_uart_pm_ops = {
+	.runtime_suspend = sunplus_uart_runtime_suspend,
+	.runtime_resume  = sunplus_uart_runtime_resume,
+};
+#define sunplus_uart_pm_ops  (&sp7021_uart_pm_ops)
+#endif
+
+static const struct of_device_id sp_uart_of_match[] = {
+	{ .compatible = "sunplus,sp7021-uart" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sp_uart_of_match);
+
+static struct platform_driver sunplus_uart_platform_driver = {
+	.probe		= sunplus_uart_probe,
+	.remove		= sunplus_uart_remove,
+	.suspend	= sunplus_uart_suspend,
+	.resume		= sunplus_uart_resume,
+	.driver = {
+		.name	= "sunplus-uart",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(sp_uart_of_match),
+#ifdef CONFIG_PM_RUNTIME_UART
+		.pm     = sunplus_uart_pm_ops,
+#endif
+	}
+};
+
+static int __init sunplus_uart_init(void)
+{
+	int ret;
+
+#ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
+	sunplus_uart_driver.cons = &sunplus_uart_console;
+#endif
+
+	ret = uart_register_driver(&sunplus_uart_driver);
+	if (ret < 0)
+		return ret;
+
+	ret = platform_driver_register(&sunplus_uart_platform_driver);
+	if (ret != 0) {
+		uart_unregister_driver(&sunplus_uart_driver);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(sunplus_uart_init);
+
+#ifdef CONFIG_SERIAL_EARLYCON
+static void sunplus_uart_putc(struct uart_port *port, int c)
+{
+	unsigned int status;
+
+	for (;;) {
+		status = readl(port->membase + SP_UART_LSR);
+		if ((status & SP_UART_LSR_TXE) == SP_UART_LSR_TXE)
+			break;
+		cpu_relax();
+	}
+	writel(c, port->membase + SP_UART_DATA);
+}
+
+static void sunplus_uart_early_write(struct console *con,
+			      const char *s, unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, sunplus_uart_putc);
+}
+
+int __init sunplus_uart_early_setup(struct earlycon_device *device,
+					 const char *opt)
+{
+	if (!(device->port.membase || device->port.iobase))
+		return -ENODEV;
+
+	device->con->write = sunplus_uart_early_write;
+	return 0;
+}
+OF_EARLYCON_DECLARE(sunplus_uart, "sunplus,sp7021-uart", sunplus_uart_early_setup);
+#endif
+
+MODULE_DESCRIPTION("Sunplus UART driver");
+MODULE_AUTHOR("Hammer Hsieh <hammer.hsieh@sunplus.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/soc/sunplus/sp_uart.h b/include/soc/sunplus/sp_uart.h
new file mode 100644
index 0000000..c34c8d0
--- /dev/null
+++ b/include/soc/sunplus/sp_uart.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Sunplus SoC UART driver header file
+ */
+
+#ifndef __SP_UART_H__
+#define __SP_UART_H__
+
+#ifdef CONFIG_DEBUG_SP_UART
+#include <mach/io_map.h>
+
+#define LL_UART_PADDR		PA_IOB_ADDR(18 * 32 * 4)
+#define LL_UART_VADDR		VA_IOB_ADDR(18 * 32 * 4)
+#define LOGI_ADDR_UART0_REG	VA_IOB_ADDR(18 * 32 * 4)
+#endif
+
+/*
+ * UART REG
+ *
+ */
+#define SP_UART_DATA			0x00
+#define SP_UART_LSR				0x04
+#define SP_UART_MSR				0x08
+#define SP_UART_LCR				0x0C
+#define SP_UART_MCR				0x10
+#define SP_UART_DIV_L			0x14
+#define SP_UART_DIV_H			0x18
+#define SP_UART_ISC				0x1C
+#define SP_UART_TX_RESIDUE		0x20
+#define SP_UART_RX_RESIDUE		0x24
+
+/* lsr
+ * 1: trasmit fifo is empty
+ */
+#define SP_UART_LSR_TXE		(1 << 6)
+
+/* interrupt
+ * SP_UART_LSR_BC : break condition
+ * SP_UART_LSR_FE : frame error
+ * SP_UART_LSR_OE : overrun error
+ * SP_UART_LSR_PE : parity error
+ * SP_UART_LSR_RX : 1: receive fifo not empty
+ * SP_UART_LSR_TX : 1: transmit fifo is not full
+ */
+#define SP_UART_CREAD_DISABLED		(1 << 16)
+#define SP_UART_LSR_BC		(1 << 5)
+#define SP_UART_LSR_FE		(1 << 4)
+#define SP_UART_LSR_OE		(1 << 3)
+#define SP_UART_LSR_PE		(1 << 2)
+#define SP_UART_LSR_RX		(1 << 1)
+#define SP_UART_LSR_TX		(1 << 0)
+#define SP_UART_LSR_TX_NOT_FULL		1
+
+#define SP_UART_LSR_BRK_ERROR_BITS	\
+	(SP_UART_LSR_PE | SP_UART_LSR_OE | SP_UART_LSR_FE | SP_UART_LSR_BC)
+
+/* lcr */
+#define SP_UART_LCR_WL5		(0 << 0)
+#define SP_UART_LCR_WL6		(1 << 0)
+#define SP_UART_LCR_WL7		(2 << 0)
+#define SP_UART_LCR_WL8		(3 << 0)
+#define SP_UART_LCR_ST		(1 << 2)
+#define SP_UART_LCR_PE		(1 << 3)
+#define SP_UART_LCR_PR		(1 << 4)
+#define SP_UART_LCR_BC		(1 << 5)
+
+/* isc
+ * SP_UART_ISC_MSM : Modem status ctrl
+ * SP_UART_ISC_LSM : Line status interrupt
+ * SP_UART_ISC_RXM : RX interrupt, when got some input data
+ * SP_UART_ISC_TXM : TX interrupt, when trans start
+ */
+#define SP_UART_ISC_MSM		(1 << 7)
+#define SP_UART_ISC_LSM		(1 << 6)
+#define SP_UART_ISC_RXM		(1 << 5)
+#define SP_UART_ISC_TXM		(1 << 4)
+#define HAS_UART_ISC_FLAGMASK	0x0F
+#define SP_UART_ISC_MS		(1 << 3)
+#define SP_UART_ISC_LS		(1 << 2)
+#define SP_UART_ISC_RX		(1 << 1)
+#define SP_UART_ISC_TX		(1 << 0)
+
+/* modem control register */
+#define SP_UART_MCR_AT		(1 << 7)
+#define SP_UART_MCR_AC		(1 << 6)
+#define SP_UART_MCR_AR		(1 << 5)
+#define SP_UART_MCR_LB		(1 << 4)
+#define SP_UART_MCR_RI		(1 << 3)
+#define SP_UART_MCR_DCD		(1 << 2)
+#define SP_UART_MCR_RTS		(1 << 1)
+#define SP_UART_MCR_DTS		(1 << 0)
+
+#endif /* __SP_UART_H__ */
-- 
2.7.4

