From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 1/2] serial: imx: clean up imx_poll_put_char()
Date: Tue, 28 Oct 2014 09:28:07 +0100
Message-ID: <1414484888-6229-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:42796 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755335AbaJ1I21 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Oct 2014 04:28:27 -0400
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta23.fe.bosch.de (Postfix) with ESMTP id CCD301580220
	for <linux-serial@vger.kernel.org>; Tue, 28 Oct 2014 09:28:25 +0100 (CET)
Received: from localhost (vsgw22.fe.internet.bosch.com [10.4.98.11])
	by vsmta14.fe.internet.bosch.com (Postfix) with SMTP id BF00CA40684
	for <linux-serial@vger.kernel.org>; Tue, 28 Oct 2014 09:28:25 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Huang Shijie <b32955@freescale.com>

From: Daniel Thompson <daniel.thompson@linaro.org>

imx_put_poll_char() has been simplified to remove the code to disable
interrupts. The present code can corrupt register state when re-entered
from FIQ handler.

Switch to _relaxed() MMIO functions (which are safe for polled I/O and
needed to avoid taking spin locks).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Huang Shijie <b32955@freescale.com>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/imx.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8f62a3c..0b6f14b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1509,42 +1509,28 @@ imx_verify_port(struct uart_port *port, struct serial_struct *ser)
 #if defined(CONFIG_CONSOLE_POLL)
 static int imx_poll_get_char(struct uart_port *port)
 {
-	if (!(readl(port->membase + USR2) & USR2_RDR))
+	if (!(readl_relaxed(port->membase + USR2) & USR2_RDR))
 		return NO_POLL_CHAR;
 
-	return readl(port->membase + URXD0) & URXD_RX_DATA;
+	return readl_relaxed(port->membase + URXD0) & URXD_RX_DATA;
 }
 
 static void imx_poll_put_char(struct uart_port *port, unsigned char c)
 {
-	struct imx_port_ucrs old_ucr;
 	unsigned int status;
 
-	/* save control registers */
-	imx_port_ucrs_save(port, &old_ucr);
-
-	/* disable interrupts */
-	writel(UCR1_UARTEN, port->membase + UCR1);
-	writel(old_ucr.ucr2 & ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
-	       port->membase + UCR2);
-	writel(old_ucr.ucr3 & ~(UCR3_DCD | UCR3_RI | UCR3_DTREN),
-	       port->membase + UCR3);
-
 	/* drain */
 	do {
-		status = readl(port->membase + USR1);
+		status = readl_relaxed(port->membase + USR1);
 	} while (~status & USR1_TRDY);
 
 	/* write */
-	writel(c, port->membase + URTX0);
+	writel_relaxed(c, port->membase + URTX0);
 
 	/* flush */
 	do {
-		status = readl(port->membase + USR2);
+		status = readl_relaxed(port->membase + USR2);
 	} while (~status & USR2_TXDC);
-
-	/* restore control registers */
-	imx_port_ucrs_restore(port, &old_ucr);
 }
 #endif
 
-- 
1.8.2

