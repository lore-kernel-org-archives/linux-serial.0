From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 20/25] tty: serial: rp2: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:21 +0530
Message-ID: <0bbd6cf46f9aae6a35559aac70f3b012802d7031.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:55812 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab3HPLpu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:45:50 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so2135502pdj.40
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:45:50 -0700 (PDT)
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
 drivers/tty/serial/rp2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index a314a94..328d6de 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -427,7 +427,9 @@ static void rp2_rx_chars(struct rp2_uart_port *up)
 		up->port.icount.rx++;
 	}
 
+	spin_unlock(&up->port.lock);
 	tty_flip_buffer_push(port);
+	spin_lock(&up->port.lock);
 }
 
 static void rp2_tx_chars(struct rp2_uart_port *up)
-- 
1.7.12.rc2.18.g61b472e

