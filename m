From: Noam Camus <noamc@ezchip.com>
Subject: [PATCH v9 3/3] serial: 8250_dw: Do not use readl/writel before checking port iotype
Date: Sat, 12 Dec 2015 19:18:27 +0200
Message-ID: <1449940707-17633-4-git-send-email-noamc@ezchip.com>
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

Direct call to readl()/writel() is checked against iotype
and in case of UPIO_MEM32BE we use ioread32be()/iowrite32be()
instead of them.

Signed-off-by: Noam Camus <noamc@ezchip.com>
---
 drivers/tty/serial/8250/8250_dw.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 92c4a9b..30810ac 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -114,6 +114,8 @@ static void dw8250_check_lcr(struct uart_port *p, int value)
 #else
 		if (p->iotype == UPIO_MEM32)
 			writel(value, offset);
+		else if (p->iotype == UPIO_MEM32BE)
+			iowrite32be(value, offset);
 		else
 			writeb(value, offset);
 #endif
@@ -327,14 +329,20 @@ static void dw8250_setup_port(struct uart_port *p)
 	 * If the Component Version Register returns zero, we know that
 	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
 	 */
-	reg = readl(p->membase + DW_UART_UCV);
+	if (p->iotype == UPIO_MEM32BE)
+		reg = ioread32be(p->membase + DW_UART_UCV);
+	else
+		reg = readl(p->membase + DW_UART_UCV);
 	if (!reg)
 		return;
 
 	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
-	reg = readl(p->membase + DW_UART_CPR);
+	if (p->iotype == UPIO_MEM32BE)
+		reg = ioread32be(p->membase + DW_UART_CPR);
+	else
+		reg = readl(p->membase + DW_UART_CPR);
 	if (!reg)
 		return;
 
-- 
1.7.1
