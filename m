From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH 1/2] serial: mfd: remove the TX full-empty interrupts workaround
Date: Tue, 22 Feb 2011 15:28:10 +0800
Message-ID: <1298359690-9150-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28094 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256Ab1BVH1i (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Feb 2011 02:27:38 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, greg@kroah.com, alan@linux.intel.com
Cc: Feng Tang <feng.tang@intel.com>

In A0 stepping, TX half-empty interrupt is not working, so have to
use the full-empty interrupts whose performance will be 15% lower.
Now re-enable the half-empty interrrupt after it is enabled in
silicon.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/tty/serial/mfd.c |   26 +++++---------------------
 1 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index 7767774..53ff6af 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -16,9 +16,7 @@
  *    2/3 chan to port 1, 4/5 chan to port 3. Even number chans
  *    are used for RX, odd chans for TX
  *
- * 2. In A0 stepping, UART will not support TX half empty flag
- *
- * 3. The RI/DSR/DCD/DTR are not pinned out, DCD & DSR are always
+ * 2. The RI/DSR/DCD/DTR are not pinned out, DCD & DSR are always
  *    asserted, only when the HW is reset the DDCD and DDSR will
  *    be triggered
  */
@@ -41,8 +39,6 @@
 #include <linux/io.h>
 #include <linux/debugfs.h>
 
-#define  MFD_HSU_A0_STEPPING	1
-
 #define HSU_DMA_BUF_SIZE	2048
 
 #define chan_readl(chan, offset)	readl(chan->reg + offset)
@@ -543,16 +539,9 @@ static void transmit_chars(struct uart_hsu_port *up)
 		return;
 	}
 
-#ifndef MFD_HSU_A0_STEPPING
+	/* The IRQ is for TX FIFO half-empty */
 	count = up->port.fifosize / 2;
-#else
-	/*
-	 * A0 only supports fully empty IRQ, and the first char written
-	 * into it won't clear the EMPT bit, so we may need be cautious
-	 * by useing a shorter buffer
-	 */
-	count = up->port.fifosize - 4;
-#endif
+
 	do {
 		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -761,9 +750,8 @@ static void serial_hsu_break_ctl(struct uart_port *port, int break_state)
 /*
  * What special to do:
  * 1. chose the 64B fifo mode
- * 2. make sure not to select half empty mode for A0 stepping
- * 3. start dma or pio depends on configuration
- * 4. we only allocate dma memory when needed
+ * 2. start dma or pio depends on configuration
+ * 3. we only allocate dma memory when needed
  */
 static int serial_hsu_startup(struct uart_port *port)
 {
@@ -967,10 +955,6 @@ serial_hsu_set_termios(struct uart_port *port, struct ktermios *termios,
 		fcr = UART_FCR_ENABLE_FIFO | UART_FCR_HSU_64_32B;
 
 	fcr |= UART_FCR_HSU_64B_FIFO;
-#ifdef MFD_HSU_A0_STEPPING
-	/* A0 doesn't support half empty IRQ */
-	fcr |= UART_FCR_FULL_EMPT_TXI;
-#endif
 
 	/*
 	 * Ok, we're now changing the port state.  Do it with
-- 
1.7.0.4

