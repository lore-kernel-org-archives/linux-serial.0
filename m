From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH] serial: mxs-auart: fix the wrong RTS hardware flow control
Date: Tue, 7 Aug 2012 16:10:52 +0800
Message-ID: <1344327052-8127-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alan@linux.intel.com
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org, Huang Shijie <b32955@freescale.com>
List-Id: linux-serial@vger.kernel.org

Without checking if the auart supports the hardware flow control or not,
the old mxs_auart_set_mctrl() asserted the RTS pin blindly.

This will causes the auart receives wrong data in the following case:
   The far-end has already started the write operation, and wait for
the auart asserts the RTS pin. Then the auart starts the read operation,
but mxs_auart_set_mctrl() may be called before we set the RTSCTS in the
mxs_auart_settermios(). So the RTS pin is asserted in a wrong situation,
and we get the wrong data in the end.

This bug has been catched when I connect the mx23(DTE) to the mx53(DCE).

This patch also replaces the AUART_CTRL2_RTS with AUART_CTRL2_RTSEN.
We should use the real the hardware flow control, not the software-controled
hardware flow control.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/mxs-auart.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 2e341b8..97f32e3 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -73,6 +73,7 @@
 #define AUART_CTRL0_CLKGATE			(1 << 30)
 
 #define AUART_CTRL2_CTSEN			(1 << 15)
+#define AUART_CTRL2_RTSEN			(1 << 14)
 #define AUART_CTRL2_RTS				(1 << 11)
 #define AUART_CTRL2_RXE				(1 << 9)
 #define AUART_CTRL2_TXE				(1 << 8)
@@ -259,9 +260,12 @@ static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
 
 	u32 ctrl = readl(u->membase + AUART_CTRL2);
 
-	ctrl &= ~AUART_CTRL2_RTS;
-	if (mctrl & TIOCM_RTS)
-		ctrl |= AUART_CTRL2_RTS;
+	ctrl &= ~AUART_CTRL2_RTSEN;
+	if (mctrl & TIOCM_RTS) {
+		if (u->flags & ASYNC_CTS_FLOW)
+			ctrl |= AUART_CTRL2_RTSEN;
+	}
+
 	s->ctrl = mctrl;
 	writel(ctrl, u->membase + AUART_CTRL2);
 }
@@ -359,9 +363,9 @@ static void mxs_auart_settermios(struct uart_port *u,
 
 	/* figure out the hardware flow control settings */
 	if (cflag & CRTSCTS)
-		ctrl2 |= AUART_CTRL2_CTSEN;
+		ctrl2 |= AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN;
 	else
-		ctrl2 &= ~AUART_CTRL2_CTSEN;
+		ctrl2 &= ~(AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN);
 
 	/* set baud rate */
 	baud = uart_get_baud_rate(u, termios, old, 0, u->uartclk);
-- 
1.7.0.4
