From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 5/8] drivers: tty: serial: introduce struct resource
Date: Tue, 12 Mar 2019 15:57:37 +0100
Message-ID: <1552402660-31730-6-git-send-email-info@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552402660-31730-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The standard data structure for holding io resources in the
kernel is struct resource. Serial drivers yet don't really
use it (except when retrieving from oftree).

This patch introduces a new field in struct uart_port for that,
plus several helpers. Yet it's up to the individual drivers for
using it - serial_core doesn't care yet. Therefore, the old fields
mapbase and mapsize need to be filled properly by the drivers.
---
 include/linux/serial_core.h | 49 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 5fe2b03..9b07a40 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -24,6 +24,7 @@
 #include <linux/compiler.h>
 #include <linux/console.h>
 #include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <linux/circ_buf.h>
 #include <linux/spinlock.h>
 #include <linux/sched.h>
@@ -256,6 +257,7 @@ struct uart_port {
 	unsigned int		minor;
 	resource_size_t		mapbase;		/* for ioremap */
 	resource_size_t		mapsize;
+	struct resource		memres;
 	struct device		*dev;			/* parent device */
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		suspended;
@@ -427,6 +429,53 @@ void uart_console_write(struct uart_port *port, const char *s,
 int uart_match_port(struct uart_port *port1, struct uart_port *port2);
 
 /*
+ * Port resource management
+ */
+static inline void uart_memres_set(struct uart_port *port,
+				     struct resource res)
+{
+	port->memres = res;
+	port->mapbase = res.start;
+}
+
+static inline void uart_memres_clear(struct uart_port *port)
+{
+	port->memres = DEFINE_RES_MEM(0, 0);
+}
+
+static inline int uart_memres_valid(struct uart_port *port)
+{
+	return (port->memres.start != 0);
+}
+
+static inline struct resource *uart_memres_request(struct uart_port *port,
+				     const char *name)
+{
+	return request_mem_region(
+		port->memres.start,
+		resource_size(&port->memres),
+		name);
+}
+
+static inline void uart_memres_release(struct uart_port *port)
+{
+	return release_mem_region(port->memres.start,
+				  resource_size(&port->memres));
+}
+
+static inline void __iomem *uart_memres_ioremap_nocache(struct uart_port *port)
+{
+	return ioremap_nocache(port->memres.start,
+			       resource_size(&port->memres.start));
+}
+
+static inline void __iomem *uart_memres_ioremap(struct uart_port *port)
+{
+	return ioremap(port->memres.start,
+		       resource_size(&port->memres.start));
+}
+
+/*
  * Power Management
  */
 int uart_suspend_port(struct uart_driver *reg, struct uart_port *port);
-- 
1.9.1
