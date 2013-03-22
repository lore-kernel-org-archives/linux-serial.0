From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH] Xilinx: ARM: UART: clear pending irqs before enabling irqs
Date: Fri, 22 Mar 2013 18:49:27 +0100
Message-ID: <1363974567-21516-1-git-send-email-s.trumtrar@pengutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36451 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422717Ab3CVRtg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Mar 2013 13:49:36 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: John Linn <john.linn@xilinx.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: John Linn <john.linn@xilinx.com>

The Boot ROM has an issue which will cause the driver to
lock up as pending irqs are not being cleared. With them
cleared it prevents that issue.

[s.trumtrar@pengutronix.de: cherry-picked from linux-xlnx.git]
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
This patch is needed for the current (3.9-rc3) mainline kernel. I guess it went
unnoticed, because it was only tested with u-boot up until now. And u-boot maybe
handles this.

 drivers/tty/serial/xilinx_uartps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index ba451c7..f36bbba 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -578,6 +578,8 @@ static int xuartps_startup(struct uart_port *port)
 	/* Receive Timeout register is enabled with value of 10 */
 	xuartps_writel(10, XUARTPS_RXTOUT_OFFSET);
 
+	/* Clear out any pending interrupts before enabling them */
+	xuartps_writel(xuartps_readl(XUARTPS_ISR_OFFSET), XUARTPS_ISR_OFFSET);
 
 	/* Set the Interrupt Registers with desired interrupts */
 	xuartps_writel(XUARTPS_IXR_TXEMPTY | XUARTPS_IXR_PARITY |
-- 
1.8.2.rc2

