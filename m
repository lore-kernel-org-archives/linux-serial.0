From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/25] tty: serial: icom: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Fri, 16 Aug 2013 17:13:10 +0530
Message-ID: <b7821cdba5d1c093a168812ec51cd940eb46513e.1376651114.git.viresh.kumar@linaro.org>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:52597 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230Ab3HPLof (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:44:35 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so1776086pab.21
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:44:35 -0700 (PDT)
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
 drivers/tty/serial/icom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 18ed5ae..46cb597 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -834,7 +834,10 @@ ignore_char:
 		status = cpu_to_le16(icom_port->statStg->rcv[rcv_buff].flags);
 	}
 	icom_port->next_rcv = rcv_buff;
+
+	spin_unlock(&icom_port->uart_port.lock);
 	tty_flip_buffer_push(port);
+	spin_lock(&icom_port->uart_port.lock);
 }
 
 static void process_interrupt(u16 port_int_reg,
-- 
1.7.12.rc2.18.g61b472e

