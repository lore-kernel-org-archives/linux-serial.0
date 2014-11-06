From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 02/11] serial/8250: Copy RS485 fields to serial_core
Date: Thu,  6 Nov 2014 09:22:51 +0100
Message-ID: <1415262180-2694-3-git-send-email-ricardo.ribalda@gmail.com>
References: <1415262180-2694-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:45304 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbaKFIXH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 03:23:07 -0500
Received: by mail-la0-f49.google.com with SMTP id ge10so2166050lab.36
        for <linux-serial@vger.kernel.org>; Thu, 06 Nov 2014 00:23:06 -0800 (PST)
In-Reply-To: <1415262180-2694-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alan Cox <alan@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Peter Hurley <peter@hurleysoftware.com>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ingo Molnar <mingo@elte.hu>

Initialize recently added rs485 fields on serial_core

Reviewed-by: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 7e78f30..67cf179 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -3595,6 +3595,8 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->rs485		= up->rs485;
 		uart->port.throttle	= up->port.throttle;
 		uart->port.unthrottle	= up->port.unthrottle;
+		uart->port.rs485_config	= up->port.rs485_config;
+		uart->port.rs485	= up->port.rs485;
 
 		/* Take tx_loadsz from fifosize if it wasn't set separately */
 		if (uart->port.fifosize && !uart->tx_loadsz)
-- 
2.1.1

