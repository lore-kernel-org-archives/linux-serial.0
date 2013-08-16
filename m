From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 07/25] tty: serial: bfin_sport: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:08 +0530
Message-ID: <e5ff32d3857e863fecf1e3f3addc0a792fd6dfa2.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35923 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230Ab3HPLoX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:44:23 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so2145734pdj.36
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:44:22 -0700 (PDT)
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
 drivers/tty/serial/bfin_sport_uart.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/bfin_sport_uart.c b/drivers/tty/serial/bfin_sport_uart.c
index 487c173..32d3926 100644
--- a/drivers/tty/serial/bfin_sport_uart.c
+++ b/drivers/tty/serial/bfin_sport_uart.c
@@ -161,11 +161,12 @@ static irqreturn_t sport_uart_rx_irq(int irq, void *dev_id)
 		if (!uart_handle_sysrq_char(&up->port, ch))
 			tty_insert_flip_char(port, ch, TTY_NORMAL);
 	}
-	/* XXX this won't deadlock with lowlat? */
-	tty_flip_buffer_push(port);
 
 	spin_unlock(&up->port.lock);
 
+	/* XXX this won't deadlock with lowlat? */
+	tty_flip_buffer_push(port);
+
 	return IRQ_HANDLED;
 }
 
-- 
1.7.12.rc2.18.g61b472e

