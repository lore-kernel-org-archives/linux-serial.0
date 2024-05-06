Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6F78249A;
	Mon,  6 May 2024 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004198; cv=none; b=fVrxCnmSlXM6v4QlgturdgUoRTIeFVG5zEll3baPo1PjW4rCsy6YAfdZ1TXDtr2G+NObfMAqNWnvhaD+KuZiUMoUoT2dQ4TkD3rhT4wVucDpFDs7l708ZzlI0MiGKI4BC7fZx17upyYW1QVtqyhBQvE7p5aK6+py669ihtRY4HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004198; c=relaxed/simple;
	bh=j5vgaaNqT3QDu7A1hhfFoQPgnfUjso+Pq8YbwUycBZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhotNaKkSaWWESyF9rwpfhBAy4/R4Ka8D4DpXMJCYHVde30PtPB7L0chi1YH0YyPobtExae/rYSBBRT62G+LAPAJNgAQEeuDBtWjZXOJkecEH6tyFqPprCnog4g1EMdQfkrf92kbFbwM73ymtix2i2QcKLyVeagff541ePnAqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ej0PsF8L; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ej0PsF8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715004196; x=1746540196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j5vgaaNqT3QDu7A1hhfFoQPgnfUjso+Pq8YbwUycBZM=;
  b=ej0PsF8LF62FHqLp8y3RbQpXFwGpIY/6vo7TIecfZlKUjoii1VuRNGW3
   8pYFWk6MY6/S6Ue3AYSJrrqi0jXax6oBARTwOAmO9lQYFNjBPDXsUOSNu
   oYh74qeDjQsKsXPQGCHGlDytY6dmYtM8n/H2J8YMsbSwEs2CjcmI5aIBb
   XFFlP7vQeP9hDZ+Ue8H5Y+CoELglxT9PjxCeRUJxHTZKGf1FZCwLn8UyH
   E7A6u0oFoRPulbkqtYBbHcqA4OTmfaSjI5CUGyAUhINXilQQKVsRZwXtq
   s9270nktMCe2RIdYrldauRZYU2aTlOuhlaZQxSc28JSnApeSXQu6QqCmZ
   g==;
X-CSE-ConnectionGUID: J5MRCOB+QEObVirc3j11AQ==
X-CSE-MsgGUID: i+t08oOSScugwrqTBuGo0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="13696630"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="13696630"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:03:13 -0700
X-CSE-ConnectionGUID: VK/wSyU5Rb+js5YK8Yhuzw==
X-CSE-MsgGUID: ZMk8juXpS8GWcO2gPFXZbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="59044875"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 06 May 2024 07:03:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C0BA32D3; Mon, 06 May 2024 17:03:09 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Lindgren <tony@atomide.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	unil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v1 2/2] serial: 8250: Extract platform driver
Date: Mon,  6 May 2024 17:00:59 +0300
Message-ID: <20240506140308.4040735-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240506140308.4040735-1-andriy.shevchenko@linux.intel.com>
References: <20240506140308.4040735-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract platform driver to a separate module for better maintenance
and to reduce churn on 8250_core part changes when it's solely related
to the former. No functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250.h          |  22 +-
 drivers/tty/serial/8250/8250_core.c     | 342 +-----------------------
 drivers/tty/serial/8250/8250_platform.c | 339 +++++++++++++++++++++++
 drivers/tty/serial/8250/Makefile        |   5 +-
 4 files changed, 369 insertions(+), 339 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_platform.c

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index ac218412e54e..e5310c65cf52 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -9,7 +9,7 @@
 
 #include <linux/bits.h>
 #include <linux/serial_8250.h>
-#include <linux/serial_reg.h>
+#include <linux/serial_core.h>
 #include <linux/dmaengine.h>
 
 #include "../serial_mctrl_gpio.h"
