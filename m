From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 25/25] tty: serial: vt8500: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:26 +0530
Message-ID: <f97a5114372fab459ed354d5aa45824ddadbcd34.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:52650 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866Ab3HPLqX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:46:23 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so1784265pab.35
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:46:23 -0700 (PDT)
In-Reply-To: <cover.1376651114.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-serial@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Tony Prisk <linux@prisktech.co.nz>

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

Cc: Tony Prisk <linux@prisktech.co.nz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/tty/serial/vt8500_serial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 48af43d..b839b98 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -170,7 +170,9 @@ static void handle_rx(struct uart_port *port)
 			tty_insert_flip_char(tport, c, flag);
 	}
 
+	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tport);
+	spin_lock(&port->lock);
 }
 
 static void handle_tx(struct uart_port *port)
-- 
1.7.12.rc2.18.g61b472e

