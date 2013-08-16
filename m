From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 17/25] tty: serial: netx: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:18 +0530
Message-ID: <3fbf56a800733879938f09f7e95eadf3d7e19401.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41809 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab3HPLp3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:45:29 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so1791363pad.33
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:45:28 -0700 (PDT)
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
 drivers/tty/serial/netx-serial.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/netx-serial.c b/drivers/tty/serial/netx-serial.c
index b9a40ed..4f59c4d 100644
--- a/drivers/tty/serial/netx-serial.c
+++ b/drivers/tty/serial/netx-serial.c
@@ -196,7 +196,7 @@ static void netx_txint(struct uart_port *port)
 		uart_write_wakeup(port);
 }
 
-static void netx_rxint(struct uart_port *port)
+static void netx_rxint(struct uart_port *port, unsigned long *flags)
 {
 	unsigned char rx, flg, status;
 
@@ -236,7 +236,9 @@ static void netx_rxint(struct uart_port *port)
 		uart_insert_char(port, status, SR_OE, rx, flg);
 	}
 
+	spin_unlock_irqrestore(&port->lock, *flags);
 	tty_flip_buffer_push(&port->state->port);
+	spin_lock_irqsave(&port->lock, *flags);
 }
 
 static irqreturn_t netx_int(int irq, void *dev_id)
@@ -250,7 +252,7 @@ static irqreturn_t netx_int(int irq, void *dev_id)
 	status = readl(port->membase + UART_IIR) & IIR_MASK;
 	while (status) {
 		if (status & IIR_RIS)
-			netx_rxint(port);
+			netx_rxint(port, &flags);
 		if (status & IIR_TIS)
 			netx_txint(port);
 		if (status & IIR_MIS) {
-- 
1.7.12.rc2.18.g61b472e

