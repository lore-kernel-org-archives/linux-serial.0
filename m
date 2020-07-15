Return-Path: <SRS0=G31y=A2=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BFDC433E6
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jul 2020 11:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6BB20720
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jul 2020 11:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="vaRDcQ7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbgGOLIO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731413AbgGOLIN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jul 2020 07:08:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0493C08C5DB
        for <linux-serial@vger.kernel.org>; Wed, 15 Jul 2020 04:08:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z24so2086465ljn.8
        for <linux-serial@vger.kernel.org>; Wed, 15 Jul 2020 04:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mByP0Ze1d+llZy0H6Rm0waL5jHPHmTpKl+TmQ6XgL5A=;
        b=vaRDcQ7HLNItIkpzM/sWZiWkjkBer9d5JWPu8XDMNbxzZZkItU4DK+OlZvwSIjDUEs
         WTx+ub5wgRRcuA6qT40GXn+HR8A6eW0PCWwITvt8u/2juCH6kcpGHpH5HueHKkj8BR2a
         3CcIq6WlFWSCuKBSeFxh3aZ9PhZuXF/lgljhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mByP0Ze1d+llZy0H6Rm0waL5jHPHmTpKl+TmQ6XgL5A=;
        b=pclPJFmgagwMnkBHCSnMcmKHvv4dMSX7whrYjtZ2DQabVGcNyzbcxc/3KUI0bqijst
         MpS5Ygnf5XgGzu6TnP3bCs2lQSy3MTxbxnhPWNT6aN/cdgGV7klQxKb0nSwyT6V9n1TW
         NMKbQ6AalL2XHO6GHgBgcVE9IBvfPPMyGqNftz9CeDYGaFDqI9+HVFLHxtKb50WkZBue
         pA2Ct9FtY5p99+ypksWdQ5MetlMGNnvJPZZfnRbCtg2sm5wQ3owZgr/kHp62j7pCkKmV
         Ax2AdVf0lI17+DmZbMTntW23juHW6OSZepb1jaa7eHAT0tA8FvUrNKLCoY/GDSP2CuNa
         eZBg==
X-Gm-Message-State: AOAM531NHxJJlao4vl3MvADQ4HDNpW3R2t2fE6dCal/urOFSUmWz9c2g
        sAuP4VoVRJul3yzPw8cpuQwCbg==
X-Google-Smtp-Source: ABdhPJxHvvdGkTCyAJGwRPGqvS+hXuvkkRHJFMR3ITW7FgGi5G3NXoe1YyhDasrhEdYDzKdGF8nJDA==
X-Received: by 2002:a2e:910c:: with SMTP id m12mr4442006ljg.274.1594811291265;
        Wed, 15 Jul 2020 04:08:11 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id j26sm392478lji.29.2020.07.15.04.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 04:08:10 -0700 (PDT)
Date:   Wed, 15 Jul 2020 13:08:05 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, "Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: [PATCH v8 5/5] drivers/tty/serial: add LiteUART driver
Message-ID: <20200715130641.1953227-5-mholenko@antmicro.com>
References: <20200715130641.1953227-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715130641.1953227-0-mholenko@antmicro.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Filip Kokosinski <fkokosinski@antmicro.com>

This commit adds driver for the FPGA-based LiteUART serial controller
from LiteX SoC builder.

The current implementation supports LiteUART configured
for 32 bit data width and 8 bit CSR bus width.

It does not support IRQ.

Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
---

