From: Timur Tabi <timur@codeaurora.org>
Subject: [PATCH 2/2] tty: amba-pl011: use iotype instead of access_32b to track 32-bit I/O
Date: Mon,  4 Jan 2016 15:37:42 -0600
Message-ID: <1451943462-27818-2-git-send-email-timur@codeaurora.org>
References: <1451943462-27818-1-git-send-email-timur@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1451943462-27818-1-git-send-email-timur@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>, Russell King <rmk+kernel@arm.linux.org.uk>, andre.przywara@arm.com, Linus Walleij <linus.walleij@linaro.org>, jslaby@suse.com, jun.nie@linaro.org, shijie.huang@arm.com, peter@hurleysoftware.com, andrew.jackson@arm.com, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Instead of defining a new field in the uart_amba_port structure, use the
existing iotype field of the uart_port structure, which is intended for
this purpose.  If we need to use 32-bit register access, we set iotype
to UPIO_MEM32, otherwise we set it to UPIO_MEM.

For early console, specify the "mmio32" option on the kernel command-line.
Example:

        earlycon=pl011,mmio32,0x3ced1000

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 Documentation/kernel-parameters.txt |  5 ++++-
 drivers/tty/serial/amba-pl011.c     | 16 +++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 474ce69..ab11d5c 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -995,10 +995,13 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			unspecified, the h/w is not initialized.
 
 		pl011,<addr>
+		pl011,mmio32,<addr>
 			Start an early, polled-mode console on a pl011 serial
 			port at the specified address. The pl011 serial port
 			must already be setup and configured. Options are not
-			yet supported.
+			yet supported.  If 'mmio32' is specified, then only
+			the driver will use only 32-bit accessors to read/write
+			the device registers.
 
 		msm_serial,<addr>
 			Start an early, polled-mode console on an msm serial
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 42aabb84..80df184 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -239,7 +239,6 @@ struct uart_amba_port {
 	unsigned int		fifosize;	/* vendor-specific */
 	unsigned int		old_cr;		/* state during shutdown */
 	bool			autorts;
-	bool			access_32b;
 	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
 	char			type[12];
 #ifdef CONFIG_DMA_ENGINE
@@ -263,7 +262,8 @@ static unsigned int pl011_read(const struct uart_amba_port *uap,
 {
 	void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
 
-	return uap->access_32b ? readl_relaxed(addr) : readw_relaxed(addr);
+	return (uap->port.iotype == UPIO_MEM32) ?
+		readl_relaxed(addr) : readw_relaxed(addr);
 }
 
 static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
@@ -271,7 +271,7 @@ static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
 {
 	void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
 
-	if (uap->access_32b)
+	if (uap->port.iotype == UPIO_MEM32)
 		writel_relaxed(val, addr);
 	else
 		writew_relaxed(val, addr);
@@ -2304,7 +2304,10 @@ static void pl011_putc(struct uart_port *port, int c)
 {
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
 		;
-	writeb(c, port->membase + UART01x_DR);
+	if (port->iotype == UPIO_MEM32)
+		writel(c, port->membase + UART01x_DR);
+	else
+		writeb(c, port->membase + UART01x_DR);
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
 		;
 }
@@ -2417,7 +2420,6 @@ static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
 	uap->port.dev = dev;
 	uap->port.mapbase = mmiobase->start;
 	uap->port.membase = base;
-	uap->port.iotype = UPIO_MEM;
 	uap->port.fifosize = uap->fifosize;
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = index;
@@ -2471,9 +2473,9 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		return PTR_ERR(uap->clk);
 
 	uap->reg_offset = vendor->reg_offset;
-	uap->access_32b = vendor->access_32b;
 	uap->vendor = vendor;
 	uap->fifosize = vendor->get_fifosize(dev);
+	uap->port.iotype = vendor->access_32b ? UPIO_MEM32 : UPIO_MEM;
 	uap->port.irq = dev->irq[0];
 	uap->port.ops = &amba_pl011_pops;
 
@@ -2552,9 +2554,9 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	uap->reg_offset	= vendor_sbsa.reg_offset;
-	uap->access_32b = vendor_sbsa.access_32b;
 	uap->vendor	= &vendor_sbsa;
 	uap->fifosize	= 32;
+	uap->port.iotype = vendor_sbsa.access_32b ? UPIO_MEM32 : UPIO_MEM;
 	uap->port.irq	= platform_get_irq(pdev, 0);
 	uap->port.ops	= &sbsa_uart_pops;
 	uap->fixed_baud = baudrate;
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
