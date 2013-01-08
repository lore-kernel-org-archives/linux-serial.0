From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v3 RESEND] mxs: uart: allow setting RTS from software
Date: Tue,  8 Jan 2013 10:28:06 +0100
Message-ID: <1357637286-29178-1-git-send-email-s.trumtrar@pengutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40192 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab3AHJ2l (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Jan 2013 04:28:41 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, stable@vger.kernel.org

With the patch "serial: mxs-auart: fix the wrong RTS hardware flow control" the
mainline mxs-uart driver now sets RTSEN only when hardware flow control is
enabled via software. It is not possible any longer to set RTS manually via
software. However, the manual modification is a valid operation.
Regain the possibility to set RTS via software and only set RTSEN when hardware
flow control is explicitly enabled via settermios cflag CRTSCTS.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Reviewed-by: Huang Shijie <b32955@freescale.com>

Cc: stable@vger.kernel.org
---
 drivers/tty/serial/mxs-auart.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 6db23b0..9f63f88 100644
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
-- 
1.7.10.4

