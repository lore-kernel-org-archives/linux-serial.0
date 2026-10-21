Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792570690;
	b=lBsWRwMsOo2OYA8ZDsvO45/71ogfmGEsbOOetnmVa7PMMXCVqZ9rjf2UQXuewNUt7p4f
	 Kfr40ZpUnyd2nue+DyomW2+NxNix/ejSTXwpjcD+2U7d8NlCH6VgwfRkLZAOXEQnLZ5b7
	 Nb80EZt1yTFwoBqe0X+X4mwOy9BzyaeXN9Hb8r6Dr+h5a068rIDuK2I28noKjc34TV2ft
	 iE4ZuUDTN0Om95/gPJ6XGwIE41SUDpMITFhhAE/lOBtIo13myy8Devpg0cyrqiD1Rpi5w
	 L0XnEJT1rfkwJdQAD0q35xT5m19E7bIEdMHSL63+W4feBIr03WifxCbUlki3yowtnow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792570690;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lKkpZqLAXdaCceJ2OwXydVjBkPtqeOkUkmcWNoJu/RE=;
	b=LhwWDu1oR1vWQS0waMCzfZaHe+qOhk7nnblkzdN9j9wUcZUCCYgwFe3onittmbG1fVbw
	 n4ORVAh7DxUoIHRQiINREcbCrJ4wjaUUbEYdkA+GjTEY3uNE8mJ4r4DEJ0DKi+nSttZMW
	 0xB5SFL7MFcBMqrsOxAODag1wAhSI6B5IGHFPlfhuCUzosss9uDYSucZUNd38LnMnUW89
	 urRYVTK4fXG7zlkS2jt/Jnh9CVIEp6WruQxYlIUN0OR4ZtlkizobXPEIdByu46N1txxVj
	 Zg3KKdqT74ATWs277RX6/4Fa7hZ4ljl5wizop1Yuaa3Nkq5C+IxZyXfFqC056CnWgrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPCy+64F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99363606A31C;
	Wed, 21 Oct 2026 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPCy+64F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC7B1F000C9;
	Wed, 21 Oct 2026 08:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792570689;
	bh=lKkpZqLAXdaCceJ2OwXydVjBkPtqeOkUkmcWNoJu/RE=;
	h=From:To:Cc:Subject:Date;
	b=fPCy+64FL9OZnpVNq87a819mapxTDhMG4Fww0wmMs4IelY1VrCYmc+t78gKppuLVK
	 WqRf0nx/tg+uaQ8I1mjeAC74jeBTPvdxJor8y6GFNAA3KNy+dafuvd34qWfwTAm/9G
	 yIvK9zuBnJHtNdZ7rXKBnWY4dlSDNk6ByfF3d/3jp72i0ETwemi3cXkWffvD2n3Jka
	 IP7fxszoDgTX9ap/wRckUEsG8hvl2a9l+XKEXnw7n203Zh9SM545U/jYtQ2gNUUQ4C
	 ApafTZFmV6L1zTkJ8Z5Mfn60KP50fi229ZE4nbMPe+klORo/TPVhVFBTndueO7HqO0
	 zXfSdDUYOgMQg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Kiyokazu SUTO <suto@ks-and-ks.ne.jp>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] [v4] serial: 8250: remove obsolete PORT_RSA support
Date: Wed, 21 Oct 2026 10:17:45 +0200
Message-ID: <20261021081746.3278002-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

For all I can tell, the RSA support in the 8250 driver is not functional
and has not been for a long time.

The RSA-DV II/S ISA card[1] was sold by IODATA in the 1990s as a faster
alternative to regular ISA serial ports, and it was discontinued in
2002. Linux support was added by Kiyokazu SUTO in 2000[2]. The company
also made PCI versions of this device, but Linux never supported those.

It seems that a patch to setserial would be required in order to set
PORT_RSA when not using autoconfiguration, and this was never merged.
Autotoconfiguration in turn requires passing probe_rsa=IOPORT arguments
at boot or module load time, which is not how any other uart drivers
work any more since linux-2.4.

This patch removes all code related to the RSA support, with the exception
of the user-visible PORT_RSA definition. I had originall sent this in
2011 [3], but did not follow up at the time.

