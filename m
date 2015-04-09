From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v3 10/10] drivers: PL011: add support for the ARM SBSA generic
 UART
Date: Thu,  9 Apr 2015 12:29:21 +0100
Message-ID: <1428578961-6896-11-git-send-email-andre.przywara@arm.com>
References: <1428578961-6896-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1428578961-6896-1-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rmk+kernel@arm.linux.org.uk, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: rob.herring@linaro.org, Dave.Martin@arm.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The ARM Server Base System Architecture[1] document describes a
generic UART which is a subset of the PL011 UART.
It lacks DMA support, baud rate control and modem status line
control, among other things.
The idea is to move the UART initialization and setup into the
firmware (which does this job today already) and let the kernel just
use the UART for sending and receiving characters.

We use the recent refactoring to build a new struct uart_ops
variable which points to some new functions avoiding access to the
missing registers. We reuse as much existing PL011 code as possible.

In contrast to the PL011 the SBSA UART does not define any AMBA or
PrimeCell relations, so we go with a pretty generic probe function
which only uses platform device functions.
A DT binding is provided, but other systems can easily attach to it,
too (hint, hint!).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/serial/arm_sbsa_uart.txt   |   10 ++
 drivers/tty/serial/amba-pl011.c                    |  165 ++++++++++++++++++++
 2 files changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt

diff --git a/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt b/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
new file mode 100644
index 0000000..4163e7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
@@ -0,0 +1,10 @@
+* ARM SBSA defined generic UART
+This UART uses a subset of the PL011 registers and consequently lives
+in the PL011 driver. It's baudrate and other communication parameters
+cannot be adjusted at runtime, so it lacks a clock specifier here.
+
+Required properties:
+- compatible: must be "arm,sbsa-uart"
+- reg: exactly one register range
+- interrupts: exactly one interrupt specifier
+- current-speed: the (fixed) baud rate set by the firmware
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index fcb95bd..27e2051 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -101,6 +101,14 @@ static struct vendor_data vendor_arm = {
 	.get_fifosize		= get_fifosize_arm,
 };
 
+static struct vendor_data vendor_sbsa = {
+	.oversampling		= false,
+	.dma_threshold		= false,
+	.cts_event_workaround	= false,
+	.always_enabled		= true,
+	.fixed_options		= true,
+};
+
 static unsigned int get_fifosize_st(struct amba_device *dev)
 {
 	return 64;
@@ -1641,6 +1649,30 @@ static int pl011_startup(struct uart_port *port)
 	return retval;
 }
 
+static int sbsa_uart_startup(struct uart_port *port)
+{
+	struct uart_amba_port *uap =
+		container_of(port, struct uart_amba_port, port);
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
@@ -1722,6 +1754,19 @@ static void pl011_shutdown(struct uart_port *port)
 		uap->port.ops->flush_buffer(port);
 }
 
+static void sbsa_uart_shutdown(struct uart_port *port)
+{
+	struct uart_amba_port *uap =
+		container_of(port, struct uart_amba_port, port);
+
+	pl011_disable_interrupts(uap);
+
+	free_irq(uap->port.irq, uap);
+
+	if (uap->port.ops->flush_buffer)
+		uap->port.ops->flush_buffer(port);
+}
+
 static void
 pl011_setup_status_masks(struct uart_port *port, struct ktermios *termios)
 {
@@ -1873,6 +1918,24 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+static void
+sbsa_uart_set_termios(struct uart_port *port, struct ktermios *termios,
+		      struct ktermios *old)
+{
+	struct uart_amba_port *uap =
+	    container_of(port, struct uart_amba_port, port);
+	unsigned long flags;
+
+	if (old)
+		tty_termios_copy_hw(termios, old);
+	tty_termios_encode_baud_rate(termios, uap->fixed_baud, uap->fixed_baud);
+
+	spin_lock_irqsave(&port->lock, flags);
+	uart_update_timeout(port, CS8, uap->fixed_baud);
+	pl011_setup_status_masks(port, termios);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
 static const char *pl011_type(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
@@ -1948,6 +2011,37 @@ static struct uart_ops amba_pl011_pops = {
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
+	.startup	= sbsa_uart_startup,
+	.shutdown	= sbsa_uart_shutdown,
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
@@ -2334,6 +2428,74 @@ static int pl011_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(pl011_dev_pm_ops, pl011_suspend, pl011_resume);
 
+static int sbsa_uart_probe(struct platform_device *pdev)
+{
+	struct uart_amba_port *uap;
+	struct resource *r;
+	int portnr, ret;
+	int baudrate;
+
+	/*
+	 * Check the mandatory baud rate parameter in the DT node early
+	 * so that we can easily exit with the error.
+	 */
+	if (pdev->dev.of_node) {
+		struct device_node *np = pdev->dev.of_node;
+
+		ret = of_property_read_u32(np, "current-speed", &baudrate);
+		if (ret)
+			return ret;
+	} else {
+		baudrate = 115200;
+	}
+
+	portnr = pl011_allocate_port(&pdev->dev, &uap);
+	if (portnr < 0)
+		return portnr;
+
+	uap->vendor	= &vendor_sbsa;
+	uap->fifosize	= 32;
+	uap->port.irq	= platform_get_irq(pdev, 0);
+	uap->port.ops	= &sbsa_uart_pops;
+	uap->fixed_baud = baudrate;
+
+	snprintf(uap->type, sizeof(uap->type), "SBSA");
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
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
 static struct amba_id pl011_ids[] = {
 	{
 		.id	= 0x00041011,
@@ -2364,11 +2526,14 @@ static int __init pl011_init(void)
 {
 	printk(KERN_INFO "Serial: AMBA PL011 UART driver\n");
 
+	if (platform_driver_register(&arm_sbsa_uart_platform_driver))
+		pr_warn("could not register SBSA UART platform driver\n");
 	return amba_driver_register(&pl011_driver);
 }
 
 static void __exit pl011_exit(void)
 {
+	platform_driver_unregister(&arm_sbsa_uart_platform_driver);
 	amba_driver_unregister(&pl011_driver);
 }
 
-- 
1.7.9.5
