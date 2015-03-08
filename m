From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH 1/2] serial: 8250: allow specifying iomem size in addition to address
Date: Sun,  8 Mar 2015 14:30:04 +0000
Message-ID: <1425825005-7556-1-git-send-email-mans@mansr.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This adds a mapsize field to struct uart_port to be used in
conjunction with mapbase. If set, it overrides whatever value
serial8250_port_size() would otherwise report.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/tty/serial/8250/8250_core.c | 4 ++++
 include/linux/serial_core.h         | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 58a9283..60bf876 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2722,6 +2722,8 @@ serial8250_pm(struct uart_port *port, unsigned int state,
 
 static unsigned int serial8250_port_size(struct uart_8250_port *pt)
 {
+	if (pt->port.mapsize)
+		return pt->port.mapsize;
 	if (pt->port.iotype == UPIO_AU) {
 		if (pt->port.type == PORT_RT2880)
 			return 0x100;
@@ -3415,6 +3417,7 @@ int __init early_serial_setup(struct uart_port *port)
 	p->iotype       = port->iotype;
 	p->flags        = port->flags;
 	p->mapbase      = port->mapbase;
+	p->mapsize      = port->mapsize;
 	p->private_data = port->private_data;
 	p->type		= port->type;
 	p->line		= port->line;
@@ -3669,6 +3672,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
 		uart->bugs		= up->bugs;
 		uart->port.mapbase      = up->port.mapbase;
+		uart->port.mapsize      = up->port.mapsize;
 		uart->port.private_data = up->port.private_data;
 		uart->port.fifosize	= up->port.fifosize;
 		uart->tx_loadsz		= up->tx_loadsz;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index baf3e1d..74a2647 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -236,6 +236,7 @@ struct uart_port {
 	unsigned int		custom_divisor;
 	unsigned int		line;			/* port index */
 	resource_size_t		mapbase;		/* for ioremap */
+	resource_size_t		mapsize;
 	struct device		*dev;			/* parent device */
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		suspended;
-- 
2.3.1