Link: http://www.iodata.jp/products/network/rsadv2s.htm [1]
Link: https://pub.ks-and-ks.ne.jp/prog/linux/rsa.en.shtml [2]
Link: https://lore.kernel.org/all/1309211120-2803-6-git-send-email-arnd@arndb.de/ [3]
Cc: Kiyokazu SUTO <suto@ks-and-ks.ne.jp>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: rebased my own patch after 15 years
v3: fix up Makefile and sunsu.c file
v4: improve changelog text, rebase ahead of hub6 driver
---
 drivers/tty/serial/8250/8250.h          |  17 --
 drivers/tty/serial/8250/8250_core.c     |   6 -
 drivers/tty/serial/8250/8250_platform.c |   4 -
 drivers/tty/serial/8250/8250_port.c     |   8 -
 drivers/tty/serial/8250/8250_rsa.c      | 209 ------------------------
 drivers/tty/serial/8250/Kconfig         |  11 --
 drivers/tty/serial/8250/Makefile        |   1 -
 drivers/tty/serial/sunsu.c              |  92 -----------
 include/uapi/linux/serial_reg.h         |  51 ------
 9 files changed, 399 deletions(-)
 delete mode 100644 drivers/tty/serial/8250/8250_rsa.c

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 21ed9c41b751..eee90c84a81d 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -126,9 +126,6 @@ void serial8250_isa_init_ports(void);
 
 extern struct platform_device *serial8250_isa_devs;
 
-extern const struct uart_ops *univ8250_port_base_ops;
-extern struct uart_ops univ8250_port_ops;
-
 static inline int serial_in(struct uart_8250_port *up, int offset)
 {
 	return up->port.serial_in(&up->port, offset);
@@ -331,20 +328,6 @@ static inline int serial8250_hub6_init(void) { return 0; }
 static inline void serial8250_hub6_exit(void) { }
 #endif
 
-#ifdef CONFIG_SERIAL_8250_RSA
-void univ8250_rsa_support(struct uart_ops *ops, const struct uart_ops *core_ops);
-void rsa_enable(struct uart_8250_port *up);
-void rsa_disable(struct uart_8250_port *up);
-void rsa_autoconfig(struct uart_8250_port *up);
-void rsa_reset(struct uart_8250_port *up);
-#else
-static inline void univ8250_rsa_support(struct uart_ops *ops, const struct uart_ops *core_ops) { }
-static inline void rsa_enable(struct uart_8250_port *up) {}
-static inline void rsa_disable(struct uart_8250_port *up) {}
-static inline void rsa_autoconfig(struct uart_8250_port *up) {}
-static inline void rsa_reset(struct uart_8250_port *up) {}
-#endif
-
 #ifdef CONFIG_SERIAL_8250_FINTEK
 int fintek_8250_probe(struct uart_8250_port *uart);
 #else
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 42319843cb5b..e7ffeac562d2 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -307,9 +307,6 @@ static void univ8250_release_irq(struct uart_8250_port *up)
 		serial_unlink_irq_chain(up);
 }
 
-const struct uart_ops *univ8250_port_base_ops;
-struct uart_ops univ8250_port_ops;
-
 static const struct uart_8250_ops univ8250_driver_ops = {
 	.setup_irq	= univ8250_setup_irq,
 	.release_irq	= univ8250_release_irq,
@@ -352,9 +349,6 @@ struct uart_8250_port *serial8250_setup_port(int index)
 	up->port.port_id = index;
 
 	serial8250_init_port(up);
-	if (!univ8250_port_base_ops)
-		univ8250_port_base_ops = up->port.ops;
-	up->port.ops = &univ8250_port_ops;
 
 	timer_setup(&up->timer, serial8250_timeout, 0);
 
diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 7ce7ad295fae..3a9101cb1060 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -73,10 +73,6 @@ static void __init __serial8250_isa_init_ports(void)
 	for (i = 0; i < nr_uarts; i++)
 		serial8250_setup_port(i);
 
-	/* chain base port ops to support Remote Supervisor Adapter */
-	univ8250_port_ops = *univ8250_port_base_ops;
-	univ8250_rsa_support(&univ8250_port_ops, univ8250_port_base_ops);
-
 	for (i = 0; i < ARRAY_SIZE(old_serial_port) && i < nr_uarts; i++) {
 		struct uart_8250_port *up = serial8250_get_port(i);
 		struct uart_port *port = &up->port;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 36b2b0a2c05c..8aaf1f852a9a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1209,8 +1209,6 @@ static void autoconfig(struct uart_8250_port *up)
 		break;
 	}
 
-	rsa_autoconfig(up);
-
 	serial_out(up, UART_LCR, save_lcr);
 
 	port->fifosize = uart_config[up->port.type].fifo_size;
@@ -1222,7 +1220,6 @@ static void autoconfig(struct uart_8250_port *up)
 		/*
 		 * Reset the UART.
 		 */
-		rsa_reset(up);
 		serial8250_out_MCR(up, save_mcr);
 		serial8250_clear_fifos(up);
 		serial_in(up, UART_RX);
@@ -2179,9 +2176,6 @@ static void serial8250_startup_special(struct uart_port *port)
 				UART_DA830_PWREMU_MGMT_URRST |
 				UART_DA830_PWREMU_MGMT_FREE);
 		break;
