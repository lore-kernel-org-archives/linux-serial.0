From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/4] TTY: serial/m32r_sio, disband m32r_sio.h
Date: Tue, 12 Jan 2016 10:59:06 +0100
Message-ID: <1452592749-25150-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

The only needed information from the header is struct old_serial_port.
Move it to m32r_sio.c, make it const and anonymous. And kill the rest
from the header as it is dead stuff.

Given m32r_sio_suspend_port and m32r_sio_resume_port are local to
m32r_sio.c and unused, kill them from .c too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/m32r_sio.c | 37 +++++++++-----------------------
 drivers/tty/serial/m32r_sio.h | 49 -------------------------------------------
 2 files changed, 10 insertions(+), 76 deletions(-)
 delete mode 100644 drivers/tty/serial/m32r_sio.h

diff --git a/drivers/tty/serial/m32r_sio.c b/drivers/tty/serial/m32r_sio.c
index 0eeb64f2499c..3c76ffc2d10a 100644
--- a/drivers/tty/serial/m32r_sio.c
+++ b/drivers/tty/serial/m32r_sio.c
@@ -47,7 +47,6 @@
 #define BAUD_RATE	115200
 
 #include <linux/serial_core.h>
-#include "m32r_sio.h"
 #include "m32r_sio_reg.h"
 
 /*
@@ -98,7 +97,16 @@
 
 #endif /* !CONFIG_PLAT_USRV */
 
-static struct old_serial_port old_serial_port[] = {
+static const struct {
+	unsigned int uart;
+	unsigned int baud_base;
+	unsigned int port;
+	unsigned int irq;
+	unsigned int flags;
+	unsigned char io_type;
+	unsigned char __iomem *iomem_base;
+	unsigned short iomem_reg_shift;
+} old_serial_port[] = {
 	SERIAL_PORT_DFNS
 };
 
@@ -1112,28 +1120,6 @@ static struct uart_driver m32r_sio_reg = {
 	.cons			= M32R_SIO_CONSOLE,
 };
 
-/**
- *	m32r_sio_suspend_port - suspend one serial port
- *	@line: serial line number
- *
- *	Suspend one serial port.
- */
-void m32r_sio_suspend_port(int line)
-{
-	uart_suspend_port(&m32r_sio_reg, &m32r_sio_ports[line].port);
-}
-
-/**
- *	m32r_sio_resume_port - resume one serial port
- *	@line: serial line number
- *
- *	Resume one serial port.
- */
-void m32r_sio_resume_port(int line)
-{
-	uart_resume_port(&m32r_sio_reg, &m32r_sio_ports[line].port);
-}
-
 static int __init m32r_sio_init(void)
 {
 	int ret, i;
@@ -1163,8 +1149,5 @@ static void __exit m32r_sio_exit(void)
 module_init(m32r_sio_init);
 module_exit(m32r_sio_exit);
 
-EXPORT_SYMBOL(m32r_sio_suspend_port);
-EXPORT_SYMBOL(m32r_sio_resume_port);
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Generic M32R SIO serial driver");
diff --git a/drivers/tty/serial/m32r_sio.h b/drivers/tty/serial/m32r_sio.h
deleted file mode 100644
index 8129824496c6..000000000000
--- a/drivers/tty/serial/m32r_sio.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- *  m32r_sio.h
- *
- *  Driver for M32R serial ports
- *
- *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
- *  Based on drivers/serial/8250.h.
- *
- *  Copyright (C) 2001  Russell King.
- *  Copyright (C) 2004  Hirokazu Takata <takata at linux-m32r.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/pci.h>
-
-struct m32r_sio_probe {
-	struct module	*owner;
-	int		(*pci_init_one)(struct pci_dev *dev);
-	void		(*pci_remove_one)(struct pci_dev *dev);
-	void		(*pnp_init)(void);
-};
-
-int m32r_sio_register_probe(struct m32r_sio_probe *probe);
-void m32r_sio_unregister_probe(struct m32r_sio_probe *probe);
-void m32r_sio_get_irq_map(unsigned int *map);
-void m32r_sio_suspend_port(int line);
-void m32r_sio_resume_port(int line);
-
-struct old_serial_port {
-	unsigned int uart;
-	unsigned int baud_base;
-	unsigned int port;
-	unsigned int irq;
-	unsigned int flags;
-	unsigned char io_type;
-	unsigned char __iomem *iomem_base;
-	unsigned short iomem_reg_shift;
-};
-
-#define _INLINE_ inline
-
-#define PROBE_RSA	(1 << 0)
-#define PROBE_ANY	(~0)
-
-#define HIGH_BITS_OFFSET ((sizeof(long)-sizeof(int))*8)
-- 
2.7.0
