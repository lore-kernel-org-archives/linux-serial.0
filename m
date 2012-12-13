From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v2] mxs: uart: allow setting RTS from software
Date: Thu, 13 Dec 2012 09:42:14 +0100
Message-ID: <1355388135-3676-1-git-send-email-s.trumtrar@pengutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51452 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab2LMImT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Dec 2012 03:42:19 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>, Huang Shijie <b32955@freescale.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>

With the patch "serial: mxs-auart: fix the wrong RTS hardware flow control" the
mainline mxs-uart driver now sets RTSEN only when hardware flow control is
enabled via software. It is not possible any longer to set RTS manually via
software. However, the manual modification is a valid operation.
Regain the possibility to set RTS via software and only set RTSEN when hardware
flow control is explicitly enabled via settermios cflag CRTSCTS.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/tty/serial/mxs-auart.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 6db23b0..21d9b12 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -412,10 +412,12 @@ static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
 
 	u32 ctrl = readl(u->membase + AUART_CTRL2);
 
-	ctrl &= ~AUART_CTRL2_RTSEN;
+	ctrl &= ~(AUART_CTRL2_RTSEN | AUART_CTRL2_RTS);
 	if (mctrl & TIOCM_RTS) {
 		if (tty_port_cts_enabled(&u->state->port))
 			ctrl |= AUART_CTRL2_RTSEN;
+		else
+			ctrl |= AUART_CTRL2_RTS;
 	}
 
 	s->ctrl = mctrl;
@@ -676,8 +678,10 @@ static void mxs_auart_settermios(struct uart_port *u,
 				ctrl2 |= AUART_CTRL2_TXDMAE | AUART_CTRL2_RXDMAE
 				       | AUART_CTRL2_DMAONERR;
 		}
+		u->flags |= ASYNC_CTS_FLOW;
 		ctrl2 |= AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN;
 	} else {
+		u->flags &= ~ASYNC_CTS_FLOW;
 		ctrl2 &= ~(AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN);
 	}
 
-- 
1.7.10.4

