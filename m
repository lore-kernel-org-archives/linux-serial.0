Return-Path: <SRS0=hEVs=4Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEABC10F27
	for <linux-serial@archiver.kernel.org>; Sun,  8 Mar 2020 16:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDF220880
	for <linux-serial@archiver.kernel.org>; Sun,  8 Mar 2020 16:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgCHQdP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:33:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:44940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgCHQcu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 8 Mar 2020 12:32:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 32982B1A2;
        Sun,  8 Mar 2020 16:32:48 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Wells=20Lu=20=E5=91=82=E8=8A=B3=E9=A8=B0?= 
        <wells.lu@sunplus.com>, Dvorkin Dmitry <dvorkin@tibbo.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [RFC 06/11] tty: serial: Add Sunplus Plus1 UART earlycon
Date:   Sun,  8 Mar 2020 17:32:24 +0100
Message-Id: <20200308163230.4002-7-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200308163230.4002-1-afaerber@suse.de>
References: <20200308163230.4002-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Prepare an earlycon driver for Sunplus Plus1 SP7021 SoC.

Based on BPI-F2S-bsp tree.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/tty/serial/Kconfig        | 19 +++++++++
 drivers/tty/serial/Makefile       |  1 +
 drivers/tty/serial/sunplus-uart.c | 90 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 drivers/tty/serial/sunplus-uart.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 880b96201530..ac6dce75c2f3 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1562,6 +1562,25 @@ config SERIAL_MILBEAUT_USIO_CONSOLE
 	  receives all kernel messages and warnings and which allows logins in
 	  single user mode).
 
+config SERIAL_PLUS1
+	bool "Sunplus Plus1 serial port support"
+	depends on ARCH_SUNPLUS || COMPILE_TEST
+	select SERIAL_CORE
+	help
+	  This driver is for Sunplus Plus1 SP7021 SoC's UART.
+	  Say 'Y' here if you wish to use the on-board serial port.
+	  Otherwise, say 'N'.
+
+config SERIAL_PLUS1_CONSOLE
+	bool "Console on Sunplus Plus1 serial port"
+	depends on SERIAL_PLUS1=y
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	default y
+	help
+	  Say 'Y' here if you wish to use Sunplus SP7021 UART
+	  as the system console. Only earlycon is implemented currently.
+
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index d056ee6cca33..fed40fb19ed0 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_SERIAL_OWL)	+= owl-uart.o
 obj-$(CONFIG_SERIAL_RDA)	+= rda-uart.o
 obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
 obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
+obj-$(CONFIG_SERIAL_PLUS1)	+= sunplus-uart.o
 
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
new file mode 100644
index 000000000000..959dfab5e07b
--- /dev/null
+++ b/drivers/tty/serial/sunplus-uart.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Andreas Färber
+ */
+
+#include <linux/bitops.h>
+#include <linux/console.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+
+#define REG_DATA		0x00
+#define REG_LSR			0x04
+
+#define PLUS1_UART_LSR_TX	BIT(0)
+
+static inline void plus1_uart_write(struct uart_port *port, unsigned int off, u32 val)
+{
+	writel_relaxed(val, port->membase + off);
+}
+
+static inline u32 plus1_uart_read(struct uart_port *port, unsigned int off)
+{
+	return readl_relaxed(port->membase + off);
+}
+
+#ifdef CONFIG_SERIAL_PLUS1_CONSOLE
+
+static void plus1_console_putchar(struct uart_port *port, int ch)
+{
+	if (!port->membase)
+		return;
+
+	while (!(plus1_uart_read(port, REG_LSR) & PLUS1_UART_LSR_TX))
+		cpu_relax();
+
+	plus1_uart_write(port, REG_DATA, ch);
+}
+
+static void plus1_uart_port_write(struct uart_port *port, const char *s,
+				  u_int count)
+{
+	unsigned long flags;
+	int locked;
+
+	local_irq_save(flags);
+
+	if (port->sysrq)
+		locked = 0;
+	else if (oops_in_progress)
+		locked = spin_trylock(&port->lock);
+	else {
+		spin_lock(&port->lock);
+		locked = 1;
+	}
+
+	uart_console_write(port, s, count, plus1_console_putchar);
+
+	if (locked)
+		spin_unlock(&port->lock);
+
+	local_irq_restore(flags);
+}
+
+static void plus1_uart_early_console_write(struct console *co,
+					   const char *s,
+					   u_int count)
+{
+	struct earlycon_device *dev = co->data;
+
+	plus1_uart_port_write(&dev->port, s, count);
+}
+
+static int __init
+plus1_uart_early_console_setup(struct earlycon_device *device, const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = plus1_uart_early_console_write;
+
+	return 0;
+}
+OF_EARLYCON_DECLARE(sunplus, "sunplus,sp7021-uart",
+		    plus1_uart_early_console_setup);
+
+#endif
-- 
2.16.4

