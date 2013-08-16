From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/25] tty: serial: ar933x: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:05 +0530
Message-ID: <01a12270dacf3d7f36a1db31dc5883593b11d5a7.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:59520 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230Ab3HPLoD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:44:03 -0400
Received: by mail-pa0-f53.google.com with SMTP id lb1so1792968pab.12
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:44:02 -0700 (PDT)
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
 drivers/tty/serial/ar933x_uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 27f20c5..964ca90 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -322,7 +322,9 @@ static void ar933x_uart_rx_chars(struct ar933x_uart_port *up)
 			tty_insert_flip_char(port, ch, TTY_NORMAL);
 	} while (max_count-- > 0);
 
+	spin_unlock(&up->port.lock);
 	tty_flip_buffer_push(port);
+	spin_lock(&up->port.lock);
 }
 
 static void ar933x_uart_tx_chars(struct ar933x_uart_port *up)
-- 
1.7.12.rc2.18.g61b472e

