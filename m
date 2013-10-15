From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/5] serial: pch_uart: remove reference to .set_wake()
Date: Tue, 15 Oct 2013 09:20:43 +0200
Message-ID: <1381821643-19528-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:36781 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab3JOHUs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Oct 2013 03:20:48 -0400
Received: by mail-we0-f173.google.com with SMTP id u57so7958390wes.4
        for <linux-serial@vger.kernel.org>; Tue, 15 Oct 2013 00:20:47 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Johan Hovold <jhovold@gmail.com>, Darren Hart <dvhart@linux.intel.com>

This callback is gone and not coming back, so will not be
supported later.

Cc: Johan Hovold <jhovold@gmail.com>
Cc: Darren Hart <dvhart@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/pch_uart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 44077c0..10472b7 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1614,7 +1614,6 @@ static struct uart_ops pch_uart_ops = {
 	.shutdown = pch_uart_shutdown,
 	.set_termios = pch_uart_set_termios,
 /*	.pm		= pch_uart_pm,		Not supported yet */
-/*	.set_wake	= pch_uart_set_wake,	Not supported yet */
 	.type = pch_uart_type,
 	.release_port = pch_uart_release_port,
 	.request_port = pch_uart_request_port,
-- 
1.8.3.1

