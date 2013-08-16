From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/25] tty: serial: bcm63xx: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:07 +0530
Message-ID: <a89109c951fcc1950a624d672db69f633bf5feb9.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:55337 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230Ab3HPLoQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:44:16 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so2146931pdi.41
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:44:15 -0700 (PDT)
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
 drivers/tty/serial/bcm63xx_uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 6fa2ae77..9f0bf4c 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -302,7 +302,9 @@ static void bcm_uart_do_rx(struct uart_port *port)
 
 	} while (--max_count);
 
+	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tty_port);
+	spin_lock(&port->lock);
 }
 
 /*
-- 
1.7.12.rc2.18.g61b472e

