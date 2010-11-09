From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] pl011: added clock management feature
Date: Tue, 9 Nov 2010 16:30:37 +0100
Message-ID: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:39116 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751439Ab0KIPbK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Nov 2010 10:31:10 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>, Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

From: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>

This patch allows to control the pl011 clock using set_termios
callback. Any positive baudrate passed enables clock, otherwise
disables. This saves a lot of power on submicron designs since
we can clock off and disable unused UARTs.

Cc: Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>
Cc: Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>
Signed-off-by: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
This patch depends on the DMA support, just because it's adjacent
in the file in some functions. If it's desired to have them in the
reverse order, this can be arranged for.

Maybe this shouldn't even be an optional Kconfig option, something
like this should be expected when you set the baud rate to zero
really. Comments welcome.
---
 drivers/serial/Kconfig      |    9 ++
 drivers/serial/amba-pl011.c |  183 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 189 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index aff9dcd..0328fba 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -323,6 +323,15 @@ config SERIAL_AMBA_PL011_CONSOLE
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 
+config SERIAL_AMBA_PL011_CLOCK_CONTROL
+	bool "Support for clock control on AMBA serial port"
+	depends on SERIAL_AMBA_PL011
+	select CONSOLE_POLL
+	---help---
+	  Say Y here if you wish to use amba set_termios function to control
+	  the pl011 clock. Any positive baudrate passed enables clock,
+	  otherwise disables (baudrate = B0 -> hangup)
+
 config SERIAL_SB1250_DUART
 	tristate "BCM1xxx on-chip DUART serial support"
 	depends on SIBYTE_SB1xxx_SOC=y
diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index e1b4652..5f4aca7 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -47,6 +47,7 @@
 #include <linux/serial.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/serial.h>
+#include <linux/workqueue.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
 #include <linux/dmaengine.h>
@@ -89,6 +90,15 @@ struct pl011_dma_tx_transaction {
 	dma_cookie_t cookie;
 };
 
+
+/* Available amba pl011 port clock states */
+enum pl011_clk_states {
+	PL011_CLK_OFF = 0,	/* clock disabled */
+	PL011_CLK_REQUEST_OFF,	/* disable after TX flushed */
+	PL011_CLK_ON,		/* clock enabled */
+	PL011_PORT_OFF,		/* port disabled */
+};
+
 /*
  * We wrap our port structure around the generic uart_port.
  */
@@ -113,6 +123,11 @@ struct uart_amba_port {
 	struct pl011_dma_rx_transaction dmarx;
 	struct pl011_dma_tx_transaction dmatx;
 #endif
+#ifdef CONFIG_SERIAL_AMBA_PL011_CLOCK_CONTROL
+	enum pl011_clk_states	clk_state;	/* actual clock state */
+	struct delayed_work	clk_off_work;	/* work used for clock off */
+	unsigned int		clk_off_delay;	/* clock off delay */
+#endif
 };
 
 /* There is by now at least one vendor with differing details, so handle it */
@@ -869,6 +884,155 @@ static inline int pl011_dma_tx_chars(struct uart_amba_port *uap)
 }
 #endif
 
