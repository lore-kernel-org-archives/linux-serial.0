From: Timur Tabi <timur@codeaurora.org>
Subject: [PATCH 1/2] [v2] tty: amba-pl011: fix earlycon register offsets
Date: Mon,  4 Jan 2016 15:37:41 -0600
Message-ID: <1451943462-27818-1-git-send-email-timur@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>, Russell King <rmk+kernel@arm.linux.org.uk>, andre.przywara@arm.com, Linus Walleij <linus.walleij@linaro.org>, jslaby@suse.com, jun.nie@linaro.org, shijie.huang@arm.com, peter@hurleysoftware.com, andrew.jackson@arm.com, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

The REG_x macros are indices into a table, not register offsets.  Since earlycon
does not have access to the vendor data, we can currently only support standard
ARM PL011 devices.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Tested-by: Huang Shijie <shijie.huang@arm.com>
Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/tty/serial/amba-pl011.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index f6ad383..42aabb84 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2302,10 +2302,10 @@ static struct console amba_console = {
 
 static void pl011_putc(struct uart_port *port, int c)
 {
-	while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
 		;
-	writeb(c, port->membase + REG_DR);
-	while (readl(port->membase + REG_FR) & UART01x_FR_BUSY)
+	writeb(c, port->membase + UART01x_DR);
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
 		;
 }
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
