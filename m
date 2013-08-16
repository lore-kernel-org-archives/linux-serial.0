From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 16/25] tty: serial: msm: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:17 +0530
Message-ID: <a6e0375d43f960df1f98e4055977eac044c16b06.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:62944 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab3HPLpW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:45:22 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so2146694pdj.36
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:45:22 -0700 (PDT)
In-Reply-To: <cover.1376651114.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-serial@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>

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

Cc: David Brown <davidb@codeaurora.org> (maintainer:ARM/QUALCOMM MSM...)
Cc: Daniel Walker <dwalker@fifo99.com> (maintainer:ARM/QUALCOMM MSM...)
Cc: Bryan Huntsman <bryanh@codeaurora.org> (maintainer:ARM/QUALCOMM MSM...)
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/tty/serial/msm_serial.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 2c6cfb3..daa2837 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -137,7 +137,10 @@ static void handle_rx_dm(struct uart_port *port, unsigned int misr)
 		count -= 4;
 	}
 
+	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tport);
+	spin_lock(&port->lock);
+
 	if (misr & (UART_IMR_RXSTALE))
 		msm_write(port, UART_CR_CMD_RESET_STALE_INT, UART_CR);
 	msm_write(port, 0xFFFFFF, UARTDM_DMRX);
@@ -189,7 +192,9 @@ static void handle_rx(struct uart_port *port)
 			tty_insert_flip_char(tport, c, flag);
 	}
 
+	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tport);
+	spin_lock(&port->lock);
 }
 
 static void reset_dm_count(struct uart_port *port)
-- 
1.7.12.rc2.18.g61b472e

