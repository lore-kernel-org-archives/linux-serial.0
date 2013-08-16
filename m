From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 23/25] tty: serial: tegra: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:24 +0530
Message-ID: <d82f1bd4b8e5a19e6059be348f2a3377b3589208.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:50780 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab3HPLqK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:46:10 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so1781981pab.22
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:46:10 -0700 (PDT)
In-Reply-To: <cover.1376651114.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-serial@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>

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

Cc: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/tty/serial/serial-tegra.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index ee7c812..82846cf 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -571,7 +571,9 @@ static void tegra_uart_rx_dma_complete(void *args)
 
 	tegra_uart_handle_rx_pio(tup, port);
 	if (tty) {
+		spin_unlock_irqrestore(&u->lock, flags);
 		tty_flip_buffer_push(port);
+		spin_lock_irqsave(&u->lock, flags);
 		tty_kref_put(tty);
 	}
 	tegra_uart_start_rx_dma(tup);
@@ -583,11 +585,13 @@ static void tegra_uart_rx_dma_complete(void *args)
 	spin_unlock_irqrestore(&u->lock, flags);
 }
 
-static void tegra_uart_handle_rx_dma(struct tegra_uart_port *tup)
+static void tegra_uart_handle_rx_dma(struct tegra_uart_port *tup,
+		unsigned long *flags)
 {
 	struct dma_tx_state state;
 	struct tty_struct *tty = tty_port_tty_get(&tup->uport.state->port);
 	struct tty_port *port = &tup->uport.state->port;
+	struct uart_port *u = &tup->uport;
 	int count;
 
 	/* Deactivate flow control to stop sender */
@@ -604,7 +608,9 @@ static void tegra_uart_handle_rx_dma(struct tegra_uart_port *tup)
 
 	tegra_uart_handle_rx_pio(tup, port);
 	if (tty) {
+		spin_unlock_irqrestore(&u->lock, *flags);
 		tty_flip_buffer_push(port);
+		spin_lock_irqsave(&u->lock, *flags);
 		tty_kref_put(tty);
 	}
 	tegra_uart_start_rx_dma(tup);
@@ -671,7 +677,7 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
 		iir = tegra_uart_read(tup, UART_IIR);
 		if (iir & UART_IIR_NO_INT) {
 			if (is_rx_int) {
-				tegra_uart_handle_rx_dma(tup);
+				tegra_uart_handle_rx_dma(tup, &flags);
 				if (tup->rx_in_progress) {
 					ier = tup->ier_shadow;
 					ier |= (UART_IER_RLSI | UART_IER_RTOIE |
-- 
1.7.12.rc2.18.g61b472e

