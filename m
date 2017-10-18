From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 2/3] tty: amba-pl011: earlycon: Unify earlycon backends
Date: Wed, 18 Oct 2017 15:14:47 +0100
Message-ID: <1508336088-3948-3-git-send-email-Dave.Martin@arm.com>
References: <1508336088-3948-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1508336088-3948-1-git-send-email-Dave.Martin@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andre Przywara <andre.przywara@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Andy Gross <andy.gross@linaro.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bhupinder Thakur <bhupinder.thakur@linaro.org>
List-Id: linux-serial@vger.kernel.org

Now that the generic pl011 and qdf2400_e44 earlycon backends differ
only in the choice of vendor_data and minor initialisation detatils
that are detectable based on vendor_data, there's no strong need
for them to be separate.

This patch factors common earlyon setup into a new function
pl011_early_console_setup_common(), which does generic setup and
stashes a pointer to the relevant vendor_data struct in
port->private_data (which appears otherwise unused by the
amba-pl011 driver).

The qdf2400_e44-specific earlycon write/putc functions would now be
identical to the pl011 versions, so they are deleted.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 drivers/tty/serial/amba-pl011.c | 53 ++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index fd9e08c..084ed3f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2436,29 +2436,9 @@ static struct console amba_console = {
 
 #define AMBA_CONSOLE	(&amba_console)
 
-static void qdf2400_e44_putc(struct uart_port *port, int c)
-{
-	const struct vendor_data *vendor = &vendor_qdt_qdf2400_e44;
-	const u16 *reg_offset = vendor->reg_offset;
-
-	while (__pl011_read(port, reg_offset, REG_FR) & UART01x_FR_TXFF)
-		cpu_relax();
-	__pl011_write(c, port, reg_offset, REG_DR);
-	while (!__pl011_tx_empty(port, reg_offset, vendor))
-		cpu_relax();
-}
-
-static void qdf2400_e44_early_write(struct console *con, const char *s, unsigned n)
-{
-	struct earlycon_device *dev = con->data;
-
-	wmb();
-	uart_console_write(&dev->port, s, n, qdf2400_e44_putc);
-}
-
 static void pl011_putc(struct uart_port *port, int c)
 {
-	const struct vendor_data *vendor = &vendor_arm;
+	const struct vendor_data *vendor = port->private_data;
 	const u16 *reg_offset = vendor->reg_offset;
 
 	while (__pl011_read(port, reg_offset, REG_FR) & UART01x_FR_TXFF)
@@ -2476,6 +2456,22 @@ static void pl011_early_write(struct console *con, const char *s, unsigned n)
 	uart_console_write(&dev->port, s, n, pl011_putc);
 }
 
+static int __init
+pl011_early_console_setup_common(struct earlycon_device *device,
+				 const struct vendor_data *vendor)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->port.private_data = (void *)vendor;
+	if (vendor->access_32b)
+		device->port.iotype = UPIO_MEM32;
+
+	device->con->write = pl011_early_write;
+
+	return 0;
+}
+
 /*
  * On non-ACPI systems, earlycon is enabled by specifying
  * "earlycon=pl011,<address>" on the kernel command line.
@@ -2491,12 +2487,7 @@ static void pl011_early_write(struct console *con, const char *s, unsigned n)
 static int __init pl011_early_console_setup(struct earlycon_device *device,
 					    const char *opt)
 {
-	if (!device->port.membase)
-		return -ENODEV;
-
-	device->con->write = pl011_early_write;
-
-	return 0;
+	return pl011_early_console_setup_common(device, &vendor_arm);
 }
 OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
 OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", pl011_early_console_setup);
@@ -2515,12 +2506,8 @@ static int __init
 qdf2400_e44_early_console_setup(struct earlycon_device *device,
 				const char *opt)
 {
-	if (!device->port.membase)
-		return -ENODEV;
-
-	device->port.iotype = UPIO_MEM32;
-	device->con->write = qdf2400_e44_early_write;
-	return 0;
+	return pl011_early_console_setup_common(device,
+						&vendor_qdt_qdf2400_e44);
 }
 EARLYCON_DECLARE(qdf2400_e44, qdf2400_e44_early_console_setup);
 
-- 
2.1.4
