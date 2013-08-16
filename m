From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 13/25] tty: serial: mcf: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:14 +0530
Message-ID: <5128c7c0bba9d7626e42255ec44b8f500b65235e.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45847 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab3HPLpD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:45:03 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so1790957pad.33
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:45:02 -0700 (PDT)
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
 drivers/tty/serial/mcf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 65be0c0..62c8fdf 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -324,7 +324,9 @@ static void mcf_rx_chars(struct mcf_uart *pp)
 		uart_insert_char(port, status, MCFUART_USR_RXOVERRUN, ch, flag);
 	}
 
+	spin_unlock(&port->lock);
 	tty_flip_buffer_push(&port->state->port);
+	spin_lock(&port->lock);
 }
 
 /****************************************************************************/
-- 
1.7.12.rc2.18.g61b472e