+#ifdef CONFIG_SERIAL_AMBA_PL011_CLOCK_CONTROL
+/* Turn clock off if TX buffer is empty, otherwise reschedule */
+static void pl011_clock_off(struct work_struct *work)
+{
+	struct uart_amba_port *uap = container_of(work, struct uart_amba_port,
+						clk_off_work.work);
+	struct uart_port *port = &uap->port;
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (uap->clk_state == PL011_CLK_REQUEST_OFF) {
+		if (uart_circ_empty(xmit)) {
+			clk_disable(uap->clk);
+			uap->clk_state = PL011_CLK_OFF;
+		} else
+			schedule_delayed_work(&uap->clk_off_work,
+						uap->clk_off_delay);
+	}
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+/* Request to turn off uart clock once pending TX is flushed */
+static void pl011_clock_request_off(struct uart_port *port)
+{
+	unsigned long flags;
+	struct uart_amba_port *uap = (struct uart_amba_port *)(port);
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (uap->clk_state == PL011_CLK_ON) {
+		uap->clk_state = PL011_CLK_REQUEST_OFF;
+		/* Turn off later */
+		schedule_delayed_work(&uap->clk_off_work,
+					uap->clk_off_delay);
+	}
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+/* Request to immediately turn on uart clock */
+static void pl011_clock_on(struct uart_port *port)
+{
+	unsigned long flags;
+	struct uart_amba_port *uap = (struct uart_amba_port *)(port);
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	switch (uap->clk_state) {
+	case PL011_CLK_OFF:
+		clk_enable(uap->clk);
+		/* fallthrough */
+	case PL011_CLK_REQUEST_OFF:
+		cancel_delayed_work(&uap->clk_off_work);
+		uap->clk_state = PL011_CLK_ON;
+		break;
+	default:
+		break;
+	}
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void pl011_clock_check(struct uart_amba_port *uap)
+{
+	/* Reshedule work during off request  */
+	if (uap->clk_state == PL011_CLK_REQUEST_OFF)
+		/* New TX - restart work */
+		if (cancel_delayed_work(&uap->clk_off_work))
+			schedule_delayed_work(&uap->clk_off_work,
+						uap->clk_off_delay);
+}
+
+static int pl011_clock_startup(struct uart_amba_port *uap)
+{
+	int retval = 0;
+
+	if (uap->clk_state == PL011_PORT_OFF) {
+		retval = clk_enable(uap->clk);
+		if (!retval)
+			uap->clk_state = PL011_CLK_ON;
+		else
+			uap->clk_state = PL011_PORT_OFF;
+	}
+
+	return retval;
+}
+
+static void pl011_clock_shutdown(struct uart_amba_port *uap)
+{
+	spin_lock_irq(&uap->port.lock);
+	if (uap->clk_state == PL011_CLK_ON) {
+		clk_disable(uap->clk);
+		uap->clk_state = PL011_PORT_OFF;
+	}
+	spin_unlock_irq(&uap->port.lock);
+}
+
+static void
+pl011_clock_control(struct uart_port *port, struct ktermios *termios,
+		     struct ktermios *old)
+{
+	if (old) {
+		if ((termios->c_cflag & CBAUD) &&
+		    (termios->c_ispeed != old->c_ispeed ||
+		     termios->c_ospeed != old->c_ospeed)) {
+			if (termios->c_ispeed || termios->c_ospeed)
+				pl011_clock_on(port);
+			else
+				pl011_clock_request_off(port);
+		}
+	}
+}
+
+static void pl011_clock_control_init(struct uart_amba_port *uap)
+{
+	uap->clk_state = PL011_PORT_OFF;
+	INIT_DELAYED_WORK(&uap->clk_off_work, pl011_clock_off);
+	uap->clk_off_delay = HZ / 1000;  /* 1 ms */
+}
+
+#else
+/* Blank functions for clock control */
+static inline void pl011_clock_check(struct uart_amba_port *uap)
+{
+}
+
+static inline int pl011_clock_startup(struct uart_amba_port *uap)
+{
+	return clk_enable(uap->clk);
+}
+
+static inline void pl011_clock_shutdown(struct uart_amba_port *uap)
+{
+	clk_disable(uap->clk);
+}
+
+static inline void
+pl011_clock_control(struct uart_port *port, struct ktermios *termios,
+		     struct ktermios *old)
+{
+}
+
+static inline void pl011_clock_control_init(struct uart_amba_port *uap)
+{
+}
+#endif
 
 static void pl011_stop_tx(struct uart_port *port)
 {
@@ -1024,6 +1188,9 @@ static void pl011_tx_chars(struct uart_amba_port *uap)
 			break;
 	} while (--count > 0);
 
+	if (count)
+		pl011_clock_check(uap);
+
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&uap->port);
 
@@ -1212,7 +1379,7 @@ static int pl011_startup(struct uart_port *port)
 	/*
 	 * Try to enable the clock producer.
 	 */
-	retval = clk_enable(uap->clk);
+	retval = pl011_clock_startup(uap);
 	if (retval)
 		goto out;
 
@@ -1280,7 +1447,7 @@ static int pl011_startup(struct uart_port *port)
 	return 0;
 
  clk_dis:
-	clk_disable(uap->clk);
+	pl011_clock_shutdown(uap);
  out:
 	return retval;
 }
@@ -1331,7 +1498,7 @@ static void pl011_shutdown(struct uart_port *port)
 	/*
 	 * Shut down the clock producer
 	 */
-	clk_disable(uap->clk);
+	pl011_clock_shutdown(uap);
 }
 
 static void
@@ -1344,6 +1511,13 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned int baud, quot;
 
 	/*
+	 * Must be before uart_get_baud_rate() call, because
+	 * this function changes baudrate to default in case of 0
+	 * B0 hangup !!!
+	 */
+	pl011_clock_control(port, termios, old);
+
+	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
 	baud = uart_get_baud_rate(port, termios, old, 0,
@@ -1721,6 +1895,9 @@ static int pl011_probe(struct amba_device *dev, struct amba_id *id)
 	amba_ports[i] = uap;
 
 	amba_set_drvdata(dev, uap);
+
+	pl011_clock_control_init(uap);
+
 	ret = uart_add_one_port(&amba_reg, &uap->port);
 	if (ret) {
 		amba_set_drvdata(dev, NULL);
-- 
1.6.3.3

