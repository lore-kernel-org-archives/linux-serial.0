From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 21/25] tty: serial: sa1100: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:22 +0530
Message-ID: <671359265468f44ee9fe9fc263ba737a918508d4.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:58589 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab3HPLp5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:45:57 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so1781153pad.30
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:45:56 -0700 (PDT)
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
 drivers/tty/serial/sa1100.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index af6b3e3..28d60ef 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -232,7 +232,10 @@ sa1100_rx_chars(struct sa1100_port *sport)
 		status = UTSR1_TO_SM(UART_GET_UTSR1(sport)) |
 			 UTSR0_TO_SM(UART_GET_UTSR0(sport));
 	}
+
+	spin_unlock(&sport->port.lock);
 	tty_flip_buffer_push(&sport->port.state->port);
+	spin_lock(&sport->port.lock);
 }
 
 static void sa1100_tx_chars(struct sa1100_port *sport)
-- 
1.7.12.rc2.18.g61b472e

