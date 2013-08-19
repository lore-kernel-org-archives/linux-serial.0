From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 10/25] tty: serial: lpc32xx_hs: don't call tty_flip_buffer_push() twice
Date: Mon, 19 Aug 2013 20:14:14 +0530
Message-ID: <00d9c7ce1f24cdaae6707fc71c957cc65b854751.1376923198.git.viresh.kumar@linaro.org>
References: <cover.1376923198.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:47774 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab3HSOpu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Aug 2013 10:45:50 -0400
Received: by mail-pa0-f44.google.com with SMTP id fz6so4686094pac.3
        for <linux-serial@vger.kernel.org>; Mon, 19 Aug 2013 07:45:49 -0700 (PDT)
In-Reply-To: <cover.1376923198.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376923198.git.viresh.kumar@linaro.org>
References: <cover.1376923198.git.viresh.kumar@linaro.org>
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

