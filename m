From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 15/25] tty: serial: mpsc: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:16 +0530
Message-ID: <bcdda9a01d8bea7ba4ad78e6e14b9ad7f86a3ee4.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:58177 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab3HPLpP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:45:15 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so2155553pde.37
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:45:15 -0700 (PDT)
In-Reply-To: <cover.1376651114.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-serial@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

The -rt patch triggers a lockdep warning for serial drivers if
tty_flip_buffer_push() is called with uart_port->lock locked. This never shows
up on UP kernels.

Release the port lock before calling tty_flip_buffer_push() and reacquire it
after the call.

Similar stuff was already done for few other drivers in the past, like:

commit 2389b272168ceec056ca1d8a870a97fa9c26e11a
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue May 29 21:53:50 2007 +0100

    [ARM] 4417/1: Serial: Fix AMBA drivers locking

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/tty/serial/mpsc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/mpsc.c b/drivers/tty/serial/mpsc.c
index bc24f49..556ff04 100644
--- a/drivers/tty/serial/mpsc.c
+++ b/drivers/tty/serial/mpsc.c
@@ -934,7 +934,7 @@ static int serial_polled;
  ******************************************************************************
  */
 
-static int mpsc_rx_intr(struct mpsc_port_info *pi)
+static int mpsc_rx_intr(struct mpsc_port_info *pi, unsigned long *flags)
 {
 	struct mpsc_rx_desc *rxre;
 	struct tty_port *port = &pi->port.state->port;
@@ -969,8 +969,11 @@ static int mpsc_rx_intr(struct mpsc_port_info *pi)
 #endif
 		/* Following use of tty struct directly is deprecated */
 		if (tty_buffer_request_room(port, bytes_in) < bytes_in) {
-			if (port->low_latency)
+			if (port->low_latency) {
+				spin_unlock_irqrestore(&pi->port.lock, *flags);
 				tty_flip_buffer_push(port);
+				spin_lock_irqsave(&pi->port.lock, *flags);
+			}
 			/*
 			 * If this failed then we will throw away the bytes
 			 * but must do so to clear interrupts.
@@ -1080,7 +1083,9 @@ next_frame:
 	if ((readl(pi->sdma_base + SDMA_SDCM) & SDMA_SDCM_ERD) == 0)
 		mpsc_start_rx(pi);
 
+	spin_unlock_irqrestore(&pi->port.lock, *flags);
 	tty_flip_buffer_push(port);
+	spin_lock_irqsave(&pi->port.lock, *flags);
 	return rc;
 }
 
@@ -1222,7 +1227,7 @@ static irqreturn_t mpsc_sdma_intr(int irq, void *dev_id)
 
 	spin_lock_irqsave(&pi->port.lock, iflags);
 	mpsc_sdma_intr_ack(pi);
-	if (mpsc_rx_intr(pi))
+	if (mpsc_rx_intr(pi, &iflags))
 		rc = IRQ_HANDLED;
 	if (mpsc_tx_intr(pi))
 		rc = IRQ_HANDLED;
-- 
1.7.12.rc2.18.g61b472e