Notes:
    Changes in v8:
    - fixed help messages in LiteUART's KConfig
    - removed dependency between LiteUART and LiteX SoC drivers

    Changed in v7:
    - added missing include directive

    Changes in v6:
    - LiteUART ports now stored in xArray
    - removed PORT_LITEUART
    - fixed formatting
    - removed some unnecessary defines

    No changes in v5.

    Changes in v4:
    - fixed copyright header
    - removed a wrong dependency on UARTLITE from Kconfig
    - added a dependency on LITEX_SOC_CONTROLLER to LITEUART in Kconfig

    Changes in v3:
    - aliases made optional
    - used litex_get_reg/litex_set_reg functions instead of macros
    - SERIAL_LITEUART_NR_PORTS renamed to SERIAL_LITEUART_MAX_PORTS
    - PORT_LITEUART changed from 122 to 123
    - added dependency on LITEX_SOC_CONTROLLER
    - patch number changed from 4 to 5

    No changes in v2.

 MAINTAINERS                   |   1 +
 drivers/tty/serial/Kconfig    |  32 +++
 drivers/tty/serial/Makefile   |   1 +
 drivers/tty/serial/liteuart.c | 402 ++++++++++++++++++++++++++++++++++
 4 files changed, 436 insertions(+)
 create mode 100644 drivers/tty/serial/liteuart.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d70a1b22a87..1387cefc63ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9841,6 +9841,7 @@ M:	Mateusz Holenko <mholenko@antmicro.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/*/litex,*.yaml
 F:	drivers/soc/litex/litex_soc_ctrl.c
+F:	drivers/tty/serial/liteuart.c
 F:	include/linux/litex.h
 
 LIVE PATCHING
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index adf9e80e7dc9..17aaf0afb27a 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1562,6 +1562,38 @@ config SERIAL_MILBEAUT_USIO_CONSOLE
 	  receives all kernel messages and warnings and which allows logins in
 	  single user mode).
 
+config SERIAL_LITEUART
+	tristate "LiteUART serial port support"
+	depends on HAS_IOMEM
+	depends on OF || COMPILE_TEST
+	depends on LITEX_SOC_CONTROLLER
+	select SERIAL_CORE
+	help
+	  This driver is for the FPGA-based LiteUART serial controller from LiteX
+	  SoC builder.
+
+	  Say 'Y' or 'M' here if you wish to use the LiteUART serial controller.
+	  Otherwise, say 'N'.
+
+config SERIAL_LITEUART_MAX_PORTS
+	int "Maximum number of LiteUART ports"
+	depends on SERIAL_LITEUART
+	default "1"
+	help
+	  Set this to the maximum number of serial ports you want the driver
+	  to support.
+
+config SERIAL_LITEUART_CONSOLE
+	bool "LiteUART serial port console support"
+	depends on SERIAL_LITEUART=y
+	select SERIAL_CORE_CONSOLE
+	help
+	  Say 'Y' or 'M' here if you wish to use the FPGA-based LiteUART serial
+	  controller from LiteX SoC builder as the system console
+	  (the system console is the device which receives all kernel messages
+	  and warnings and which allows logins in single user mode).
+	  Otherwise, say 'N'.
+
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index d056ee6cca33..9f8ba419ff3b 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_SERIAL_OWL)	+= owl-uart.o
 obj-$(CONFIG_SERIAL_RDA)	+= rda-uart.o
 obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
 obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
+obj-$(CONFIG_SERIAL_LITEUART) += liteuart.o
 
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
new file mode 100644
index 000000000000..b087e6a32106
--- /dev/null
+++ b/drivers/tty/serial/liteuart.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LiteUART serial controller (LiteX) Driver
+ *
+ * Copyright (C) 2019-2020 Antmicro <www.antmicro.com>
+ */
+
+#include <linux/console.h>
+#include <linux/litex.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+#include <linux/tty_flip.h>
+#include <linux/xarray.h>
+
+/*
+ * CSRs definitions (base address offsets + width)
+ *
+ * The definitions below are true for LiteX SoC configured for 8-bit CSR Bus,
+ * 32-bit aligned.
+ *
+ * Supporting other configurations might require new definitions or a more
+ * generic way of indexing the LiteX CSRs.
+ *
+ * For more details on how CSRs are defined and handled in LiteX, see comments
+ * in the LiteX SoC Driver: drivers/soc/litex/litex_soc_ctrl.c
+ */
+#define OFF_RXTX	0x00
+#define OFF_TXFULL	0x04
+#define OFF_RXEMPTY	0x08
+#define OFF_EV_STATUS	0x0c
+#define OFF_EV_PENDING	0x10
+#define OFF_EV_ENABLE	0x14
+
+/* events */
+#define EV_TX		0x1
+#define EV_RX		0x2
+
+struct liteuart_port {
+	struct uart_port port;
+	struct timer_list timer;
+};
+
+#define to_liteuart_port(port)	container_of(port, struct liteuart_port, port)
+
+static DEFINE_XARRAY_FLAGS(liteuart_array, XA_FLAGS_ALLOC);
+
+#ifdef CONFIG_SERIAL_LITEUART_CONSOLE
+static struct console liteuart_console;
+#endif
+
+static struct uart_driver liteuart_driver = {
+	.owner = THIS_MODULE,
+	.driver_name = "liteuart",
+	.dev_name = "ttyLXU",
+	.major = 0,
+	.minor = 0,
+	.nr = CONFIG_SERIAL_LITEUART_MAX_PORTS,
+#ifdef CONFIG_SERIAL_LITEUART_CONSOLE
+	.cons = &liteuart_console,
+#endif
+};
+
+static void liteuart_timer(struct timer_list *t)
+{
+	struct liteuart_port *uart = from_timer(uart, t, timer);
+	struct uart_port *port = &uart->port;
+	unsigned char __iomem *membase = port->membase;
+	unsigned int flg = TTY_NORMAL;
+	int ch;
+	unsigned long status;
+
+	while ((status = !litex_get_reg(membase + OFF_RXEMPTY, 1)) == 1) {
+		ch = litex_get_reg(membase + OFF_RXTX, 1);
+		port->icount.rx++;
+
+		/* necessary for RXEMPTY to refresh its value */
+		litex_set_reg(membase + OFF_EV_PENDING, 1, EV_TX | EV_RX);
+
+		/* no overflow bits in status */
+		if (!(uart_handle_sysrq_char(port, ch)))
+			uart_insert_char(port, status, 0, ch, flg);
+
+		tty_flip_buffer_push(&port->state->port);
+	}
+
+	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
+}
+
+static void liteuart_putchar(struct uart_port *port, int ch)
+{
+	while (litex_get_reg(port->membase + OFF_TXFULL, 1))
+		cpu_relax();
+
+	litex_set_reg(port->membase + OFF_RXTX, 1, ch);
+}
+
+static unsigned int liteuart_tx_empty(struct uart_port *port)
+{
+	/* not really tx empty, just checking if tx is not full */
+	if (!litex_get_reg(port->membase + OFF_TXFULL, 1))
+		return TIOCSER_TEMT;
+
+	return 0;
+}
+
+static void liteuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	/* modem control register is not present in LiteUART */
+}
+
+static unsigned int liteuart_get_mctrl(struct uart_port *port)
+{
+	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+}
+
+static void liteuart_stop_tx(struct uart_port *port)
+{
+}
+
+static void liteuart_start_tx(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned char ch;
+
+	if (unlikely(port->x_char)) {
+		litex_set_reg(port->membase + OFF_RXTX, 1, port->x_char);
+		port->icount.tx++;
+		port->x_char = 0;
+	} else if (!uart_circ_empty(xmit)) {
+		while (xmit->head != xmit->tail) {
+			ch = xmit->buf[xmit->tail];
+			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+			port->icount.tx++;
+			liteuart_putchar(port, ch);
+		}
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+}
+
+static void liteuart_stop_rx(struct uart_port *port)
+{
+	struct liteuart_port *uart = to_liteuart_port(port);
+
+	/* just delete timer */
+	del_timer(&uart->timer);
+}
+
+static void liteuart_break_ctl(struct uart_port *port, int break_state)
+{
+	/* LiteUART doesn't support sending break signal */
+}
+
+static int liteuart_startup(struct uart_port *port)
+{
+	struct liteuart_port *uart = to_liteuart_port(port);
+
+	/* disable events */
+	litex_set_reg(port->membase + OFF_EV_ENABLE, 1, 0);
+
+	/* prepare timer for polling */
+	timer_setup(&uart->timer, liteuart_timer, 0);
+	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
+
+	return 0;
+}
+
+static void liteuart_shutdown(struct uart_port *port)
+{
+}
+
+static void liteuart_set_termios(struct uart_port *port, struct ktermios *new,
+				 struct ktermios *old)
+{
+	unsigned int baud;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	/* update baudrate */
+	baud = uart_get_baud_rate(port, new, old, 0, 460800);
+	uart_update_timeout(port, new->c_cflag, baud);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static const char *liteuart_type(struct uart_port *port)
+{
+	return "liteuart";
+}
+
+static void liteuart_release_port(struct uart_port *port)
+{
+}
+
+static int liteuart_request_port(struct uart_port *port)
+{
+	return 0;
+}
+
+static void liteuart_config_port(struct uart_port *port, int flags)
+{
+	/*
+	 * Driver core for serial ports forces a non-zero value for port type.
+	 * Write an arbitrary value here to accommodate the serial core driver,
+	 * as ID part of UAPI is redundant.
+	 */
+	port->type = 1;
+}
+
+static int liteuart_verify_port(struct uart_port *port,
+				struct serial_struct *ser)
+{
+	if (port->type != PORT_UNKNOWN && ser->type != 1)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct uart_ops liteuart_ops = {
+	.tx_empty	= liteuart_tx_empty,
+	.set_mctrl	= liteuart_set_mctrl,
+	.get_mctrl	= liteuart_get_mctrl,
+	.stop_tx	= liteuart_stop_tx,
+	.start_tx	= liteuart_start_tx,
+	.stop_rx	= liteuart_stop_rx,
+	.break_ctl	= liteuart_break_ctl,
+	.startup	= liteuart_startup,
+	.shutdown	= liteuart_shutdown,
+	.set_termios	= liteuart_set_termios,
+	.type		= liteuart_type,
+	.release_port	= liteuart_release_port,
+	.request_port	= liteuart_request_port,
+	.config_port	= liteuart_config_port,
+	.verify_port	= liteuart_verify_port,
+};
+
+static int liteuart_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct liteuart_port *uart;
+	struct uart_port *port;
+	struct xa_limit limit;
+	int dev_id, ret;
+
+	/* no device tree */
+	if (!np)
+		return -ENODEV;
+
+	/* look for aliases; auto-enumerate for free index if not found */
+	dev_id = of_alias_get_id(np, "serial");
+	if (dev_id < 0)
+		limit = XA_LIMIT(0, CONFIG_SERIAL_LITEUART_MAX_PORTS);
+	else
+		limit = XA_LIMIT(dev_id, dev_id);
+
+	uart = kzalloc(sizeof(struct liteuart_port), GFP_KERNEL);
+	if (!uart)
+		return -ENOMEM;
+
+	ret = xa_alloc(&liteuart_array, &dev_id, uart, limit, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	port = &uart->port;
+
+	/* get membase */
+	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (!port->membase)
+		return -ENXIO;
+
+	/* values not from device tree */
+	port->dev = &pdev->dev;
+	port->iotype = UPIO_MEM;
+	port->flags = UPF_BOOT_AUTOCONF;
+	port->ops = &liteuart_ops;
+	port->regshift = 2;
+	port->fifosize = 16;
+	port->iobase = 1;
+	port->type = PORT_UNKNOWN;
+	port->line = dev_id;
+	spin_lock_init(&port->lock);
+
+	return uart_add_one_port(&liteuart_driver, &uart->port);
+}
+
+static int liteuart_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct of_device_id liteuart_of_match[] = {
+	{ .compatible = "litex,liteuart" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, liteuart_of_match);
+
+static struct platform_driver liteuart_platform_driver = {
+	.probe = liteuart_probe,
+	.remove = liteuart_remove,
+	.driver = {
+		.name = "liteuart",
+		.of_match_table = liteuart_of_match,
+	},
+};
+
+#ifdef CONFIG_SERIAL_LITEUART_CONSOLE
+
+static void liteuart_console_write(struct console *co, const char *s,
+	unsigned int count)
+{
+	struct liteuart_port *uart;
+	struct uart_port *port;
+	unsigned long flags;
+
+	uart = (struct liteuart_port *)xa_load(&liteuart_array, co->index);
+	port = &uart->port;
+
+	spin_lock_irqsave(&port->lock, flags);
+	uart_console_write(port, s, count, liteuart_putchar);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static int liteuart_console_setup(struct console *co, char *options)
+{
+	struct liteuart_port *uart;
+	struct uart_port *port;
+	int baud = 115200;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	uart = (struct liteuart_port *)xa_load(&liteuart_array, co->index);
+	if (!uart)
+		return -ENODEV;
+
+	port = &uart->port;
+	if (!port->membase)
+		return -ENODEV;
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(port, co, baud, parity, bits, flow);
+}
+
+static struct console liteuart_console = {
+	.name = "liteuart",
+	.write = liteuart_console_write,
+	.device = uart_console_device,
+	.setup = liteuart_console_setup,
+	.flags = CON_PRINTBUFFER,
+	.index = -1,
+	.data = &liteuart_driver,
+};
+
+static int __init liteuart_console_init(void)
+{
+	register_console(&liteuart_console);
+
+	return 0;
+}
+console_initcall(liteuart_console_init);
+#endif /* CONFIG_SERIAL_LITEUART_CONSOLE */
+
+static int __init liteuart_init(void)
+{
+	int res;
+
+	res = uart_register_driver(&liteuart_driver);
+	if (res)
+		return res;
+
+	res = platform_driver_register(&liteuart_platform_driver);
+	if (res) {
+		uart_unregister_driver(&liteuart_driver);
+		return res;
+	}
+
+	return 0;
+}
+
+static void __exit liteuart_exit(void)
+{
+	platform_driver_unregister(&liteuart_platform_driver);
+	uart_unregister_driver(&liteuart_driver);
+}
+
+module_init(liteuart_init);
+module_exit(liteuart_exit);
+
+MODULE_AUTHOR("Antmicro <www.antmicro.com>");
+MODULE_DESCRIPTION("LiteUART serial driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform: liteuart");
-- 
2.25.1