-	case PORT_RSA:
-		rsa_enable(up);
-		break;
 	}
 }
 
@@ -2473,8 +2467,6 @@ void serial8250_do_shutdown(struct uart_port *port)
 
 	serial8250_clear_fifos(up);
 
-	rsa_disable(up);
-
 	/*
 	 * Read data port to reset things, and then unlink from
 	 * the IRQ chain.
diff --git a/drivers/tty/serial/8250/8250_rsa.c b/drivers/tty/serial/8250/8250_rsa.c
deleted file mode 100644
index da971437e89c..000000000000
--- a/drivers/tty/serial/8250/8250_rsa.c
+++ /dev/null
@@ -1,209 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-
-#include <linux/errno.h>
-#include <linux/ioport.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-
-#include <linux/serial.h>
-#include <linux/serial_8250.h>
-
-#include "8250.h"
-
-#define PORT_RSA_MAX 4
-static unsigned long probe_rsa[PORT_RSA_MAX];
-static unsigned int probe_rsa_count;
-
-static const struct uart_ops *core_port_base_ops;
-
-static int rsa8250_request_resource(struct uart_8250_port *up)
-{
-	struct uart_port *port = &up->port;
-	unsigned long start;
-	unsigned int size;
-
-	if (!uart_iotype_io(port->iotype))
-		return -EINVAL;
-
-	start = UART_RSA_BASE << port->regshift;
-	start += port->iobase;
-	size = 8 << port->regshift;
-
-	if (!request_region(start, size, "serial-rsa"))
-		return -EBUSY;
-	return 0;
-}
-
-static void rsa8250_release_resource(struct uart_8250_port *up)
-{
-	struct uart_port *port = &up->port;
-	unsigned long offset;
-	unsigned int size;
-
-	if (!uart_iotype_io(port->iotype))
-		return;
-
-	offset = UART_RSA_BASE << port->regshift;
-	size = 8 << port->regshift;
-	release_region(port->iobase + offset, size);
-}
-
-static void univ8250_config_port(struct uart_port *port, int flags)
-{
-	struct uart_8250_port *up = up_to_u8250p(port);
-	unsigned int i;
-
-	up->probe &= ~UART_PROBE_RSA;
-	if (port->type == PORT_RSA) {
-		if (rsa8250_request_resource(up) == 0)
-			up->probe |= UART_PROBE_RSA;
-	} else if (flags & UART_CONFIG_TYPE) {
-		for (i = 0; i < probe_rsa_count; i++) {
-			if (probe_rsa[i] == up->port.iobase) {
-				if (rsa8250_request_resource(up) == 0)
-					up->probe |= UART_PROBE_RSA;
-				break;
-			}
-		}
-	}
-
-	core_port_base_ops->config_port(port, flags);
-
-	if (port->type != PORT_RSA && up->probe & UART_PROBE_RSA)
-		rsa8250_release_resource(up);
-}
-
-static int univ8250_request_port(struct uart_port *port)
-{
-	struct uart_8250_port *up = up_to_u8250p(port);
-	int ret;
-
-	ret = core_port_base_ops->request_port(port);
-	if (ret == 0 && port->type == PORT_RSA) {
-		ret = rsa8250_request_resource(up);
-		if (ret < 0)
-			core_port_base_ops->release_port(port);
-	}
-
-	return ret;
-}
-
-static void univ8250_release_port(struct uart_port *port)
-{
-	struct uart_8250_port *up = up_to_u8250p(port);
-
-	if (port->type == PORT_RSA)
-		rsa8250_release_resource(up);
-	core_port_base_ops->release_port(port);
-}
-
-/*
- * It is not allowed to directly reference any symbols from 8250.ko here as
- * that would result in a dependency loop between the 8250.ko and
- * 8250_base.ko modules. This function is called from 8250.ko and is used to
- * break the symbolic dependency cycle. Anything that is needed from 8250.ko
- * has to be passed as pointers to this function which then can adjust those
- * variables on 8250.ko side or store them locally as needed.
- */
-void univ8250_rsa_support(struct uart_ops *ops, const struct uart_ops *core_ops)
-{
-	core_port_base_ops = core_ops;
-	ops->config_port  = univ8250_config_port;
-	ops->request_port = univ8250_request_port;
-	ops->release_port = univ8250_release_port;
-}
-EXPORT_SYMBOL_FOR_MODULES(univ8250_rsa_support, "8250");
-
-module_param_hw_array(probe_rsa, ulong, ioport, &probe_rsa_count, 0444);
-MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
-
-/*
- * Attempts to turn on the RSA FIFO.  Returns zero on failure.
- * We set the port uart clock rate if we succeed.
- */
-static int __rsa_enable(struct uart_8250_port *up)
-{
-	unsigned char mode;
-	int result;
-
-	mode = serial_in(up, UART_RSA_MSR);
-	result = mode & UART_RSA_MSR_FIFO;
-
-	if (!result) {
-		serial_out(up, UART_RSA_MSR, mode | UART_RSA_MSR_FIFO);
-		mode = serial_in(up, UART_RSA_MSR);
-		result = mode & UART_RSA_MSR_FIFO;
-	}
-
-	if (result)
-		up->port.uartclk = SERIAL_RSA_BAUD_BASE * 16;
-
-	return result;
-}
-
-/*
- * If this is an RSA port, see if we can kick it up to the higher speed clock.
- */
-void rsa_enable(struct uart_8250_port *up)
-{
-	if (up->port.type != PORT_RSA)
-		return;
-
-	if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16) {
-		guard(uart_port_lock_irq)(&up->port);
-		__rsa_enable(up);
-	}
-	if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
-		serial_out(up, UART_RSA_FRR, 0);
-}
-
-/*
- * Attempts to turn off the RSA FIFO and resets the RSA board back to 115kbps compat mode. It is
- * unknown why interrupts were disabled in here. However, the caller is expected to preserve this
- * behaviour by grabbing the spinlock before calling this function.
- */
-void rsa_disable(struct uart_8250_port *up)
-{
-	unsigned char mode;
-	int result;
-
-	if (up->port.type != PORT_RSA)
-		return;
-
-	if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16)
-		return;
-
-	guard(uart_port_lock_irq)(&up->port);
-
-	mode = serial_in(up, UART_RSA_MSR);
-	result = !(mode & UART_RSA_MSR_FIFO);
-
-	if (!result) {
-		serial_out(up, UART_RSA_MSR, mode & ~UART_RSA_MSR_FIFO);
-		mode = serial_in(up, UART_RSA_MSR);
-		result = !(mode & UART_RSA_MSR_FIFO);
-	}
-
-	if (result)
-		up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
-}
-
-void rsa_autoconfig(struct uart_8250_port *up)
-{
-	/* Only probe for RSA ports if we got the region. */
-	if (up->port.type != PORT_16550A)
-		return;
-	if (!(up->probe & UART_PROBE_RSA))
-		return;
-
-	if (__rsa_enable(up))
-		up->port.type = PORT_RSA;
-}
-
-void rsa_reset(struct uart_8250_port *up)
-{
-	if (up->port.type != PORT_RSA)
-		return;
-
-	serial_out(up, UART_RSA_FRR, 0);
-}
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 82e761b8298a..7a5a9cbc7d02 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -236,17 +236,6 @@ config SERIAL_8250_DETECT_IRQ
 
 	  If unsure, say N.
 
