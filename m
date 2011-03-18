From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RFC 4/5] 8250: evict the hub6 I/O operations
Date: Fri, 18 Mar 2011 15:25:57 +0000
Message-ID: <20110318152549.10657.33161.stgit@bob.linux.org.uk>
References: <20110318152145.10657.23718.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:44128 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab1CRPps (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Mar 2011 11:45:48 -0400
Received: from bob.linux.org.uk (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.4/8.14.1) with ESMTP id p2IFmbRC018128
	for <linux-serial@vger.kernel.org>; Fri, 18 Mar 2011 15:48:42 GMT
In-Reply-To: <20110318152145.10657.23718.stgit@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

This is a test to see how the split looks when we do this, there is other
hub6 code buried in the core because of the way the 8250 and serial core
manage resources. That needs addressing.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/8250.c      |   52 ++--------------------------------------
 drivers/tty/serial/8250.h      |   27 +++++++++++++++++++++
 drivers/tty/serial/8250_hub6.c |   39 ++++++++++++++++++++++++++++++
 include/linux/serial_8250.h    |    2 +-
 4 files changed, 69 insertions(+), 51 deletions(-)


diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 89a00d1..a5867da 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -131,32 +131,6 @@ static unsigned long probe_rsa[PORT_RSA_MAX];
 static unsigned int probe_rsa_count;
 #endif /* CONFIG_SERIAL_8250_RSA  */
 
-struct uart_8250_port {
-	struct uart_port	port;
-	const struct serial8250_ops *ops;	/* I/O access methods */
-	struct timer_list	timer;		/* "no irq" timer */
-	struct list_head	list;		/* ports on this IRQ */
-	unsigned short		capabilities;	/* port capabilities */
-	unsigned short		bugs;		/* port bugs */
-	unsigned int		tx_loadsz;	/* transmit fifo load size */
-	unsigned char		acr;
-	unsigned char		ier;
-	unsigned char		lcr;
-	unsigned char		mcr;
-	unsigned char		mcr_mask;	/* mask of user bits */
-	unsigned char		mcr_force;	/* mask of forced bits */
-	unsigned char		cur_iotype;	/* Running I/O type */
-
-	/*
-	 * Some bits in registers are cleared on a read, so they must
-	 * be saved whenever the register is read but the bits will not
-	 * be immediately processed.
-	 */
-#define LSR_SAVE_FLAGS UART_LSR_BRK_ERROR_BITS
-	unsigned char		lsr_saved_flags;
-#define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
-	unsigned char		msr_saved_flags;
-};
 
 struct irq_info {
 	struct			hlist_node node;
@@ -406,28 +380,6 @@ static void std_serial_dl_write(struct uart_port *p, unsigned int value)
 	up->ops->serial_out(p, UART_DLM, value >> 8 & 0xff);
 }
 
-
-static unsigned int hub6_serial_in(struct uart_port *p, int offset)
-{
-	offset = map_8250_in_reg(p, offset) << p->regshift;
-	outb(p->hub6 - 1 + offset, p->iobase);
-	return inb(p->iobase + 1);
-}
-
-static void hub6_serial_out(struct uart_port *p, int offset, int value)
-{
-	offset = map_8250_out_reg(p, offset) << p->regshift;
-	outb(p->hub6 - 1 + offset, p->iobase);
-	outb(value, p->iobase + 1);
-}
-
-static const struct serial8250_ops hub6_ops = {
-	.serial_in = hub6_serial_in,
-	.serial_out = hub6_serial_out,
-	.serial_dl_read = std_serial_dl_read,
-	.serial_dl_write = std_serial_dl_write
-};
-
 static unsigned int mem_serial_in(struct uart_port *p, int offset)
 {
 	offset = map_8250_in_reg(p, offset) << p->regshift;
@@ -616,7 +568,7 @@ static const struct serial8250_ops rm9k_ops = {
 static const struct serial8250_ops *upio_ops[UPIO_MAX + 1] = {
 	/* We rely upon pio_ops being built in */
 	&pio_ops,	/* UPIO_PORT */
-	&hub6_ops,	/* UPIO_HUB6 */
+	NULL,		/* UPIO_HUB6 */
 	&mem_ops,	/* UPIO_MEM */
 	&mem32_ops,	/* UPIO_MEM32 */
 	&au_ops,	/* UPIO_AU */
@@ -664,7 +616,7 @@ static void set_io_from_upio(struct uart_port *p)
  *	specific reasons new drivers should pass an ops structure directly
  *	instead.
  */
-int serial8250_upio_register(int upio, struct serial8250_ops *ops)
+int serial8250_upio_register(int upio, const struct serial8250_ops *ops)
 {
 	int ret = 0;
 	mutex_lock(&upio_mutex);
diff --git a/drivers/tty/serial/8250.h b/drivers/tty/serial/8250.h
index 6e19ea3..3b3c282 100644
--- a/drivers/tty/serial/8250.h
+++ b/drivers/tty/serial/8250.h
@@ -28,6 +28,33 @@ struct old_serial_port {
 	unsigned long irqflags;
 };
 
+struct uart_8250_port {
+	struct uart_port	port;
+	const struct serial8250_ops *ops;	/* I/O access methods */
+	struct timer_list	timer;		/* "no irq" timer */
+	struct list_head	list;		/* ports on this IRQ */
+	unsigned short		capabilities;	/* port capabilities */
+	unsigned short		bugs;		/* port bugs */
+	unsigned int		tx_loadsz;	/* transmit fifo load size */
+	unsigned char		acr;
+	unsigned char		ier;
+	unsigned char		lcr;
+	unsigned char		mcr;
+	unsigned char		mcr_mask;	/* mask of user bits */
+	unsigned char		mcr_force;	/* mask of forced bits */
+	unsigned char		cur_iotype;	/* Running I/O type */
+
+	/*
+	 * Some bits in registers are cleared on a read, so they must
+	 * be saved whenever the register is read but the bits will not
+	 * be immediately processed.
+	 */
+#define LSR_SAVE_FLAGS UART_LSR_BRK_ERROR_BITS
+	unsigned char		lsr_saved_flags;
+#define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
+	unsigned char		msr_saved_flags;
+};
+
 /*
  * This replaces serial_uart_config in include/linux/serial.h
  */
diff --git a/drivers/tty/serial/8250_hub6.c b/drivers/tty/serial/8250_hub6.c
index 7609150..4f34201 100644
--- a/drivers/tty/serial/8250_hub6.c
+++ b/drivers/tty/serial/8250_hub6.c
@@ -11,6 +11,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/serial_8250.h>
+#include <linux/serial_reg.h>
+#include "8250.h"
 
 #define HUB6(card,port)							\
 	{								\
@@ -38,6 +40,42 @@ static struct plat_serial8250_port hub6_data[] = {
 	{ },
 };
 
+
+static unsigned int hub6_serial_in(struct uart_port *p, int offset)
+{
+	outb(p->hub6 - 1 + offset, p->iobase);
+	return inb(p->iobase + 1);
+}
+
+static void hub6_serial_out(struct uart_port *p, int offset, int value)
+{
+	outb(p->hub6 - 1 + offset, p->iobase);
+	outb(value, p->iobase + 1);
+}
+
+/* Uart divisor latch read */
+static unsigned hub6_serial_dl_read(struct uart_port *p)
+{
+	return hub6_serial_in(p, UART_DLL) |
+			hub6_serial_in(p, UART_DLM) << 8;
+}
+
+/* Uart divisor latch write */
+static void hub6_serial_dl_write(struct uart_port *p, unsigned int value)
+{
+	hub6_serial_out(p, UART_DLL, value & 0xff);
+	hub6_serial_out(p, UART_DLM, value >> 8 & 0xff);
+}
+
+static const struct serial8250_ops hub6_ops = {
+	.owner = THIS_MODULE,
+
+	.serial_in = hub6_serial_in,
+	.serial_out = hub6_serial_out,
+	.serial_dl_read = hub6_serial_dl_read,
+	.serial_dl_write = hub6_serial_dl_write
+};
+
 static struct platform_device hub6_device = {
 	.name			= "serial8250",
 	.id			= PLAT8250_DEV_HUB6,
@@ -48,6 +86,7 @@ static struct platform_device hub6_device = {
 
 static int __init hub6_init(void)
 {
+	serial8250_upio_register(UPIO_HUB6, &hub6_ops);
 	return platform_device_register(&hub6_device);
 }
 
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 30d4f62..e36495e 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -100,7 +100,7 @@ static inline int __deprecated early_serial_setup(struct uart_port *port)
         return serial8250_early_setup(port, NULL);
 }
 
-extern int serial8250_upio_register(int upio, struct serial8250_ops *ops);
+extern int serial8250_upio_register(int upio, const struct serial8250_ops *ops);
 extern int serial8250_upio_unregister(int upio);
 
 #endif

