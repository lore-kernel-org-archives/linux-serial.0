From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 11/25] tty: serial: lpc32xx_hs: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:12 +0530
Message-ID: <91cd5fec75d8cbd56a60e105c4252d8589e8fe26.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:57058 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230Ab3HPLot (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:44:49 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so1902145pbc.18
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:44:49 -0700 (PDT)
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
 drivers/tty/serial/lpc32xx_hs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index 8fdf6a8..701644f 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -279,7 +279,10 @@ static void __serial_lpc32xx_rx(struct uart_port *port)
 
 		tmp = readl(LPC32XX_HSUART_FIFO(port->membase));
 	}
+
+	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tport);
+	spin_lock(&port->lock);
 }
 
 static void __serial_lpc32xx_tx(struct uart_port *port)
-- 
1.7.12.rc2.18.g61b472e

