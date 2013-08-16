From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 22/25] tty: serial: samsung: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:23 +0530
Message-ID: <c0035ba4d796786514d8efe3d0cc04ea6d88e330.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:55790 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab3HPLqD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:46:03 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so2137419pdj.25
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:46:02 -0700 (PDT)
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
 drivers/tty/serial/samsung.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 376079b..275e3e0 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -249,6 +249,8 @@ s3c24xx_serial_rx_chars(int irq, void *dev_id)
 					ufcon |= S3C2410_UFCON_RESETRX;
 					wr_regl(port, S3C2410_UFCON, ufcon);
 					rx_enabled(port) = 1;
+					spin_unlock_irqrestore(&port->lock,
+							flags);
 					goto out;
 				}
 				continue;
@@ -297,10 +299,11 @@ s3c24xx_serial_rx_chars(int irq, void *dev_id)
  ignore_char:
 		continue;
 	}
+
+	spin_unlock_irqrestore(&port->lock, flags);
 	tty_flip_buffer_push(&port->state->port);
 
  out:
-	spin_unlock_irqrestore(&port->lock, flags);
 	return IRQ_HANDLED;
 }
 
-- 
1.7.12.rc2.18.g61b472e

