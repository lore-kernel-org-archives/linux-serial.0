From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/5] serial: mpc52xx: remove reference to .set_wake()
Date: Tue, 15 Oct 2013 09:20:35 +0200
Message-ID: <1381821635-19483-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:44602 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab3JOHUk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Oct 2013 03:20:40 -0400
Received: by mail-we0-f169.google.com with SMTP id q58so8164450wes.28
        for <linux-serial@vger.kernel.org>; Tue, 15 Oct 2013 00:20:39 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Gerhard Sittig <gsi@denx.de>, Anatolij Gustschin <agust@denx.de>

This callback is gone and not coming back, so will not be
supported later.

Cc: Gerhard Sittig <gsi@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/mpc52xx_uart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 5be1df3..448cb3b 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1301,7 +1301,6 @@ static struct uart_ops mpc52xx_uart_ops = {
 	.shutdown	= mpc52xx_uart_shutdown,
 	.set_termios	= mpc52xx_uart_set_termios,
 /*	.pm		= mpc52xx_uart_pm,		Not supported yet */
-/*	.set_wake	= mpc52xx_uart_set_wake,	Not supported yet */
 	.type		= mpc52xx_uart_type,
 	.release_port	= mpc52xx_uart_release_port,
 	.request_port	= mpc52xx_uart_request_port,
-- 
1.8.3.1

