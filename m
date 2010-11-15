From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [RFC PATCH 3/4] serial: use kfifo instead of circ_buf in icom.c
Date: Mon, 15 Nov 2010 16:01:04 -0500
Message-ID: <1289854865-11865-4-git-send-email-wfp5p@virginia.edu>
References: <1289854865-11865-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:57506 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758460Ab0KOVJt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Nov 2010 16:09:49 -0500
In-Reply-To: <1289854865-11865-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Not tested!

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 drivers/serial/icom.c |   26 +++++++++++---------------
 1 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/serial/icom.c b/drivers/serial/icom.c
index 53a4682..0d63d42 100644
--- a/drivers/serial/icom.c
+++ b/drivers/serial/icom.c
@@ -627,7 +627,9 @@ static int icom_write(struct uart_port *port)
 	unsigned long data_count;
 	unsigned char cmdReg;
 	unsigned long offset;
-	int temp_tail = port->state->xmit.tail;
+	struct kfifo *xmit_fifo = &port->stat->xmit_fifo;
+	u8 c;
+	int len;
 
 	trace(ICOM_PORT, "WRITE", 0);
 
@@ -638,14 +640,11 @@ static int icom_write(struct uart_port *port)
 	}
 
 	data_count = 0;
-	while ((port->state->xmit.head != temp_tail) &&
+	while ((!kifo_is_empty(xmit_fifo)) &&
 	       (data_count <= XMIT_BUFF_SZ)) {
 
-		ICOM_PORT->xmit_buf[data_count++] =
-		    port->state->xmit.buf[temp_tail];
-
-		temp_tail++;
-		temp_tail &= (UART_XMIT_SIZE - 1);
+		len = kfifo_out(xmit_fifo, &c, 1);
+		ICOM_PORT->xmit_buf[data_count++] = c;
 	}
 
 	if (data_count) {
@@ -704,7 +703,9 @@ static inline void check_modem_status(struct icom_port *icom_port)
 static void xmit_interrupt(u16 port_int_reg, struct icom_port *icom_port)
 {
 	unsigned short int count;
-	int i;
+	int i, len;
+	u8 c;
+
 
 	if (port_int_reg & (INT_XMIT_COMPLETED)) {
 		trace(icom_port, "XMIT_COMPLETE", 0);
@@ -717,13 +718,8 @@ static void xmit_interrupt(u16 port_int_reg, struct icom_port *icom_port)
 			cpu_to_le16(icom_port->statStg->xmit[0].leLength);
 		icom_port->uart_port.icount.tx += count;
 
-		for (i=0; i<count &&
-			!uart_circ_empty(&icom_port->uart_port.state->xmit); i++) {
-
-			icom_port->uart_port.state->xmit.tail++;
-			icom_port->uart_port.state->xmit.tail &=
-				(UART_XMIT_SIZE - 1);
-		}
+		len = kfifo_out(&icom_port->uart_port.state->xmit_fifo,
+				&c, count);
 
 		if (!icom_write(&icom_port->uart_port))
 			/* activate write queue */
-- 
1.7.3.2

