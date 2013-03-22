From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH] serial: xilinx_uartps: remove superfluous IDR write
Date: Fri, 22 Mar 2013 18:50:02 +0100
Message-ID: <1363974602-21728-1-git-send-email-s.trumtrar@pengutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36459 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422728Ab3CVRuF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Mar 2013 13:50:05 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The datesheet clearly states, that writing low bits to the
XUARTPS_IDR register have no effect. Remove the write.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/xilinx_uartps.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index f36bbba..4e5c778 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -585,9 +585,6 @@ static int xuartps_startup(struct uart_port *port)
 	xuartps_writel(XUARTPS_IXR_TXEMPTY | XUARTPS_IXR_PARITY |
 		XUARTPS_IXR_FRAMING | XUARTPS_IXR_OVERRUN |
 		XUARTPS_IXR_RXTRIG | XUARTPS_IXR_TOUT, XUARTPS_IER_OFFSET);
-	xuartps_writel(~(XUARTPS_IXR_TXEMPTY | XUARTPS_IXR_PARITY |
-		XUARTPS_IXR_FRAMING | XUARTPS_IXR_OVERRUN |
-		XUARTPS_IXR_RXTRIG | XUARTPS_IXR_TOUT), XUARTPS_IDR_OFFSET);
 
 	return retval;
 }
-- 
1.8.2.rc2