@@ -93,6 +93,10 @@ struct serial8250_config {
 #define UART_BUG_THRE	BIT(3)	/* UART has buggy THRE reassertion */
 #define UART_BUG_TXRACE	BIT(5)	/* UART Tx fails to set remote DR */
 
+/* Module parameters */
+#define UART_NR	CONFIG_SERIAL_8250_NR_UARTS
+
+extern unsigned int nr_uarts;
 
 #ifdef CONFIG_SERIAL_8250_SHARE_IRQ
 #define SERIAL8250_SHARE_IRQS 1
@@ -100,6 +104,9 @@ struct serial8250_config {
 #define SERIAL8250_SHARE_IRQS 0
 #endif
 
+extern unsigned int share_irqs;
+extern unsigned int skip_txen_test;
+
 #define SERIAL8250_PORT_FLAGS(_base, _irq, _flags)		\
 	{							\
 		.iobase		= _base,			\
@@ -111,7 +118,19 @@ struct serial8250_config {
 
 #define SERIAL8250_PORT(_base, _irq) SERIAL8250_PORT_FLAGS(_base, _irq, 0)
 
+extern struct uart_driver serial8250_reg;
+void serial8250_register_ports(struct uart_driver *drv, struct device *dev);
+
+/* Legacy ISA bus related APIs */
+typedef void (*serial8250_isa_config_fn)(int, struct uart_port *, u32 *);
+extern serial8250_isa_config_fn serial8250_isa_config;
+
+void serial8250_isa_init_ports(void);
+
+extern struct platform_device *serial8250_isa_devs;
+
 extern const struct uart_ops *univ8250_port_base_ops;
+extern struct uart_ops univ8250_port_ops;
 
 static inline int serial_in(struct uart_8250_port *up, int offset)
 {
@@ -201,6 +220,7 @@ static inline bool serial8250_clear_THRI(struct uart_8250_port *up)
 	return true;
 }
 
+struct uart_8250_port *serial8250_setup_port(int index);
 struct uart_8250_port *serial8250_get_port(int line);
 
 void serial8250_rpm_get(struct uart_8250_port *p);
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 51432f89919c..192f8d19d2fe 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -6,11 +6,9 @@
  *
  *  Copyright (C) 2001 Russell King.
  *
- *  Supports: ISA-compatible 8250/16550 ports
- *	      PNP 8250/16550 ports
+ *  Supports:
  *	      early_serial_setup() ports
  *	      userspace-configurable "phantom" ports
- *	      "serial8250" platform devices
  *	      serial8250_register_8250_port() ports
  */
 
@@ -36,47 +34,13 @@
 #include <linux/string_helpers.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
-#ifdef CONFIG_SPARC
-#include <linux/sunserialcore.h>
-#endif
 
 #include <asm/irq.h>
 
-#include "../serial_base.h"	/* For serial_base_add_isa_preferred_console() */
-
 #include "8250.h"
 
-/*
- * Configuration:
- *   share_irqs - whether we pass IRQF_SHARED to request_irq().  This option
- *                is unsafe when used on edge-triggered interrupts.
- */
-static unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
-
-static unsigned int nr_uarts = CONFIG_SERIAL_8250_RUNTIME_UARTS;
-
-static struct uart_driver serial8250_reg;
-
-static unsigned int skip_txen_test; /* force skip of txen test at init time */
-
 #define PASS_LIMIT	512
 
-#include <asm/serial.h>
-/*
- * SERIAL_PORT_DFNS tells us about built-in ports that have no
- * standard enumeration mechanism.   Platforms that can find all
- * serial ports via mechanisms like ACPI or PCI need not supply it.
- */
-#ifndef SERIAL_PORT_DFNS
-#define SERIAL_PORT_DFNS
-#endif
-
-static const struct old_serial_port old_serial_port[] = {
-	SERIAL_PORT_DFNS /* defined in asm/serial.h */
-};
-
-#define UART_NR	CONFIG_SERIAL_8250_NR_UARTS
-
 struct irq_info {
 	struct			hlist_node node;
 	int			irq;
@@ -342,7 +306,7 @@ static void univ8250_release_irq(struct uart_8250_port *up)
 }
 
 const struct uart_ops *univ8250_port_base_ops = NULL;
-static struct uart_ops univ8250_port_ops;
+struct uart_ops univ8250_port_ops;
 
 static const struct uart_8250_ops univ8250_driver_ops = {
 	.setup_irq	= univ8250_setup_irq,
@@ -370,22 +334,12 @@ struct uart_8250_port *serial8250_get_port(int line)
 }
 EXPORT_SYMBOL_GPL(serial8250_get_port);
 
-static void (*serial8250_isa_config)(int port, struct uart_port *up,
-	u32 *capabilities);
-
-void serial8250_set_isa_configurator(
-	void (*v)(int port, struct uart_port *up, u32 *capabilities))
-{
-	serial8250_isa_config = v;
-}
-EXPORT_SYMBOL(serial8250_set_isa_configurator);
-
 static inline void serial8250_apply_quirks(struct uart_8250_port *up)
 {
 	up->port.quirks |= skip_txen_test ? UPQ_NO_TXEN_TEST : 0;
 }
 
-static struct uart_8250_port *serial8250_setup_port(int index)
+struct uart_8250_port *serial8250_setup_port(int index)
 {
 	struct uart_8250_port *up;
 
@@ -410,59 +364,7 @@ static struct uart_8250_port *serial8250_setup_port(int index)
 	return up;
 }
 
-static void __init serial8250_isa_init_ports(void)
-{
-	struct uart_8250_port *up;
-	static int first = 1;
-	int i, irqflag = 0;
-
-	if (!first)
-		return;
-	first = 0;
-
-	if (nr_uarts > UART_NR)
-		nr_uarts = UART_NR;
-
-	/*
-	 * Set up initial isa ports based on nr_uart module param, or else
-	 * default to CONFIG_SERIAL_8250_RUNTIME_UARTS. Note that we do not
-	 * need to increase nr_uarts when setting up the initial isa ports.
-	 */
-	for (i = 0; i < nr_uarts; i++)
-		serial8250_setup_port(i);
-
-	/* chain base port ops to support Remote Supervisor Adapter */
-	univ8250_port_ops = *univ8250_port_base_ops;
-	univ8250_rsa_support(&univ8250_port_ops);
-
-	if (share_irqs)
-		irqflag = IRQF_SHARED;
-
-	for (i = 0, up = serial8250_ports;
-	     i < ARRAY_SIZE(old_serial_port) && i < nr_uarts;
-	     i++, up++) {
-		struct uart_port *port = &up->port;
-
-		port->iobase   = old_serial_port[i].port;
-		port->irq      = irq_canonicalize(old_serial_port[i].irq);
-		port->irqflags = 0;
-		port->uartclk  = old_serial_port[i].baud_base * 16;
-		port->flags    = old_serial_port[i].flags;
-		port->hub6     = 0;
-		port->membase  = old_serial_port[i].iomem_base;
-		port->iotype   = old_serial_port[i].io_type;
-		port->regshift = old_serial_port[i].iomem_reg_shift;
-
-		port->irqflags |= irqflag;
-		if (serial8250_isa_config != NULL)
-			serial8250_isa_config(i, &up->port, &up->capabilities);
-
-		serial_base_add_isa_preferred_console(serial8250_reg.dev_name, i);
-	}
-}
-
-static void __init
-serial8250_register_ports(struct uart_driver *drv, struct device *dev)
+void __init serial8250_register_ports(struct uart_driver *drv, struct device *dev)
 {
 	int i;
 
@@ -619,7 +521,7 @@ console_initcall(univ8250_console_init);
 #define SERIAL8250_CONSOLE	NULL
 #endif
 
-static struct uart_driver serial8250_reg = {
+struct uart_driver serial8250_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial",
 	.dev_name		= "ttyS",
@@ -720,120 +622,6 @@ void serial8250_resume_port(int line)
 }
 EXPORT_SYMBOL(serial8250_resume_port);
 
-/*
- * Register a set of serial devices attached to a platform device.  The
- * list is terminated with a zero flags entry, which means we expect
- * all entries to have at least UPF_BOOT_AUTOCONF set.
- */
-static int serial8250_probe(struct platform_device *dev)
-{
-	struct plat_serial8250_port *p = dev_get_platdata(&dev->dev);
-	struct uart_8250_port uart;
-	int ret, i, irqflag = 0;
-
-	memset(&uart, 0, sizeof(uart));
-
-	if (share_irqs)
-		irqflag = IRQF_SHARED;
-
-	for (i = 0; p && p->flags != 0; p++, i++) {
-		uart.port.iobase	= p->iobase;
-		uart.port.membase	= p->membase;
-		uart.port.irq		= p->irq;
-		uart.port.irqflags	= p->irqflags;
-		uart.port.uartclk	= p->uartclk;
-		uart.port.regshift	= p->regshift;
-		uart.port.iotype	= p->iotype;
-		uart.port.flags		= p->flags;
-		uart.port.mapbase	= p->mapbase;
-		uart.port.mapsize	= p->mapsize;
-		uart.port.hub6		= p->hub6;
-		uart.port.has_sysrq	= p->has_sysrq;
-		uart.port.private_data	= p->private_data;
-		uart.port.type		= p->type;
-		uart.bugs		= p->bugs;
-		uart.port.serial_in	= p->serial_in;
-		uart.port.serial_out	= p->serial_out;
-		uart.dl_read		= p->dl_read;
-		uart.dl_write		= p->dl_write;
-		uart.port.handle_irq	= p->handle_irq;
-		uart.port.handle_break	= p->handle_break;
-		uart.port.set_termios	= p->set_termios;
-		uart.port.set_ldisc	= p->set_ldisc;
-		uart.port.get_mctrl	= p->get_mctrl;
-		uart.port.pm		= p->pm;
-		uart.port.dev		= &dev->dev;
-		uart.port.irqflags	|= irqflag;
-		ret = serial8250_register_8250_port(&uart);
-		if (ret < 0) {
-			dev_err(&dev->dev, "unable to register port at index %d "
-				"(IO%lx MEM%llx IRQ%d): %d\n", i,
-				p->iobase, (unsigned long long)p->mapbase,
-				p->irq, ret);
-		}
-	}
-	return 0;
-}
-
-/*
- * Remove serial ports registered against a platform device.
- */
-static void serial8250_remove(struct platform_device *dev)
-{
-	int i;
-
-	for (i = 0; i < nr_uarts; i++) {
-		struct uart_8250_port *up = &serial8250_ports[i];
-
-		if (up->port.dev == &dev->dev)
-			serial8250_unregister_port(i);
-	}
-}
-
-static int serial8250_suspend(struct platform_device *dev, pm_message_t state)
-{
-	int i;
-
-	for (i = 0; i < UART_NR; i++) {
-		struct uart_8250_port *up = &serial8250_ports[i];
-
-		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
-			uart_suspend_port(&serial8250_reg, &up->port);
-	}
-
-	return 0;
-}
-
-static int serial8250_resume(struct platform_device *dev)
-{
-	int i;
-
-	for (i = 0; i < UART_NR; i++) {
-		struct uart_8250_port *up = &serial8250_ports[i];
-
-		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
-			serial8250_resume_port(i);
-	}
-
-	return 0;
-}
-
-static struct platform_driver serial8250_isa_driver = {
-	.probe		= serial8250_probe,
-	.remove_new	= serial8250_remove,
-	.suspend	= serial8250_suspend,
-	.resume		= serial8250_resume,
-	.driver		= {
-		.name	= "serial8250",
-	},
-};
-
-/*
- * This "device" covers _all_ ISA 8250-compatible serial devices listed
- * in the table in include/asm/serial.h
- */
-static struct platform_device *serial8250_isa_devs;
-
 /*
  * serial8250_register_8250_port and serial8250_unregister_port allows for
  * 16x50 serial ports to be configured at run-time, to support PCMCIA
@@ -1110,125 +898,5 @@ void serial8250_unregister_port(int line)
 }
 EXPORT_SYMBOL(serial8250_unregister_port);
 
-static int __init serial8250_init(void)
-{
-	int ret;
-
-	if (nr_uarts == 0)
-		return -ENODEV;
-
-	serial8250_isa_init_ports();
-
-	pr_info("Serial: 8250/16550 driver, %d ports, IRQ sharing %s\n",
-		nr_uarts, str_enabled_disabled(share_irqs));
-
-#ifdef CONFIG_SPARC
-	ret = sunserial_register_minors(&serial8250_reg, UART_NR);
-#else
-	serial8250_reg.nr = UART_NR;
-	ret = uart_register_driver(&serial8250_reg);
-#endif
-	if (ret)
-		goto out;
-
-	ret = serial8250_pnp_init();
-	if (ret)
-		goto unreg_uart_drv;
-
-	serial8250_isa_devs = platform_device_alloc("serial8250",
-						    PLAT8250_DEV_LEGACY);
-	if (!serial8250_isa_devs) {
-		ret = -ENOMEM;
-		goto unreg_pnp;
-	}
-
-	ret = platform_device_add(serial8250_isa_devs);
-	if (ret)
-		goto put_dev;
-
-	serial8250_register_ports(&serial8250_reg, &serial8250_isa_devs->dev);
-
-	ret = platform_driver_register(&serial8250_isa_driver);
-	if (ret == 0)
-		goto out;
-
-	platform_device_del(serial8250_isa_devs);
-put_dev:
-	platform_device_put(serial8250_isa_devs);
-unreg_pnp:
-	serial8250_pnp_exit();
-unreg_uart_drv:
-#ifdef CONFIG_SPARC
-	sunserial_unregister_minors(&serial8250_reg, UART_NR);
-#else
-	uart_unregister_driver(&serial8250_reg);
-#endif
-out:
-	return ret;
-}
-
-static void __exit serial8250_exit(void)
-{
-	struct platform_device *isa_dev = serial8250_isa_devs;
-
-	/*
-	 * This tells serial8250_unregister_port() not to re-register
-	 * the ports (thereby making serial8250_isa_driver permanently
-	 * in use.)
-	 */
-	serial8250_isa_devs = NULL;
-
-	platform_driver_unregister(&serial8250_isa_driver);
-	platform_device_unregister(isa_dev);
-
-	serial8250_pnp_exit();
-
-#ifdef CONFIG_SPARC
-	sunserial_unregister_minors(&serial8250_reg, UART_NR);
-#else
-	uart_unregister_driver(&serial8250_reg);
-#endif
-}
-
-module_init(serial8250_init);
-module_exit(serial8250_exit);
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Generic 8250/16x50 serial driver");
-
-module_param_hw(share_irqs, uint, other, 0644);
-MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices (unsafe)");
-
-module_param(nr_uarts, uint, 0644);
-MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
-
-module_param(skip_txen_test, uint, 0644);
-MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at init time");
-
-MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
-
-#ifdef CONFIG_SERIAL_8250_DEPRECATED_OPTIONS
-#ifndef MODULE
-/* This module was renamed to 8250_core in 3.7.  Keep the old "8250" name
- * working as well for the module options so we don't break people.  We
- * need to keep the names identical and the convenient macros will happily
- * refuse to let us do that by failing the build with redefinition errors
- * of global variables.  So we stick them inside a dummy function to avoid
- * those conflicts.  The options still get parsed, and the redefined
- * MODULE_PARAM_PREFIX lets us keep the "8250." syntax alive.
- *
- * This is hacky.  I'm sorry.
- */
-static void __used s8250_options(void)
-{
-#undef MODULE_PARAM_PREFIX
-#define MODULE_PARAM_PREFIX "8250_core."
-
-	module_param_cb(share_irqs, &param_ops_uint, &share_irqs, 0644);
-	module_param_cb(nr_uarts, &param_ops_uint, &nr_uarts, 0644);
-	module_param_cb(skip_txen_test, &param_ops_uint, &skip_txen_test, 0644);
-}
-#else
-MODULE_ALIAS("8250_core");
-#endif
-#endif
diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
new file mode 100644
index 000000000000..ded985182e04
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Universal/legacy platform driver for 8250/16550-type serial ports
+ *
+ *  Supports: ISA-compatible 8250/16550 ports
+ *	      PNP 8250/16550 ports
+ *	      "serial8250" platform devices
+ */
+#include <linux/array_size.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+
+#include <linux/serial_8250.h>
+
+#ifdef CONFIG_SPARC
+#include <linux/sunserialcore.h>
+#endif
+
+#include "../serial_base.h"	/* For serial_base_add_isa_preferred_console() */
+#include "8250.h"
+
+/*
+ * Configuration:
+ *    share_irqs   Whether we pass IRQF_SHARED to request_irq().
+ *                 This option is unsafe when used on edge-triggered interrupts.
+ * skip_txen_test  Force skip of txen test at init time.
+ */
+unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
+unsigned int skip_txen_test;
+
+unsigned int nr_uarts = CONFIG_SERIAL_8250_RUNTIME_UARTS;
+
+#include <asm/serial.h>
+
+/*
+ * SERIAL_PORT_DFNS tells us about built-in ports that have no
+ * standard enumeration mechanism. Platforms that can find all
+ * serial ports via mechanisms like ACPI or PCI need not supply it.
+ */
+#ifndef SERIAL_PORT_DFNS
+#define SERIAL_PORT_DFNS
+#endif
+
+static const struct old_serial_port old_serial_port[] = {
+	SERIAL_PORT_DFNS /* defined in asm/serial.h */
+};
+
+serial8250_isa_config_fn serial8250_isa_config;
+void serial8250_set_isa_configurator(serial8250_isa_config_fn v)
+{
+	serial8250_isa_config = v;
+}
+EXPORT_SYMBOL(serial8250_set_isa_configurator);
+
+void __init serial8250_isa_init_ports(void)
+{
+	static int first = 1;
+	int i, irqflag = 0;
+
+	if (!first)
+		return;
+	first = 0;
+
+	if (nr_uarts > UART_NR)
+		nr_uarts = UART_NR;
+
+	/*
+	 * Set up initial isa ports based on nr_uart module param, or else
+	 * default to CONFIG_SERIAL_8250_RUNTIME_UARTS. Note that we do not
+	 * need to increase nr_uarts when setting up the initial isa ports.
+	 */
+	for (i = 0; i < nr_uarts; i++)
+		serial8250_setup_port(i);
+
+	/* chain base port ops to support Remote Supervisor Adapter */
+	univ8250_port_ops = *univ8250_port_base_ops;
+	univ8250_rsa_support(&univ8250_port_ops);
+
+	if (share_irqs)
+		irqflag = IRQF_SHARED;
+
+	for (i = 0; i < ARRAY_SIZE(old_serial_port) && i < nr_uarts; i++) {
+		struct uart_8250_port *up = serial8250_get_port(i);
+		struct uart_port *port = &up->port;
+
+		port->iobase   = old_serial_port[i].port;
+		port->irq      = irq_canonicalize(old_serial_port[i].irq);
+		port->irqflags = 0;
+		port->uartclk  = old_serial_port[i].baud_base * 16;
+		port->flags    = old_serial_port[i].flags;
+		port->hub6     = 0;
+		port->membase  = old_serial_port[i].iomem_base;
+		port->iotype   = old_serial_port[i].io_type;
+		port->regshift = old_serial_port[i].iomem_reg_shift;
+
+		port->irqflags |= irqflag;
+		if (serial8250_isa_config != NULL)
+			serial8250_isa_config(i, &up->port, &up->capabilities);
+
+		serial_base_add_isa_preferred_console(serial8250_reg.dev_name, i);
+	}
+}
+
+/*
+ * Register a set of serial devices attached to a platform device.  The
+ * list is terminated with a zero flags entry, which means we expect
+ * all entries to have at least UPF_BOOT_AUTOCONF set.
+ */
+static int serial8250_probe(struct platform_device *dev)
+{
+	struct plat_serial8250_port *p = dev_get_platdata(&dev->dev);
+	struct uart_8250_port uart;
+	int ret, i, irqflag = 0;
+
+	memset(&uart, 0, sizeof(uart));
+
+	if (share_irqs)
+		irqflag = IRQF_SHARED;
+
+	for (i = 0; p && p->flags != 0; p++, i++) {
+		uart.port.iobase	= p->iobase;
+		uart.port.membase	= p->membase;
+		uart.port.irq		= p->irq;
+		uart.port.irqflags	= p->irqflags;
+		uart.port.uartclk	= p->uartclk;
+		uart.port.regshift	= p->regshift;
+		uart.port.iotype	= p->iotype;
+		uart.port.flags		= p->flags;
+		uart.port.mapbase	= p->mapbase;
+		uart.port.mapsize	= p->mapsize;
+		uart.port.hub6		= p->hub6;
+		uart.port.has_sysrq	= p->has_sysrq;
+		uart.port.private_data	= p->private_data;
+		uart.port.type		= p->type;
+		uart.bugs		= p->bugs;
+		uart.port.serial_in	= p->serial_in;
+		uart.port.serial_out	= p->serial_out;
+		uart.dl_read		= p->dl_read;
+		uart.dl_write		= p->dl_write;
+		uart.port.handle_irq	= p->handle_irq;
+		uart.port.handle_break	= p->handle_break;
+		uart.port.set_termios	= p->set_termios;
+		uart.port.set_ldisc	= p->set_ldisc;
+		uart.port.get_mctrl	= p->get_mctrl;
+		uart.port.pm		= p->pm;
+		uart.port.dev		= &dev->dev;
+		uart.port.irqflags	|= irqflag;
+		ret = serial8250_register_8250_port(&uart);
+		if (ret < 0) {
+			dev_err(&dev->dev, "unable to register port at index %d "
+				"(IO%lx MEM%llx IRQ%d): %d\n", i,
+				p->iobase, (unsigned long long)p->mapbase,
+				p->irq, ret);
+		}
+	}
+	return 0;
+}
+
+/*
+ * Remove serial ports registered against a platform device.
+ */
+static void serial8250_remove(struct platform_device *dev)
+{
+	int i;
+
+	for (i = 0; i < nr_uarts; i++) {
+		struct uart_8250_port *up = serial8250_get_port(i);
+
+		if (up->port.dev == &dev->dev)
+			serial8250_unregister_port(i);
+	}
+}
+
+static int serial8250_suspend(struct platform_device *dev, pm_message_t state)
+{
+	int i;
+
+	for (i = 0; i < UART_NR; i++) {
+		struct uart_8250_port *up = serial8250_get_port(i);
+
+		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
+			uart_suspend_port(&serial8250_reg, &up->port);
+	}
+
+	return 0;
+}
+
+static int serial8250_resume(struct platform_device *dev)
+{
+	int i;
+
+	for (i = 0; i < UART_NR; i++) {
+		struct uart_8250_port *up = serial8250_get_port(i);
+
+		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
+			serial8250_resume_port(i);
+	}
+
+	return 0;
+}
+
+static struct platform_driver serial8250_isa_driver = {
+	.probe		= serial8250_probe,
+	.remove_new	= serial8250_remove,
+	.suspend	= serial8250_suspend,
+	.resume		= serial8250_resume,
+	.driver		= {
+		.name	= "serial8250",
+	},
+};
+
+/*
+ * This "device" covers _all_ ISA 8250-compatible serial devices listed
+ * in the table in include/asm/serial.h
+ */
+struct platform_device *serial8250_isa_devs;
+
+static int __init serial8250_init(void)
+{
+	int ret;
+
+	if (nr_uarts == 0)
+		return -ENODEV;
+
+	serial8250_isa_init_ports();
+
+	pr_info("Serial: 8250/16550 driver, %d ports, IRQ sharing %s\n",
+		nr_uarts, str_enabled_disabled(share_irqs));
+
+#ifdef CONFIG_SPARC
+	ret = sunserial_register_minors(&serial8250_reg, UART_NR);
+#else
+	serial8250_reg.nr = UART_NR;
+	ret = uart_register_driver(&serial8250_reg);
+#endif
+	if (ret)
+		goto out;
+
+	ret = serial8250_pnp_init();
+	if (ret)
+		goto unreg_uart_drv;
+
+	serial8250_isa_devs = platform_device_alloc("serial8250",
+						    PLAT8250_DEV_LEGACY);
+	if (!serial8250_isa_devs) {
+		ret = -ENOMEM;
+		goto unreg_pnp;
+	}
+
+	ret = platform_device_add(serial8250_isa_devs);
+	if (ret)
+		goto put_dev;
+
+	serial8250_register_ports(&serial8250_reg, &serial8250_isa_devs->dev);
+
+	ret = platform_driver_register(&serial8250_isa_driver);
+	if (ret == 0)
+		goto out;
+
+	platform_device_del(serial8250_isa_devs);
+put_dev:
+	platform_device_put(serial8250_isa_devs);
+unreg_pnp:
+	serial8250_pnp_exit();
+unreg_uart_drv:
+#ifdef CONFIG_SPARC
+	sunserial_unregister_minors(&serial8250_reg, UART_NR);
+#else
+	uart_unregister_driver(&serial8250_reg);
+#endif
+out:
+	return ret;
+}
+module_init(serial8250_init);
+
+static void __exit serial8250_exit(void)
+{
+	struct platform_device *isa_dev = serial8250_isa_devs;
+
+	/*
+	 * This tells serial8250_unregister_port() not to re-register
+	 * the ports (thereby making serial8250_isa_driver permanently
+	 * in use.)
+	 */
+	serial8250_isa_devs = NULL;
+
+	platform_driver_unregister(&serial8250_isa_driver);
+	platform_device_unregister(isa_dev);
+
+	serial8250_pnp_exit();
+
+#ifdef CONFIG_SPARC
+	sunserial_unregister_minors(&serial8250_reg, UART_NR);
+#else
+	uart_unregister_driver(&serial8250_reg);
+#endif
+}
+module_exit(serial8250_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Generic 8250/16x50 serial platform driver");
+
+module_param_hw(share_irqs, uint, other, 0644);
+MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices (unsafe)");
+
+module_param(nr_uarts, uint, 0644);
+MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
+
+module_param(skip_txen_test, uint, 0644);
+MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at init time");
+
+MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
+
+#ifdef CONFIG_SERIAL_8250_DEPRECATED_OPTIONS
+#ifndef MODULE
+/* This module was renamed to 8250_core in 3.7.  Keep the old "8250" name
+ * working as well for the module options so we don't break people.  We
+ * need to keep the names identical and the convenient macros will happily
+ * refuse to let us do that by failing the build with redefinition errors
+ * of global variables.  So we stick them inside a dummy function to avoid
+ * those conflicts.  The options still get parsed, and the redefined
+ * MODULE_PARAM_PREFIX lets us keep the "8250." syntax alive.
+ *
+ * This is hacky.  I'm sorry.
+ */
+static void __used s8250_options(void)
+{
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "8250_core."
+
+	module_param_cb(share_irqs, &param_ops_uint, &share_irqs, 0644);
+	module_param_cb(nr_uarts, &param_ops_uint, &nr_uarts, 0644);
+	module_param_cb(skip_txen_test, &param_ops_uint, &skip_txen_test, 0644);
+}
+#else
+MODULE_ALIAS("8250_core");
+#endif
+#endif
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 96d97184d320..1516de629b61 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -3,10 +3,13 @@
 # Makefile for the 8250 serial device drivers.
 #
 
-obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
+obj-$(CONFIG_SERIAL_8250)		+= 8250.o
 8250-y					:= 8250_core.o
+8250-y					+= 8250_platform.o
 8250-$(CONFIG_SERIAL_8250_PNP)		+= 8250_pnp.o
 8250-$(CONFIG_SERIAL_8250_RSA)		+= 8250_rsa.o
+
+obj-$(CONFIG_SERIAL_8250)		+= 8250_base.o
 8250_base-y				:= 8250_port.o
 8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
 8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
-- 
2.43.0.rc1.1336.g36b5255a03ac

