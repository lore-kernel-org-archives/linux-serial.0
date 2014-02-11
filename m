From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH v2 2/4] tty/serial: at91: use dev_err instead of printk
Date: Tue, 11 Feb 2014 18:45:13 +0100
Message-ID: <1392140715-15295-3-git-send-email-richard.genoud@gmail.com>
References: <1392140715-15295-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:38042 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbaBKRpv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Feb 2014 12:45:51 -0500
Received: by mail-ee0-f43.google.com with SMTP id c41so3751284eek.2
        for <linux-serial@vger.kernel.org>; Tue, 11 Feb 2014 09:45:50 -0800 (PST)
In-Reply-To: <1392140715-15295-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

For better consistency.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 91c0d8839570..ed9621a21d67 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1549,7 +1549,7 @@ static int atmel_startup(struct uart_port *port)
 	retval = request_irq(port->irq, atmel_interrupt, IRQF_SHARED,
 			tty ? tty->name : "atmel_serial", port);
 	if (retval) {
-		printk("atmel_serial: atmel_startup - Can't get irq\n");
+		dev_err(port->dev, "atmel_startup - Can't get irq\n");
 		return retval;
 	}
 
@@ -1732,7 +1732,7 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
 		clk_disable_unprepare(atmel_port->clk);
 		break;
 	default:
-		printk(KERN_ERR "atmel_serial: unknown pm %d\n", state);
+		dev_err(port->dev, "atmel_serial: unknown pm %d\n", state);
 	}
 }
 
-- 
1.8.5

