From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 14/25] tty: serial: mfd: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:15 +0530
Message-ID: <e677fe0811e5196a0d673da05fe104975c995363.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:62901 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab3HPLpJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:45:09 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so1767101pad.23
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:45:08 -0700 (PDT)
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
 drivers/tty/serial/mfd.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index 4a82267..d3db042 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -386,7 +386,7 @@ static void serial_hsu_stop_tx(struct uart_port *port)
 
 /* This is always called in spinlock protected mode, so
  * modify timeout timer is safe here */
-void hsu_dma_rx(struct uart_hsu_port *up, u32 int_sts)
+void hsu_dma_rx(struct uart_hsu_port *up, u32 int_sts, unsigned long *flags)
 {
 	struct hsu_dma_buffer *dbuf = &up->rxbuf;
 	struct hsu_dma_chan *chan = up->rxc;
@@ -438,7 +438,9 @@ void hsu_dma_rx(struct uart_hsu_port *up, u32 int_sts)
 					 | (0x1 << 16)
 					 | (0x1 << 24)	/* timeout bit, see HSU Errata 1 */
 					 );
+	spin_unlock_irqrestore(&up->port.lock, *flags);
 	tty_flip_buffer_push(tport);
+	spin_lock_irqsave(&up->port.lock, *flags);
 
 	chan_writel(chan, HSU_CH_CR, 0x3);
 
@@ -459,7 +461,8 @@ static void serial_hsu_stop_rx(struct uart_port *port)
 	}
 }
 
-static inline void receive_chars(struct uart_hsu_port *up, int *status)
+static inline void receive_chars(struct uart_hsu_port *up, int *status,
+		unsigned long *flags)
 {
 	unsigned int ch, flag;
 	unsigned int max_count = 256;
@@ -519,7 +522,10 @@ static inline void receive_chars(struct uart_hsu_port *up, int *status)
 	ignore_char:
 		*status = serial_in(up, UART_LSR);
 	} while ((*status & UART_LSR_DR) && max_count--);
+
+	spin_unlock_irqrestore(&up->port.lock, *flags);
 	tty_flip_buffer_push(&up->port.state->port);
+	spin_lock_irqsave(&up->port.lock, *flags);
 }
 
 static void transmit_chars(struct uart_hsu_port *up)
@@ -613,7 +619,7 @@ static irqreturn_t port_irq(int irq, void *dev_id)
 
 	lsr = serial_in(up, UART_LSR);
 	if (lsr & UART_LSR_DR)
-		receive_chars(up, &lsr);
+		receive_chars(up, &lsr, &flags);
 	check_modem_status(up);
 
 	/* lsr will be renewed during the receive_chars */
@@ -643,7 +649,7 @@ static inline void dma_chan_irq(struct hsu_dma_chan *chan)
 
 	/* Rx channel */
 	if (chan->dirt == DMA_FROM_DEVICE)
-		hsu_dma_rx(up, int_sts);
+		hsu_dma_rx(up, int_sts, &flags);
 
 	/* Tx channel */
 	if (chan->dirt == DMA_TO_DEVICE) {
-- 
1.7.12.rc2.18.g61b472e

