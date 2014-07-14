From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] serial: 8250: introduce up_to_u8250p() macro
Date: Mon, 14 Jul 2014 11:41:39 +0300
Message-ID: <1405327299-25649-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:24244 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702AbaGNIms (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Jul 2014 04:42:48 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

It helps to convert struct uart_port to struct uart_8250_port.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_core.c | 57 +++++++++++++------------------------
 drivers/tty/serial/8250/8250_dw.c   |  8 ++++--
 drivers/tty/serial/8250/8250_fsl.c  |  3 +-
 drivers/tty/serial/8250/8250_pci.c  |  6 ++--
 include/linux/serial_8250.h         |  2 ++
 5 files changed, 29 insertions(+), 47 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 7a91c6d..0da0145 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -439,8 +439,7 @@ static int exar_handle_irq(struct uart_port *port);
 
 static void set_io_from_upio(struct uart_port *p)
 {
-	struct uart_8250_port *up =
-		container_of(p, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(p);
 
 	up->dl_read = default_serial_dl_read;
 	up->dl_write = default_serial_dl_write;
@@ -1277,8 +1276,7 @@ static inline void __stop_tx(struct uart_8250_port *p)
 
 static void serial8250_stop_tx(struct uart_port *port)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 
 	__stop_tx(up);
 
@@ -1293,8 +1291,7 @@ static void serial8250_stop_tx(struct uart_port *port)
 
 static void serial8250_start_tx(struct uart_port *port)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 
 	if (up->dma && !serial8250_tx_dma(up)) {
 		return;
@@ -1322,8 +1319,7 @@ static void serial8250_start_tx(struct uart_port *port)
 
 static void serial8250_stop_rx(struct uart_port *port)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 
 	up->ier &= ~UART_IER_RLSI;
 	up->port.read_status_mask &= ~UART_LSR_DR;
@@ -1332,8 +1328,7 @@ static void serial8250_stop_rx(struct uart_port *port)
 
 static void serial8250_enable_ms(struct uart_port *port)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 
 	/* no MSR capabilities */
 	if (up->bugs & UART_BUG_NOMSR)
@@ -1499,8 +1494,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 {
 	unsigned char status;
 	unsigned long flags;
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 	int dma_err = 0;
 
 	if (iir & UART_IIR_NO_INT)
@@ -1785,8 +1779,7 @@ static void serial8250_backup_timeout(unsigned long data)
 
 static unsigned int serial8250_tx_empty(struct uart_port *port)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
 	unsigned int lsr;
 
@@ -1800,8 +1793,7 @@ static unsigned int serial8250_tx_empty(struct uart_port *port)
 
 static unsigned int serial8250_get_mctrl(struct uart_port *port)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned int status;
 	unsigned int ret;
 
@@ -1821,8 +1813,7 @@ static unsigned int serial8250_get_mctrl(struct uart_port *port)
 
 static void serial8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned char mcr = 0;
 
 	if (mctrl & TIOCM_RTS)
@@ -1843,8 +1834,7 @@ static void serial8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static void serial8250_break_ctl(struct uart_port *port, int break_state)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -1911,8 +1901,7 @@ static void serial8250_put_poll_char(struct uart_port *port,
 			 unsigned char c)
 {
 	unsigned int ier;
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 
 	/*
 	 *	First save the IER then disable the interrupts
@@ -1941,8 +1930,7 @@ static void serial8250_put_poll_char(struct uart_port *port,
 
 static int serial8250_startup(struct uart_port *port)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
 	unsigned char lsr, iir;
 	int retval;
@@ -2194,8 +2182,7 @@ dont_test_tx_en:
 
 static void serial8250_shutdown(struct uart_port *port)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
 
 	/*
@@ -2268,8 +2255,7 @@ void
 serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		          struct ktermios *old)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned char cval, fcr = 0;
 	unsigned long flags;
 	unsigned int baud, quot;
@@ -2498,8 +2484,7 @@ serial8250_set_ldisc(struct uart_port *port, int new)
 void serial8250_do_pm(struct uart_port *port, unsigned int state,
 		      unsigned int oldstate)
 {
-	struct uart_8250_port *p =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *p = up_to_u8250p(port);
 
 	serial8250_set_sleep(p, state != 0);
 }
@@ -2630,8 +2615,7 @@ static void serial8250_release_rsa_resource(struct uart_8250_port *up)
 
 static void serial8250_release_port(struct uart_port *port)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 
 	serial8250_release_std_resource(up);
 	if (port->type == PORT_RSA)
@@ -2640,8 +2624,7 @@ static void serial8250_release_port(struct uart_port *port)
 
 static int serial8250_request_port(struct uart_port *port)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 	int ret;
 
 	if (port->type == PORT_8250_CIR)
@@ -2659,8 +2642,7 @@ static int serial8250_request_port(struct uart_port *port)
 
 static void serial8250_config_port(struct uart_port *port, int flags)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 	int probeflags = PROBE_ANY;
 	int ret;
 
@@ -2859,8 +2841,7 @@ serial8250_register_ports(struct uart_driver *drv, struct device *dev)
 
 static void serial8250_console_putchar(struct uart_port *port, int ch)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 
 	wait_for_xmitr(up, UART_LSR_THRE);
 	serial_port_out(port, UART_TX, ch);
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index c531fa4..affdcb1 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -84,8 +84,9 @@ static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
 
 static void dw8250_force_idle(struct uart_port *p)
 {
-	serial8250_clear_and_reinit_fifos(container_of
-					  (p, struct uart_8250_port, port));
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	serial8250_clear_and_reinit_fifos(up);
 	(void)p->serial_in(p, UART_RX);
 }
 
@@ -255,6 +256,7 @@ static int dw8250_probe_of(struct uart_port *p,
 			   struct dw8250_data *data)
 {
 	struct device_node	*np = p->dev->of_node;
+	struct uart_8250_port *up = up_to_u8250p(p);
 	u32			val;
 	bool has_ucv = true;
 
@@ -287,7 +289,7 @@ static int dw8250_probe_of(struct uart_port *p,
 		}
 	}
 	if (has_ucv)
-		dw8250_setup_port(container_of(p, struct uart_8250_port, port));
+		dw8250_setup_port(up);
 
 	if (!of_property_read_u32(np, "reg-shift", &val))
 		p->regshift = val;
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index f4d3c47..c0533a5 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -28,8 +28,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 	unsigned char lsr, orig_lsr;
 	unsigned long flags;
 	unsigned int iir;
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 
 	spin_lock_irqsave(&up->port.lock, flags);
 
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 33137b3..61830b1 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1581,8 +1581,7 @@ static int skip_tx_en_setup(struct serial_private *priv,
 
 static void kt_handle_break(struct uart_port *p)
 {
-	struct uart_8250_port *up =
-		container_of(p, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(p);
 	/*
 	 * On receipt of a BI, serial device in Intel ME (Intel
 	 * management engine) needs to have its fifos cleared for sane
@@ -1593,8 +1592,7 @@ static void kt_handle_break(struct uart_port *p)
 
 static unsigned int kt_serial_in(struct uart_port *p, int offset)
 {
-	struct uart_8250_port *up =
-		container_of(p, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(p);
 	unsigned int val;
 
 	/*
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index af47a8a..6ff0244 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -100,6 +100,8 @@ struct uart_8250_port {
 	void			(*dl_write)(struct uart_8250_port *, int);
 };
 
+#define	up_to_u8250p(up)	container_of(up, struct uart_8250_port, port)
+
 int serial8250_register_8250_port(struct uart_8250_port *);
 void serial8250_unregister_port(int line);
 void serial8250_suspend_port(int line);
-- 
2.0.1