-config SERIAL_8250_RSA
-	bool "Support RSA serial ports"
-	depends on SERIAL_8250_EXTENDED
-	help
-	  Say Y here if you have a IODATA RSA-DV II/S ISA card and
-	  would like to use its >115kbps speeds.
-	  You will need to provide module parameter "probe_rsa", or boot-time
-	  parameter 8250.probe_rsa with I/O addresses of this card then.
-
-	  If you don't have such card, or if unsure, say N.
-
 config SERIAL_8250_MANY_PORTS
 	bool "Support more than 4 legacy serial ports"
 	depends on SERIAL_8250_EXTENDED
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 5ff2ba414e13..3c8ae7e4231b 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -15,7 +15,6 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250_base.o
 8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
 8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
 8250_base-$(CONFIG_SERIAL_8250_PCILIB)	+= 8250_pcilib.o
-8250_base-$(CONFIG_SERIAL_8250_RSA)	+= 8250_rsa.o
 
 obj-$(CONFIG_SERIAL_8250_CONSOLE)	+= 8250_early.o
 
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 4ff3e5c41dab..52437a133cdd 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -159,75 +159,6 @@ static void serial_icr_write(struct uart_sunsu_port *up, int offset, int value)
 	serial_out(up, UART_ICR, value);
 }
 
