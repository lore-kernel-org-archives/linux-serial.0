From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 18/25] tty: serial: nwpserial: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:19 +0530
Message-ID: <31dc81fa5810c8362038e71ec8f9c1b73cc84b1d.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:52842 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab3HPLpf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:45:35 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so1772414pab.39
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:45:35 -0700 (PDT)
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
 drivers/tty/serial/nwpserial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/nwpserial.c b/drivers/tty/serial/nwpserial.c
index 549c70a..693bc6c 100644
--- a/drivers/tty/serial/nwpserial.c
+++ b/drivers/tty/serial/nwpserial.c
@@ -149,7 +149,10 @@ static irqreturn_t nwpserial_interrupt(int irq, void *dev_id)
 			tty_insert_flip_char(port, ch, TTY_NORMAL);
 	} while (dcr_read(up->dcr_host, UART_LSR) & UART_LSR_DR);
 
+	spin_unlock(&up->port.lock);
 	tty_flip_buffer_push(port);
+	spin_lock(&up->port.lock);
+
 	ret = IRQ_HANDLED;
 
 	/* clear interrupt */
-- 
1.7.12.rc2.18.g61b472e

