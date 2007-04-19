From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Don't shutdown TX on mpc5200 serial port if it is a console
Date: Thu, 19 Apr 2007 13:42:54 -0600
Message-ID: <11770117743675-git-send-email-grant.likely@secretlab.ca>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from S01060016b61d1226.cg.shawcable.net ([68.147.67.118]:48906 "EHLO
	sandbox.secretlab.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766968AbXDSTnN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 Apr 2007 15:43:13 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org, Sylvain Munaut <tnt@246tnt.com>, Wolfgang Denk <wd@denx.de>, Bartlomiej Sieka <tur@semihalf.com>
Cc: Grant Likely <grant.likely@secretlab.ca>

If the serial port gets shut down, then console output stalls.  9 out
of 10 kernel hackers agree, this is a bad thing.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Wolfgang, please verify this new patch.  Sylvain rightly pointed out that
RX and interrupts should be turned off regardless.  If it works for you,
please reply with a Signed-of-by line.

Thanks,
g.

 drivers/serial/mpc52xx_uart.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index f8c1761..35f8b86 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -257,9 +257,10 @@ mpc52xx_uart_shutdown(struct uart_port *port)
 {
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 
-	/* Shut down the port, interrupt and all */
+	/* Shut down the port.  Leave TX active if on a console port */
 	out_8(&psc->command,MPC52xx_PSC_RST_RX);
-	out_8(&psc->command,MPC52xx_PSC_RST_TX);
+	if (!uart_console(port))
+		out_8(&psc->command,MPC52xx_PSC_RST_TX);
 
 	port->read_status_mask = 0;
 	out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
-- 
1.5.1

