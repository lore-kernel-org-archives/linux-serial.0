From: Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] tty: ar933x_uart: remove superfluous assignment of ar933x_uart_driver.nr
Date: Wed, 28 Aug 2013 14:21:10 +0200
Message-ID: <1377692470-24059-1-git-send-email-juhosg@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:56471 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630Ab3H1MVS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Aug 2013 08:21:18 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>

The 'nr' field of the 'ar933x_uart_driver' structure
is already initialized with the same value in the static
declaration. Remove the superfluous assignment in the
module init routine.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
The patch is agains the 'tty-next' branch of the
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tree
---
 drivers/tty/serial/ar933x_uart.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 1052ee0..2d83a45 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -730,7 +730,6 @@ static int __init ar933x_uart_init(void)
 {
 	int ret;
 
-	ar933x_uart_driver.nr = CONFIG_SERIAL_AR933X_NR_UARTS;
 	ret = uart_register_driver(&ar933x_uart_driver);
 	if (ret)
 		goto err_out;
-- 
1.7.10
