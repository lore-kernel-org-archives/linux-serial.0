From: Noam Camus <noamc@ezchip.com>
Subject: [PATCH v9 1/3] serial: 8250_dw: Avoid serial_outx code duplicate with new dw8250_check_lcr()
Date: Sat, 12 Dec 2015 19:18:25 +0200
Message-ID: <1449940707-17633-2-git-send-email-noamc@ezchip.com>
References: <1449940707-17633-1-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449940707-17633-1-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com, vgupta@synopsys.com, Alexey.Brodkin@synopsys.com, jslaby@suse.com, peter@hurleysoftware.com, Noam Camus <noamc@ezchip.com>
List-Id: linux-serial@vger.kernel.org

From: Noam Camus <noamc@ezchip.com>

With the help of Heikki we take common code that
makes sure LCR write wasn't ignored and put it in new function called
dw8250_check_lcr(). This function serves 3 serial_out routines:
dw8250_serial_out(), dw8250_serial_out32(), and dw8250_serial_outq().

This patch only brings better code reuse.

Signed-off-by: Noam Camus <noamc@ezchip.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c |   91 +++++++++++++++++--------------------
 1 files changed, 42 insertions(+), 49 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a5d319e..ffe5e0c 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -95,25 +95,43 @@ static void dw8250_force_idle(struct uart_port *p)
 	(void)p->serial_in(p, UART_RX);
 }
 
-static void dw8250_serial_out(struct uart_port *p, int offset, int value)
+static void dw8250_check_lcr(struct uart_port *p, int value)
 {
-	writeb(value, p->membase + (offset << p->regshift));
+	void __iomem *offset = p->membase + (UART_LCR << p->regshift);
+	int tries = 1000;
 
 	/* Make sure LCR write wasn't ignored */
-	if (offset == UART_LCR) {
-		int tries = 1000;
-		while (tries--) {
-			unsigned int lcr = p->serial_in(p, UART_LCR);
-			if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
-				return;
-			dw8250_force_idle(p);
-			writeb(value, p->membase + (UART_LCR << p->regshift));
-		}
-		/*
-		 * FIXME: this deadlocks if port->lock is already held
-		 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
-		 */
+	while (tries--) {
+		unsigned int lcr = p->serial_in(p, UART_LCR);
+
+		if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
+			return;
+
+		dw8250_force_idle(p);
+
+#ifdef CONFIG_64BIT
+		__raw_writeq(value & 0xff, offset);
+#else
+		if (p->iotype == UPIO_MEM32)
+			writel(value, offset);
+		else
+			writeb(value, offset);
+#endif
 	}
+	/*
+	 * FIXME: this deadlocks if port->lock is already held
+	 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
+	 */
+}
+
+static void dw8250_serial_out(struct uart_port *p, int offset, int value)
+{
+	struct dw8250_data *d = p->private_data;
+
+	writeb(value, p->membase + (offset << p->regshift));
+
+	if (offset == UART_LCR && !d->uart_16550_compatible)
+		dw8250_check_lcr(p, value);
 }
 
 static unsigned int dw8250_serial_in(struct uart_port *p, int offset)
@@ -135,49 +153,26 @@ static unsigned int dw8250_serial_inq(struct uart_port *p, int offset)
 
 static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
 {
+	struct dw8250_data *d = p->private_data;
+
 	value &= 0xff;
 	__raw_writeq(value, p->membase + (offset << p->regshift));
 	/* Read back to ensure register write ordering. */
 	__raw_readq(p->membase + (UART_LCR << p->regshift));
 
-	/* Make sure LCR write wasn't ignored */
-	if (offset == UART_LCR) {
-		int tries = 1000;
-		while (tries--) {
-			unsigned int lcr = p->serial_in(p, UART_LCR);
-			if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
-				return;
-			dw8250_force_idle(p);
-			__raw_writeq(value & 0xff,
-				     p->membase + (UART_LCR << p->regshift));
-		}
-		/*
-		 * FIXME: this deadlocks if port->lock is already held
-		 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
-		 */
-	}
+	if (offset == UART_LCR && !d->uart_16550_compatible)
+		dw8250_check_lcr(p, value);
 }
 #endif /* CONFIG_64BIT */
 
 static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
 {
+	struct dw8250_data *d = p->private_data;
+
 	writel(value, p->membase + (offset << p->regshift));
 
-	/* Make sure LCR write wasn't ignored */
-	if (offset == UART_LCR) {
-		int tries = 1000;
-		while (tries--) {
-			unsigned int lcr = p->serial_in(p, UART_LCR);
-			if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
-				return;
-			dw8250_force_idle(p);
-			writel(value, p->membase + (UART_LCR << p->regshift));
-		}
-		/*
-		 * FIXME: this deadlocks if port->lock is already held
-		 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
-		 */
-	}
+	if (offset == UART_LCR && !d->uart_16550_compatible)
+		dw8250_check_lcr(p, value);
 }
 
 static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
@@ -463,10 +458,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	dw8250_quirks(p, data);
 
 	/* If the Busy Functionality is not implemented, don't handle it */
-	if (data->uart_16550_compatible) {
-		p->serial_out = NULL;
+	if (data->uart_16550_compatible)
 		p->handle_irq = NULL;
-	}
 
 	if (!data->skip_autocfg)
 		dw8250_setup_port(p);
-- 
1.7.1
