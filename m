From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 03/25] tty: serial: apbuart: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:04 +0530
Message-ID: <5eb096b77ce72ef4bc0c2ddc07b4518bca4b88c9.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:42095 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230Ab3HPLn4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:43:56 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so1884189pbc.7
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:43:56 -0700 (PDT)
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
 drivers/tty/serial/apbuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 6331464d..de11ab8 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -125,7 +125,9 @@ static void apbuart_rx_chars(struct uart_port *port)
 		status = UART_GET_STATUS(port);
 	}
 
+	spin_unlock(&port->lock);
 	tty_flip_buffer_push(&port->state->port);
+	spin_lock(&port->lock);
 }
 
 static void apbuart_tx_chars(struct uart_port *port)
-- 
1.7.12.rc2.18.g61b472e

