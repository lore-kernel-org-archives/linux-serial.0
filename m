From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/25] tty: serial: altera_jtag: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:02 +0530
Message-ID: <b57aa015f0c91ba2ab6e2f1b18f46df4e71cdad7.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:55706 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957Ab3HPLnn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:43:43 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so1787133pab.13
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:43:42 -0700 (PDT)
In-Reply-To: <cover.1376651114.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-serial@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Tobias Klauser <tklauser@distanz.ch>

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

Cc: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/tty/serial/altera_jtaguart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index c6bdb94..46c25ff 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -139,7 +139,9 @@ static void altera_jtaguart_rx_chars(struct altera_jtaguart *pp)
 		uart_insert_char(port, 0, 0, ch, flag);
 	}
 
+	spin_unlock(&port->lock);
 	tty_flip_buffer_push(&port->state->port);
+	spin_lock(&port->lock);
 }
 
 static void altera_jtaguart_tx_chars(struct altera_jtaguart *pp)
-- 
1.7.12.rc2.18.g61b472e

