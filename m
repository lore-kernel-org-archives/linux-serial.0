From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
Subject: [v2][PATCH 1/1] serial: 8250: 8250_omap: Fix spelling error.
Date: Wed,  6 Dec 2017 16:52:23 +0100
Message-ID: <20171206155223.6838-1-embedded24@evers-fischer.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vigneshr@ti.com, tony@atomide.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
List-Id: linux-serial@vger.kernel.org

From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>

Fixed a spelling error in a comment.

Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
---
 drivers/tty/serial/8250/8250_omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index bd40ba402410..57f6eba47f44 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -414,7 +414,7 @@ static void omap_8250_set_termios(struct uart_port *port,
 	/* Up to here it was mostly serial8250_do_set_termios() */
 
 	/*
-	 * We enable TRIG_GRANU for RX and TX and additionaly we set
+	 * We enable TRIG_GRANU for RX and TX and additionally we set
 	 * SCR_TX_EMPTY bit. The result is the following:
 	 * - RX_TRIGGER amount of bytes in the FIFO will cause an interrupt.
 	 * - less than RX_TRIGGER number of bytes will also cause an interrupt
-- 
2.15.1
