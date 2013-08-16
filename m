From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/25] tty: serial: lpc32xx_hs: don't call tty_flip_buffer_push() twice
Date: Fri, 16 Aug 2013 17:13:11 +0530
Message-ID: <a2cd09578a7df937dbe4ebc7d0dfbe24a441efc3.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:59028 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230Ab3HPLom (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:44:42 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so1903592pbc.11
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:44:41 -0700 (PDT)
In-Reply-To: <cover.1376651114.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-serial@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

serial_lpc32xx_interrupt() calls __serial_lpc32xx_rx() first and then
tty_flip_buffer_push() immediately after that. But last statement of
__serial_lpc32xx_rx() already called tty_flip_buffer_push()..

So, probably its not required to be called twice. Lets remove one of them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/tty/serial/lpc32xx_hs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index dffea6b..8fdf6a8 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -351,10 +351,8 @@ static irqreturn_t serial_lpc32xx_interrupt(int irq, void *dev_id)
 	}
 
 	/* Data received? */
-	if (status & (LPC32XX_HSU_RX_TIMEOUT_INT | LPC32XX_HSU_RX_TRIG_INT)) {
+	if (status & (LPC32XX_HSU_RX_TIMEOUT_INT | LPC32XX_HSU_RX_TRIG_INT))
 		__serial_lpc32xx_rx(port);
-		tty_flip_buffer_push(tport);
-	}
 
 	/* Transmit data request? */
 	if ((status & LPC32XX_HSU_TX_INT) && (!uart_tx_stopped(port))) {
-- 
1.7.12.rc2.18.g61b472e

