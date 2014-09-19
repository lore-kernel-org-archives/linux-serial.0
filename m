From: Andre Przywara <andre.przywara@arm.com>
Subject: [RFC PATCH 10/10] drivers: PL011: add support for the ARM SBSA generic UART
Date: Fri, 19 Sep 2014 13:21:23 +0100
Message-ID: <1411129283-17219-11-git-send-email-andre.przywara@arm.com>
References: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36081 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753398AbaISMWN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 08:22:13 -0400
In-Reply-To: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: rob.herring@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

The ARM Server Base System Architecture[1] document describes a
generic UART which is a subset of the PL011 UART.
It lacks DMA support, baud rate control and modem status line
control, among other things.
The idea is to move the UART initialization and setup into the
firmware (which does this job today already) and let the kernel just
use the UART for sending and receiving characters.
We use the recent refactoring the build a new struct uart_ops
variable which points to some new functions avoiding access to the
missing registers. We reuse as much existing PL011 code as possible.

In contrast to the PL011 the SBSA UART does not define any AMBA or
PrimeCell relations, so we go a pretty generic probe function
which only uses platform device functions.
A DT binding is provided, but other systems can easily attach to it,
too (hint, hint!).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/serial/arm_sbsa_uart.txt   |    9 ++
 drivers/tty/serial/amba-pl011.c                    |  152 ++++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt

diff --git a/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt b/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
new file mode 100644
index 0000000..21d211f
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
@@ -0,0 +1,9 @@
+* ARM SBSA defined generic UART
+This UART uses a subset of the PL011 registers and consequently lives
+in the PL011 driver. It's baudrate and other communication parameters
+cannot be adjusted at runtime, so it lacks a clock specifier here.
+
+Required properties:
+- compatible: must be "arm,sbsa-uart"
+- reg: exactly one register range
+- interrupts: exactly one interrupt specifier
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 12f1a5f..2065d07 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -101,6 +101,20 @@ static struct vendor_data vendor_arm = {
 	.get_fifosize		= get_fifosize_arm,
 };
 
+static unsigned int get_fifosize_sbsa(struct amba_device *dev)
+{
+	return 32;
+}
+
+static struct vendor_data vendor_sbsa = {
+	.oversampling		= false,
+	.dma_threshold		= false,
+	.cts_event_workaround	= false,
+	.always_enabled		= true,
+	.fixed_options		= "115200n8",
+	.get_fifosize		= get_fifosize_sbsa,
+};
+
 static unsigned int get_fifosize_st(struct amba_device *dev)
 {
 	return 64;
@@ -1630,6 +1644,29 @@ static int pl011_startup(struct uart_port *port)
 	return retval;
 }
 
+static int sbsa_uart_startup(struct uart_port *port)
+{
+	struct uart_amba_port *uap = (struct uart_amba_port *)port;
+	int retval;
+
+	retval = pl011_hwinit(port);
+	if (retval)
+		return retval;
+
+	retval = pl011_allocate_irq(uap);
+	if (retval)
+		return retval;
+
+	/*
+	 * The SBSA UART does not support any modem status lines.
+	 */
+	uap->old_status = 0;
+
+	pl011_enable_interrupts(uap);
+
+	return 0;
+}
+
 static void pl011_shutdown_channel(struct uart_amba_port *uap,
 					unsigned int lcrh)
 {
@@ -1706,7 +1743,15 @@ static void pl011_shutdown(struct uart_port *port)
 		if (plat->exit)
 			plat->exit();
 	}
+}
+
+static void sbsa_uart_shutdown(struct uart_port *port)
+{
+	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 
+	pl011_disable_interrupts(uap);
+
+	free_irq(uap->port.irq, uap);
 }
 
 static void
@@ -1859,6 +1904,26 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+static void
+sbsa_uart_set_termios(struct uart_port *port, struct ktermios *termios,
+		      struct ktermios *old)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	/*
+	 * We don't know the clock or baud rate of the UART, so we do
+	 * some kind of worst case assumption here. The code adds a
+	 * 20ms buffer anyway, so going with 19200 should be fine.
+	 */
+	uart_update_timeout(port, CS8, 19200);
+
+	pl011_setup_status_masks(port, termios);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
 static const char *pl011_type(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
@@ -1933,6 +1998,40 @@ static struct uart_ops amba_pl011_pops = {
 #endif
 };
 
+static void sbsa_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+}
+
+static unsigned int sbsa_uart_get_mctrl(struct uart_port *port)
+{
+	return 0;
+}
+
+static struct uart_ops sbsa_uart_pops = {
+	.tx_empty	= pl011_tx_empty,
+	.set_mctrl	= sbsa_uart_set_mctrl,
+	.get_mctrl	= sbsa_uart_get_mctrl,
+	.stop_tx	= pl011_stop_tx,
+	.start_tx	= pl011_start_tx,
+	.stop_rx	= pl011_stop_rx,
+	.enable_ms	= NULL,
+	.break_ctl	= NULL,
+	.startup	= sbsa_uart_startup,
+	.shutdown	= sbsa_uart_shutdown,
+	.flush_buffer	= NULL,
+	.set_termios	= sbsa_uart_set_termios,
+	.type		= pl011_type,
+	.release_port	= pl011_release_port,
+	.request_port	= pl011_request_port,
+	.config_port	= pl011_config_port,
+	.verify_port	= pl011_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_init     = pl011_hwinit,
+	.poll_get_char = pl011_get_poll_char,
+	.poll_put_char = pl011_put_poll_char,
+#endif
+};
+
 static struct uart_amba_port *amba_ports[UART_NR];
 
 #ifdef CONFIG_SERIAL_AMBA_PL011_CONSOLE
@@ -2317,6 +2416,59 @@ static int pl011_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(pl011_dev_pm_ops, pl011_suspend, pl011_resume);
 
+static int sbsa_uart_probe(struct platform_device *pdev)
+{
+	struct uart_amba_port *uap;
+	struct resource *r;
+	int portnr, ret;
+
+	portnr = pl011_allocate_port(&pdev->dev, &uap);
+	if (portnr < 0)
+		return portnr;
+
+	uap->vendor	= &vendor_sbsa;
+	uap->fifosize	= 32;
+	uap->port.irq	= platform_get_irq(pdev, 0);
+	uap->port.ops	= &sbsa_uart_pops;
+
+	snprintf(uap->type, sizeof(uap->type), "SBSA");
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ret = pl011_setup_port(&pdev->dev, uap, r, portnr);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, uap);
+
+	return pl011_register_port(uap);
+}
+
+static int sbsa_uart_remove(struct platform_device *pdev)
+{
+	struct uart_amba_port *uap = platform_get_drvdata(pdev);
+
+	uart_remove_one_port(&amba_reg, &uap->port);
+	pl011_unregister_port(uap);
+	return 0;
+}
+
+static const struct of_device_id sbsa_uart_match[] = {
+	{ .compatible = "arm,sbsa-uart", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sbsa_uart_match);
+
+static struct platform_driver arm_sbsa_uart_platform_driver = {
+	.probe		= sbsa_uart_probe,
+	.remove		= sbsa_uart_remove,
+	.driver	= {
+		.name	= "sbsa-uart",
+		.of_match_table = of_match_ptr(sbsa_uart_match),
+	},
+};
+
+module_platform_driver(arm_sbsa_uart_platform_driver);
+
 static struct amba_id pl011_ids[] = {
 	{
 		.id	= 0x00041011,
-- 
1.7.9.5

