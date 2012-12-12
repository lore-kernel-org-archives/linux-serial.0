From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH] mxs: uart: allow setting RTS from software
Date: Wed, 12 Dec 2012 17:31:53 +0100
Message-ID: <1355329913-27666-1-git-send-email-s.trumtrar@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>, Huang Shijie <b32955@freescale.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

With the patch "serial: mxs-auart: fix the wrong RTS hardware flow control" the
mainline mxs-uart driver now sets RTSEN only when hardware flow control is
enabled via software. It is not possible any longer to set RTS manually via
software. However, the manual modification is a valid operation.
Regain the possibility to set RTS via software and only set RTSEN when hardware
flow control is explicitly enabled via settermios cflag CRTSCTS.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/tty/serial/mxs-auart.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 6db23b0..9b62c4b 100644
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
@@ -678,6 +680,10 @@ static void mxs_auart_settermios(struct uart_port *u,
 		}
 		ctrl2 |= AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN;
 	} else {
+		u->flags |= ASYNC_CTS_FLOW;
+		ctrl2 |= AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN;
+	} else {
+		u->flags &= ~ASYNC_CTS_FLOW;
 		ctrl2 &= ~(AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN);
 	}
 
-- 
1.7.10.4
