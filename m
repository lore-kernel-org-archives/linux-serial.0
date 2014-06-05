From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] serial: 8250_dw: clock rate handling for all ACPI platforms
Date: Thu,  5 Jun 2014 16:51:40 +0300
Message-ID: <1401976300-2569-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29565 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbaFENvr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Jun 2014 09:51:47 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

This replaces the Baytrail specific custom set_termios hook
with a more generic one where the clock framework is used to
set the rate. The method also doesn't need to be limited to
just Baytrail, so it's used with all ACPI platforms.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 103 +++++++++++---------------------------
 1 file changed, 28 insertions(+), 75 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 51b307a..b8e4eb3 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -62,70 +62,12 @@ struct dw8250_data {
 	struct uart_8250_dma	dma;
 };
 
-struct dw8250_acpi_desc {
-	void (*set_termios)(struct uart_port *p, struct ktermios *termios,
-			    struct ktermios *old);
-};
-
 #define BYT_PRV_CLK			0x800
 #define BYT_PRV_CLK_EN			(1 << 0)
 #define BYT_PRV_CLK_M_VAL_SHIFT		1
 #define BYT_PRV_CLK_N_VAL_SHIFT		16
 #define BYT_PRV_CLK_UPDATE		(1 << 31)
 
-static void byt_set_termios(struct uart_port *p, struct ktermios *termios,
-			    struct ktermios *old)
-{
-	unsigned int baud = tty_termios_baud_rate(termios);
-	unsigned int m, n;
-	u32 reg;
-
-	/*
-	* For baud rates 0.5M, 1M, 1.5M, 2M, 2.5M, 3M, 3.5M and 4M the
-	* dividers must be adjusted.
-	*
-	* uartclk = (m / n) * 100 MHz, where m <= n
-	*/
-	switch (baud) {
-	case 500000:
-	case 1000000:
-	case 2000000:
-	case 4000000:
-		m = 64;
-		n = 100;
-		p->uartclk = 64000000;
-		break;
-	case 3500000:
-		m = 56;
-		n = 100;
-		p->uartclk = 56000000;
-		break;
-	case 1500000:
-	case 3000000:
-		m = 48;
-		n = 100;
-		p->uartclk = 48000000;
-		break;
-	case 2500000:
-		m = 40;
-		n = 100;
-		p->uartclk = 40000000;
-		break;
-	default:
-		m = 2304;
-		n = 3125;
-		p->uartclk = 73728000;
-	}
-
-	/* Reset the clock */
-	reg = (m << BYT_PRV_CLK_M_VAL_SHIFT) | (n << BYT_PRV_CLK_N_VAL_SHIFT);
-	writel(reg, p->membase + BYT_PRV_CLK);
-	reg |= BYT_PRV_CLK_EN | BYT_PRV_CLK_UPDATE;
-	writel(reg, p->membase + BYT_PRV_CLK);
-
-	serial8250_do_set_termios(p, termios, old);
-}
-
 static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
 {
 	struct dw8250_data *d = p->private_data;
@@ -242,6 +184,32 @@ dw8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 		pm_runtime_put_sync_suspend(port->dev);
 }
 
+static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
+			       struct ktermios *old)
+{
+	unsigned int baud = tty_termios_baud_rate(termios);
+	struct dw8250_data *d = p->private_data;
+	unsigned int rate;
+	int ret;
+
+	if (IS_ERR(d->clk) || !old)
+		goto out;
+
+	/* Not requesting clock rates below 1.8432Mhz */
+	if (baud < 115200)
+		baud = 115200;
+
+	clk_disable_unprepare(d->clk);
+	rate = clk_round_rate(d->clk, baud * 16);
+	ret = clk_set_rate(d->clk, rate);
+	clk_prepare_enable(d->clk);
+
+	if (!ret)
+		p->uartclk = rate;
+out:
+	serial8250_do_set_termios(p, termios, old);
+}
+
 static bool dw8250_dma_filter(struct dma_chan *chan, void *param)
 {
 	struct dw8250_data *data = param;
@@ -340,16 +308,10 @@ static int dw8250_probe_of(struct uart_port *p,
 static int dw8250_probe_acpi(struct uart_8250_port *up,
 			     struct dw8250_data *data)
 {
-	const struct acpi_device_id *id;
 	struct uart_port *p = &up->port;
-	struct dw8250_acpi_desc *acpi_desc;
 
 	dw8250_setup_port(up);
 
-	id = acpi_match_device(p->dev->driver->acpi_match_table, p->dev);
-	if (!id)
-		return -ENODEV;
-
 	p->iotype = UPIO_MEM32;
 	p->serial_in = dw8250_serial_in32;
 	p->serial_out = dw8250_serial_out32;
@@ -360,12 +322,7 @@ static int dw8250_probe_acpi(struct uart_8250_port *up,
 	up->dma->rxconf.src_maxburst = p->fifosize / 4;
 	up->dma->txconf.dst_maxburst = p->fifosize / 4;
 
-	acpi_desc = (struct dw8250_acpi_desc *)id->driver_data;
-	if (!acpi_desc)
-		return 0;
-
-	if (acpi_desc->set_termios)
-		p->set_termios = acpi_desc->set_termios;
+	up->port.set_termios = dw8250_set_termios;
 
 	return 0;
 }
@@ -514,16 +471,12 @@ static const struct of_device_id dw8250_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dw8250_of_match);
 
-static struct dw8250_acpi_desc byt_8250_desc = {
-	.set_termios = byt_set_termios,
-};
-
 static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "INT33C4", 0 },
 	{ "INT33C5", 0 },
 	{ "INT3434", 0 },
 	{ "INT3435", 0 },
-	{ "80860F0A", (kernel_ulong_t)&byt_8250_desc},
+	{ "80860F0A", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
-- 
2.0.0.rc4

