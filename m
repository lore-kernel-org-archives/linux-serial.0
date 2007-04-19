From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Don't shutdown mpc5200 serial port if it is a console
Date: Thu, 19 Apr 2007 12:08:33 -0600
Message-ID: <11770061133776-git-send-email-grant.likely@secretlab.ca>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from S01060016b61d1226.cg.shawcable.net ([68.147.67.118]:58130 "EHLO
	sandbox.secretlab.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbXDSSfR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 Apr 2007 14:35:17 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org, Sylvain Munaut <tnt@246tnt.com>, Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, Bartlomiej Sieka <tur@semihalf.com>

If the serial port gets shut down, then console output stalls.  9 out
of 10 kernel hackers agree, this is a bad thing.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Bartlomiej Sieka <tur@semihalf.com>
---

This is a simple bug fix, but it's not a critical one.  It would be really
nice to get this merged for 2.6.21
 drivers/serial/mpc52xx_uart.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index f8c1761..35669f8 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -257,14 +257,16 @@ mpc52xx_uart_shutdown(struct uart_port *port)
 {
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 
-	/* Shut down the port, interrupt and all */
-	out_8(&psc->command,MPC52xx_PSC_RST_RX);
-	out_8(&psc->command,MPC52xx_PSC_RST_TX);
+	/* We don't want to shut down a port that is used as a console */
+	if (!uart_console(port)) {
+		out_8(&psc->command,MPC52xx_PSC_RST_RX);
+		out_8(&psc->command,MPC52xx_PSC_RST_TX);
 
-	port->read_status_mask = 0;
-	out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
+		port->read_status_mask = 0;
+		out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
+	}
 
-	/* Release interrupt */
+	/* Release interrupt (OK for console port b/c console uses polling) */
 	free_irq(port->irq, port);
 }
 
-- 
1.5.1

