From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 19/25] tty: serial: pnx8xxx: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:20 +0530
Message-ID: <4de8e95b2a8289b4f9556bb0a663fb6b967b98d2.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:63818 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab3HPLpl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:45:41 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so2159565pdj.15
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:45:41 -0700 (PDT)
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
 drivers/tty/serial/pnx8xxx_uart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/pnx8xxx_uart.c b/drivers/tty/serial/pnx8xxx_uart.c
index 7e277a5..8db7482 100644
--- a/drivers/tty/serial/pnx8xxx_uart.c
+++ b/drivers/tty/serial/pnx8xxx_uart.c
@@ -237,7 +237,10 @@ static void pnx8xxx_rx_chars(struct pnx8xxx_port *sport)
 		status = FIFO_TO_SM(serial_in(sport, PNX8XXX_FIFO)) |
 			 ISTAT_TO_SM(serial_in(sport, PNX8XXX_ISTAT));
 	}
+
+	spin_unlock(&sport->port.lock);
 	tty_flip_buffer_push(&sport->port.state->port);
+	spin_lock(&sport->port.lock);
 }
 
 static void pnx8xxx_tx_chars(struct pnx8xxx_port *sport)
-- 
1.7.12.rc2.18.g61b472e