-#ifdef CONFIG_SERIAL_8250_RSA
-/*
- * Attempts to turn on the RSA FIFO.  Returns zero on failure.
- * We set the port uart clock rate if we succeed.
- */
-static int __enable_rsa(struct uart_sunsu_port *up)
-{
-	unsigned char mode;
-	int result;
-
-	mode = serial_in(up, UART_RSA_MSR);
-	result = mode & UART_RSA_MSR_FIFO;
-
-	if (!result) {
-		serial_out(up, UART_RSA_MSR, mode | UART_RSA_MSR_FIFO);
-		mode = serial_in(up, UART_RSA_MSR);
-		result = mode & UART_RSA_MSR_FIFO;
-	}
-
-	if (result)
-		up->port.uartclk = SERIAL_RSA_BAUD_BASE * 16;
-
-	return result;
-}
-
-static void enable_rsa(struct uart_sunsu_port *up)
-{
-	if (up->port.type == PORT_RSA) {
-		if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16) {
-			uart_port_lock_irq(&up->port);
-			__enable_rsa(up);
-			uart_port_unlock_irq(&up->port);
-		}
-		if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
-			serial_out(up, UART_RSA_FRR, 0);
-	}
-}
-
-/*
- * Attempts to turn off the RSA FIFO.  Returns zero on failure.
- * It is unknown why interrupts were disabled in here.  However,
- * the caller is expected to preserve this behaviour by grabbing
- * the spinlock before calling this function.
- */
-static void disable_rsa(struct uart_sunsu_port *up)
-{
-	unsigned char mode;
-	int result;
-
-	if (up->port.type == PORT_RSA &&
-	    up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16) {
-		uart_port_lock_irq(&up->port);
-
-		mode = serial_in(up, UART_RSA_MSR);
-		result = !(mode & UART_RSA_MSR_FIFO);
-
-		if (!result) {
-			serial_out(up, UART_RSA_MSR, mode & ~UART_RSA_MSR_FIFO);
-			mode = serial_in(up, UART_RSA_MSR);
-			result = !(mode & UART_RSA_MSR_FIFO);
-		}
-
-		if (result)
-			up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
-		uart_port_unlock_irq(&up->port);
-	}
-}
-#endif /* CONFIG_SERIAL_8250_RSA */
-
 static inline void __stop_tx(struct uart_sunsu_port *p)
 {
 	if (p->ier & UART_IER_THRI) {
@@ -605,14 +536,6 @@ static int sunsu_startup(struct uart_port *port)
 		serial_out(up, UART_LCR, 0);
 	}
 
-#ifdef CONFIG_SERIAL_8250_RSA
-	/*
-	 * If this is an RSA port, see if we can kick it up to the
-	 * higher speed clock.
-	 */
-	enable_rsa(up);
-#endif
-
 	/*
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
@@ -728,13 +651,6 @@ static void sunsu_shutdown(struct uart_port *port)
 				  UART_FCR_CLEAR_XMIT);
 	serial_out(up, UART_FCR, 0);
 
-#ifdef CONFIG_SERIAL_8250_RSA
-	/*
-	 * Reset the RSA board back to 115kbps compat mode.
-	 */
-	disable_rsa(up);
-#endif
-
 	/*
 	 * Read data port to reset things.
 	 */
@@ -789,10 +705,6 @@ sunsu_change_speed(struct uart_port *port, unsigned int cflag,
 	if (uart_config[up->port.type].flags & UART_USE_FIFO) {
 		if ((up->port.uartclk / quot) < (2400 * 16))
 			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
-#ifdef CONFIG_SERIAL_8250_RSA
-		else if (up->port.type == PORT_RSA)
-			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_14;
-#endif
 		else
 			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_8;
 	}
@@ -1137,10 +1049,6 @@ static void sunsu_autoconfig(struct uart_sunsu_port *up)
 	/*
 	 * Reset the UART.
 	 */
-#ifdef CONFIG_SERIAL_8250_RSA
-	if (up->port.type == PORT_RSA)
-		serial_out(up, UART_RSA_FRR, 0);
-#endif
 	serial_out(up, UART_MCR, save_mcr);
 	serial_out(up, UART_FCR, (UART_FCR_ENABLE_FIFO |
 				     UART_FCR_CLEAR_RCVR |
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index 9c987b04e2d0..e4f288b557ca 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -285,57 +285,6 @@
 #define UART_ACR_ICRRD	0x40	/* ICR Read enable */
 #define UART_ACR_ASREN	0x80	/* Additional status enable */
 
-
-
-/*
- * These definitions are for the RSA-DV II/S card, from
- *
- * Kiyokazu SUTO <suto@ks-and-ks.ne.jp>
- */
-
-#define UART_RSA_BASE (-8)
-
-#define UART_RSA_MSR ((UART_RSA_BASE) + 0) /* I/O: Mode Select Register */
-
-#define UART_RSA_MSR_SWAP (1 << 0) /* Swap low/high 8 bytes in I/O port addr */
-#define UART_RSA_MSR_FIFO (1 << 2) /* Enable the external FIFO */
-#define UART_RSA_MSR_FLOW (1 << 3) /* Enable the auto RTS/CTS flow control */
-#define UART_RSA_MSR_ITYP (1 << 4) /* Level (1) / Edge triger (0) */
-
-#define UART_RSA_IER ((UART_RSA_BASE) + 1) /* I/O: Interrupt Enable Register */
-
-#define UART_RSA_IER_Rx_FIFO_H (1 << 0) /* Enable Rx FIFO half full int. */
-#define UART_RSA_IER_Tx_FIFO_H (1 << 1) /* Enable Tx FIFO half full int. */
-#define UART_RSA_IER_Tx_FIFO_E (1 << 2) /* Enable Tx FIFO empty int. */
-#define UART_RSA_IER_Rx_TOUT (1 << 3) /* Enable char receive timeout int */
-#define UART_RSA_IER_TIMER (1 << 4) /* Enable timer interrupt */
-
-#define UART_RSA_SRR ((UART_RSA_BASE) + 2) /* IN: Status Read Register */
-
-#define UART_RSA_SRR_Tx_FIFO_NEMP (1 << 0) /* Tx FIFO is not empty (1) */
-#define UART_RSA_SRR_Tx_FIFO_NHFL (1 << 1) /* Tx FIFO is not half full (1) */
-#define UART_RSA_SRR_Tx_FIFO_NFUL (1 << 2) /* Tx FIFO is not full (1) */
-#define UART_RSA_SRR_Rx_FIFO_NEMP (1 << 3) /* Rx FIFO is not empty (1) */
-#define UART_RSA_SRR_Rx_FIFO_NHFL (1 << 4) /* Rx FIFO is not half full (1) */
-#define UART_RSA_SRR_Rx_FIFO_NFUL (1 << 5) /* Rx FIFO is not full (1) */
-#define UART_RSA_SRR_Rx_TOUT (1 << 6) /* Character reception timeout occurred (1) */
-#define UART_RSA_SRR_TIMER (1 << 7) /* Timer interrupt occurred */
-
-#define UART_RSA_FRR ((UART_RSA_BASE) + 2) /* OUT: FIFO Reset Register */
-
-#define UART_RSA_TIVSR ((UART_RSA_BASE) + 3) /* I/O: Timer Interval Value Set Register */
-
-#define UART_RSA_TCR ((UART_RSA_BASE) + 4) /* OUT: Timer Control Register */
-
-#define UART_RSA_TCR_SWITCH (1 << 0) /* Timer on */
-
-/*
- * The RSA DSV/II board has two fixed clock frequencies.  One is the
- * standard rate, and the other is 8 times faster.
- */
-#define SERIAL_RSA_BAUD_BASE (921600)
-#define SERIAL_RSA_BAUD_BASE_LO (SERIAL_RSA_BAUD_BASE / 8)
-
 /* Extra registers for TI DA8xx/66AK2x */
 #define UART_DA830_PWREMU_MGMT	12
 
-- 
2.53.0

