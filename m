From: Timur Tabi <timur@codeaurora.org>
Subject: [PATCH] tty: amba-pl011: add support for 32-bit register access for
 earlycon
Date: Fri,  6 Nov 2015 18:18:23 -0600
Message-ID: <1446855503-25881-1-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew.Jackson@arm.com, andre.przywara@arm.com, jun.nie@linaro.org, peter@hurleysoftware.com, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <greg@kroah.com>, jslaby@suse.com, rmk+kernel@arm.linux.org.uk
List-Id: linux-serial@vger.kernel.org

Add support the "mmio32" earlycon option for the pl011 device.  If
specified in the earlycon parameter, all reads/writes to pl011 registers
during early console will use 32-bit accessors.  Normally the function
uses 8-bit writes.

Normal console uses the "access_32b" field of the vendor data structure
to determine whether the registers needs 32-bit accessors.  Early console
is used before the vendor data is available, so we need a different
mechanism to choose the accessor.

Example:

	earlycon=pl011,mmio32,0x3ced1000

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---

This patch applies on top of Russell's 12-part amba-pl011.c patchset.

 Documentation/kernel-parameters.txt | 5 ++++-
 drivers/tty/serial/amba-pl011.c     | 9 ++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 22a4b68..2436f62 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -992,10 +992,13 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
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
index 373b152..6643ed9 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2301,10 +2301,13 @@ static struct console amba_console = {
 
 static void pl011_putc(struct uart_port *port, int c)
 {
-	while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
 		;
-	writeb(c, port->membase + REG_DR);
-	while (readl(port->membase + REG_FR) & UART01x_FR_BUSY)
+	if (port->iotype == UPIO_MEM32)
+		writel(c, port->membase + UART01x_DR);
+	else
+		writeb(c, port->membase + UART01x_DR);
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
 		;
 }
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
