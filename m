From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RFC 3/5] 8250: register upio users
Date: Fri, 18 Mar 2011 15:25:38 +0000
Message-ID: <20110318152529.10657.10613.stgit@bob.linux.org.uk>
References: <20110318152145.10657.23718.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:44127 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab1CRPp3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Mar 2011 11:45:29 -0400
Received: from bob.linux.org.uk (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.4/8.14.1) with ESMTP id p2IFmI2i018113
	for <linux-serial@vger.kernel.org>; Fri, 18 Mar 2011 15:48:24 GMT
In-Reply-To: <20110318152145.10657.23718.stgit@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

We need to do this so we can continue to offer the setserial upio interface
while dumping I/O methods back out into the drivers.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/8250.c   |  103 ++++++++++++++++++++++++++++++-------------
 include/linux/serial_8250.h |    4 ++
 2 files changed, 77 insertions(+), 30 deletions(-)


diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index c3e56a7..89a00d1 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -612,46 +612,87 @@ static const struct serial8250_ops rm9k_ops = {
 	.serial_dl_write = rm9k_serial_dl_write
 };
 
-/* This needs to move to a table where drivers register their ops. Needs
-   some thought on the module count side */
+	
+static const struct serial8250_ops *upio_ops[UPIO_MAX + 1] = {
+	/* We rely upon pio_ops being built in */
+	&pio_ops,	/* UPIO_PORT */
+	&hub6_ops,	/* UPIO_HUB6 */
+	&mem_ops,	/* UPIO_MEM */
+	&mem32_ops,	/* UPIO_MEM32 */
+	&au_ops,	/* UPIO_AU */
+	&tsi_ops,	/* UPIO_TSI */
+	&dwapb_ops,	/* UPIO_DWAPB */
+	&rm9k_ops,	/* UPIO_RM9000 */
+	&dwapb32_ops	/* UPIO_DWAPB32 */
+};
+
+static DEFINE_MUTEX(upio_mutex);
+
 static void set_io_from_upio(struct uart_port *p)
 {
 	struct uart_8250_port *up =
 		container_of(p, struct uart_8250_port, port);
 
-	switch (p->iotype) {
-	case UPIO_HUB6:
-		up->ops = &hub6_ops;
-		break;
-	case UPIO_MEM:
-		up->ops = &mem_ops;
-		break;
-	case UPIO_RM9000:
-		up->ops = &rm9k_ops;
-		break;
-	case UPIO_MEM32:
-		up->ops = &mem32_ops;
-		break;
-	case UPIO_AU:
-		up->ops = &au_ops;
-		break;
-	case UPIO_TSI:
-		up->ops = &tsi_ops;
-		break;
-	case UPIO_DWAPB:
-		up->ops = &dwapb_ops;
-		break;
-	case UPIO_DWAPB32:
-		up->ops = &dwapb32_ops;
-		break;
-	default:
+	mutex_lock(&upio_mutex);
+	if (p->iotype > UPIO_MAX) {
+		WARN_ON(1);
 		up->ops = &pio_ops;
-		break;
+		p->iotype = UPIO_PORT;
+	}
+	/* up->ops may differ from up->cur_iotype ops
+	   For now work off cur_iotype, we should address this better later */
+	module_put(upio_ops[up->cur_iotype]->owner);
+	up->ops = upio_ops[p->iotype];
+	if (up->ops == NULL || !try_module_get(up->ops->owner)) {
+		up->ops = &pio_ops;
+		p->iotype = UPIO_PORT;
 	}
+		
 	/* Remember loaded iotype */
 	up->cur_iotype = p->iotype;
+	mutex_unlock(&upio_mutex);
 }
 
+/**
+ *	serial8250_upio_register	-	register UPIO methods
+ *	@upio: upio number
+ *	@ops: operations for this upio
+ *
+ *	Registers a set of upio operations and makes them available via
+ *	the serial configuration interface for tty devices, and via the
+ *	registration interfaces via upio value setting. Unless there are
+ *	specific reasons new drivers should pass an ops structure directly
+ *	instead.
+ */
+int serial8250_upio_register(int upio, struct serial8250_ops *ops)
+{
+	int ret = 0;
+	mutex_lock(&upio_mutex);
+	if (upio < 1 || upio > UPIO_MAX)
+		ret = -EINVAL;
+	else if (upio_ops[upio])
+		ret = -EBUSY;
+	else
+		upio_ops[upio] = ops;
+	mutex_unlock(&upio_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(serial8250_upio_register);
+
+int serial8250_upio_unregister(int upio)
+{
+	int ret = 0;
+	mutex_lock(&upio_mutex);
+	if (upio_ops[upio] == NULL) {
+		WARN_ON(1);
+		ret = -EINVAL;
+	}
+	upio_ops[upio] = NULL;
+	mutex_unlock(&upio_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(serial8250_upio_unregister);
+
 static void
 serial_out_sync(struct uart_8250_port *up, int offset, int value)
 {
@@ -3305,7 +3346,7 @@ int serial8250_register_port(struct uart_port *port,
 
 		set_io_from_upio(&uart->port);
 		if (ops)
-			uart->port.ops = ops;
+			uart->ops = ops;
 
 		if (serial8250_isa_config != NULL)
 			serial8250_isa_config(0, &uart->port,
@@ -3337,6 +3378,8 @@ void serial8250_unregister_port(int line)
 	if (serial8250_isa_devs) {
 		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
 		uart->port.type = PORT_UNKNOWN;
+		uart->port.iotype = UPIO_PORT;
+		set_io_from_upio(&uart->port);
 		uart->port.dev = &serial8250_isa_devs->dev;
 		uart_add_one_port(&serial8250_reg, &uart->port);
 	} else {
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 15806bb..30d4f62 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -24,6 +24,7 @@ struct serial8250_ops {
 			      unsigned old);
 	unsigned int	(*serial_dl_read)(struct uart_port *);
 	void		(*serial_dl_write)(struct uart_port *, unsigned int);
+	struct module 	*owner;
 };
 
 /*
@@ -99,4 +100,7 @@ static inline int __deprecated early_serial_setup(struct uart_port *port)
         return serial8250_early_setup(port, NULL);
 }
 
+extern int serial8250_upio_register(int upio, struct serial8250_ops *ops);
+extern int serial8250_upio_unregister(int upio);
+
 #endif

