From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 3/9] tty: serial: bcm63xx: Fix typo in MODULE_DESCRIPTION
Date: Mon, 20 Oct 2014 13:54:02 -0700
Message-ID: <1413838448-29464-4-git-send-email-cernekee@gmail.com>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:45443 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbaJTUzA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Oct 2014 16:55:00 -0400
In-Reply-To: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
Cc: geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

Remove the extra '<' character.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 2315190..a70910e 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -905,5 +905,5 @@ module_init(bcm_uart_init);
 module_exit(bcm_uart_exit);
 
 MODULE_AUTHOR("Maxime Bizon <mbizon@freebox.fr>");
-MODULE_DESCRIPTION("Broadcom 63<xx integrated uart driver");
+MODULE_DESCRIPTION("Broadcom 63xx integrated uart driver");
 MODULE_LICENSE("GPL");
-- 
2.1.1

