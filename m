From: Loic Poulain <loic.poulain@intel.com>
Subject: [PATCHv2] 8250_dw: Support all baudrates on baytrail
Date: Fri, 18 Apr 2014 11:00:21 +0200
Message-ID: <1397811621-8489-1-git-send-email-loic.poulain@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:58695 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbaDRJFB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Apr 2014 05:05:01 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, Loic Poulain <loic.poulain@intel.com>

In the same manner as 8250_pci, 8250_dw needs some
baytrail specific quirks to be used. The reference
clock needs to be adjusted before divided in order
to have the minimum error rate on the baudrate.

The specific byt set termios function is stored in
the driver_data field of the acpi device id via the
dw8250_acpi_desc structure.

Remove the uartclk field which is no longer delivered
as driver data.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v2: point directly to byt_set_termios
     remove uartclk driver data field

 drivers/tty/serial/8250/8250_dw.c | 81 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index ed31135..51b307a 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -62,6 +62,70 @@ struct dw8250_data {
 	struct uart_8250_dma	dma;
 };
 
+struct dw8250_acpi_desc {
+	void (*set_termios)(struct uart_port *p, struct ktermios *termios,
+			    struct ktermios *old);
+};
+
+#define BYT_PRV_CLK			0x800
+#define BYT_PRV_CLK_EN			(1 << 0)
+#define BYT_PRV_CLK_M_VAL_SHIFT		1
+#define BYT_PRV_CLK_N_VAL_SHIFT		16
+#define BYT_PRV_CLK_UPDATE		(1 << 31)
+
+static void byt_set_termios(struct uart_port *p, struct ktermios *termios,
+			    struct ktermios *old)
+{
+	unsigned int baud = tty_termios_baud_rate(termios);
+	unsigned int m, n;
+	u32 reg;
+
+	/*
+	* For baud rates 0.5M, 1M, 1.5M, 2M, 2.5M, 3M, 3.5M and 4M the
+	* dividers must be adjusted.
+	*
+	* uartclk = (m / n) * 100 MHz, where m <= n
+	*/
+	switch (baud) {
+	case 500000:
+	case 1000000:
+	case 2000000:
+	case 4000000:
+		m = 64;
+		n = 100;
+		p->uartclk = 64000000;
+		break;
+	case 3500000:
+		m = 56;
+		n = 100;
+		p->uartclk = 56000000;
+		break;
+	case 1500000:
+	case 3000000:
+		m = 48;
+		n = 100;
+		p->uartclk = 48000000;
+		break;
+	case 2500000:
+		m = 40;
+		n = 100;
+		p->uartclk = 40000000;
+		break;
+	default:
+		m = 2304;
+		n = 3125;
+		p->uartclk = 73728000;
+	}
+
+	/* Reset the clock */
+	reg = (m << BYT_PRV_CLK_M_VAL_SHIFT) | (n << BYT_PRV_CLK_N_VAL_SHIFT);
+	writel(reg, p->membase + BYT_PRV_CLK);
+	reg |= BYT_PRV_CLK_EN | BYT_PRV_CLK_UPDATE;
+	writel(reg, p->membase + BYT_PRV_CLK);
+
+	serial8250_do_set_termios(p, termios, old);
+}
+
 static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
 {
 	struct dw8250_data *d = p->private_data;
@@ -278,6 +342,7 @@ static int dw8250_probe_acpi(struct uart_8250_port *up,
 {
 	const struct acpi_device_id *id;
 	struct uart_port *p = &up->port;
+	struct dw8250_acpi_desc *acpi_desc;
 
 	dw8250_setup_port(up);
 
@@ -290,14 +355,18 @@ static int dw8250_probe_acpi(struct uart_8250_port *up,
 	p->serial_out = dw8250_serial_out32;
 	p->regshift = 2;
 
-	if (!p->uartclk)
-		p->uartclk = (unsigned int)id->driver_data;
-
 	up->dma = &data->dma;
 
 	up->dma->rxconf.src_maxburst = p->fifosize / 4;
 	up->dma->txconf.dst_maxburst = p->fifosize / 4;
 
+	acpi_desc = (struct dw8250_acpi_desc *)id->driver_data;
+	if (!acpi_desc)
+		return 0;
+
+	if (acpi_desc->set_termios)
+		p->set_termios = acpi_desc->set_termios;
+
 	return 0;
 }
 
@@ -445,12 +514,16 @@ static const struct of_device_id dw8250_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dw8250_of_match);
 
+static struct dw8250_acpi_desc byt_8250_desc = {
+	.set_termios = byt_set_termios,
+};
+
 static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "INT33C4", 0 },
 	{ "INT33C5", 0 },
 	{ "INT3434", 0 },
 	{ "INT3435", 0 },
-	{ "80860F0A", 0 },
+	{ "80860F0A", (kernel_ulong_t)&byt_8250_desc},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
-- 
1.8.3.2

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

